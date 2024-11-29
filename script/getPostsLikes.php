
<?php
// Połączenie z bazą danych
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
$conn = new mysqli('localhost', 'root', '', 'socialmedia');

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$postId = $_GET['postId']; // ID postu, którego stan polubienia chcemy pobrać

// Zapytanie do bazy danych, aby pobrać dane o polubieniu postu
$sql = "SELECT 
            p.Ilosc_polubien,
            IF(l.ID_uzytkownika IS NOT NULL, 1, 0) AS liked
        FROM posty p
        LEFT JOIN polubienia_posty l ON p.ID_postu = l.ID_postu AND l.ID_uzytkownika = ? 
        WHERE p.ID_postu = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $_GET['userId'], $postId);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $post = $result->fetch_assoc();
    echo json_encode($post); // Zwracamy dane o stanie polubienia i liczbie polubień
} else {
    echo json_encode(['error' => 'Post not found']);
}

$conn->close();
?>
