<?php
session_start();
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'vendor/autoload.php';  // Załaduj PHPMailera

header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");

$host = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Błąd połączenia z bazą danych: " . $e->getMessage());
}

// FUNKCJA WYSYŁANIA E-MAILA Z LINKIEM RESETUJĄCYM
function sendResetEmail($email, $token) {
    // Tworzymy instancję PHPMailera
    $email = new PHPMailer(true);
    try {
        $mail->SMTPDebug = 2;  // Włącz szczegółowy tryb debugowania
        $mail->Debugoutput = 'html';  // Można zmienić na 'error_log', aby zapisywać do logów

        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com'; 
        $mail->SMTPAuth = true;
        $mail->Username = 'fuse.help.center@gmail.com'; // Twój adres Gmail
        $mail->Password = 'ncqk tipv lrtw toah'; // Twoje hasło aplikacji
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port =   465;
        $mail->setFrom('fuse.help.center@gmail.com', 'Fuse Community'); 
        $mail->addAddress($email);
        $mail->isHTML(true);
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'Resetowanie hasła';
        $mail->Body = "
            Witaj,<br>
            Otrzymałeś ten e-mail, ponieważ poprosiłeś o zresetowanie hasła do swojego konta. <br>
            Aby zresetować hasło, kliknij poniższy link: <br>
            <a href='http://localhost/password_reset/resetowanie.php?token=$token'>Zresetuj hasło</a><br>
            Link będzie ważny przez 24 godziny.<br>
            Jeśli nie rozpoczynałeś procesu resetowania hasła, zignoruj tę wiadomość.
        ";
    
        sleep(2);  // Opóźnienie 2 sekundy
        $mail->send();
        echo "E-mail z linkiem resetującym został wysłany.";
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
        // Generowanie unikalnego tokenu
        $token = bin2hex(random_bytes(50)); 
        $stmt = $pdo->prepare("INSERT INTO password_resets (email, token) VALUES (:email, :token)");
        $stmt->execute(['email' => $email, 'token' => $token]);
        
        // Wywołanie funkcji wysyłającej e-mail
        sendResetEmail($email, $token);
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