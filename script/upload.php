<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");  

$host = 'localhost';
$username = 'root';
$password = '';
$dbname = 'socialmedia';

// Połączenie z bazą danych
$conn = new mysqli($host, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Błąd połączenia: " . $conn->connect_error);
}

// Zapytanie do bazy danych o posty
$sql = "
    SELECT
        p.ID_postu,
        p.Tytul,
        p.Tresc,
        p.Data_publikacji,
        p.Ilosc_polubien,
        p.Hasztagi,
        p.ID_uzytkownika,  -- Dodano ID_uzytkownika
        u.Imie,
        u.Nazwisko,
        u.Nick
    FROM posty p
    JOIN uzytkownicy u ON p.ID_uzytkownika = u.ID_uzytkownika
    ORDER BY p.Data_publikacji DESC";

$result = $conn->query($sql);

// Przygotowanie danych do odpowiedzi
$posts = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Pobieranie komentarzy dla danego posta
        $commentsQuery = "
            SELECT 
                c.Tresc AS comment_content,
                c.Data_publikacji AS comment_date,
                c.ID_komentarza as comment_id,
                c.Ilosc_polubien as comment_like,
                u.Imie AS comment_author_firstname,
                u.Nazwisko AS comment_author_lastname,
                u.Nick AS comment_author_nickname,
                u.Link_zdjecia as profil
            FROM komentarze c
            JOIN uzytkownicy u ON c.ID_uzytkownika = u.ID_uzytkownika
            WHERE c.ID_postu = " . $row['ID_postu'];

        $commentsResult = $conn->query($commentsQuery);

        // Inicjalizacja tablicy komentarzy
        $comments = [];
        if ($commentsResult->num_rows > 0) {
            while ($commentRow = $commentsResult->fetch_assoc()) {
                $comments[] = [
                    'id' => $commentRow['comment_id'],
                    'like' => $commentRow['comment_like'],
                    'auth' => $commentRow['comment_author_firstname'] . ' ' . $commentRow['comment_author_lastname'],  // Autor komentarza
                    'content' => $commentRow['comment_content'],  // Treść komentarza
                    'comm_nick' => $commentRow['comment_author_nickname'],
                    'publishedAt' => $commentRow['comment_date'],  // Data dodania komentarza
                    'prof' => $commentRow['profil']
                ];
            }
        }

        // Split the Hasztagi field by space to get an array of hashtags
        $hashtags = !empty($row['Hasztagi']) ? explode(' ', $row['Hasztagi']) : [];

        // Konwertowanie 'Ilosc_polubien' na liczbę całkowitą lub przypisanie domyślnej wartości 0, jeśli NULL
        $likeCount = isset($row['Ilosc_polubien']) && is_numeric($row['Ilosc_polubien']) ? intval($row['Ilosc_polubien']) : 0;

        // Dodanie posta do tablicy
        $posts[] = [
            'id' => $row['ID_postu'],  // ID posta
            'title' => $row['Tytul'],  // Tytuł posta
            'content' => $row['Tresc'],  // Treść posta
            'publishedAt' => $row['Data_publikacji'],  // Data publikacji posta
            'likeCount' => $likeCount,  // Liczba polubień jako int
            'hashtags' => $hashtags,  // Hashtags as an array
            'author' => $row['Imie'].' '.$row['Nazwisko'],  // Imię i nazwisko autora
            'nickname' => $row['Nick'],  // Nickname autora
            'userId' => $row['ID_uzytkownika'],  // Dodanie ID_uzytkownika
            'comments' => $comments  // Dodanie komentarzy do posta
        ];
    }
}

// Zwracamy dane jako JSON
echo json_encode($posts);

$conn->close();
?>
