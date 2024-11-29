<?php
// uploadVideo.php

// Ustawienia połączenia z bazą danych
$host = 'localhost';
$dbname = 'instastories';
$username = 'socialmedia';
$password = '';

try {
    // Połączenie z bazą danych
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Sprawdzenie, czy plik został wysłany
    if (isset($_FILES['video']) && $_FILES['video']['error'] == 0) {
        $fileTmpPath = $_FILES['video']['tmp_name'];
        $fileName = $_FILES['video']['name'];
        $filePath = 'videos/' . $fileName;

        // Sprawdzenie typu pliku
        $allowedTypes = ['video/mp4', 'video/avi', 'video/mkv'];
        if (in_array($_FILES['video']['type'], $allowedTypes)) {

            // Sprawdzenie rozmiaru pliku (maksymalnie 100 MB)
            $maxFileSize = 100 * 1024 * 1024; // 100 MB
            if ($_FILES['video']['size'] > $maxFileSize) {
                echo "Plik jest zbyt duży. Maksymalny rozmiar to 100 MB.";
                exit;
            }

            // Przeniesienie pliku na serwer
            if (move_uploaded_file($fileTmpPath, $filePath)) {
                // Zapisanie nazwy pliku w bazie danych
                $stmt = $pdo->prepare("INSERT INTO filmiki (Link_filmu) VALUES (:filename)");
                $stmt->bindParam(':filename', $fileName);
                $stmt->execute();

                echo "Plik został przesłany pomyślnie!";
            } else {
                echo "Wystąpił problem z przesyłaniem pliku.";
            }
        } else {
            echo "Nieobsługiwany format pliku.";
        }
    } else {
        echo "Brak pliku do przesłania.";
    }

} catch (PDOException $e) {
    echo "Błąd połączenia z bazą danych: " . $e->getMessage();
}
?>
