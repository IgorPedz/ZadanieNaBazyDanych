<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$postId = $data['postId'];
$commentId = $data['commentId'];

// Database connection
$host = 'localhost';
$dbname = 'socialmedia';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Delete the comment from the database
    $stmt = $pdo->prepare("DELETE FROM Komentarze WHERE ID_komentarza = :commentId AND ID_postu = :postId");
    $stmt->execute([
        ':commentId' => $commentId,
        ':postId' => $postId
    ]);

    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
