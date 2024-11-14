<?php
// Zezwalaj na dostęp z dowolnego źródła
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json'); // Nagłówek informujący o formacie JSON

// Jeśli to zapytanie typu OPTIONS (preflight), zakończ odpowiedź
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Połączenie z bazą danych
$host = 'localhost';
$dbname = 'socialmedia'; // Zmień na swoją nazwę bazy danych
$user = 'root'; // Domyślny użytkownik w XAMPP
$password = ''; // Domyślne hasło w XAMPP to pusty ciąg znaków

try {
    // Połączenie z bazą danych
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Błąd połączenia: " . $e->getMessage());
}

// Funkcja do pobierania danych z tabeli
function getTableData($pdo, $tableName) {
    try {
        $stmt = $pdo->query("SELECT * FROM `$tableName`");
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // Zwróć dane jako tablica asocjacyjna
    } catch (PDOException $e) {
        return ['error' => $e->getMessage()];
    }
}

// Funkcja do wykonywania zapytań SQL
function executeCustomQuery($pdo, $query) {
    try {
        // Wykonaj zapytanie SQL
        $stmt = $pdo->query($query);
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // Zwróć dane
    } catch (PDOException $e) {
        return ['error' => 'Błąd wykonania zapytania: ' . $e->getMessage()];
    }
}

// Funkcja do pobierania dostępnych widoków
function getViews($pdo) {
    try {
        // Pobierz dostępne widoki w bazie danych
        $stmt = $pdo->query("SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW'");
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // Zwróć listę widoków
    } catch (PDOException $e) {
        return ['error' => 'Błąd pobierania widoków: ' . $e->getMessage()];
    }
}

// Funkcja do pobierania danych z widoku
function getViewData($pdo, $viewName) {
    try {
        $stmt = $pdo->query("SELECT * FROM `$viewName`");
        return $stmt->fetchAll(PDO::FETCH_ASSOC); // Zwróć dane widoku
    } catch (PDOException $e) {
        return ['error' => 'Błąd pobierania danych z widoku: ' . $e->getMessage()];
    }
}

// Obsługa zapytania GET dla tabeli (np. /admin.php?table=uzytkownicy)
if (isset($_GET['table'])) {
    $table = $_GET['table'];
    $data = getTableData($pdo, $table);
    echo json_encode($data);
} 
// Obsługa zapytania GET dla niestandardowego zapytania SQL (np. /admin.php?query=SELECT * FROM uzytkownicy)
else if (isset($_GET['query'])) {
    $query = $_GET['query'];
    $data = executeCustomQuery($pdo, $query);
    echo json_encode($data);
} 
// Obsługa zapytania GET dla widoków (np. /admin.php?view=widok_nazwa)
else if (isset($_GET['view'])) {
    $view = $_GET['view'];
    $data = getViewData($pdo, $view);
    echo json_encode($data);
}
// Obsługa zapytania GET dla dostępnych widoków (np. /admin.php?views)
else if (isset($_GET['views'])) {
    $data = getViews($pdo);
    echo json_encode($data);
}
// Jeśli nie podano zapytania ani tabeli
else {
    echo json_encode(['error' => 'Brak parametrów do wykonania zapytania.']);
}
?>
