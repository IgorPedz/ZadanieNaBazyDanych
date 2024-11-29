<?php
header('Access-Control-Allow-Origin: *'); // Możesz zastąpić '*' na domenę, której chcesz zezwolić
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
header("Content-Type: application/json");

// Konfiguracja bazy danych
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'socialmedia';

// Połączenie z bazą danych
try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // Włącz tryb zgłaszania wyjątków
} catch (PDOException $e) {
    echo json_encode(['error' => 'Błąd połączenia z bazą danych: ' . $e->getMessage()]);
    exit;
}

// Pobieranie danych z parametrów GET
$commentId = isset($_GET['commentId']) ? $_GET['commentId'] : null;
$userId = isset($_GET['userId']) ? $_GET['userId'] : null;

if ($commentId && $userId) {
    // Sprawdzamy, czy komentarz istnieje w tabeli 'komentarze'
    $query = "SELECT COUNT(*) FROM komentarze WHERE id_komentarza = ?";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$commentId]);
    $commentExists = $stmt->fetchColumn() > 0;

    if (!$commentExists) {
        echo json_encode(['error' => 'Komentarz o podanym ID nie istnieje']);
        exit;
    }

    // Sprawdzamy, czy użytkownik już polubił komentarz
    $query = "
        SELECT COUNT(*) FROM polubienia_komentarze 
        WHERE ID_komentarza = ? AND ID_uzytkownika = ?
    ";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$commentId, $userId]);

    $liked = $stmt->fetchColumn() > 0;

    // Zwracamy odpowiedź z informacją o stanie polubienia i liczbę polubień
    $query = "SELECT COUNT(*) FROM polubienia_komentarze WHERE ID_komentarza = ?";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$commentId]);
    $likeCount = $stmt->fetchColumn();

    echo json_encode([
        'liked' => $liked ? 1 : 0, // 1 jeśli polubiono, 0 jeśli nie
        'likeCount' => $likeCount
    ]);
} else {
    echo json_encode(['error' => 'Brak wymaganych parametrów commentId lub userId']);
}
?>
