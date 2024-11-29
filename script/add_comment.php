<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Set the header to allow JSON responses
header('Content-Type: application/json');

// Database connection
$host = 'localhost';  // Your database host
$dbname = 'socialmedia';  // Your database name
$username = 'root';  // Your database username
$password = '';  // Your database password

// Create a new PDO instance for database connection
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Enable error reporting
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed: ' . $e->getMessage()]);
    exit();
}

// Get the POST data
$data = json_decode(file_get_contents('php://input'), true);

// Validate data
if (isset($data['postId']) && isset($data['comment']) && !empty($data['comment']['content'])) {
    $postId = $data['postId'];
    $author = $data['comment']['author'];
    $content = $data['comment']['content'];
    $likeCount = $data['comment']['likeCount'];

    // Prepare SQL query to insert the comment
    $query = "INSERT INTO komentarze (ID_postu, ID_uzytkownika, Tresc, Ilosc_polubien) VALUES (:postId, :author, :content, :likeCount)";

    // Prepare the statement
    $stmt = $pdo->prepare($query);

    // Bind parameters
    $stmt->bindParam(':postId', $postId);
    $stmt->bindParam(':author', $author);
    $stmt->bindParam(':content', $content);
    $stmt->bindParam(':likeCount', $likeCount);

    // Execute the query
    try {
        $stmt->execute();

        // Respond with success
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        // If there’s a database error, return an error response
        echo json_encode(['success' => false, 'message' => 'Failed to add comment: ' . $e->getMessage()]);
    }
} else {
    // Respond with error if data is not valid
    echo json_encode(['success' => false, 'message' => 'Invalid data']);
}
?>

