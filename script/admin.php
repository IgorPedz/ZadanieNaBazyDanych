<?php
// Database connection settings
$host = 'localhost';
$dbname = 'projekt';
$username = 'leo';
$password = 'elo';

try {
    // Establish PDO connection
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Function to display a table's contents
function displayTable($pdo, $tableName, $columns) {
    echo "<h2>Table: $tableName</h2>";
    echo "<table border='1'><tr>";

    // Print table headers
    foreach ($columns as $column) {
        echo "<th>$column</th>";
    }
    echo "</tr>";

    // Query to fetch all rows from the specified table
    try {
        $stmt = $pdo->prepare("SELECT * FROM `$tableName`");
        $stmt->execute();
        
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
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

// Check if a table was selected
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['table']) && array_key_exists($_POST['table'], $tables)) {
    $tableName = $_POST['table'];
}

?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Przeglądanie tabel</title>
</head>
<body>
    <h1>Wybierz tabelę do wyświetlenia</h1>
    <form method="post">
        <?php foreach ($tables as $table => $columns): ?>
            <button type="submit" name="table" value="<?php echo $table; ?>">Tabela <?php echo ucfirst($table); ?></button>
        <?php endforeach; ?>
    </form>

    <?php
    // Display the selected table
    if (!empty($tableName)) {
        displayTable($pdo, $tableName, $tables[$tableName]);
    }
    ?>
</body>
</html>