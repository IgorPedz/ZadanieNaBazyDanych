<?php

// Dane do połączenia z bazą danych
$host = "localhost";  // Adres serwera bazy danych
$dbname = "socialmedia";  // Nazwa bazy danych
$username = "root";  // Nazwa użytkownika bazy danych
$password = "";  // Hasło użytkownika bazy danych

// Tworzenie połączenia
$conn = new mysqli($host, $username, $password, $dbname);

// Sprawdzanie, czy połączenie się powiodło
if ($conn->connect_error) {
    die("Połączenie nie powiodło się: " . $conn->connect_error);
}
echo "Połączenie z bazą danych powiodło się!";

if (!file_exists('uploads')) {
    mkdir('uploads', 0777, true); // 0777 - uprawnienia do odczytu, zapisu i wykonywania
}
// Sprawdzenie, czy plik został przesłany
if (isset($_FILES['file'])) {
    $file = $_FILES['file'];
    $fileName = $_FILES['file']['name'];
    $fileTmpName = $_FILES['file']['tmp_name'];
    $fileSize = $_FILES['file']['size'];
    $fileError = $_FILES['file']['error'];
    $fileType = $_FILES['file']['type'];
    
    // Sprawdzanie, czy nie wystąpiły błędy podczas przesyłania
    if ($fileError === 0) {
        // Sprawdzenie, czy plik jest filmem
        $fileExt = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        $allowed = ['mp4', 'mov', 'avi']; // Dozwolone formaty

        if (in_array($fileExt, $allowed)) {
            // Generowanie unikalnej nazwy dla pliku
            $newFileName = uniqid('', true) . "." . $fileExt;
            $fileDestination = 'uploads/' . $newFileName;

            // Przeniesienie pliku do odpowiedniego folderu
            if (move_uploaded_file($fileTmpName, $fileDestination)) {
                // Po zapisaniu pliku w folderze, zapisz jego dane w bazie danych
                $userId = 1; // ID użytkownika, który wysyła film (np. z sesji)
                $linkToVideo = $fileDestination; // Link do filmu w systemie

                // Zapytanie SQL do dodania filmiku
                $conn = new mysqli('localhost', 'root', '', 'socialmedia');
                if ($conn->connect_error) {
                    die("Connection failed: " . $conn->connect_error);
                }

                $sql = "INSERT INTO `filmiki` (`ID_uzytkownika`, `Link_filmu`, `Data_publikacji`)
                        VALUES ('$userId', '$linkToVideo', NOW())";
                if ($conn->query($sql) === TRUE) {
                    echo "Filmik został dodany!";
                } else {
                    echo "Błąd: " . $conn->error;
                }
                $conn->close();
            } else {
                echo "Błąd przy przesyłaniu pliku.";
            }
        } else {
            echo "Nieobsługiwany format pliku.";
        }
    } else {
        echo "Błąd przesyłania pliku.";
    }
}
?>
