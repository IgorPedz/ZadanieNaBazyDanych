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
    $tresc = $conn->real_escape_string($_POST['tresc']);
    $userID = 1; // ID zalogowanego użytkownika (na razie na stałe, zmień według systemu logowania)

    // Dodanie komentarza do bazy
    $sql = "INSERT INTO komentarze (ID_postu, ID_uzytkownika, Tresc) VALUES ($postID, $userID, '$tresc')";

    if ($conn->query($sql) === TRUE) {
        echo "Komentarz został dodany!";
        header("Location: upload.php"); // Przekierowanie z powrotem na stronę główną
        exit();
    } else {
        echo "Błąd: " . $conn->error;
    }
}

$conn->close();
?>
