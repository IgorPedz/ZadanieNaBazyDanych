<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root"; // Zmień na swój użytkownik bazy danych
$password = ""; // Zmień na swoje hasło
$dbname = "socialmedia"; // Nazwa bazy danych

$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzamy, czy połączenie z bazą danych powiodło się
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$targetDir = "uploads/"; // Folder, w którym będą zapisywane pliki wideo
$targetFile = $targetDir . basename($_FILES["video"]["name"]);
$uploadOk = 1;
$videoFileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

$userId = $_POST['userId'];

// Sprawdzamy, czy przekazano userId
if ($userId === null) {
    echo json_encode(['success' => false, 'message' => 'User ID is required']);
    exit();
}

// Sprawdzamy, czy plik jest wideo
if (isset($_POST["submit"])) {
    $check = getimagesize($_FILES["video"]["tmp_name"]);
    if ($check !== false) {
        echo "Plik jest wideo - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        echo "Plik nie jest wideo.";
        $uploadOk = 0;
    }
}

// Sprawdzamy rozmiar pliku
if ($_FILES["video"]["size"] > 50000000) { // Ograniczenie do 50MB
    echo "Sorry, plik jest za duży.";
    $uploadOk = 0;
}

// Sprawdzamy typ pliku
if ($videoFileType != "mp4" && $videoFileType != "avi" && $videoFileType != "mov") {
    echo "Sorry, tylko pliki wideo MP4, AVI, MOV są dozwolone.";
    $uploadOk = 0;
}

// Jeśli upload jest OK, przesyłamy plik
if ($uploadOk == 0) {
    echo "Sorry, Twój plik nie został przesłany.";
} else {
    if (move_uploaded_file($_FILES["video"]["tmp_name"], $targetFile)) {
        echo "Plik " . htmlspecialchars(basename($_FILES["video"]["name"])) . " został przesłany.";

        // Zapisz dane filmu w bazie danych
        $fileName = basename($_FILES["video"]["name"]);
        $filePath = $targetFile;

        // Wstawiamy dane do bazy danych
        $stmt = $conn->prepare("INSERT INTO filmiki (Link_filmu, ID_uzytkownika) VALUES (?, ?)");
        $stmt->bind_param("si", $filePath, $userId);

        if ($stmt->execute()) {
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to save to database']);
        }

        $stmt->close();
    } else {
        echo "Sorry, wystąpił błąd przy przesyłaniu pliku.";
    }
}

$conn->close();
?>
