<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

// Połączenie z bazą danych
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Zakładając, że ID użytkownika jest przekazywane w zapytaniu (np. ?user_id=1)
$userId = isset($_GET['user_id']) ? (int)$_GET['user_id'] : 1; // Domyślnie ID użytkownika to 1

// Zapytanie do bazy danych w celu pobrania linku do zdjęcia
$sql = "SELECT link_zdjecia FROM uzytkownicy WHERE id_uzytkownika = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userId);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // Pobranie linku do zdjęcia
    $stmt->bind_result($link_zdjecia);
    $stmt->fetch();
    echo json_encode(['status' => 'success', 'link_zdjecia' => $link_zdjecia]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Brak zdjęcia profilowego.']);
}

$conn->close();
?>
