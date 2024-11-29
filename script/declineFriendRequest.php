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

function rejectFriendRequest($userId, $friendId) {
    global $conn;
    
    // Usunięcie zaproszenia z bazy danych
    $sql = "DELETE FROM znajomi
            WHERE (ID_znajomego1 = ? AND ID_znajomego2 = ?) OR (ID_znajomego1 = ? AND ID_znajomego2 = ?)";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiii", $userId, $friendId, $friendId, $userId);
    
    if ($stmt->execute()) {
        return json_encode(["status" => "success", "message" => "Request rejected successfully."]);
    } else {
        return json_encode(["status" => "error", "message" => "Failed to reject the request."]);
    }
}

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['userId']) && isset($data['friendId'])) {
    $userId = $data['userId'];
    $friendId = $data['friendId'];
    echo rejectFriendRequest($userId, $friendId);
} else {
    echo json_encode(["error" => "Missing userId or friendId"]);
}

$conn->close();
?>
