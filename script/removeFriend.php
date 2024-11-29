<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json'); // Nagłówek informujący o formacie JSON

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

// Tworzymy połączenie z bazą danych
$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzamy, czy połączenie zostało wykonane poprawnie
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Odbieramy dane POST z frontendu
$data = json_decode(file_get_contents("php://input"), true);

$sender_id = $data['sender_id']; // ID użytkownika, który chce usunąć znajomego
$friend_id = $data['receiver_id']; // ID znajomego, którego chcemy usunąć

// Usuwamy znajomego z bazy danych
$sql = "DELETE FROM znajomi WHERE (ID_znajomego1 = ? AND ID_znajomego2 = ? OR ID_znajomego1 = ? AND ID_znajomego2 = ?) AND status_znajomosci = 'zatwierdzona'";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iiii", $sender_id, $friend_id, $friend_id, $sender_id);

// Wykonujemy zapytanie
if ($stmt->execute()) {
    // Usuwamy wiadomości pomiędzy użytkownikami
    $sql_delete_messages = "DELETE FROM wiadomosci WHERE (ID_wysylajacego = ? AND ID_odbierajacego = ?) OR (ID_wysylajacego = ? AND ID_odbierajacego = ?)";

    $stmt_delete_messages = $conn->prepare($sql_delete_messages);
    $stmt_delete_messages->bind_param("iiii", $sender_id, $friend_id, $friend_id, $sender_id);

    // Wykonujemy zapytanie usuwające wiadomości
    if ($stmt_delete_messages->execute()) {
        echo json_encode(["success" => "Znajomy został usunięty, a wiadomości usunięte."]);
    } else {
        echo json_encode(["error" => "Wystąpił błąd podczas usuwania wiadomości."]);
    }
} else {
    echo json_encode(["error" => "Wystąpił błąd podczas usuwania znajomego."]);
}

// Zamykamy połączenie z bazą danych
$conn->close();
?>
