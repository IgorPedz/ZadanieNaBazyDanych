<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json'); // Nagłówek informujący o formacie JSON

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Funkcja do wysyłania zaproszenia do znajomego
function sendFriendRequest($sender_id, $receiver_id) {
    global $conn;

    // Sprawdzamy, czy zaproszenie już istnieje
    $sql = "SELECT * FROM znajomi WHERE ID_znajomego1 = ? AND ID_znajomego2 = ? AND status_znajomosci = 'oczekująca'";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $sender_id, $receiver_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        // Zaproszenie już zostało wysłane
        return json_encode(["error" => "Zaproszenie już zostało wysłane."]);
    }

    // Wstawiamy zaproszenie do bazy danych
    $sql = "INSERT INTO znajomi (ID_znajomego1, ID_znajomego2, status_znajomosci) VALUES (?, ?, 'oczekująca')";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $sender_id, $receiver_id);
    
    if ($stmt->execute()) {
        // Wysłano zaproszenie, teraz generujemy powiadomienie w formie odpowiedzi
        return json_encode(["success" => "Zaproszenie zostało wysłane. Masz nowe zaproszenie do znajomych!"]);
    } else {
        return json_encode(["error" => "Wystąpił błąd podczas wysyłania zaproszenia."]);
    }
}

// Odbieramy dane JSON
$data = json_decode(file_get_contents("php://input"), true);

// Sprawdzamy, czy dane zostały poprawnie przesłane
if (isset($data['sender_id']) && isset($data['receiver_id'])) {
    $sender_id = $data['sender_id'];
    $receiver_id = $data['receiver_id'];
    echo sendFriendRequest($sender_id, $receiver_id);
} else {
    echo json_encode(["error" => "Brak wymaganych danych: sender_id lub receiver_id."]);
}

$conn->close();
?>
