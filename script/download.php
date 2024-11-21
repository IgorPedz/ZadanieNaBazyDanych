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
file_put_contents('php://stderr', "Otrzymane dane: " . $rawData . "\n"); // Logowanie surowych danych

$data = json_decode($rawData, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    file_put_contents('php://stderr', "Błąd dekodowania JSON: " . json_last_error_msg() . "\n");
    echo json_encode(["status" => "error", "message" => "Błąd dekodowania JSON: " . json_last_error_msg()]);
    exit;
}
// Sprawdzenie, czy dane zostały poprawnie przekazane
if ($data === null) {
    echo json_encode([
        "status" => "error",
        "message" => "Błąd odczytu JSON: " . json_last_error_msg()
    ]);
    exit;
}

// Debugowanie danych
file_put_contents('php://stderr', print_r($data, true));  // Zapisuje dane do logów serwera

// Sprawdzenie, czy dane zawierają wymagane pola
if (isset($data['title']) && $data['content'] && $data['hashtags'] && $data['userID']) {
    $title = $data['title'];
    $tresc = $data['content'];
    $hashtagi = implode(' ', $data['hashtags']);
    $ID_uzytkownika = $data['userID'];

    // Przygotowanie zapytania SQL
    $stmt = $conn->prepare("INSERT INTO posty (ID_uzytkownika,Tytul,Tresc,Hasztagi) 
                            VALUES (?,?,?,?)");

    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Błąd przygotowania zapytania: " . $conn->error]);
        exit;
    }

    // Przypisanie zmiennych do zapytania
    $stmt->bind_param("ssss", $ID_uzytkownika,$title,$tresc,$hashtagi);

    // Wykonanie zapytania
    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Post został pomyślnie dodany!"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Błąd podczas dodawania posta: " . $stmt->error]);
    }

    // Zamknięcie przygotowanego zapytania
    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Brak wymaganych danych (title)."]);
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
