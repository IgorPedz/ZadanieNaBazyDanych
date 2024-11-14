<?php
// Database connection parameters
$host = 'localhost';
$dbname = 'praktyki';
$user = 'leo';
$password = 'elo';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully"; // For testing purposes
} catch (PDOException $e) {
    die('Connection failed: ' . $e->getMessage());
}

// Function to display data from a table or view
function displayTableOrView($pdo, $name, $columns, $isView = false) {
    echo "<h2>" . ($isView ? 'Widok: ' : 'Tabela: ') . $name . "</h2>";
    echo "<table border='1'><tr>";

    // Print table headers
    foreach ($columns as $column) {
        echo "<th>$column</th>";
    }
    echo "</tr>";

    // Query to fetch all rows from the table/view
    try {
        $query = $pdo->query("SELECT * FROM `$name`");
        while ($row = $query->fetch(PDO::FETCH_ASSOC)) {
            echo "<tr>";
            foreach ($columns as $column) {
                echo "<td>" . htmlspecialchars($row[$column]) . "</td>";
            }
            echo "</tr>";
        }
    } catch (Exception $e) {
        echo "<tr><td colspan='" . count($columns) . "'>Error: " . $e->getMessage() . "</td></tr>";
    }
    echo "</table><br>";
}

// List of tables and their columns
$tables = [
    'uzytkownicy' => ['ID_uzytkownika', 'Imie', 'Nazwisko', 'Nick', 'Email', 'Data_Urodzenia'],
    'posty' => ['ID_postu', 'ID_uzytkownika', 'Tresc', 'Tytul', 'Data_publikacji', 'Ilosc_polubien'],
    'komentarze' => ['ID_komentarza', 'ID_postu', 'ID_uzytkownika', 'Tresc', 'Data_publikacji', 'Ilosc_polubien'],
    'filmiki' => ['ID_filmu', 'ID_uzytkownika', 'Link_filmu', 'Data_Publikacji'],
    'obserwujacy' => ['ID_obserwowanego', 'ID_obserwujacego', 'Data_obserwacji'],
    'rozmowy' => ['ID_rozmowy', 'Data_utworzenia', 'Nazwa_rozmowy'],
    'wiadomosci' => ['ID_wiadomosci', 'ID_wysylajacego', 'ID_rozmowy', 'Tresc', 'Wyslano', 'Przeczytano'],
    'znajomi' => ['ID_znajomego1', 'ID_znajomego2', 'Status_znajomosci', 'Poczatek_znajomosci'],
];

// Display each table
foreach ($tables as $tableName => $columns) {
    displayTableOrView($pdo, $tableName, $columns, false);
}

echo "<h1><u>Widoki</u></h1>";

// Fetch and display views
try {
    // Fetch the list of views from information_schema
    $viewsQuery = $pdo->query("SELECT TABLE_NAME FROM information_schema.views WHERE TABLE_SCHEMA = '$dbname'");
    
    // Fetch all view names
    $views = $viewsQuery->fetchAll(PDO::FETCH_COLUMN);
    
    // Loop through views and display their data
    foreach ($views as $viewName) {
        // Fetch columns for each view using DESCRIBE
        $columnsQuery = $pdo->query("DESCRIBE `$viewName`");
        $columns = [];
        while ($column = $columnsQuery->fetch(PDO::FETCH_ASSOC)) {
            $columns[] = $column['Field'];
        }
        
        // Display view data
        displayTableOrView($pdo, $viewName, $columns, true);
    }
} catch (Exception $e) {
    echo "Error fetching views: " . $e->getMessage();
}
?>
