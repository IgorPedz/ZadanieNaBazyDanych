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

// Pobieranie danych z parametrów POST
$commentId = isset($_POST['commentID']) ? $_POST['commentID'] : null;
$userId = isset($_POST['userID']) ? $_POST['userID'] : null;

if ($commentId && $userId) {
    // Sprawdzamy, czy użytkownik już polubił komentarz
    $query = "
        SELECT COUNT(*) FROM polubienia_komentarze 
        WHERE ID_komentarza = ? AND ID_uzytkownika = ?
    ";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$commentId, $userId]);

    $liked = $stmt->fetchColumn() > 0;

    if ($liked) {
        // Jeśli już polubiono, usuwamy polubienie
        $query = "DELETE FROM polubienia_komentarze WHERE ID_komentarza = ? AND ID_uzytkownika = ?";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$commentId, $userId]);

        // Zwracamy zaktualizowaną liczbę polubień
        $query = "SELECT COUNT(*) FROM polubienia_komentarze WHERE ID_komentarza = ?";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$commentId]);
        $likeCount = $stmt->fetchColumn();
        echo json_encode(['success' => true, 'newLikeCount' => $likeCount]);
    } else {
        // Jeśli nie polubiono, dodajemy polubienie
        $query = "INSERT INTO polubienia_komentarze (ID_komentarza, ID_uzytkownika) VALUES (?, ?)";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$commentId, $userId]);

        // Zwracamy zaktualizowaną liczbę polubień
        $query = "SELECT COUNT(*) FROM polubienia_komentarze WHERE ID_komentarza = ?";
        $stmt = $pdo->prepare($query);
        $stmt->execute([$commentId]);
        $likeCount = $stmt->fetchColumn();
        echo json_encode(['success' => true, 'newLikeCount' => $likeCount]);
    }
} else {
    echo json_encode(['error' => 'Brak wymaganych parametrów commentId lub userId']);
}
?>
