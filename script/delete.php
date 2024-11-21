<?php
// Połączenie z bazą danych
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Zmienna z nazwą bazy danych

$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Połączenie nieudane: " . $conn->connect_error]));
}

// Odczytanie danych JSON z ciała żądania
$rawData = file_get_contents("php://input");
$data = json_decode($rawData, true);

// Sprawdzenie, czy przekazano id posta
if (isset($data['postId'])) {
    $postId = $data['postId'];

    // Przygotowanie zapytania SQL do usunięcia posta
    $stmt = $conn->prepare("DELETE FROM posty WHERE id_postu = ?");
    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Błąd przygotowania zapytania: " . $conn->error]);
        exit;
    }

    // Przypisanie zmiennej do zapytania
    $stmt->bind_param("i", $postId);

    // Wykonanie zapytania
    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Post został pomyślnie usunięty!"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Błąd podczas usuwania posta: " . $stmt->error]);
    }

    // Zamknięcie przygotowanego zapytania
    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Brak parametru postId."]);
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
