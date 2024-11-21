<?php
session_start();

// Połączenie z bazą danych
$host = "localhost";
$username = "root";  // Twoja nazwa użytkownika bazy danych
$password = "";      // Twoje hasło do bazy danych
$dbname = "socialmedia";  // Nazwa bazy danych

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Błąd połączenia z bazą danych: " . $e->getMessage());
}

// Sprawdzenie, czy istnieje token w URL
if (isset($_GET['token'])) {
    $token = $_GET['token'];

    // Sprawdzamy, czy token istnieje w bazie danych
    $stmt = $pdo->prepare("SELECT * FROM password_resets WHERE token = :token");
    $stmt->execute(['token' => $token]);
    $resetRequest = $stmt->fetch();

    if ($resetRequest) {
        // Sprawdzamy, czy formularz do resetowania hasła został wysłany
        if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['new_password'])) {
            $newPassword = password_hash($_POST['new_password'], PASSWORD_BCRYPT); // Hashowanie nowego hasła

            // Zaktualizowanie hasła użytkownika
            $stmt = $pdo->prepare("UPDATE uzytkownicy SET haslo = :new_password WHERE email = :email");
            $stmt->execute(['new_password' => $newPassword, 'email' => $resetRequest['email']]);

            // Usunięcie tokenu z tabeli password_resets
            $stmt = $pdo->prepare("DELETE FROM password_resets WHERE email = :email");
            $stmt->execute(['email' => $resetRequest['email']]);

            // Komunikat informujący o pomyślnym zresetowaniu hasła
            echo "Hasło zostało pomyślnie zmienione.";
             echo "<br><a href='login_proces.php'>Kliknij tutaj, aby się zalogować</a>";
        } else {
            echo "
                <h2>Resetowanie hasła</h2>
                <form method='POST'>
                    <label for='new_password'>Nowe hasło:</label><br>
                    <input type='password' name='new_password' required><br><br>
                    <button type='submit'>Zresetuj hasło</button>
                </form>
            ";
        }
    } else {
        echo "Token resetowania hasła jest nieprawidłowy lub wygasł.";
    }
} else {
    echo "Brak tokenu resetowania hasła.";
}
?>