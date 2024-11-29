<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
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

// Funkcja do pobierania znajomych
function getFriends($userId) {
    global $conn;

    // Pobieranie wszystkich znajomych (zarówno zatwierdzonych jak i oczekujących)
    $sql_friends = "
    SELECT u.ID_uzytkownika, u.Imie, u.Nazwisko, u.Nick, z.Status_znajomosci
    FROM znajomi z
    JOIN uzytkownicy u ON (u.ID_uzytkownika = z.ID_znajomego1 OR u.ID_uzytkownika = z.ID_znajomego2)
    WHERE (z.ID_znajomego1 = ? OR z.ID_znajomego2 = ?)
    AND z.Status_znajomosci = 'zatwierdzona'
    AND u.ID_uzytkownika != ?
";

$stmt_friends = $conn->prepare($sql_friends);
$stmt_friends->bind_param("iii", $userId, $userId, $userId);
$stmt_friends->execute();
$result_friends = $stmt_friends->get_result();

$friends = [];
while ($row = $result_friends->fetch_assoc()) {
    $friends[] = $row;  // Zatwierdzeni znajomi
}

// Pobieranie oczekujących zaproszeń
$sql_pending = "
        SELECT u.ID_uzytkownika, u.Imie, u.Nazwisko, u.Nick, z.Status_znajomosci
        FROM znajomi z
        JOIN uzytkownicy u ON u.ID_uzytkownika = z.ID_znajomego1
        WHERE z.ID_znajomego2 = ?
        AND  z.Status_znajomosci = 'oczekująca';
";

$stmt_pending = $conn->prepare($sql_pending);
$stmt_pending->bind_param("i", $userId);
$stmt_pending->execute();
$result_pending = $stmt_pending->get_result();

$pending_requests = [];
while ($row = $result_pending->fetch_assoc()) {
    $pending_requests[] = $row;  // Oczekujące zaproszenia
}

return json_encode([
    'friends' => $friends,
    'pending' => $pending_requests
]);
}

$data = json_decode(file_get_contents("php://input"), true);

// Sprawdzamy, czy został przekazany ID użytkownika
if (isset($data['userId'])) {
    $userId = $data['userId'];
    echo getFriends($userId);
} else {
    echo json_encode(["error" => "Brak wymaganych danych: userId."]);
}

$conn->close();
?>
