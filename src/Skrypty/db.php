<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "localhost";  // Zmienna z nazwą hosta (zwykle localhost)
$username = "root";         // Zmienna z nazwą użytkownika bazy danych
$password = "";             // Zmienna z hasłem do bazy danych
$dbname = "praktyki";    // Zmienna z nazwą bazy danych

// Utwórz połączenie
$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdź połączenie
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
