<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Twoja baza danych

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Połączenie nieudane: " . $conn->connect_error]));
}

if (isset($_GET['username'])) {
    $username = $_GET['username'];

    $stmt = $conn->prepare("SELECT * FROM uzytkownicy WHERE Nick = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        echo json_encode([
            "status" => "success",
            "data" => $user
        ]);
    } else {
        echo json_encode(["status" => "error", "message" => "Użytkownik nie znaleziony"]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Brak nazwy użytkownika"]);
}

$conn->close();
?>
