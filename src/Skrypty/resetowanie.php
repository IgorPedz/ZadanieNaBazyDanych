<?php
// reset-password.php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET');

$servername = "localhost";
$username = "root";  // Twoja nazwa użytkownika bazy danych
$password = "";      // Twoje hasło do bazy danych
$dbname = "moja_strona";  // Nazwa bazy danych

try {
    // Połączenie z bazą danych
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo json_encode(["error" => "Połączenie z bazą danych nieudane: " . $e->getMessage()]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($data['email'])) {
    $stmt = $conn->prepare("SELECT * FROM users WHERE email = :email");
    $stmt->bindParam(':email', $data['email']);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // Tutaj logika wysyłania linku do resetowania hasła
        // W prawdziwej aplikacji wysyłaj e-mail z linkiem do resetowania
        echo json_encode(["message" => "Link do resetowania hasła został wysłany na Twój e-mail."]);
    } else {
        echo json_encode(["error" => "Nie znaleziono użytkownika z takim adresem e-mail."]);
    }
} else {
    echo json_encode(["error" => "Proszę podać poprawny adres e-mail."]);
}
?>