<?php
// Połączenie z bazą danych (zaktualizuj dane połączenia)
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "socialmedia";

// Utworzenie połączenia
$conn = new mysqli($servername, $username, $password, $dbname);

// Sprawdzenie połączenia
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Sprawdzenie, czy użytkownik jest zalogowany (np. przez sesję)
session_start();
$user_id = 8; // Zakłada, że ID użytkownika jest zapisane w sesji

// Obsługa formularza do edycji danych
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $bio = $_POST['bio']; // Pobranie tekstu z formularza
    $kraj = $_POST['kraj']; // Pobranie wpisanego kraju z formularza
    $nick = $_POST['nick']; // Pobranie nowego nicku
    $data_urodzenia = $_POST['data_urodzenia']; // Pobranie nowej daty urodzenia
    $email = $_POST['email']; // Pobranie nowego maila
    $zdjecie_link = $_POST['zdjecie_link']; // Pobranie nowego linku do zdjęcia
    
    // Aktualizacja danych w bazie
    $sql = "UPDATE uzytkownicy SET Bio = ?, Kraj = ?, Nick = ?, Data_Urodzenia = ?, Email = ?, Link_Zdjecia = ? WHERE ID_uzytkownika = ?";
    
    // Przygotowanie i wykonanie zapytania
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssssi", $bio, $kraj, $nick, $data_urodzenia, $email, $zdjecie_link, $user_id);
    
    if ($stmt->execute()) {
        echo "Dane zostały zaktualizowane!";
    } else {
        echo "Błąd przy aktualizacji danych: " . $stmt->error;
    }
    $stmt->close();
}

// Pobranie aktualnych danych użytkownika
$sql = "SELECT Imie, Nazwisko, Email, Nick, Bio, Kraj, Data_Urodzenia, Link_Zdjecia FROM uzytkownicy WHERE ID_uzytkownika = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$stmt->bind_result($current_imie, $current_nazwisko, $current_email, $current_nick, $current_bio, $current_country, $current_birthdate, $current_zdjecie_link);
$stmt->fetch();
$stmt->close();

$conn->close();
?>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edytuj swoje dane</title>
</head>
<body>
    <h1>Edytuj swoje dane</h1>

    <form method="post">
        <!-- Imię i nazwisko (tylko do wyświetlania, nie edytowalne) -->
        <label for="imie">Imię:</label><br>
        <input type="text" id="imie" name="imie" value="<?php echo htmlspecialchars($current_imie); ?>" disabled><br><br>

        <label for="nazwisko">Nazwisko:</label><br>
        <input type="text" id="nazwisko" name="nazwisko" value="<?php echo htmlspecialchars($current_nazwisko); ?>" disabled><br><br>

        <!-- E-mail (tylko do wyświetlania, można edytować) -->
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($current_email); ?>" required><br><br>

        <!-- Nick -->
        <label for="nick">Nick:</label><br>
        <input type="text" id="nick" name="nick" value="<?php echo htmlspecialchars($current_nick); ?>" required><br><br>

        <!-- Data urodzenia -->
        <label for="data_urodzenia">Data urodzenia:</label><br>
        <input type="date" id="data_urodzenia" name="data_urodzenia" value="<?php echo htmlspecialchars($current_birthdate); ?>" required><br><br>

        <!-- Bio -->
        <label for="bio">Bio:</label><br>
        <textarea name="bio" id="bio" rows="5" cols="50"><?php echo htmlspecialchars($current_bio); ?></textarea><br><br>

        <!-- Kraj -->
        <label for="kraj">Kraj:</label><br>
        <input type="text" name="kraj" id="kraj" value="<?php echo htmlspecialchars($current_country); ?>" placeholder="Wpisz kraj"><br><br>

        <!-- Link do zdjęcia profilowego -->
        <label for="zdjecie_link">Link do zdjęcia profilowego:</label><br>
        <input type="url" id="zdjecie_link" name="zdjecie_link" value="<?php echo htmlspecialchars($current_zdjecie_link); ?>" placeholder="Wpisz URL do zdjęcia"><br><br>

        <button type="submit">Zapisz zmiany</button>
    </form>
</body>
</html>
