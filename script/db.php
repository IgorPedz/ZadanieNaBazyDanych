<?php
// Dane dostępowe do bazy danych
$host = 'localhost';  // lub IP serwera bazy danych
$user = 'root';   // Nazwa użytkownika bazy danych
$password = ''; // Hasło użytkownika
$dbname = 'socialmedia'; // Nazwa bazy danych

// Połączenie z bazą danych
$conn = new mysqli($host, $user, $password, $dbname);

// Sprawdzenie, czy połączenie jest udane
if ($conn->connect_error) {
    // Jeśli połączenie nie powiodło się, wypisz błąd
    die("Błąd połączenia z bazą danych: " . $conn->connect_error);
} else {
    // Połączenie udane
    echo "Połączenie z bazą danych zostało nawiązane!";
}

// Zamknięcie połączenia
$conn->close();
?>