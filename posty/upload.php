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
$sql = "
    SELECT 
        p.ID_postu,
        p.Tytul,
        p.Tresc AS TrescPosta,
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
        echo "<p><strong>Treść:</strong> " . htmlspecialchars($row['TrescPosta']) . "</p>";
        echo "<p><strong>Data publikacji:</strong> " . htmlspecialchars($row['Data_publikacji']) . "</p>";
        echo "<p><strong>Polubienia:</strong> " . htmlspecialchars($row['Ilosc_polubien']) . "</p>";

        // Pobranie komentarzy dla aktualnego posta
        $postID = $row['ID_postu'];
        $sql_komentarze = "
            SELECT 
                k.Tresc AS TrescKomentarza,
                k.Data_publikacji,
                k.Ilosc_polubien AS PolubieniaKomentarza,
                u.Imie,
                u.Nazwisko,
                u.Nick
            FROM komentarze k
            JOIN uzytkownicy u ON k.ID_uzytkownika = u.ID_uzytkownika
            WHERE k.ID_postu = $postID
            ORDER BY k.Data_publikacji ASC";

        $result_komentarze = $conn->query($sql_komentarze);

        if ($result_komentarze->num_rows > 0) {
            echo "<div style='margin-top:10px; padding-left:20px; border-left:2px solid #ddd;'>";
            echo "<h4>Komentarze:</h4>";
            while ($komentarz = $result_komentarze->fetch_assoc()) {
                echo "<div style='margin-bottom:10px;'>";
                echo "<p><strong>" . htmlspecialchars($komentarz['Imie']) . " " . htmlspecialchars($komentarz['Nazwisko']) . " (" . htmlspecialchars($komentarz['Nick']) . "):</strong></p>";
                echo "<p>" . htmlspecialchars($komentarz['TrescKomentarza']) . "</p>";
                echo "<p><small>Dodano: " . htmlspecialchars($komentarz['Data_publikacji']) . " | Polubienia: " . htmlspecialchars($komentarz['PolubieniaKomentarza']) . "</small></p>";
                echo "</div>";
            }
            echo "</div>";
        } else {
            echo "<p>Brak komentarzy do wyświetlenia.</p>";
        }

        // Formularz dodawania komentarza
        echo "<form method='POST' action='add_comments.php' style='margin-top:10px;'>";
        echo "<input type='hidden' name='postID' value='" . $postID . "'>";
        echo "<label for='tresc'>Dodaj komentarz:</label><br>";
        echo "<textarea name='tresc' id='tresc' rows='3' cols='50' required></textarea><br>";
        echo "<button type='submit'>Dodaj komentarz</button>";
        echo "</form>";

        echo "</div>";
    }
} else {
    echo "Brak postów do wyświetlenia.";
}

$conn->close();
?>
