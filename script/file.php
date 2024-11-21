<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type");

// Połączenie z bazą danych (np. MySQL)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Sprawdzenie, czy plik został wysłany

if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
    $uploadedFile = $_FILES['image'];
    $fileName = $uploadedFile['name'];
    $fileTmpPath = $uploadedFile['tmp_name'];
    $fileSize = $uploadedFile['size'];
    $fileType = $uploadedFile['type'];

    // Debugowanie informacji o przesyłanym pliku
    // Zwróć informacje o pliku, aby upewnić się, że jest poprawnie przesyłany
    error_log("Nazwa pliku: " . $fileName);
    error_log("Typ pliku: " . $fileType);
    error_log("Rozmiar pliku: " . $fileSize);

    // Sprawdzenie rozszerzenia pliku
    $allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    $fileExtension = pathinfo($fileName, PATHINFO_EXTENSION);
    if (!in_array(strtolower($fileExtension), $allowedExtensions)) {
        echo json_encode(['status' => 'error', 'message' => 'Nieobsługiwany format pliku.']);
        exit;
    }

    // Zmienna na nazwę pliku
    $newFileName = uniqid() . '.' . $fileExtension;
    $uploadDirectory = 'uploads/'; // Katalog, w którym będą przechowywane zdjęcia

    // Upewnij się, że katalog istnieje
    if (!is_dir($uploadDirectory)) {
        if (!mkdir($uploadDirectory, 0755, true)) {
            echo json_encode(['status' => 'error', 'message' => 'Nie udało się utworzyć katalogu.']);
            exit;
        }
    }

    // Sprawdzenie, czy plik został poprawnie przeniesiony
    $uploadPath = $uploadDirectory . $newFileName;
    if (move_uploaded_file($fileTmpPath, $uploadPath)) {
        // Zapisz ścieżkę do bazy danych
        $userId = 29; // W tym przypadku zakładamy, że ID użytkownika to 1 (możesz to zmienić)

        $sql = "UPDATE uzytkownicy SET link_zdjecia = ? WHERE id_uzytkownika = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("si", $uploadPath, $userId);

        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Zdjęcie zapisane pomyślnie!', 'file' => $uploadPath]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Błąd zapisu do bazy danych.']);
        }
    } else {
        // Błąd przenoszenia pliku
        echo json_encode(['status' => 'error', 'message' => 'Wystąpił problem z przesyłaniem pliku.']);
    }
} else {
    // Brak pliku lub błąd w przesyłaniu
    $error = $_FILES['image']['error'] ?? 'Nieznany błąd';
    echo json_encode(['status' => 'error', 'message' => 'Brak pliku lub wystąpił błąd podczas przesyłania: ' . $error]);
}

$conn->close();
?>
