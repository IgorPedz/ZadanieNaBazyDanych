<?php
// reset-password.php

header("Access-Control-Allow-Origin: http://localhost:3000"); // Zmienna domena frontendowa
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); // Dozwolone metody HTTP
header("Access-Control-Allow-Headers: Content-Type"); // Dozwolone nagłówki

$servername = "localhost";
$username = "root";  // Twoja nazwa użytkownika bazy danych
$password = "";      // Twoje hasło do bazy danych
$dbname = "socialmedia";  // Nazwa bazy danych

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
    // Sprawdzamy, czy użytkownik z takim e-mailem istnieje w bazie
    $stmt = $conn->prepare("SELECT * FROM uzytkownicy WHERE email = :email");
    $stmt->bindParam(':email', $data['email']);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // Generowanie tokenu resetowania hasła
        $token = bin2hex(random_bytes(50));  // Generujemy bezpieczny token
        $expiry = date("Y-m-d H:i:s", strtotime('+1 hour'));  // Token wygasa za godzinę

        // Wstawiamy token do bazy danych
        $updateStmt = $conn->prepare("UPDATE uzytkownicy SET reset_token = :token, reset_expiry = :expiry WHERE email = :email");
        $updateStmt->bindParam(':token', $token);
        $updateStmt->bindParam(':expiry', $expiry);
        $updateStmt->bindParam(':email', $data['email']);
        $updateStmt->execute();

        // Tworzenie linku do resetowania hasła
        $resetLink = "http://localhost/reset-password-form.php?token=" . $token;

        // W prawdziwej aplikacji użyj PHPMailer lub innej biblioteki do wysyłania e-maili
        // Tutaj przykład z użyciem funkcji mail() w PHP:
        $subject = "Link do resetowania hasła";
        $message = "Kliknij poniższy link, aby zresetować swoje hasło:\n\n" . $resetLink;
        $headers = "From: no-reply@socialmedia.com";

        // Wysyłanie e-maila (upewnij się, że Twoja aplikacja jest skonfigurowana do wysyłania e-maili)
        if (mail($data['email'], $subject, $message, $headers)) {
            echo json_encode(["message" => "Link do resetowania hasła został wysłany na Twój e-mail."]);
        } else {
            echo json_encode(["error" => "Wystąpił problem podczas wysyłania e-maila."]);
        }
    } else {
        echo json_encode(["error" => "Nie znaleziono użytkownika z takim adresem e-mail."]);
    }
} else {
    echo json_encode(["error" => "Proszę podać poprawny adres e-mail."]);
}
?>
