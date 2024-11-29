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

    if (isset($data->followerId) && isset($data->followedId)) {
        $followerId = $data->followerId;
        $followedId = $data->followedId;

        try {
            // Zapytanie sprawdzające, czy użytkownik już obserwuje
            $query = "SELECT * FROM obserwujacy WHERE ID_obserwowanego = :followerId AND ID_obserwujacego = :followedId";
            $stmt = $pdo->prepare($query);
            $stmt->execute(['followerId' => $followerId, 'followedId' => $followedId]);

            if ($stmt->rowCount() > 0) {
                echo json_encode(['isFollowing' => true]);
            } else {
                echo json_encode(['isFollowing' => false]);
            }
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
