<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");
$host = 'localhost';
$dbname = 'socialmedia';
$username = 'root';
$password = '';

try {
    // Połączenie z bazą danych
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Pobranie filmów z bazy danych
    $stmt = $pdo->query("SELECT f.Link_filmu, u.Imie, u.Nazwisko
                            FROM filmiki f
                            LEFT JOIN uzytkownicy u ON f.ID_uzytkownika = u.ID_uzytkownika;
                            ");
    $videos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Zwrócenie wyników w formacie JSON
    echo json_encode($videos);

} catch (PDOException $e) {
    echo "Błąd połączenia z bazą danych: " . $e->getMessage();
}
?>
