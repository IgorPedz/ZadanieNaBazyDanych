<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $host = 'localhost';
    $dbname = 'socialmedia';
    $username = 'root';
    $password = '';

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Błąd połączenia z bazą danych: ' . $e->getMessage()]);
        exit();
    }

    $data = json_decode(file_get_contents("php://input"));

    if (isset($data->userId)) {
        $userId = $data->userId;

        try {
            // Pobieranie obserwujących danego użytkownika
            $queryFollowers = "SELECT u.ID_uzytkownika, u.Imie, u.Nazwisko, u.Nick FROM uzytkownicy u 
                               JOIN obserwujacy f ON u.ID_uzytkownika = f.ID_obserwujacego
                               WHERE f.ID_obserwowanego = :followedId";
            $stmtFollowers = $pdo->prepare($queryFollowers);
            $stmtFollowers->execute(['followedId' => $userId]);

            // Pobieranie obserwowanych przez danego użytkownika
            $queryFollowing = "SELECT u.ID_uzytkownika, u.Imie, u.Nazwisko, u.Nick FROM uzytkownicy u 
                               JOIN obserwujacy f ON u.ID_uzytkownika = f.ID_obserwowanego
                               WHERE f.ID_obserwujacego = :followerId";
            $stmtFollowing = $pdo->prepare($queryFollowing);
            $stmtFollowing->execute(['followerId' => $userId]);

            $followers = $stmtFollowers->fetchAll(PDO::FETCH_ASSOC);
            $following = $stmtFollowing->fetchAll(PDO::FETCH_ASSOC);

            // Zwracamy obserwujących i obserwowanych
            echo json_encode([
                'followers' => $followers,
                'following' => $following
            ]);
        } catch (PDOException $e) {
            echo json_encode(['error' => 'Błąd wykonania zapytania: ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['error' => 'Brak wymaganych parametrów']);
    }
} else {
    echo json_encode(['error' => 'Niepoprawna metoda zapytania']);
}
?>
