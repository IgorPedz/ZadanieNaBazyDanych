<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

// Parametry połączenia z bazą danych
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Nazwa bazy danych

// Połączenie z bazą danych
$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Błąd połączenia: " . $conn->connect_error]));
}

// Zapytanie SQL, które pobiera najpopularniejsze hasztagi z widoku
$query = "SELECT hashtag, count FROM popular_hashtags ORDER BY count DESC LIMIT 10";
$result = $conn->query($query);

// Sprawdzenie, czy zapytanie zakończyło się sukcesem
if ($result) {
    $hashtags = [];
    // Pobranie wyników zapytania do tablicy
    while ($row = $result->fetch_assoc()) {
        $hashtags[] = $row;
    }

    // Zwrócenie danych jako JSON
    echo json_encode($hashtags);
} else {
    // Jeśli zapytanie się nie powiedzie
    echo json_encode(["status" => "error", "message" => "Błąd zapytania: " . $conn->error]);
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
