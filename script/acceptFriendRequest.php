<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

function acceptFriendRequest($userId, $friendId) {
    global $conn;
    
    // Zaktualizowanie statusu zaproszenia na "zatwierdzona"
    $sql = "UPDATE znajomi
            SET Status_znajomosci = 'zatwierdzona'
            WHERE (ID_znajomego1 = ? AND ID_znajomego2 = ?) OR (ID_znajomego1 = ? AND ID_znajomego2 = ?)";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiii", $userId, $friendId, $friendId, $userId);
    
    if ($stmt->execute()) {
        return json_encode(["status" => "success", "message" => "Request accepted successfully."]);
    } else {
        return json_encode(["status" => "error", "message" => "Failed to accept the request."]);
    }
}

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['userId']) && isset($data['friendId'])) {
    $userId = $data['userId'];
    $friendId = $data['friendId'];
    echo acceptFriendRequest($userId, $friendId);
} else {
    echo json_encode(["error" => "Missing userId or friendId"]);
}

$conn->close();
?>
