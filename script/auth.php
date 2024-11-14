<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root"; // Zmień na odpowiednią nazwę użytkownika
$password = ""; // Zmień na odpowiednie hasło
$dbname = "socialmedia"; // Zmień na nazwę swojej bazy danych

$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzamy połączenie
if ($conn->connect_error) {
    die(json_encode(["error" => true, "message" => "Połączenie z bazą danych nieudane: " . $conn->connect_error]));
}

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($data['email'], $data['password'])) {
        $email = $data['email'];
        $password = $data['password'];

        if (isset($data['username']) && isset($data['confirmPassword'])) {
            // Rejestracja użytkownika
            $username = $data['username'];
            $surrname = $data['surrname'];
            $nickname = $username .'_'.$surrname;
            $confirmPassword = $data['confirmPassword'];

            // Sprawdzamy, czy hasła się zgadzają
            if ($password !== $confirmPassword) {
                echo json_encode(['error' => true, 'message' => 'Hasła się nie zgadzają.']);
                exit;
            }

            // Sprawdzamy, czy użytkownik już istnieje
            $checkEmailQuery = "SELECT * FROM uzytkownicy WHERE email = ?";
            $stmt = $conn->prepare($checkEmailQuery);
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                echo json_encode(['error' => true, 'message' => 'Użytkownik o tym adresie e-mail już istnieje.']);
                exit;
            }

            // Haszowanie hasła
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            // Wstawianie użytkownika
            $insertQuery = "INSERT INTO uzytkownicy (imie, nazwisko, nick ,email, haslo) VALUES (?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($insertQuery);
            $stmt->bind_param("sssss", $username, $surrname, $nickname, $email, $hashedPassword);

            if ($stmt->execute()) {
                echo json_encode(['success' => true, 'message' => 'Użytkownik został zarejestrowany.']);
            } else {
                echo json_encode(['error' => true, 'message' => 'Błąd podczas rejestracji użytkownika.']);
            }
        } else {
            // Logowanie użytkownika
            $checkUserQuery = "SELECT * FROM uzytkownicy WHERE email = ?";
            $stmt = $conn->prepare($checkUserQuery);
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                $user = $result->fetch_assoc();
                if (password_verify($password, $user['Haslo'])) {
                    echo json_encode(['username'=>$user,'email'=>$email,'success' => true, 'message' => 'Zalogowano pomyślnie.']);
                } else {
                    echo json_encode(['error' => true, 'message' => 'Niepoprawne hasło.']);
                }
            } else {
                echo json_encode(['error' => true, 'message' => 'Nie znaleziono użytkownika o tym e-mailu.']);
            }
        }
    } else {
        echo json_encode(['error' => true, 'message' => 'Brak wymaganych danych.']);
    }
}

$conn->close();
?>
