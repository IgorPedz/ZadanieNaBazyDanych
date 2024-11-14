<?php
// Database connection parameters
$host = 'localhost';
$dbname = 'praktyki';
$user = 'leo';
$password = 'elo';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4", $user, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die('Connection failed: ' . $e->getMessage());
}

// Function to display data from a table or view
function displayTableOrView($pdo, $name, $columns, $isView = false) {
    echo "<h2>" . ($isView ? 'Widok: ' : 'Tabela: ') . $name . "</h2>";
    echo "<table border='1'><tr>";
    foreach ($columns as $column) {
        echo "<th>$column</th>";
    }
    echo "</tr>";

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

// Function to fetch views from the database
function getViews($pdo, $dbname) {
    $views = [];
    try {
        $stmt = $pdo->prepare("SELECT TABLE_NAME FROM information_schema.views WHERE TABLE_SCHEMA = :dbname");
        $stmt->bindParam(':dbname', $dbname, PDO::PARAM_STR);
        $stmt->execute();
        $views = $stmt->fetchAll(PDO::FETCH_COLUMN);
    } catch (PDOException $e) {
        echo "Error fetching views: " . $e->getMessage();
    }
    return $views;
}

// Get columns for a view
function getViewColumns($pdo, $viewName) {
    $columns = [];
    try {
        $stmt = $pdo->prepare("DESCRIBE `$viewName`");
        $stmt->execute();
        while ($column = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $columns[] = $column['Field'];
        }
    } catch (PDOException $e) {
        echo "Error fetching columns for view '$viewName': " . $e->getMessage();
    }
    return $columns;
}

// Handle form submission and display
$selectedName = null;
$isView = false;
$columns = [];
$customQueryResult = null; // To store custom query results
$customQueryError = null; // To store any errors from custom queries

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['table_or_view']) && $_POST['table_or_view'] !== '') {
        $selectedName = $_POST['table_or_view'];
        $isView = isset($_POST['is_view']) && $_POST['is_view'] === 'true';

        if (isset($tables[$selectedName])) {
            $columns = $tables[$selectedName];
        } else {
            $columns = getViewColumns($pdo, $selectedName);
        }
    }

    // Handle custom SQL query
    if (isset($_POST['custom_query']) && !empty($_POST['custom_query'])) {
        try {
            $customQuery = $_POST['custom_query'];
            $stmt = $pdo->query($customQuery);
            $customQueryResult = $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            $customQueryError = $e->getMessage();
        }
    }
}

// Combine tables and views for pagination
$views = getViews($pdo, $dbname);
$allTablesAndViews = array_merge(
    array_map(function($table) { return ['name' => $table, 'is_view' => false]; }, array_keys($tables)),
    array_map(function($view) { return ['name' => $view, 'is_view' => true]; }, $views)
);

// Pagination setup
$totalItems = count($allTablesAndViews);
$itemsPerPage = 19;
$totalPages = ceil($totalItems / $itemsPerPage);
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$page = max(1, min($page, $totalPages));
$startIndex = ($page - 1) * $itemsPerPage;
$itemsOnPage = array_slice($allTablesAndViews, $startIndex, $itemsPerPage);

?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Przeglądanie tabel i widoków</title>
    <style>
        button { margin: 5px; }
        .pagination { margin: 20px; }
        textarea { width: 100%; height: 150px; }
    </style>
</head>
<body>
    <h1>Wybierz tabelę lub widok do wyświetlenia</h1>

    <form method="post">
        <?php foreach ($itemsOnPage as $item): ?>
            <button type="submit" name="table_or_view" value="<?php echo $item['name']; ?>">
                <?php echo $item['is_view'] ? 'Widok ' : 'Tabela '; ?>
                <?php echo ucfirst($item['name']); ?>
            </button>
            <input type="hidden" name="is_view" value="<?php echo $item['is_view'] ? 'true' : 'false'; ?>">
        <?php endforeach; ?>
    </form>

    <div class="pagination">
        <?php if ($page > 1): ?>
            <a href="?page=<?php echo $page - 1; ?>">Poprzednia</a>
        <?php endif; ?>
        
        <?php if ($page < $totalPages): ?>
            <a href="?page=<?php echo $page + 1; ?>">Następna</a>
        <?php endif; ?>
    </div>

    <h2>Wykonaj zapytanie SQL:</h2>
    <form method="post">
        <textarea name="custom_query" placeholder="Wprowadź zapytanie SQL..."></textarea><br>
        <button type="submit">Wykonaj zapytanie</button>
    </form>

    <?php
    // Display the results of the custom query
    if ($customQueryResult !== null) {
        echo "<h2>Wyniki zapytania SQL</h2>";
        if (empty($customQueryResult)) {
            echo "Zapytanie wykonane.";
        } else {
            echo "<table border='1'><tr>";
            // Display column headers
            foreach (array_keys($customQueryResult[0]) as $column) {
                echo "<th>$column</th>";
            }
            echo "</tr>";

            // Display rows
            foreach ($customQueryResult as $row) {
                echo "<tr>";
                foreach ($row as $value) {
                    echo "<td>" . htmlspecialchars($value) . "</td>";
                }
                echo "</tr>";
            }
            echo "</table>";
        }
    }

    // Show any error for the custom query
    if ($customQueryError !== null) {
        echo "<p style='color: red;'>Błąd: $customQueryError</p>";
    }

    // Display the selected table or view
    if ($selectedName !== null) {
        displayTableOrView($pdo, $selectedName, $columns, $isView);
    }
    ?>
</body>
</html>
