<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root"; // your MySQL username
$password = ""; // your MySQL password
$dbname = "socialmedia"; // your MySQL database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$senderId = isset($_POST['senderId']) ? $_POST['senderId'] : '';
$receiverId = isset($_POST['receiverId']) ? $_POST['receiverId'] : '';
$text = isset($_POST['text']) ? $_POST['text'] : '';

if ($senderId && $receiverId && $text) {
    $sql = "INSERT INTO wiadomosci (ID_wysylajacego, ID_odbierajacego, Tresc) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('iis', $senderId, $receiverId, $text);
    
    if ($stmt->execute()) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'error' => 'Unable to send message']);
    }
} else {
    echo json_encode(['status' => 'error', 'error' => 'Missing required fields']);
}

$conn->close();
?>