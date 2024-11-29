<?php
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Pobranie danych z ciała żądania
$data = json_decode(file_get_contents('php://input'), true);

// Sprawdzenie, czy dane zostały poprawnie przesłane
if (isset($data['postId'], $data['commentId'])) {
    $postId = $data['postId'];
    $commentId = $data['commentId'];

    // Sprawdzenie, czy postId i commentId są liczbami całkowitymi
        // Połączenie z bazą danych
        $host = 'localhost';
        $db = 'socialmedia';  // Zmień na nazwę swojej bazy danych
        $user = 'root';             // Zmień na swoją nazwę użytkownika
        $password = '';             // Zmień na swoje hasło

        try {
            // Ustalenie połączenia z bazą danych
            $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $password);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Zapytanie SQL do usunięcia komentarza
            $sql = "DELETE FROM komentarze WHERE ID_komentarza = :commentId AND ID_postu = :postId";

            // Przygotowanie zapytania
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':commentId', $commentId, PDO::PARAM_INT);
            $stmt->bindParam(':postId', $postId, PDO::PARAM_INT);

            // Wykonanie zapytania
            $stmt->execute();

            // Sprawdzenie, czy zostały usunięte dane
            if ($stmt->rowCount() > 0) {
                echo json_encode(['status' => 'success', 'message' => 'Komentarz został usunięty']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Nie znaleziono komentarza do usunięcia']);
            }

        } catch (PDOException $e) {
            // Obsługa błędów połączenia z bazą danych
            echo json_encode(['status' => 'error', 'message' => 'Błąd bazy danych: ' . $e->getMessage()]);
        }
    } 
 else {
    // Jeśli nie przesłano wymaganych danych
    echo json_encode(['status' => 'error', 'message' => 'Brak wymaganych danych']);
}
?>
