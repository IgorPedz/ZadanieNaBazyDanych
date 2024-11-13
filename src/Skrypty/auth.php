<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

header('Content-Type: application/json');

// Wczytaj dane z formularza (POST)
$data = json_decode(file_get_contents("php://input"), true);

// Połącz się z bazą danych
include('db.php');

// Funkcja do generowania odpowiedzi JSON
function sendResponse($error, $message) {
    echo json_encode(['error' => $error, 'message' => $message]);
    exit();
}

// Rejestracja użytkownika
if (isset($data['email']) && isset($data['password']) && isset($data['username'])) {
    // Rejestracja - sprawdź, czy użytkownik już istnieje
    $email = $conn->real_escape_string($data['email']);
    $password = password_hash($conn->real_escape_string($data['password']), PASSWORD_BCRYPT); // Haszowanie hasła
    $username = $conn->real_escape_string($data['username']);

    // Sprawdź, czy email już istnieje
    $checkEmailQuery = "SELECT * FROM uzytkownicy WHERE Email = '$email'";
    $result = $conn->query($checkEmailQuery);

    if ($result->num_rows > 0) {
        sendResponse(true, "Użytkownik z takim adresem e-mail już istnieje.");
    }

    // Dodaj użytkownika do bazy
    $insertQuery = "INSERT INTO uzytkownicy (Imie, Email, Haslo) VALUES ('$username', '$email', '$password')";
    if ($conn->query($insertQuery) === TRUE) {
        sendResponse(false, "Rejestracja zakończona sukcesem.");
    } else {
        sendResponse(true, "Błąd rejestracji: " . $conn->error);
    }
}

// Logowanie użytkownika
if (isset($data['email']) && isset($data['password'])) {
    // Logowanie - sprawdź dane użytkownika
    $email = $conn->real_escape_string($data['email']);
    $password = $conn->real_escape_string($data['password']);

    // Pobierz dane użytkownika z bazy
    $query = "SELECT * FROM uzytkownicy WHERE Email = '$email'";
    $result = $conn->query($query);

    if ($result->num_rows == 0) {
        sendResponse(true, "Nie znaleziono użytkownika o takim adresie e-mail.");
    }

    $user = $result->fetch_assoc();

    // Sprawdź hasło
    if (password_verify($password, $user['Haslo'])) {
        sendResponse(false, "Zalogowano pomyślnie.");
    } else {
        sendResponse(true, "Nieprawidłowe hasło.");
    }
}

sendResponse(true, "Niepoprawne dane.");
?>
