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

// Pobranie danych z formularza
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $postID = intval($_POST['postID']);

    // Zwiększenie liczby polubień posta
    $sql = "UPDATE posty SET Ilosc_polubien = Ilosc_polubien + 1 WHERE ID_postu = $postID";

    if ($conn->query($sql) === TRUE) {
        echo "Post został polubiony!";
        header("Location: upload.php"); // Przekierowanie z powrotem na stronę główną
        exit();
    } else {
        echo "Błąd: " . $conn->error;
    }
}

$conn->close();
?>
