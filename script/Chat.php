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

// Get friend username from query parameter
$senderId = $_GET['senderId'];
$receiverId = $_GET['receiverId'];

if ($senderId) {
    $sql = "SELECT wiadomosci.*, 
       sender.Imie AS sender_username, 
       receiver.Imie AS receiver_username
        FROM wiadomosci
        JOIN uzytkownicy AS sender ON wiadomosci.ID_wysylajacego = sender.ID_uzytkownika
        JOIN uzytkownicy AS receiver ON wiadomosci.ID_odbierajacego = receiver.ID_uzytkownika
        WHERE (wiadomosci.ID_wysylajacego = ? AND wiadomosci.ID_odbierajacego = ?) 
        OR (wiadomosci.ID_wysylajacego = ? AND wiadomosci.ID_odbierajacego = ?)
        ORDER BY wiadomosci.Wyslano ASC;";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param('iiii', $senderId, $receiverId, $receiverId, $senderId);
    $stmt->execute();
    $result = $stmt->get_result();

    $messages = [];
    while ($row = $result->fetch_assoc()) {
        $messages[] = $row;
    }

    echo json_encode($messages);
} else {
    echo json_encode([]);
}

$conn->close();
?>
