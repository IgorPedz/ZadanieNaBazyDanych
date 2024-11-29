<?php
// Ustawienie nagłówków CORS (w razie potrzeby, jeśli masz frontend na innym porcie)
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Sprawdzenie, czy żądanie jest metodą POST
    // Pobranie danych z ciała żądania
    $data = json_decode(file_get_contents('php://input'), true);

    // Sprawdzenie, czy wszystkie wymagane dane zostały przesłane
    if (isset($data['postId'], $data['commentId'], $data['content'])) {
        $postId = $data['postId'];
        $commentId = $data['commentId'];
        $content = $data['content'];

        // Sprawdzenie, czy treść komentarza nie jest pusta
        if (empty($content)) {
            echo json_encode(['status' => 'error', 'message' => 'Treść komentarza nie może być pusta']);
            exit;
        }

        // Połączenie z bazą danych
        $host = 'localhost';
        $db = 'socialmedia';  // Zmień na nazwę swojej bazy danych
        $user = 'root';             // Zmień na swoją nazwę użytkownika
        $password = '';             // Zmień na swoje hasło

        try {
            // Ustalenie połączenia z bazą danych
            $pdo = new PDO("mysql:host=$host;dbname=$db", $user, $password);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Zapytanie SQL do zaktualizowania komentarza
            $sql = "UPDATE komentarze SET Tresc = :content WHERE ID_komentarza = :commentId AND ID_postu = :postId";

            // Przygotowanie zapytania
            $stmt = $pdo->prepare($sql);
            $stmt->bindParam(':content', $content);
            $stmt->bindParam(':commentId', $commentId, PDO::PARAM_INT);
            $stmt->bindParam(':postId', $postId, PDO::PARAM_INT);

            // Wykonanie zapytania
            $stmt->execute();

            // Sprawdzenie, czy zostały dokonane zmiany
            if ($stmt->rowCount() > 0) {
                echo json_encode(['status' => 'success', 'message' => 'Komentarz został zaktualizowany']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Nie znaleziono komentarza do edycji']);
            }

        } catch (PDOException $e) {
            // Obsługa błędów połączenia z bazą danych
            echo json_encode(['status' => 'error', 'message' => 'Błąd bazy danych: ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Brak wymaganych danych']);
    }

?>
