<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Zmienna z nazwą bazy danych

// Połączenie z bazą danych
$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Połączenie nieudane: " . $conn->connect_error]));
}

// Odczytanie danych JSON z ciała żądania
$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);

// Sprawdzenie błędów dekodowania JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    echo json_encode(["status" => "error", "message" => "Błąd dekodowania JSON: " . json_last_error_msg()]);
    exit;
}

// Debugowanie - logowanie danych
file_put_contents('php://stderr', "Otrzymane dane: " . print_r($data, true) . "\n");

// Sprawdzenie, czy wszystkie wymagane dane są przekazane
if (isset($data['postId'], $data['title'], $data['content'], $data['hashtags'])) {
    $postId = $data['postId'];
    $title = $data['title'];
    $content = $data['content'];
    $hashtags = $data['hashtags'];  // Hashtagi w formie stringa, np. "tag1 tag2 tag3"

    // Przygotowanie zapytania SQL do aktualizacji posta
    $stmt = $conn->prepare("UPDATE posty SET Tytul = ?, Tresc = ?, Hasztagi = ? WHERE ID_postu = ?");

    // Sprawdzenie, czy zapytanie zostało poprawnie przygotowane
    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Błąd przygotowania zapytania: " . $conn->error]);
        exit;
    }

    // Związanie parametrów z zapytaniem
    $stmt->bind_param("sssi", $title, $content, $hashtags, $postId);

    // Debugowanie - logowanie zapytania przed wykonaniem
    file_put_contents('php://stderr', "Zapytanie SQL: UPDATE posty SET Tytul = '$title', Tresc = '$content', Hasztagi = '$hashtags' WHERE ID_postu = $postId\n");

    // Wykonanie zapytania
    if ($stmt->execute()) {
        // Zwrócenie odpowiedzi po pomyślnym wykonaniu
        echo json_encode(["status" => "success", "message" => "Post został pomyślnie zaktualizowany.", "post" => [
            "id" => $postId,
            "title" => $title,
            "content" => $content,
            "hashtags" => explode(' ', $hashtags)  // Zamiana stringa na tablicę hashtagów
        ]]);
    } else {
        echo json_encode(["status" => "error", "message" => "Błąd podczas aktualizacji posta: " . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Brak wymaganych danych."]);
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
