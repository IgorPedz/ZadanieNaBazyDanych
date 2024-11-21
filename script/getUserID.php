<?php
// Połączenie z bazą danych
header("Content-Type: application/json");
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia"; // Zmienna z nazwą bazy danych

$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Połączenie nieudane: " . $conn->connect_error]));
}

// Sprawdzanie, czy e-mail został przekazany
if (isset($_GET['email'])) {
    $email = $_GET['email'];

    // Zapytanie SQL, aby pobrać userID na podstawie e-maila
    $stmt = $conn->prepare("SELECT id_uzytkownika FROM uzytkownicy WHERE email = ?");
    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Błąd przygotowania zapytania: " . $conn->error]);
        exit;
    }

    // Przypisanie e-maila do zapytania
    $stmt->bind_param("s", $email);

    // Wykonanie zapytania
    $stmt->execute();

    // Sprawdzanie wyników
    $stmt->store_result();
    if ($stmt->num_rows > 0) {
        // Użytkownik istnieje, pobieramy userID
        $stmt->bind_result($userID);
        $stmt->fetch();
        echo json_encode(["status" => "success", "userID" => $userID]);
    } else {
        echo json_encode(["status" => "error", "message" => "Nie znaleziono użytkownika z tym e-mailem."]);
    }

    // Zamknięcie zapytania
    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Brak e-maila w zapytaniu."]);
}

// Zamknięcie połączenia z bazą danych
$conn->close();
?>
