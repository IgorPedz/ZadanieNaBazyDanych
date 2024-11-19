<?php
// Połączenie z bazą danych
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Zmienna z nazwą bazy danych

$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die("Połączenie nieudane: " . $conn->connect_error);
}

// Sprawdzenie, czy formularz został wysłany metodą POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pobieranie danych z formularza
    $tytul = $_POST['tytul'];
    $tresc = $_POST['tresc'];
    $link_zdjecia = isset($_POST['link_zdjecia']) ? $_POST['link_zdjecia'] : NULL;
    $hasztagi = isset($_POST['hasztagi']) ? $_POST['hasztagi'] : NULL;

    // Zabezpieczenie przed SQL Injection za pomocą przygotowanych zapytań
    $stmt = $conn->prepare("INSERT INTO posty (Tytul, Tresc, Link_zdjecia, Hasztagi) 
                            VALUES (?, ?, ?, ?)");
    
    if (!$stmt) {
        echo "Błąd przygotowania zapytania: " . $conn->error;
        exit;
    }

    
    
    // Przypisanie zmiennych do zapytania
    $stmt->bind_param("ssss", $tytul, $tresc, $link_zdjecia, $hasztagi);

    // Wykonanie zapytania
    if ($stmt->execute()) {
        echo "Post został pomyślnie dodany!";
    } else {
        echo "Błąd podczas dodawania posta: " . $stmt->error;
    }

    // Zamknięcie przygotowanego zapytania
    $stmt->close();
} else {
    echo "Formularz nie został wysłany metodą POST.";
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
