<?php
session_start();
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


header("Access-Control-Allow-Origin: http://localhost:3000"); // Zmienna domena frontendowa
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT"); // Dozwolone metody HTTP
header("Access-Control-Allow-Headers: Content-Type"); // Dozwolone nagłówki

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

// FUNKCJA WYSYŁANIA E-MAILA Z LINKIEM RESETUJĄCYM
function sendResetEmail($email, $token) {
    $mail = new PHPMailer(true);

    try {
        // Konfiguracja SMTP
        $mail->isSMTP();
        $mail->Host = 'smtp.example.com'; // Zastąp adresem swojego serwera SMTP
        $mail->SMTPAuth = true;
        $mail->Username = 'your_email@example.com'; // Twój adres e-mail
        $mail->Password = 'your_password'; // Twoje hasło do e-maila
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        // Dane nadawcy i odbiorcy
        $mail->setFrom('your_email@example.com', 'Reset Hasła');
        $mail->addAddress($email);

        // Treść e-maila
        $mail->isHTML(true);
        $mail->Subject = 'Resetowanie hasła';
        $mail->Body = "
            Kliknij poniższy link, aby zresetować swoje hasło:<br>
            <a href='http://localhost/reset/resetowanie.php?token=$token'>Resetuj hasło</a><br>
            Jeśli to nie Ty zgłaszałeś reset hasła, zignoruj tę wiadomość.
        ";

        $mail->send();
    } catch (Exception $e) {
        echo "Nie udało się wysłać wiadomości e-mail: {$mail->ErrorInfo}";
    }
}

// ZARZĄDZANIE RESETEM
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['email'])) {
    // Wysłanie linku resetującego
    $email = $_POST['email'];
    $stmt = $pdo->prepare("SELECT * FROM uzytkownicy WHERE email = :email");
    $stmt->execute(['email' => $email]);
    $user = $stmt->fetch();

    if ($user) {
        $token = bin2hex(random_bytes(50)); // Generowanie unikalnego tokenu
        $stmt = $pdo->prepare("INSERT INTO password_resets (email, token) VALUES (:email, :token)");
        $stmt->execute(['email' => $email, 'token' => $token]);

        sendResetEmail($email, $token);
        echo "E-mail z linkiem resetującym został wysłany.";
    } else {
        echo "Nie znaleziono użytkownika z podanym adresem e-mail.";
    }
} elseif (isset($_GET['token'])) {
    // Obsługa linku resetującego
    $token = $_GET['token'];
    $stmt = $pdo->prepare("SELECT * FROM password_resets WHERE token = :token");
    $stmt->execute(['token' => $token]);
    $reset = $stmt->fetch();

    if ($reset) {
        if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST['new_password'])) {
            $newPassword = password_hash($_POST['new_password'], PASSWORD_BCRYPT);
            $stmt = $pdo->prepare("UPDATE uzytkownicy SET password = :password WHERE email = :email");
            $stmt->execute(['password' => $newPassword, 'email' => $reset['email']]);

            $stmt = $pdo->prepare("DELETE FROM password_resets WHERE email = :email");
            $stmt->execute(['email' => $reset['email']]);

            echo "Hasło zostało pomyślnie zresetowane.";
        } else {
            echo "
                <form method='POST'>
                    <label>Nowe hasło:</label>
                    <input type='password' name='new_password' required>
                    <button type='submit'>Zresetuj hasło</button>
                </form>
            ";
        }
    } else {
        echo "Nieprawidłowy token resetujący.";
    }
} else {
    // Formularz do wpisania adresu e-mail
    echo "
        <form method='POST'>
            <label>Podaj swój e-mail:</label>
            <input type='email' name='email' required>
            <button type='submit'>Zresetuj hasło</button>
        </form>
    ";
}
?>
