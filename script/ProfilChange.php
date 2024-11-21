<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");
$inputData = json_decode(file_get_contents('php://input'), true);

// Sprawdzenie, czy dane zostały prawidłowo przesłane
if (!$inputData || !isset($inputData['username'])) {
    echo json_encode(['status' => 'error', 'message' => 'Brak wymaganych danych']);
    exit;
}

// Zmienna do przetwarzania danych użytkownika
$username = $inputData['username'];
$imie = $inputData['Imie'];
$nazwisko = $inputData['Nazwisko'];
$nick = $inputData['Nick'];
$email = $inputData['Email'];
$bio = $inputData['Bio'];
$dataUrodzenia = $inputData['Data_Urodzenia'];
$kraj = $inputData['Kraj'];

// Załóżmy, że mamy połączenie z bazą danych
// Wykonaj zapytanie SQL do aktualizacji danych użytkownika
// Użyj przygotowanych zapytań, aby zapobiec SQL Injection

$servername = "localhost";
$usernameDB = "root";
$passwordDB = "";
$dbname = "socialmedia";

// Połączenie z bazą danych
$conn = new mysqli($servername, $usernameDB, $passwordDB, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Przygotowanie zapytania
$stmt = $conn->prepare("UPDATE uzytkownicy SET Imie = ?, Nazwisko = ?, Nick = ?, Email = ?, Bio = ?, Data_Urodzenia = ?, Kraj = ? WHERE Nick = ?");
$stmt->bind_param("ssssssss", $imie,$nazwisko, $nick, $email, $bio, $dataUrodzenia, $kraj, $username);

// Wykonaj zapytanie
if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Zmiany zostały zapisane']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Błąd zapisu danych']);
}

// Zamknięcie połączenia
$stmt->close();
$conn->close();
?>
