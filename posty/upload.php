<?php
// Połączenie z bazą danych
$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'socialmedia';

$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Błąd połączenia: " . $conn->connect_error);
}

// Pobranie postów z bazy danych
$sql = "
    SELECT 
        p.ID_postu,
        p.Tytul,
        p.Tresc,
        p.Data_publikacji,
        p.Ilosc_polubien,
        u.Imie,
        u.Nazwisko,
        u.Nick
    FROM posty p
    JOIN uzytkownicy u ON p.ID_uzytkownika = u.ID_uzytkownika
    ORDER BY p.Data_publikacji DESC";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<h1>Lista postów:</h1>";
    while ($row = $result->fetch_assoc()) {
        echo "<div style='border:1px solid #ccc; margin-bottom:10px; padding:10px;'>";
        echo "<h2>" . htmlspecialchars($row['Tytul']) . "</h2>";
        echo "<p><strong>Autor:</strong> " . htmlspecialchars($row['Imie']) . " " . htmlspecialchars($row['Nazwisko']) . " (" . htmlspecialchars($row['Nick']) . ")</p>";
        echo "<p><strong>Treść:</strong> " . htmlspecialchars($row['Tresc']) . "</p>";
        echo "<p><strong>Data publikacji:</strong> " . htmlspecialchars($row['Data_publikacji']) . "</p>";
        echo "<p><strong>Polubienia:</strong> " . htmlspecialchars($row['Ilosc_polubien']) . "</p>";
        echo "</div>";
    }
} else {
    echo "Brak postów do wyświetlenia.";
}

$conn->close();
?>