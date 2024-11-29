<?php
// Włącz logowanie błędów
ini_set('display_errors', 1);
error_reporting(E_ALL);
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json"); // Ustawienie nagłówka na JSON

// Połączenie z bazą danych
$conn = new mysqli('localhost', 'root', '', 'socialmedia');

// Sprawdzamy, czy połączenie jest udane
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Błąd połączenia z bazą danych']);
    exit;  // Zatrzymanie dalszego wykonywania, jeśli połączenie nie powiodło się
}

// Sprawdzamy, czy otrzymano dane
if (!isset($_POST['postID']) || !isset($_POST['userID'])) {
    echo json_encode(['success' => false, 'message' => 'Brak wymaganych parametrów']);
    exit;  // Zatrzymanie dalszego wykonywania, jeśli brakuje parametrów
}

$postId = $_POST['postID'];
$userId = $_POST['userID'];

// Sprawdzanie, czy użytkownik już polubił post
$sql = "SELECT * FROM polubienia_posty WHERE ID_uzytkownika = ? AND ID_postu = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $userId, $postId);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Usuń polubienie
    $sql = "DELETE FROM polubienia_posty WHERE ID_uzytkownika = ? AND ID_postu = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $userId, $postId);
    $stmt->execute();
    
    // Zmniejsz liczbę polubień
    $sql = "UPDATE posty SET Ilosc_polubien = Ilosc_polubien - 1 WHERE ID_postu = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $postId);
    $stmt->execute();
} else {
    // Dodaj polubienie
    $sql = "INSERT INTO polubienia_posty (ID_uzytkownika, ID_postu) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $userId, $postId);
    $stmt->execute();
    
    // Zwiększ liczbę polubień
    $sql = "UPDATE posty SET Ilosc_polubien = Ilosc_polubien + 1 WHERE ID_postu = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $postId);
    $stmt->execute();
}

// Zwracamy odpowiedź w formacie JSON
echo json_encode(['success' => true, 'newLikeCount' => getLikeCount($postId, $conn)]);

$conn->close();

// Funkcja pomocnicza do pobrania liczby polubień
function getLikeCount($postId, $conn) {
    $sql = "SELECT Ilosc_polubien FROM posty WHERE ID_postu = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $postId);
    $stmt->execute();
    $stmt->bind_result($likeCount);
    $stmt->fetch();
    return $likeCount;
}
?>
