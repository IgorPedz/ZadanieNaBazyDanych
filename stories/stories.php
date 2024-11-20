<?php
// Połączenie z bazą danych
$host = "localhost";
$dbname = "socialmedia";
$username = "root";
$password = "";

$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Połączenie nie powiodło się: " . $conn->connect_error);
}

// Zapytanie SQL, które pobiera wszystkie filmiki
$sql = "SELECT * FROM filmiki ORDER BY Data_publikacji DESC";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Wyświetlanie filmików
    while($row = $result->fetch_assoc()) {
        // Pobieramy link do filmu
        $linkToVideo = $row['Link_filmu'];
        
        // Wyświetlanie filmiku za pomocą tagu video HTML
        echo '<div class="video-item">';
        echo '<video width="320" height="240" controls>';
        echo '<source src="' . $linkToVideo . '" type="video/mp4">';
        echo 'Twój przeglądarka nie obsługuje elementu wideo.';
        echo '</video>';
        echo '</div>';
    }
} else {
    echo "Brak filmików do wyświetlenia.";
}

$conn->close();
?>
