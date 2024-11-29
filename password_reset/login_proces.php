<?php
header("Access-Control-Allow-Origin: http://localhost:3000");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE, PUT");
header("Access-Control-Allow-Headers: Content-Type");
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

// Sprawdzamy, czy formularz został wysłany
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Otrzymanie danych z formularza
    if (isset($_POST['email']) && isset($_POST['password'])) {
        $email = $_POST['email'];
        $password = $_POST['password'];

        // Przygotowanie zapytania do bazy danych
        $stmt = $pdo->prepare("SELECT * FROM uzytkownicy WHERE Email = :email");  // Zmieniono na 'Email' zgodnie z bazą
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch();

        if ($user) {
            // Porównanie hasła z tym zapisanym w bazie danych
            if (password_verify($password, $user['Haslo'])) {  // Zmieniono na 'Haslo'
                echo "Zalogowano pomyślnie!";
                // Możesz tutaj np. przejść do dashboardu, lub przekierować użytkownika
                // session_start(); // Rozpocznij sesję
                // $_SESSION['user_id'] = $user['ID_uzytkownika']; // Zapamiętaj użytkownika w sesji
                // header("Location: dashboard.php"); // Przekierowanie na stronę powitalną po zalogowaniu
            } else {
                echo "Nieprawidłowe hasło.";
            }
        } else {
            echo "Nie znaleziono użytkownika o podanym adresie e-mail.";
        }
    } else {
        echo "Proszę wprowadzić e-mail i hasło.";
    }
}
?>