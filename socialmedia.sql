-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 20 Lis 2024, 13:07
-- Wersja serwera: 10.4.25-MariaDB
-- Wersja PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `socialmedia`
--

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `5_uzytkow_z_najwieksza_iloscia_obserwacji`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `5_uzytkow_z_najwieksza_iloscia_obserwacji` (
`ID_uzytkownika` int(11)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Nick` varchar(50)
,`Liczba_Obserwujacych` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `aktywnosc_uzytkownikow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `aktywnosc_uzytkownikow` (
`ID_uzytkownika` int(11)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Nick` varchar(50)
,`Liczba_Postow` bigint(21)
,`Liczba_Komentarzy` bigint(21)
,`Liczba_Filmow` bigint(21)
,`Liczba_Wiadomosci` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `filmiki`
--

CREATE TABLE `filmiki` (
  `ID_filmu` int(11) NOT NULL,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Link_filmu` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `filmiki`
--

INSERT INTO `filmiki` (`ID_filmu`, `ID_uzytkownika`, `Link_filmu`, `Data_publikacji`) VALUES
(501, 1, 'https://www.youtube.com/watch?v=abcd1234', '2024-05-01 07:00:00'),
(506, 1, 'uploads/673dc857c33ef9.67773932.mp4', '2024-11-20 11:30:31'),
(507, 1, 'uploads/673dc941d05736.56439140.mp4', '2024-11-20 11:34:25'),
(508, 1, 'uploads/673dc9a71718b8.34182891.mp4', '2024-11-20 11:36:07'),
(509, 1, 'uploads/673dcb12f25736.52769729.mp4', '2024-11-20 11:42:10');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `komentarze`
--

CREATE TABLE `komentarze` (
  `ID_komentarza` int(11) NOT NULL,
  `ID_postu` int(11) DEFAULT NULL,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  `Data_edycji` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Ilosc_polubien` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `komentarze`
--

INSERT INTO `komentarze` (`ID_komentarza`, `ID_postu`, `ID_uzytkownika`, `Tresc`, `Data_publikacji`, `Data_edycji`, `Ilosc_polubien`) VALUES
(521, 501, 2, 'Świetny post! Zgadzam się z Tobą.', '2024-05-01 08:00:00', '2024-05-01 08:10:00', 5),
(522, 502, 3, 'Dzięki za podzielenie się, bardzo pomocne.', '2024-05-02 10:15:00', '2024-11-20 11:15:57', 3),
(523, 503, 4, 'Zgadzam się, świetna perspektywa!', '2024-05-03 06:30:00', '2024-11-14 21:19:17', 10),
(524, 504, 5, 'Ciekawy punkt widzenia, muszę to przemyśleć.', '2024-05-04 12:45:00', '2024-05-04 13:00:00', 3),
(525, 505, 6, 'Podzielam Twoje zdanie, bardzo inspirujące.', '2024-05-05 14:00:00', '2024-11-14 21:19:17', 4),
(526, 506, 7, 'Dzięki za wspaniałą treść, bardzo mi się podoba.', '2024-05-06 16:20:00', '2024-05-06 16:25:00', 8),
(527, 507, 8, 'Świetny artykuł! Chciałbym przeczytać więcej na ten temat.', '2024-05-07 07:00:00', '2024-11-14 21:19:17', 12),
(528, 508, 9, 'To mi się naprawdę podoba, dzięki za inspirację!', '2024-05-08 09:30:00', '2024-05-08 09:40:00', 7),
(529, 509, 10, 'Fajne, ale mam kilka wątpliwości.', '2024-05-09 11:25:00', '2024-11-14 21:19:17', 2),
(530, 510, 11, 'Zgadzam się w 100%. Więcej takich treści!', '2024-05-10 15:50:00', '2024-11-14 21:19:17', 6),
(531, 520, NULL, 'hej', '2024-11-20 10:51:48', '2024-11-20 10:51:48', 0),
(532, 520, NULL, 'hej', '2024-11-20 10:51:53', '2024-11-20 10:51:53', 0),
(533, 519, NULL, 'witam', '2024-11-20 10:55:28', '2024-11-20 10:55:28', 0),
(534, 520, 1, 'witam', '2024-11-20 11:01:01', '2024-11-20 11:42:49', 17),
(535, 520, 1, 'czesc', '2024-11-20 11:01:26', '2024-11-20 11:08:04', 3),
(536, 520, 1, 'hi', '2024-11-20 11:08:21', '2024-11-20 11:08:24', 6),
(537, 520, 1, 'sup', '2024-11-20 11:13:25', '2024-11-20 11:13:27', 2),
(538, 520, 1, 'siema', '2024-11-20 11:42:53', '2024-11-20 11:42:53', 0);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `komentarze_z_postami`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `komentarze_z_postami` (
`ID_komentarza` int(11)
,`Komentarz` varchar(255)
,`Komentarz_Polubienia` int(11)
,`Post_Tytul` varchar(255)
,`Post_Tresc` varchar(255)
,`Post_Polubienia` int(11)
,`Komentujacy_Imie` varchar(100)
,`Komentujacy_Nazwisko` varchar(100)
,`Autor_Postu_Imie` varchar(100)
,`Autor_Postu_Nazwisko` varchar(100)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najbardziej_polubiane_komentarze`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `najbardziej_polubiane_komentarze` (
`ID_komentarza` int(11)
,`Komentarz_Tresc` varchar(255)
,`Komentarz_Polubienia` int(11)
,`Komentujacy_Imie` varchar(100)
,`Komentujacy_Nazwisko` varchar(100)
,`Post_Tytul` varchar(255)
,`Post_Tresc` varchar(255)
,`Post_Polubienia` int(11)
,`Komentarz_Data_Publikacji` timestamp
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najwiecej_hasztagow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `najwiecej_hasztagow` (
`Hasztagi` varchar(255)
,`liczba_postow` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obserwujacy`
--

CREATE TABLE `obserwujacy` (
  `ID_obserwowanego` int(11) NOT NULL,
  `ID_obserwujacego` int(11) NOT NULL,
  `Data_obserwacji` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `obserwujacy`
--

INSERT INTO `obserwujacy` (`ID_obserwowanego`, `ID_obserwujacego`, `Data_obserwacji`) VALUES
(20, 1, '2024-05-09 22:00:00'),
(1, 2, '2023-12-31 23:00:00'),
(2, 3, '2024-01-14 23:00:00'),
(3, 4, '2024-01-31 23:00:00'),
(4, 5, '2024-02-09 23:00:00'),
(5, 6, '2024-02-29 23:00:00'),
(6, 7, '2024-03-04 23:00:00'),
(7, 8, '2024-03-09 23:00:00'),
(8, 9, '2024-03-14 23:00:00'),
(9, 10, '2024-03-19 23:00:00'),
(10, 11, '2024-03-24 23:00:00'),
(11, 12, '2024-03-31 22:00:00'),
(12, 13, '2024-04-04 22:00:00'),
(13, 14, '2024-04-09 22:00:00'),
(14, 15, '2024-04-14 22:00:00'),
(15, 16, '2024-04-19 22:00:00'),
(16, 17, '2024-04-24 22:00:00'),
(17, 18, '2024-04-29 22:00:00'),
(18, 19, '2024-04-30 22:00:00'),
(19, 20, '2024-05-04 22:00:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `posty`
--

CREATE TABLE `posty` (
  `ID_postu` int(11) NOT NULL,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Link_zdjecia` varchar(255) DEFAULT NULL,
  `Tytul` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  `Data_edycji` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Hasztagi` varchar(255) DEFAULT NULL,
  `Ilosc_polubien` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `posty`
--

INSERT INTO `posty` (`ID_postu`, `ID_uzytkownika`, `Tresc`, `Link_zdjecia`, `Tytul`, `Data_publikacji`, `Data_edycji`, `Hasztagi`, `Ilosc_polubien`) VALUES
(501, 20, 'To jest przykładowy post #1. Lorem ipsum dolor sit amet.', 'https://placeimg.com/640/480/any', 'Pierwszy post', '2024-04-01 08:00:00', '2024-04-01 08:15:00', '#przyklad, #test', 15),
(502, 20, 'Drugi post na tej platformie, zawierający interesujące informacje.', 'https://placeimg.com/640/480/any', 'Drugi post', '2024-04-02 09:15:00', '2024-04-02 09:25:00', '#tutorial, #post', 22),
(503, 3, 'Post o ciekawej tematyce, który będzie wkrótce edytowany.', 'https://placeimg.com/640/480/any', 'Ciekawe tematy', '2024-04-03 10:30:00', '2024-04-03 10:45:00', '#nowosc, #zmiana', 10),
(504, 4, 'Tutaj znajduje się tekst posta, który opisuje moje doświadczenia.', 'https://placeimg.com/640/480/any', 'Moje doświadczenia', '2024-04-04 11:00:00', '2024-04-04 11:10:00', '#sukces, #rozwój', 8),
(505, 5, 'Dzięki za wsparcie w moim projekcie. Zapraszam do komentowania!', 'https://placeimg.com/640/480/any', 'Dziękuję za wsparcie', '2024-04-05 12:00:00', '2024-04-05 12:05:00', '#projekt, #komentarze', 35),
(506, 6, 'Post z grafiką przedstawiającą przykład projektu. Zobaczcie!', 'https://placeimg.com/640/480/any', 'Projekt z grafiką', '2024-04-06 13:30:00', '2024-04-06 13:45:00', '#grafika, #projektowanie', 20),
(507, 7, 'Jakie książki warto przeczytać w 2024 roku? Moja lista.', 'https://placeimg.com/640/480/any', 'Książki na 2024', '2024-04-07 14:00:00', '2024-04-07 14:10:00', '#książki, #czytanie', 45),
(508, 8, 'Zachwyciłem się tym filmem. Koniecznie obejrzyjcie!', 'https://placeimg.com/640/480/any', 'Film, który musisz zobaczyć', '2024-04-08 15:15:00', '2024-04-08 15:30:00', '#film, #polecam', 50),
(509, 15, 'Poradnik jak zarządzać czasem i być bardziej produktywnym.', 'https://placeimg.com/640/480/any', 'Zarządzanie czasem', '2024-04-09 16:30:00', '2024-04-09 16:40:00', '#produktywność, #efektywność', 40),
(510, 10, 'Znaleziono świetne narzędzia do nauki online. Przeczytaj więcej.', 'https://placeimg.com/640/480/any', 'Nauka online', '2024-04-10 17:00:00', '2024-04-10 17:10:00', '#nauka, #online', 12),
(511, 11, 'Dzielę się z Wami moimi doświadczeniami z pracy zdalnej.', 'https://placeimg.com/640/480/any', 'Praca zdalna', '2024-04-11 18:15:00', '2024-04-11 18:25:00', '#praca, #homeoffice', 29),
(512, 12, 'Podróż po pięknych miejscach w Polsce. Zobaczcie te zdjęcia!', 'https://placeimg.com/640/480/any', 'Podróże po Polsce', '2024-04-12 19:00:00', '2024-04-12 19:05:00', '#podróże, #Polska', 60),
(513, 13, 'Przykładowa treść posta z cytatem motywacyjnym.', 'https://placeimg.com/640/480/any', 'Motywacja na dziś', '2024-04-13 20:00:00', '2024-04-13 20:15:00', '#motywacja, #cytat', 70),
(514, 14, 'Dziś o najnowszych trendach w technologiach. Przeczytaj nasz artykuł.', 'https://placeimg.com/640/480/any', 'Trendy technologiczne', '2024-04-14 21:30:00', '2024-04-14 21:40:00', '#technologia, #trendy', 30),
(515, 20, 'Dziękuję za wszystkie wiadomości. Czas na nowy projekt!', 'https://placeimg.com/640/480/any', 'Nowy projekt', '2024-04-14 22:00:00', '2024-04-14 22:10:00', '#nowyprojekt, #rozwój', 25),
(516, 16, 'Wskazówki dotyczące zdrowia i dobrego samopoczucia na co dzień.', 'https://placeimg.com/640/480/any', 'Zdrowie na co dzień', '2024-04-15 23:00:00', '2024-04-15 23:05:00', '#zdrowie, #fitness', 33),
(517, 17, 'Krótki przewodnik po najlepszych restauracjach w mieście.', 'https://placeimg.com/640/480/any', 'Najlepsze restauracje', '2024-04-17 00:00:00', '2024-04-17 00:10:00', '#jedzenie, #restauracje', 50),
(518, 18, 'Nowe wyzwanie: nauka języka obcego w 30 dni. Przeżyj to ze mną!', 'https://placeimg.com/640/480/any', 'Nauka języka', '2024-04-18 01:00:00', '2024-04-18 01:05:00', '#nauka, #wyzwanie', 28),
(519, 19, 'Mój pierwszy post na blogu. Czekam na opinie!', 'https://placeimg.com/640/480/any', 'Pierwszy post blogowy', '2024-04-19 02:00:00', '2024-11-20 11:43:10', '#blog, #pierwszy', 61),
(520, 20, 'Relacja z mojej ostatniej podróży. Zobaczcie zdjęcia!', 'https://placeimg.com/640/480/any', 'Podróż życia', '2024-04-20 03:00:00', '2024-11-20 11:43:17', '#podróż, #przygoda', 100),
(527, NULL, '132456', '', '123', '2024-11-19 18:14:06', '2024-11-19 18:14:06', '#1234', 0),
(528, NULL, '53767', '', '4556', '2024-11-19 18:16:40', '2024-11-19 18:16:40', '#1234', 0),
(529, NULL, 'dgsjuoisGJ', '', '4556', '2024-11-20 10:35:14', '2024-11-20 10:35:14', '#1234', 0),
(530, NULL, 'Siema siema', '', '4556', '2024-11-20 11:14:40', '2024-11-20 11:14:40', '#sup', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rozmowy`
--

CREATE TABLE `rozmowy` (
  `ID_rozmowy` int(11) NOT NULL,
  `Data_utworzenia` timestamp NOT NULL DEFAULT current_timestamp(),
  `Nazwa_rozmowy` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `rozmowy`
--

INSERT INTO `rozmowy` (`ID_rozmowy`, `Data_utworzenia`, `Nazwa_rozmowy`) VALUES
(1, '0000-00-00 00:00:00', 'viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est'),
(2, '0000-00-00 00:00:00', 'eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra'),
(3, '0000-00-00 00:00:00', 'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed'),
(4, '0000-00-00 00:00:00', 'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate'),
(5, '0000-00-00 00:00:00', 'erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam'),
(6, '0000-00-00 00:00:00', 'arcu sed augue aliquam erat volutpat in congue etiam justo'),
(7, '0000-00-00 00:00:00', 'eget rutrum at lorem integer tincidunt ante vel ipsum praesent'),
(8, '0000-00-00 00:00:00', 'nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium'),
(9, '0000-00-00 00:00:00', 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis'),
(10, '0000-00-00 00:00:00', 'viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus'),
(11, '0000-00-00 00:00:00', 'ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor'),
(12, '0000-00-00 00:00:00', 'nunc rhoncus dui vel sem sed sagittis nam congue risus semper'),
(13, '0000-00-00 00:00:00', 'sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec'),
(14, '0000-00-00 00:00:00', 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at'),
(15, '0000-00-00 00:00:00', 'amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus'),
(16, '0000-00-00 00:00:00', 'nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam'),
(17, '0000-00-00 00:00:00', 'eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum'),
(18, '0000-00-00 00:00:00', 'suspendisse potenti cras in purus eu magna vulputate luctus cum sociis'),
(19, '0000-00-00 00:00:00', 'potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non'),
(20, '0000-00-00 00:00:00', 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi'),
(21, '0000-00-00 00:00:00', 'nec dui luctus rutrum nulla tellus in sagittis dui vel'),
(22, '0000-00-00 00:00:00', 'viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et'),
(23, '0000-00-00 00:00:00', 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed'),
(24, '0000-00-00 00:00:00', 'amet turpis elementum ligula vehicula consequat morbi a ipsum integer'),
(25, '0000-00-00 00:00:00', 'porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus'),
(26, '0000-00-00 00:00:00', 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id'),
(27, '0000-00-00 00:00:00', 'sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis'),
(28, '0000-00-00 00:00:00', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus'),
(29, '0000-00-00 00:00:00', 'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate'),
(30, '0000-00-00 00:00:00', 'integer non velit donec diam neque vestibulum eget vulputate ut'),
(31, '0000-00-00 00:00:00', 'odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est'),
(32, '0000-00-00 00:00:00', 'lectus in est risus auctor sed tristique in tempus sit amet'),
(33, '0000-00-00 00:00:00', 'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices'),
(34, '0000-00-00 00:00:00', 'posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam'),
(35, '0000-00-00 00:00:00', 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus'),
(36, '0000-00-00 00:00:00', 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi'),
(37, '0000-00-00 00:00:00', 'volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh'),
(38, '0000-00-00 00:00:00', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio'),
(39, '0000-00-00 00:00:00', 'tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed'),
(40, '0000-00-00 00:00:00', 'gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet'),
(41, '0000-00-00 00:00:00', 'mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla'),
(42, '0000-00-00 00:00:00', 'varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas'),
(43, '0000-00-00 00:00:00', 'dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in'),
(44, '0000-00-00 00:00:00', 'sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus'),
(45, '0000-00-00 00:00:00', 'ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed'),
(46, '0000-00-00 00:00:00', 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus'),
(47, '0000-00-00 00:00:00', 'at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio'),
(48, '0000-00-00 00:00:00', 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in'),
(49, '0000-00-00 00:00:00', 'ac diam cras pellentesque volutpat dui maecenas tristique est et tempus'),
(50, '0000-00-00 00:00:00', 'in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla'),
(51, '0000-00-00 00:00:00', 'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut'),
(52, '0000-00-00 00:00:00', 'a ipsum integer a nibh in quis justo maecenas rhoncus'),
(53, '0000-00-00 00:00:00', 'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum'),
(54, '0000-00-00 00:00:00', 'fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget'),
(55, '0000-00-00 00:00:00', 'nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in'),
(56, '0000-00-00 00:00:00', 'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat'),
(57, '0000-00-00 00:00:00', 'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec'),
(58, '0000-00-00 00:00:00', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes'),
(59, '0000-00-00 00:00:00', 'odio cras mi pede malesuada in imperdiet et commodo vulputate justo'),
(60, '0000-00-00 00:00:00', 'donec dapibus duis at velit eu est congue elementum in hac habitasse platea'),
(61, '0000-00-00 00:00:00', 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id'),
(62, '0000-00-00 00:00:00', 'proin risus praesent lectus vestibulum quam sapien varius ut blandit'),
(63, '0000-00-00 00:00:00', 'sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet'),
(64, '0000-00-00 00:00:00', 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare'),
(65, '0000-00-00 00:00:00', 'pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel'),
(66, '0000-00-00 00:00:00', 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero'),
(67, '0000-00-00 00:00:00', 'erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac'),
(68, '0000-00-00 00:00:00', 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra'),
(69, '0000-00-00 00:00:00', 'duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse'),
(70, '0000-00-00 00:00:00', 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus'),
(71, '0000-00-00 00:00:00', 'at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec'),
(72, '0000-00-00 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor'),
(73, '0000-00-00 00:00:00', 'quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in'),
(74, '0000-00-00 00:00:00', 'placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris'),
(75, '0000-00-00 00:00:00', 'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc'),
(76, '0000-00-00 00:00:00', 'massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque'),
(77, '0000-00-00 00:00:00', 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut'),
(78, '0000-00-00 00:00:00', 'et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante'),
(79, '0000-00-00 00:00:00', 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum'),
(80, '0000-00-00 00:00:00', 'nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec'),
(81, '0000-00-00 00:00:00', 'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor'),
(82, '0000-00-00 00:00:00', 'aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in'),
(83, '0000-00-00 00:00:00', 'cum sociis natoque penatibus et magnis dis parturient montes nascetur'),
(84, '0000-00-00 00:00:00', 'neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit'),
(85, '0000-00-00 00:00:00', 'vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia'),
(86, '0000-00-00 00:00:00', 'lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh'),
(87, '0000-00-00 00:00:00', 'in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non'),
(88, '0000-00-00 00:00:00', 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis'),
(89, '0000-00-00 00:00:00', 'maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices'),
(90, '0000-00-00 00:00:00', 'pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse'),
(91, '0000-00-00 00:00:00', 'at nibh in hac habitasse platea dictumst aliquam augue quam'),
(92, '0000-00-00 00:00:00', 'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus'),
(93, '0000-00-00 00:00:00', 'integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero'),
(94, '0000-00-00 00:00:00', 'in est risus auctor sed tristique in tempus sit amet'),
(95, '0000-00-00 00:00:00', 'consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce'),
(96, '0000-00-00 00:00:00', 'enim sit amet nunc viverra dapibus nulla suscipit ligula in'),
(97, '0000-00-00 00:00:00', 'rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id'),
(98, '0000-00-00 00:00:00', 'a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus'),
(99, '0000-00-00 00:00:00', 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec'),
(100, '0000-00-00 00:00:00', 'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam'),
(101, '0000-00-00 00:00:00', 'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est'),
(102, '0000-00-00 00:00:00', 'posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut'),
(103, '0000-00-00 00:00:00', 'luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices'),
(104, '0000-00-00 00:00:00', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse'),
(105, '0000-00-00 00:00:00', 'metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean'),
(106, '0000-00-00 00:00:00', 'rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean'),
(107, '0000-00-00 00:00:00', 'luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi'),
(108, '0000-00-00 00:00:00', 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero'),
(109, '0000-00-00 00:00:00', 'interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum'),
(110, '0000-00-00 00:00:00', 'platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris'),
(111, '0000-00-00 00:00:00', 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu'),
(112, '0000-00-00 00:00:00', 'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis'),
(113, '0000-00-00 00:00:00', 'lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut'),
(114, '0000-00-00 00:00:00', 'quis turpis eget elit sodales scelerisque mauris sit amet eros'),
(115, '0000-00-00 00:00:00', 'lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus'),
(116, '0000-00-00 00:00:00', 'sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam'),
(117, '0000-00-00 00:00:00', 'at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis'),
(118, '0000-00-00 00:00:00', 'ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla'),
(119, '0000-00-00 00:00:00', 'purus sit amet nulla quisque arcu libero rutrum ac lobortis'),
(120, '0000-00-00 00:00:00', 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci'),
(121, '0000-00-00 00:00:00', 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius'),
(122, '0000-00-00 00:00:00', 'sodales sed tincidunt eu felis fusce posuere felis sed lacus'),
(123, '0000-00-00 00:00:00', 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra'),
(124, '0000-00-00 00:00:00', 'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum'),
(125, '0000-00-00 00:00:00', 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed'),
(126, '0000-00-00 00:00:00', 'aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac'),
(127, '0000-00-00 00:00:00', 'felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed'),
(128, '0000-00-00 00:00:00', 'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris'),
(129, '0000-00-00 00:00:00', 'semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut'),
(130, '0000-00-00 00:00:00', 'tortor risus dapibus augue vel accumsan tellus nisi eu orci'),
(131, '0000-00-00 00:00:00', 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu'),
(132, '0000-00-00 00:00:00', 'tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum'),
(133, '0000-00-00 00:00:00', 'morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien'),
(134, '0000-00-00 00:00:00', 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras'),
(135, '0000-00-00 00:00:00', 'massa volutpat convallis morbi odio odio elementum eu interdum eu'),
(136, '0000-00-00 00:00:00', 'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue'),
(137, '0000-00-00 00:00:00', 'ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices'),
(138, '0000-00-00 00:00:00', 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis'),
(139, '0000-00-00 00:00:00', 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id'),
(140, '0000-00-00 00:00:00', 'tincidunt eu felis fusce posuere felis sed lacus morbi sem'),
(141, '0000-00-00 00:00:00', 'id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci'),
(142, '0000-00-00 00:00:00', 'varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt'),
(143, '0000-00-00 00:00:00', 'elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis'),
(144, '0000-00-00 00:00:00', 'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere'),
(145, '0000-00-00 00:00:00', 'ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna'),
(146, '0000-00-00 00:00:00', 'sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper'),
(147, '0000-00-00 00:00:00', 'elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus'),
(148, '0000-00-00 00:00:00', 'sapien non mi integer ac neque duis bibendum morbi non'),
(149, '0000-00-00 00:00:00', 'rutrum neque aenean auctor gravida sem praesent id massa id'),
(150, '0000-00-00 00:00:00', 'sapien ut nunc vestibulum ante ipsum primis in faucibus orci'),
(151, '0000-00-00 00:00:00', 'convallis eget eleifend luctus ultricies eu nibh quisque id justo sit'),
(152, '0000-00-00 00:00:00', 'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem'),
(153, '0000-00-00 00:00:00', 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit'),
(154, '0000-00-00 00:00:00', 'penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel'),
(155, '0000-00-00 00:00:00', 'quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam'),
(156, '0000-00-00 00:00:00', 'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum'),
(157, '0000-00-00 00:00:00', 'posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti'),
(158, '0000-00-00 00:00:00', 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis'),
(159, '0000-00-00 00:00:00', 'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat'),
(160, '0000-00-00 00:00:00', 'sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci'),
(161, '0000-00-00 00:00:00', 'vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent'),
(162, '0000-00-00 00:00:00', 'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum'),
(163, '0000-00-00 00:00:00', 'curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae'),
(164, '0000-00-00 00:00:00', 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse'),
(165, '0000-00-00 00:00:00', 'erat volutpat in congue etiam justo etiam pretium iaculis justo'),
(166, '0000-00-00 00:00:00', 'nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan'),
(167, '0000-00-00 00:00:00', 'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse'),
(168, '0000-00-00 00:00:00', 'magna at nunc commodo placerat praesent blandit nam nulla integer pede'),
(169, '0000-00-00 00:00:00', 'sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac'),
(170, '0000-00-00 00:00:00', 'blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est'),
(171, '0000-00-00 00:00:00', 'amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis'),
(172, '0000-00-00 00:00:00', 'pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo'),
(173, '0000-00-00 00:00:00', 'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec'),
(174, '0000-00-00 00:00:00', 'phasellus sit amet erat nulla tempus vivamus in felis eu'),
(175, '0000-00-00 00:00:00', 'donec quis orci eget orci vehicula condimentum curabitur in libero'),
(176, '0000-00-00 00:00:00', 'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed'),
(177, '0000-00-00 00:00:00', 'nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit'),
(178, '0000-00-00 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(179, '0000-00-00 00:00:00', 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique'),
(180, '0000-00-00 00:00:00', 'donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis'),
(181, '0000-00-00 00:00:00', 'sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec'),
(182, '0000-00-00 00:00:00', 'posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam'),
(183, '0000-00-00 00:00:00', 'in porttitor pede justo eu massa donec dapibus duis at velit eu est congue'),
(184, '0000-00-00 00:00:00', 'faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius'),
(185, '0000-00-00 00:00:00', 'bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu'),
(186, '0000-00-00 00:00:00', 'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere'),
(187, '0000-00-00 00:00:00', 'vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede'),
(188, '0000-00-00 00:00:00', 'libero quis orci nullam molestie nibh in lectus pellentesque at nulla'),
(189, '0000-00-00 00:00:00', 'felis ut at dolor quis odio consequat varius integer ac leo'),
(190, '0000-00-00 00:00:00', 'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet'),
(191, '0000-00-00 00:00:00', 'viverra pede ac diam cras pellentesque volutpat dui maecenas tristique'),
(192, '0000-00-00 00:00:00', 'eros elementum pellentesque quisque porta volutpat erat quisque erat eros'),
(193, '0000-00-00 00:00:00', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque'),
(194, '0000-00-00 00:00:00', 'curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit'),
(195, '0000-00-00 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(196, '0000-00-00 00:00:00', 'quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus'),
(197, '0000-00-00 00:00:00', 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(198, '0000-00-00 00:00:00', 'nulla ut erat id mauris vulputate elementum nullam varius nulla'),
(199, '0000-00-00 00:00:00', 'porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie'),
(200, '0000-00-00 00:00:00', 'felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat'),
(201, '0000-00-00 00:00:00', 'augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in'),
(202, '0000-00-00 00:00:00', 'dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum'),
(203, '0000-00-00 00:00:00', 'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse'),
(204, '0000-00-00 00:00:00', 'rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa'),
(205, '0000-00-00 00:00:00', 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non'),
(206, '0000-00-00 00:00:00', 'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio'),
(207, '0000-00-00 00:00:00', 'scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis'),
(208, '0000-00-00 00:00:00', 'a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla'),
(209, '0000-00-00 00:00:00', 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci'),
(210, '0000-00-00 00:00:00', 'mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus'),
(211, '0000-00-00 00:00:00', 'consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim'),
(212, '0000-00-00 00:00:00', 'neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia'),
(213, '0000-00-00 00:00:00', 'varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero'),
(214, '0000-00-00 00:00:00', 'id massa id nisl venenatis lacinia aenean sit amet justo'),
(215, '0000-00-00 00:00:00', 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam'),
(216, '0000-00-00 00:00:00', 'vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in'),
(217, '0000-00-00 00:00:00', 'quis turpis sed ante vivamus tortor duis mattis egestas metus'),
(218, '0000-00-00 00:00:00', 'venenatis non sodales sed tincidunt eu felis fusce posuere felis'),
(219, '0000-00-00 00:00:00', 'ut odio cras mi pede malesuada in imperdiet et commodo'),
(220, '0000-00-00 00:00:00', 'orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi'),
(221, '0000-00-00 00:00:00', 'mauris eget massa tempor convallis nulla neque libero convallis eget'),
(222, '0000-00-00 00:00:00', 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend'),
(223, '0000-00-00 00:00:00', 'sit amet lobortis sapien sapien non mi integer ac neque'),
(224, '0000-00-00 00:00:00', 'ut nulla sed accumsan felis ut at dolor quis odio consequat'),
(225, '0000-00-00 00:00:00', 'sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam'),
(226, '0000-00-00 00:00:00', 'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce'),
(227, '0000-00-00 00:00:00', 'a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus'),
(228, '0000-00-00 00:00:00', 'lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi'),
(229, '0000-00-00 00:00:00', 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar'),
(230, '0000-00-00 00:00:00', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu'),
(231, '0000-00-00 00:00:00', 'vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis'),
(232, '0000-00-00 00:00:00', 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu'),
(233, '0000-00-00 00:00:00', 'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla'),
(234, '0000-00-00 00:00:00', 'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat'),
(235, '0000-00-00 00:00:00', 'blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla'),
(236, '0000-00-00 00:00:00', 'dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et'),
(237, '0000-00-00 00:00:00', 'neque duis bibendum morbi non quam nec dui luctus rutrum nulla'),
(238, '0000-00-00 00:00:00', 'volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis'),
(239, '0000-00-00 00:00:00', 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien'),
(240, '0000-00-00 00:00:00', 'sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui'),
(241, '0000-00-00 00:00:00', 'eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est'),
(242, '0000-00-00 00:00:00', 'cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi'),
(243, '0000-00-00 00:00:00', 'tempus semper est quam pharetra magna ac consequat metus sapien ut nunc'),
(244, '0000-00-00 00:00:00', 'lectus pellentesque at nulla suspendisse potenti cras in purus eu magna'),
(245, '0000-00-00 00:00:00', 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id'),
(246, '0000-00-00 00:00:00', 'purus phasellus in felis donec semper sapien a libero nam dui proin leo'),
(247, '0000-00-00 00:00:00', 'augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(248, '0000-00-00 00:00:00', 'potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus'),
(249, '0000-00-00 00:00:00', 'ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non'),
(250, '0000-00-00 00:00:00', 'dolor sit amet consectetuer adipiscing elit proin interdum mauris non'),
(251, '0000-00-00 00:00:00', 'ac diam cras pellentesque volutpat dui maecenas tristique est et'),
(252, '0000-00-00 00:00:00', 'volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh'),
(253, '0000-00-00 00:00:00', 'eget semper rutrum nulla nunc purus phasellus in felis donec semper'),
(254, '0000-00-00 00:00:00', 'felis ut at dolor quis odio consequat varius integer ac leo'),
(255, '0000-00-00 00:00:00', 'quam turpis adipiscing lorem vitae mattis nibh ligula nec sem'),
(256, '0000-00-00 00:00:00', 'orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi'),
(257, '0000-00-00 00:00:00', 'tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo'),
(258, '0000-00-00 00:00:00', 'sollicitudin mi sit amet lobortis sapien sapien non mi integer'),
(259, '0000-00-00 00:00:00', 'leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa'),
(260, '0000-00-00 00:00:00', 'diam erat fermentum justo nec condimentum neque sapien placerat ante'),
(261, '0000-00-00 00:00:00', 'varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit'),
(262, '0000-00-00 00:00:00', 'curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus'),
(263, '0000-00-00 00:00:00', 'nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse'),
(264, '0000-00-00 00:00:00', 'justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales'),
(265, '0000-00-00 00:00:00', 'interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices'),
(266, '0000-00-00 00:00:00', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu'),
(267, '0000-00-00 00:00:00', 'fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam'),
(268, '0000-00-00 00:00:00', 'ac neque duis bibendum morbi non quam nec dui luctus'),
(269, '0000-00-00 00:00:00', 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque'),
(270, '0000-00-00 00:00:00', 'mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel'),
(271, '0000-00-00 00:00:00', 'in libero ut massa volutpat convallis morbi odio odio elementum eu interdum'),
(272, '0000-00-00 00:00:00', 'cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi'),
(273, '0000-00-00 00:00:00', 'et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat'),
(274, '0000-00-00 00:00:00', 'lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat'),
(275, '0000-00-00 00:00:00', 'odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue'),
(276, '0000-00-00 00:00:00', 'sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis'),
(277, '0000-00-00 00:00:00', 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus'),
(278, '0000-00-00 00:00:00', 'neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet'),
(279, '0000-00-00 00:00:00', 'porttitor pede justo eu massa donec dapibus duis at velit eu est'),
(280, '0000-00-00 00:00:00', 'ac est lacinia nisi venenatis tristique fusce congue diam id ornare'),
(281, '0000-00-00 00:00:00', 'rutrum neque aenean auctor gravida sem praesent id massa id nisl'),
(282, '0000-00-00 00:00:00', 'sed tristique in tempus sit amet sem fusce consequat nulla'),
(283, '0000-00-00 00:00:00', 'pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac'),
(284, '0000-00-00 00:00:00', 'quis turpis sed ante vivamus tortor duis mattis egestas metus'),
(285, '0000-00-00 00:00:00', 'donec dapibus duis at velit eu est congue elementum in'),
(286, '0000-00-00 00:00:00', 'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla'),
(287, '0000-00-00 00:00:00', 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet'),
(288, '0000-00-00 00:00:00', 'nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat'),
(289, '0000-00-00 00:00:00', 'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer'),
(290, '0000-00-00 00:00:00', 'enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit'),
(291, '0000-00-00 00:00:00', 'condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu'),
(292, '0000-00-00 00:00:00', 'metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in'),
(293, '0000-00-00 00:00:00', 'odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit'),
(294, '0000-00-00 00:00:00', 'venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut'),
(295, '0000-00-00 00:00:00', 'purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend'),
(296, '0000-00-00 00:00:00', 'massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst'),
(297, '0000-00-00 00:00:00', 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et'),
(298, '0000-00-00 00:00:00', 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci'),
(299, '0000-00-00 00:00:00', 'eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris'),
(300, '0000-00-00 00:00:00', 'vulputate elementum nullam varius nulla facilisi cras non velit nec'),
(301, '0000-00-00 00:00:00', 'convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque'),
(302, '0000-00-00 00:00:00', 'porta volutpat quam pede lobortis ligula sit amet eleifend pede libero'),
(303, '0000-00-00 00:00:00', 'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec'),
(304, '0000-00-00 00:00:00', 'ut nulla sed accumsan felis ut at dolor quis odio consequat'),
(305, '0000-00-00 00:00:00', 'nonummy integer non velit donec diam neque vestibulum eget vulputate ut'),
(306, '0000-00-00 00:00:00', 'proin leo odio porttitor id consequat in consequat ut nulla sed accumsan'),
(307, '0000-00-00 00:00:00', 'est phasellus sit amet erat nulla tempus vivamus in felis'),
(308, '0000-00-00 00:00:00', 'consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut'),
(309, '0000-00-00 00:00:00', 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis'),
(310, '0000-00-00 00:00:00', 'sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus'),
(311, '0000-00-00 00:00:00', 'ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim'),
(312, '0000-00-00 00:00:00', 'lorem quisque ut erat curabitur gravida nisi at nibh in hac'),
(313, '0000-00-00 00:00:00', 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a'),
(314, '0000-00-00 00:00:00', 'vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis'),
(315, '0000-00-00 00:00:00', 'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id'),
(316, '0000-00-00 00:00:00', 'ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis'),
(317, '0000-00-00 00:00:00', 'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante'),
(318, '0000-00-00 00:00:00', 'nisi at nibh in hac habitasse platea dictumst aliquam augue quam'),
(319, '0000-00-00 00:00:00', 'cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit'),
(320, '0000-00-00 00:00:00', 'integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non'),
(321, '0000-00-00 00:00:00', 'turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi'),
(322, '0000-00-00 00:00:00', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque'),
(323, '0000-00-00 00:00:00', 'pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac'),
(324, '0000-00-00 00:00:00', 'mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy'),
(325, '0000-00-00 00:00:00', 'orci mauris lacinia sapien quis libero nullam sit amet turpis'),
(326, '0000-00-00 00:00:00', 'vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue'),
(327, '0000-00-00 00:00:00', 'rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis'),
(328, '0000-00-00 00:00:00', 'fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum'),
(329, '0000-00-00 00:00:00', 'massa quis augue luctus tincidunt nulla mollis molestie lorem quisque'),
(330, '0000-00-00 00:00:00', 'magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce'),
(331, '0000-00-00 00:00:00', 'curabitur in libero ut massa volutpat convallis morbi odio odio elementum'),
(332, '0000-00-00 00:00:00', 'morbi non quam nec dui luctus rutrum nulla tellus in sagittis'),
(333, '0000-00-00 00:00:00', 'in sagittis dui vel nisl duis ac nibh fusce lacus'),
(334, '0000-00-00 00:00:00', 'accumsan odio curabitur convallis duis consequat dui nec nisi volutpat'),
(335, '0000-00-00 00:00:00', 'dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante'),
(336, '0000-00-00 00:00:00', 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus'),
(337, '0000-00-00 00:00:00', 'gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin'),
(338, '0000-00-00 00:00:00', 'libero nam dui proin leo odio porttitor id consequat in consequat ut nulla'),
(339, '0000-00-00 00:00:00', 'platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat'),
(340, '0000-00-00 00:00:00', 'proin leo odio porttitor id consequat in consequat ut nulla sed'),
(341, '0000-00-00 00:00:00', 'in sagittis dui vel nisl duis ac nibh fusce lacus purus'),
(342, '0000-00-00 00:00:00', 'nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra'),
(343, '0000-00-00 00:00:00', 'risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum'),
(344, '0000-00-00 00:00:00', 'erat nulla tempus vivamus in felis eu sapien cursus vestibulum'),
(345, '0000-00-00 00:00:00', 'eget nunc donec quis orci eget orci vehicula condimentum curabitur in'),
(346, '0000-00-00 00:00:00', 'luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus'),
(347, '0000-00-00 00:00:00', 'lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam'),
(348, '0000-00-00 00:00:00', 'id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan'),
(349, '0000-00-00 00:00:00', 'suspendisse potenti cras in purus eu magna vulputate luctus cum'),
(350, '0000-00-00 00:00:00', 'nunc purus phasellus in felis donec semper sapien a libero nam dui'),
(351, '0000-00-00 00:00:00', 'vitae mattis nibh ligula nec sem duis aliquam convallis nunc'),
(352, '0000-00-00 00:00:00', 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc'),
(353, '0000-00-00 00:00:00', 'ac neque duis bibendum morbi non quam nec dui luctus'),
(354, '0000-00-00 00:00:00', 'in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris'),
(355, '0000-00-00 00:00:00', 'sed sagittis nam congue risus semper porta volutpat quam pede'),
(356, '0000-00-00 00:00:00', 'aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend'),
(357, '0000-00-00 00:00:00', 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac'),
(358, '0000-00-00 00:00:00', 'morbi non lectus aliquam sit amet diam in magna bibendum'),
(359, '0000-00-00 00:00:00', 'congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu'),
(360, '0000-00-00 00:00:00', 'natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien'),
(361, '0000-00-00 00:00:00', 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam'),
(362, '0000-00-00 00:00:00', 'vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus'),
(363, '0000-00-00 00:00:00', 'vel sem sed sagittis nam congue risus semper porta volutpat quam'),
(364, '0000-00-00 00:00:00', 'condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget'),
(365, '0000-00-00 00:00:00', 'commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit'),
(366, '0000-00-00 00:00:00', 'morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed'),
(367, '0000-00-00 00:00:00', 'condimentum neque sapien placerat ante nulla justo aliquam quis turpis'),
(368, '0000-00-00 00:00:00', 'sit amet turpis elementum ligula vehicula consequat morbi a ipsum'),
(369, '0000-00-00 00:00:00', 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt'),
(370, '0000-00-00 00:00:00', 'quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis'),
(371, '0000-00-00 00:00:00', 'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices'),
(372, '0000-00-00 00:00:00', 'fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet'),
(373, '0000-00-00 00:00:00', 'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie'),
(374, '0000-00-00 00:00:00', 'ut tellus nulla ut erat id mauris vulputate elementum nullam'),
(375, '0000-00-00 00:00:00', 'eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis'),
(376, '0000-00-00 00:00:00', 'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam'),
(377, '0000-00-00 00:00:00', 'turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis'),
(378, '0000-00-00 00:00:00', 'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum'),
(379, '0000-00-00 00:00:00', 'magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum'),
(380, '0000-00-00 00:00:00', 'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in'),
(381, '0000-00-00 00:00:00', 'vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id'),
(382, '0000-00-00 00:00:00', 'pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus'),
(383, '0000-00-00 00:00:00', 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis'),
(384, '0000-00-00 00:00:00', 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at'),
(385, '0000-00-00 00:00:00', 'potenti cras in purus eu magna vulputate luctus cum sociis'),
(386, '0000-00-00 00:00:00', 'sed interdum venenatis turpis enim blandit mi in porttitor pede'),
(387, '0000-00-00 00:00:00', 'diam vitae quam suspendisse potenti nullam porttitor lacus at turpis'),
(388, '0000-00-00 00:00:00', 'morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar'),
(389, '0000-00-00 00:00:00', 'venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien'),
(390, '0000-00-00 00:00:00', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus'),
(391, '0000-00-00 00:00:00', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus'),
(392, '0000-00-00 00:00:00', 'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec'),
(393, '0000-00-00 00:00:00', 'quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit'),
(394, '0000-00-00 00:00:00', 'lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis'),
(395, '0000-00-00 00:00:00', 'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi'),
(396, '0000-00-00 00:00:00', 'maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus'),
(397, '0000-00-00 00:00:00', 'turpis donec posuere metus vitae ipsum aliquam non mauris morbi'),
(398, '0000-00-00 00:00:00', 'ut suscipit a feugiat et eros vestibulum ac est lacinia nisi'),
(399, '0000-00-00 00:00:00', 'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio'),
(400, '0000-00-00 00:00:00', 'sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis'),
(401, '0000-00-00 00:00:00', 'morbi non lectus aliquam sit amet diam in magna bibendum'),
(402, '0000-00-00 00:00:00', 'non mi integer ac neque duis bibendum morbi non quam nec dui luctus'),
(403, '0000-00-00 00:00:00', 'donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris'),
(404, '0000-00-00 00:00:00', 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis'),
(405, '0000-00-00 00:00:00', 'tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus'),
(406, '0000-00-00 00:00:00', 'ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc'),
(407, '0000-00-00 00:00:00', 'turpis sed ante vivamus tortor duis mattis egestas metus aenean'),
(408, '0000-00-00 00:00:00', 'proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue'),
(409, '0000-00-00 00:00:00', 'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis'),
(410, '0000-00-00 00:00:00', 'amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices'),
(411, '0000-00-00 00:00:00', 'lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui'),
(412, '0000-00-00 00:00:00', 'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam'),
(413, '0000-00-00 00:00:00', 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien'),
(414, '0000-00-00 00:00:00', 'duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit'),
(415, '0000-00-00 00:00:00', 'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in'),
(416, '0000-00-00 00:00:00', 'ac est lacinia nisi venenatis tristique fusce congue diam id'),
(417, '0000-00-00 00:00:00', 'massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt'),
(418, '0000-00-00 00:00:00', 'ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(419, '0000-00-00 00:00:00', 'at velit vivamus vel nulla eget eros elementum pellentesque quisque porta'),
(420, '0000-00-00 00:00:00', 'faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis'),
(421, '0000-00-00 00:00:00', 'mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis'),
(422, '0000-00-00 00:00:00', 'curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit'),
(423, '0000-00-00 00:00:00', 'non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet'),
(424, '0000-00-00 00:00:00', 'ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis'),
(425, '0000-00-00 00:00:00', 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus'),
(426, '0000-00-00 00:00:00', 'lectus in est risus auctor sed tristique in tempus sit amet sem fusce'),
(427, '0000-00-00 00:00:00', 'nulla nunc purus phasellus in felis donec semper sapien a'),
(428, '0000-00-00 00:00:00', 'eu orci mauris lacinia sapien quis libero nullam sit amet turpis'),
(429, '0000-00-00 00:00:00', 'augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet'),
(430, '0000-00-00 00:00:00', 'in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra'),
(431, '0000-00-00 00:00:00', 'arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc'),
(432, '0000-00-00 00:00:00', 'sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar'),
(433, '0000-00-00 00:00:00', 'mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet'),
(434, '0000-00-00 00:00:00', 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra'),
(435, '0000-00-00 00:00:00', 'suscipit nulla elit ac nulla sed vel enim sit amet nunc'),
(436, '0000-00-00 00:00:00', 'magna at nunc commodo placerat praesent blandit nam nulla integer'),
(437, '0000-00-00 00:00:00', 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut'),
(438, '0000-00-00 00:00:00', 'vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod'),
(439, '0000-00-00 00:00:00', 'justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut'),
(440, '0000-00-00 00:00:00', 'tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque'),
(441, '0000-00-00 00:00:00', 'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit'),
(442, '0000-00-00 00:00:00', 'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor'),
(443, '0000-00-00 00:00:00', 'velit id pretium iaculis diam erat fermentum justo nec condimentum neque'),
(444, '0000-00-00 00:00:00', 'etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
(445, '0000-00-00 00:00:00', 'cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam'),
(446, '0000-00-00 00:00:00', 'duis aliquam convallis nunc proin at turpis a pede posuere nonummy'),
(447, '0000-00-00 00:00:00', 'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum'),
(448, '0000-00-00 00:00:00', 'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu'),
(449, '0000-00-00 00:00:00', 'hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem'),
(450, '0000-00-00 00:00:00', 'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor'),
(451, '0000-00-00 00:00:00', 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat'),
(452, '0000-00-00 00:00:00', 'turpis a pede posuere nonummy integer non velit donec diam neque vestibulum');
INSERT INTO `rozmowy` (`ID_rozmowy`, `Data_utworzenia`, `Nazwa_rozmowy`) VALUES
(453, '0000-00-00 00:00:00', 'odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt'),
(454, '0000-00-00 00:00:00', 'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam'),
(455, '0000-00-00 00:00:00', 'proin risus praesent lectus vestibulum quam sapien varius ut blandit non'),
(456, '0000-00-00 00:00:00', 'massa donec dapibus duis at velit eu est congue elementum in'),
(457, '0000-00-00 00:00:00', 'ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar'),
(458, '0000-00-00 00:00:00', 'morbi odio odio elementum eu interdum eu tincidunt in leo'),
(459, '0000-00-00 00:00:00', 'placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit'),
(460, '0000-00-00 00:00:00', 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem'),
(461, '0000-00-00 00:00:00', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus'),
(462, '0000-00-00 00:00:00', 'suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique'),
(463, '0000-00-00 00:00:00', 'duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti'),
(464, '0000-00-00 00:00:00', 'duis at velit eu est congue elementum in hac habitasse platea dictumst'),
(465, '0000-00-00 00:00:00', 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem'),
(466, '0000-00-00 00:00:00', 'accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas'),
(467, '0000-00-00 00:00:00', 'pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in'),
(468, '0000-00-00 00:00:00', 'fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum'),
(469, '0000-00-00 00:00:00', 'leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in'),
(470, '0000-00-00 00:00:00', 'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id'),
(471, '0000-00-00 00:00:00', 'nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus'),
(472, '0000-00-00 00:00:00', 'odio condimentum id luctus nec molestie sed justo pellentesque viverra pede'),
(473, '0000-00-00 00:00:00', 'eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla'),
(474, '0000-00-00 00:00:00', 'id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras'),
(475, '0000-00-00 00:00:00', 'orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum'),
(476, '0000-00-00 00:00:00', 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin'),
(477, '0000-00-00 00:00:00', 'augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi'),
(478, '0000-00-00 00:00:00', 'nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla'),
(479, '0000-00-00 00:00:00', 'eu magna vulputate luctus cum sociis natoque penatibus et magnis'),
(480, '0000-00-00 00:00:00', 'nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla'),
(481, '0000-00-00 00:00:00', 'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed'),
(482, '0000-00-00 00:00:00', 'nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a'),
(483, '0000-00-00 00:00:00', 'vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur'),
(484, '0000-00-00 00:00:00', 'eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id'),
(485, '0000-00-00 00:00:00', 'enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris'),
(486, '0000-00-00 00:00:00', 'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet'),
(487, '0000-00-00 00:00:00', 'lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id'),
(488, '0000-00-00 00:00:00', 'justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus'),
(489, '0000-00-00 00:00:00', 'mauris sit amet eros suspendisse accumsan tortor quis turpis sed'),
(490, '0000-00-00 00:00:00', 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo'),
(491, '0000-00-00 00:00:00', 'diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec'),
(492, '0000-00-00 00:00:00', 'ut nulla sed accumsan felis ut at dolor quis odio'),
(493, '0000-00-00 00:00:00', 'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia'),
(494, '0000-00-00 00:00:00', 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus'),
(495, '0000-00-00 00:00:00', 'dui vel nisl duis ac nibh fusce lacus purus aliquet'),
(496, '0000-00-00 00:00:00', 'libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a'),
(497, '0000-00-00 00:00:00', 'tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis'),
(498, '0000-00-00 00:00:00', 'integer non velit donec diam neque vestibulum eget vulputate ut ultrices'),
(499, '0000-00-00 00:00:00', 'sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at'),
(500, '0000-00-00 00:00:00', 'vestibulum sit amet cursus id turpis integer aliquet massa id lobortis');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `ID_uzytkownika` int(11) NOT NULL,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `Nick` varchar(50) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `Haslo` varchar(255) NOT NULL,
  `Bio` text NOT NULL,
  `Kraj` varchar(80) NOT NULL,
  `Data_Urodzenia` date DEFAULT NULL,
  `Link_Zdjecia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`ID_uzytkownika`, `Imie`, `Nazwisko`, `Nick`, `Email`, `Haslo`, `Bio`, `Kraj`, `Data_Urodzenia`, `Link_Zdjecia`) VALUES
(1, 'Jan', 'Kowalski', 'jankowalski', 'jankowalski@example.com', 'haslo123', 'siema to ja ', '', '1990-05-10', 'https://randomuser.me/api/portraits/men/1.jpg'),
(2, 'Anna', 'Nowak', 'annanowak', 'annanowak@example.com', 'haslo123', '', '', '1992-08-15', 'https://randomuser.me/api/portraits/women/1.jpg'),
(3, 'Marek', 'Zalewski', 'marekzalewski', 'marekzalewski@example.com', 'haslo123', '', '', '1987-12-22', 'https://randomuser.me/api/portraits/men/2.jpg'),
(4, 'Ewa', 'Wiśniewska', 'ewawisniewska', 'ewawisniewska@example.com', 'haslo123', 'siema to ja ', 'Polska', '1994-03-05', 'https://randomuser.me/api/portraits/women/2.jpg'),
(5, 'Paweł', 'Wójcik', 'pawelwojcik', 'pawelwojcik@example.com', 'haslo123', 'siema to ja ', '', '1989-07-19', 'https://randomuser.me/api/portraits/men/3.jpg'),
(6, 'Katarzyna', 'Kaczmarek', 'katarzynakaczmarek', 'katarzynakaczmarek@example.com', 'haslo123', '', '', '1991-11-30', 'https://randomuser.me/api/portraits/women/3.jpg'),
(7, 'Piotr', 'Mazur', 'ziomo', 'piortrulo@poczta', 'haslo123', 'siema to ja ', 'Polska', '2028-02-20', 'https://randomuser.me/api/portraits/men/4.jpg'),
(8, 'Agnieszka', 'Kowalska', 'aga', 'agnieszkakowalska@example.com', 'haslo123', 'ja na nartach', 'Polska', '1993-09-11', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Ffotoplus.pl%2F&psig=AOvVaw02XXY_TWy7C0o9Ucr6lVhY&ust=1732190712575000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPC5xbLv6okDFQAAAAAdAAAAABAE'),
(9, 'Tomasz', 'Pawlak', 'tomaszpawlak', 'tomaszpawlak@example.com', 'haslo123', '', '', '1986-10-03', 'https://randomuser.me/api/portraits/men/5.jpg'),
(10, 'Magdalena', 'Szymańska', 'magdalenaszymanska', 'magdalenaszymanska@example.com', 'haslo123', '', '', '1995-06-25', 'https://randomuser.me/api/portraits/women/5.jpg'),
(11, 'Jakub', 'Jankowski', 'jakubjankowski', 'jakubjankowski@example.com', 'haslo123', '', '', '1988-04-17', 'https://randomuser.me/api/portraits/men/6.jpg'),
(12, 'Monika', 'Bąk', 'monikabak', 'monikabak@example.com', 'haslo123', '', '', '1990-01-20', 'https://randomuser.me/api/portraits/women/6.jpg'),
(13, 'Andrzej', 'Lis', 'andrzejlis', 'andrzejlis@example.com', 'haslo123', '', '', '1992-09-09', 'https://randomuser.me/api/portraits/men/7.jpg'),
(14, 'Joanna', 'Wójcik', 'joannawojcik', 'joannawojcik@example.com', 'haslo123', '', '', '1994-02-12', 'https://randomuser.me/api/portraits/women/7.jpg'),
(15, 'Marcin', 'Jabłoński', 'marcinjablonski', 'marcinjablonski@example.com', 'haslo123', '', '', '1983-06-02', 'https://randomuser.me/api/portraits/men/8.jpg'),
(16, 'Olga', 'Maciąg', 'olgamaciag', 'olgamaciag@example.com', 'haslo123', '', '', '1996-12-13', 'https://randomuser.me/api/portraits/women/8.jpg'),
(17, 'Krzysztof', 'Kwiatkowski', 'krzysztofkwiatkowski', 'krzysztofkwiatkowski@example.com', 'haslo123', '', '', '1987-11-10', 'https://randomuser.me/api/portraits/men/9.jpg'),
(18, 'Julia', 'Nowakowska', 'julianowakowska', 'julianowakowska@example.com', 'haslo123', '', '', '1991-04-08', 'https://randomuser.me/api/portraits/women/9.jpg'),
(19, 'Szymon', 'Stolarz', 'szymonstolarz', 'szymonstolarz@example.com', 'haslo123', '', '', '1993-08-14', 'https://randomuser.me/api/portraits/men/10.jpg'),
(20, 'Wiktoria', 'Krawczyk', 'wiktoriakrawczyk', 'wiktoriakrawczyk@example.com', 'haslo123', '', '', '1990-05-30', 'https://randomuser.me/api/portraits/women/10.jpg'),
(21, 'test', 'test', 'test_test', 'test@wp.pl', '$2y$10$kLHXBJhEhTe/SmFGsa6hKeXRbyk5OxWOttjl27KixKT1U6MGeLyv6', '', '', NULL, NULL),
(22, 'lemi', 'sjhfdaisp', 'lemi_sjhfdaisp', 'Lemi@pocztra', '$2y$10$bb2Uj6xv2cRmLa/eCMkZqeaQXM27N2xDOA4QhF1rQnZvFzw6cZegW', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wiadomosci`
--

CREATE TABLE `wiadomosci` (
  `ID_wiadomosci` int(11) NOT NULL,
  `ID_wysylajacego` int(11) DEFAULT NULL,
  `ID_rozmowy` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Wyslano` timestamp NOT NULL DEFAULT current_timestamp(),
  `Przeczytano` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `wiadomosci`
--

INSERT INTO `wiadomosci` (`ID_wiadomosci`, `ID_wysylajacego`, `ID_rozmowy`, `Tresc`, `Wyslano`, `Przeczytano`) VALUES
(501, 1, 1, 'Cześć, jak się masz?', '2024-04-01 08:00:00', 0),
(502, 2, 1, 'Dobrze, dziękuję! A ty?', '2024-04-01 08:05:00', 1),
(503, 3, 2, 'Pamiętasz o projekcie?', '2024-04-02 09:00:00', 0),
(504, 4, 2, 'Tak, już pracuję nad tym!', '2024-04-02 09:10:00', 1),
(505, 5, 3, 'Hej, masz czas na spotkanie?', '2024-04-03 10:00:00', 0),
(506, 6, 3, 'Oczywiście, kiedy ci pasuje?', '2024-04-03 10:05:00', 1),
(507, 7, 4, 'Przypomnienie o zadaniu.', '2024-04-04 11:00:00', 0),
(508, 8, 4, 'Okej, zajmuję się tym teraz.', '2024-04-04 11:10:00', 0),
(509, 9, 5, 'Czy przeczytałeś raport?', '2024-04-05 12:00:00', 1),
(510, 10, 5, 'Tak, już przeczytałem.', '2024-04-05 12:05:00', 1),
(511, 11, 6, 'Co u ciebie słychać?', '2024-04-06 13:00:00', 0),
(512, 12, 6, 'Wszystko w porządku, a u ciebie?', '2024-04-06 13:05:00', 1),
(513, 13, 7, 'Zadanie zostało ukończone!', '2024-04-07 14:00:00', 0),
(514, 20, 7, 'Świetnie, czekam na raport.', '2024-04-07 14:05:00', 1),
(515, 15, 8, 'Czy masz czas na spotkanie?', '2024-04-08 15:00:00', 1),
(516, 16, 8, 'Tak, pasuje mi 15:00.', '2024-04-08 15:05:00', 1),
(517, 17, 9, 'Musimy porozmawiać o projekcie.', '2024-04-09 16:00:00', 0),
(518, 18, 9, 'Zgadza się, kiedy ci pasuje?', '2024-04-09 16:05:00', 0),
(519, 19, 10, 'Zakończyłem pierwszą część zadania.', '2024-04-10 17:00:00', 1),
(520, 20, 10, 'Świetnie, teraz przejdźmy do drugiej części.', '2024-04-10 17:05:00', 1);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wiadomosci_niewyslane`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `wiadomosci_niewyslane` (
`ID_wiadomosci` int(11)
,`Tresc` varchar(255)
,`Wyslano` timestamp
,`Przeczytano` tinyint(1)
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Nazwa_rozmowy` varchar(255)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `widok_top_10_posty`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `widok_top_10_posty` (
`ID_postu` int(11)
,`Tytul` varchar(255)
,`Tresc` varchar(255)
,`Ilosc_polubien` int(11)
,`Data_publikacji` timestamp
,`Imie` varchar(100)
,`Nazwisko` varchar(100)
,`Nick` varchar(50)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `znaj`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `znaj` (
`ID_uzytkownika` int(11)
,`Imie_uzytkownika` varchar(100)
,`Nazwisko_uzytkownika` varchar(100)
,`Status_znajomosci` enum('zatwierdzona','oczekująca','','')
,`Poczatek_znajomosci` timestamp
,`Imie_znajomego` varchar(100)
,`Nazwisko_znajomego` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `znajomi`
--

CREATE TABLE `znajomi` (
  `ID_znajomego1` int(11) NOT NULL,
  `ID_znajomego2` int(11) NOT NULL,
  `Status_znajomosci` enum('zatwierdzona','oczekująca','','') NOT NULL,
  `Poczatek_znajomosci` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `znajomi`
--

INSERT INTO `znajomi` (`ID_znajomego1`, `ID_znajomego2`, `Status_znajomosci`, `Poczatek_znajomosci`) VALUES
(1, 2, 'zatwierdzona', '2023-12-31 23:00:00'),
(1, 3, 'oczekująca', '2024-01-31 23:00:00'),
(2, 3, 'zatwierdzona', '2024-03-14 23:00:00'),
(2, 4, 'oczekująca', '2024-03-31 22:00:00'),
(3, 4, 'zatwierdzona', '2024-04-04 22:00:00'),
(5, 6, 'oczekująca', '2024-04-09 22:00:00'),
(6, 7, 'zatwierdzona', '2024-04-11 22:00:00'),
(7, 8, 'oczekująca', '2024-04-14 22:00:00'),
(8, 9, 'zatwierdzona', '2024-04-17 22:00:00'),
(9, 10, 'oczekująca', '2024-04-19 22:00:00'),
(10, 11, 'zatwierdzona', '2024-04-21 22:00:00'),
(11, 12, 'oczekująca', '2024-04-24 22:00:00'),
(12, 13, 'zatwierdzona', '2024-04-26 22:00:00'),
(13, 14, 'oczekująca', '2024-04-28 22:00:00'),
(14, 15, 'zatwierdzona', '2024-04-30 22:00:00'),
(15, 16, 'oczekująca', '2024-05-04 22:00:00'),
(16, 17, 'zatwierdzona', '2024-05-06 22:00:00'),
(17, 18, 'oczekująca', '2024-05-09 22:00:00'),
(18, 19, 'zatwierdzona', '2024-05-11 22:00:00'),
(19, 20, 'oczekująca', '2024-05-14 22:00:00');

-- --------------------------------------------------------

--
-- Struktura widoku `5_uzytkow_z_najwieksza_iloscia_obserwacji`
--
DROP TABLE IF EXISTS `5_uzytkow_z_najwieksza_iloscia_obserwacji`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `5_uzytkow_z_najwieksza_iloscia_obserwacji`  AS SELECT `uzy`.`ID_uzytkownika` AS `ID_uzytkownika`, `uzy`.`Imie` AS `Imie`, `uzy`.`Nazwisko` AS `Nazwisko`, `uzy`.`Nick` AS `Nick`, count(`obser`.`ID_obserwujacego`) AS `Liczba_Obserwujacych` FROM (`uzytkownicy` `uzy` join `obserwujacy` `obser` on(`uzy`.`ID_uzytkownika` = `obser`.`ID_obserwowanego`)) GROUP BY `uzy`.`ID_uzytkownika` ORDER BY count(`obser`.`ID_obserwujacego`) DESC LIMIT 0, 55  ;

-- --------------------------------------------------------

--
-- Struktura widoku `aktywnosc_uzytkownikow`
--
DROP TABLE IF EXISTS `aktywnosc_uzytkownikow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aktywnosc_uzytkownikow`  AS SELECT `user`.`ID_uzytkownika` AS `ID_uzytkownika`, `user`.`Imie` AS `Imie`, `user`.`Nazwisko` AS `Nazwisko`, `user`.`Nick` AS `Nick`, coalesce(count(distinct `posts`.`ID_postu`),0) AS `Liczba_Postow`, coalesce(count(distinct `comms`.`ID_komentarza`),0) AS `Liczba_Komentarzy`, coalesce(count(distinct `films`.`ID_filmu`),0) AS `Liczba_Filmow`, coalesce(count(distinct `msgs`.`ID_wiadomosci`),0) AS `Liczba_Wiadomosci` FROM ((((`uzytkownicy` `user` left join `posty` `posts` on(`user`.`ID_uzytkownika` = `posts`.`ID_uzytkownika`)) left join `komentarze` `comms` on(`user`.`ID_uzytkownika` = `comms`.`ID_uzytkownika`)) left join `filmiki` `films` on(`user`.`ID_uzytkownika` = `films`.`ID_uzytkownika`)) left join `wiadomosci` `msgs` on(`user`.`ID_uzytkownika` = `msgs`.`ID_wysylajacego`)) GROUP BY `user`.`ID_uzytkownika``ID_uzytkownika`  ;

-- --------------------------------------------------------

--
-- Struktura widoku `komentarze_z_postami`
--
DROP TABLE IF EXISTS `komentarze_z_postami`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `komentarze_z_postami`  AS SELECT `comms`.`ID_komentarza` AS `ID_komentarza`, `comms`.`Tresc` AS `Komentarz`, `comms`.`Ilosc_polubien` AS `Komentarz_Polubienia`, `posts`.`Tytul` AS `Post_Tytul`, `posts`.`Tresc` AS `Post_Tresc`, `posts`.`Ilosc_polubien` AS `Post_Polubienia`, `user1`.`Imie` AS `Komentujacy_Imie`, `user1`.`Nazwisko` AS `Komentujacy_Nazwisko`, `user2`.`Imie` AS `Autor_Postu_Imie`, `user2`.`Nazwisko` AS `Autor_Postu_Nazwisko` FROM (((`komentarze` `comms` join `posty` `posts` on(`comms`.`ID_postu` = `posts`.`ID_postu`)) join `uzytkownicy` `user1` on(`comms`.`ID_uzytkownika` = `user1`.`ID_uzytkownika`)) join `uzytkownicy` `user2` on(`posts`.`ID_uzytkownika` = `user2`.`ID_uzytkownika`))  ;

-- --------------------------------------------------------

--
-- Struktura widoku `najbardziej_polubiane_komentarze`
--
DROP TABLE IF EXISTS `najbardziej_polubiane_komentarze`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najbardziej_polubiane_komentarze`  AS SELECT `kom`.`ID_komentarza` AS `ID_komentarza`, `kom`.`Tresc` AS `Komentarz_Tresc`, `kom`.`Ilosc_polubien` AS `Komentarz_Polubienia`, `uzy`.`Imie` AS `Komentujacy_Imie`, `uzy`.`Nazwisko` AS `Komentujacy_Nazwisko`, `pos`.`Tytul` AS `Post_Tytul`, `pos`.`Tresc` AS `Post_Tresc`, `pos`.`Ilosc_polubien` AS `Post_Polubienia`, `kom`.`Data_publikacji` AS `Komentarz_Data_Publikacji` FROM ((`komentarze` `kom` join `uzytkownicy` `uzy` on(`kom`.`ID_uzytkownika` = `uzy`.`ID_uzytkownika`)) join `posty` `pos` on(`kom`.`ID_postu` = `pos`.`ID_postu`)) ORDER BY `kom`.`Ilosc_polubien` AS `DESCdesc` ASC  ;

-- --------------------------------------------------------

--
-- Struktura widoku `najwiecej_hasztagow`
--
DROP TABLE IF EXISTS `najwiecej_hasztagow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najwiecej_hasztagow`  AS SELECT `p`.`Hasztagi` AS `Hasztagi`, count(`p`.`ID_postu`) AS `liczba_postow` FROM `posty` AS `p` GROUP BY `p`.`Hasztagi` ORDER BY count(`p`.`ID_postu`) DESC LIMIT 0, 55  ;

-- --------------------------------------------------------

--
-- Struktura widoku `wiadomosci_niewyslane`
--
DROP TABLE IF EXISTS `wiadomosci_niewyslane`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wiadomosci_niewyslane`  AS SELECT `wiadomosc`.`ID_wiadomosci` AS `ID_wiadomosci`, `wiadomosc`.`Tresc` AS `Tresc`, `wiadomosc`.`Wyslano` AS `Wyslano`, `wiadomosc`.`Przeczytano` AS `Przeczytano`, `uzytkownik`.`Imie` AS `Imie`, `uzytkownik`.`Nazwisko` AS `Nazwisko`, `rozmowa`.`Nazwa_rozmowy` AS `Nazwa_rozmowy` FROM ((`wiadomosci` `wiadomosc` join `uzytkownicy` `uzytkownik` on(`wiadomosc`.`ID_wysylajacego` = `uzytkownik`.`ID_uzytkownika`)) join `rozmowy` `rozmowa` on(`wiadomosc`.`ID_rozmowy` = `rozmowa`.`ID_rozmowy`)) WHERE `wiadomosc`.`Przeczytano` = 00  ;

-- --------------------------------------------------------

--
-- Struktura widoku `widok_top_10_posty`
--
DROP TABLE IF EXISTS `widok_top_10_posty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widok_top_10_posty`  AS SELECT `p`.`ID_postu` AS `ID_postu`, `p`.`Tytul` AS `Tytul`, `p`.`Tresc` AS `Tresc`, `p`.`Ilosc_polubien` AS `Ilosc_polubien`, `p`.`Data_publikacji` AS `Data_publikacji`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `u`.`Nick` AS `Nick` FROM (`posty` `p` join `uzytkownicy` `u` on(`p`.`ID_uzytkownika` = `u`.`ID_uzytkownika`)) ORDER BY `p`.`Ilosc_polubien` DESC LIMIT 0, 1010  ;

-- --------------------------------------------------------

--
-- Struktura widoku `znaj`
--
DROP TABLE IF EXISTS `znaj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `znaj`  AS SELECT `znajomy`.`ID_znajomego1` AS `ID_uzytkownika`, `uzytkownik1`.`Imie` AS `Imie_uzytkownika`, `uzytkownik1`.`Nazwisko` AS `Nazwisko_uzytkownika`, `znajomy`.`Status_znajomosci` AS `Status_znajomosci`, `znajomy`.`Poczatek_znajomosci` AS `Poczatek_znajomosci`, `uzytkownik2`.`Imie` AS `Imie_znajomego`, `uzytkownik2`.`Nazwisko` AS `Nazwisko_znajomego` FROM ((`znajomi` `znajomy` join `uzytkownicy` `uzytkownik1` on(`znajomy`.`ID_znajomego1` = `uzytkownik1`.`ID_uzytkownika`)) join `uzytkownicy` `uzytkownik2` on(`znajomy`.`ID_znajomego2` = `uzytkownik2`.`ID_uzytkownika`))  ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `filmiki`
--
ALTER TABLE `filmiki`
  ADD PRIMARY KEY (`ID_filmu`),
  ADD KEY `id_uzytkownika` (`ID_uzytkownika`);

--
-- Indeksy dla tabeli `komentarze`
--
ALTER TABLE `komentarze`
  ADD PRIMARY KEY (`ID_komentarza`),
  ADD KEY `id_postu` (`ID_postu`),
  ADD KEY `id_uzytkownika` (`ID_uzytkownika`);

--
-- Indeksy dla tabeli `obserwujacy`
--
ALTER TABLE `obserwujacy`
  ADD PRIMARY KEY (`ID_obserwujacego`,`ID_obserwowanego`),
  ADD KEY `id_obserwowanego` (`ID_obserwowanego`);

--
-- Indeksy dla tabeli `posty`
--
ALTER TABLE `posty`
  ADD PRIMARY KEY (`ID_postu`),
  ADD KEY `id_uzytkownika` (`ID_uzytkownika`);

--
-- Indeksy dla tabeli `rozmowy`
--
ALTER TABLE `rozmowy`
  ADD PRIMARY KEY (`ID_rozmowy`);

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`ID_uzytkownika`),
  ADD UNIQUE KEY `E-mail` (`Email`) USING BTREE;

--
-- Indeksy dla tabeli `wiadomosci`
--
ALTER TABLE `wiadomosci`
  ADD PRIMARY KEY (`ID_wiadomosci`),
  ADD KEY `id_wysylajacego` (`ID_wysylajacego`),
  ADD KEY `id_rozmowy` (`ID_rozmowy`);

--
-- Indeksy dla tabeli `znajomi`
--
ALTER TABLE `znajomi`
  ADD PRIMARY KEY (`ID_znajomego1`,`ID_znajomego2`),
  ADD KEY `id_znajomego2` (`ID_znajomego2`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `filmiki`
--
ALTER TABLE `filmiki`
  MODIFY `ID_filmu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=510;

--
-- AUTO_INCREMENT dla tabeli `komentarze`
--
ALTER TABLE `komentarze`
  MODIFY `ID_komentarza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=539;

--
-- AUTO_INCREMENT dla tabeli `posty`
--
ALTER TABLE `posty`
  MODIFY `ID_postu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=531;

--
-- AUTO_INCREMENT dla tabeli `rozmowy`
--
ALTER TABLE `rozmowy`
  MODIFY `ID_rozmowy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `ID_uzytkownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT dla tabeli `wiadomosci`
--
ALTER TABLE `wiadomosci`
  MODIFY `ID_wiadomosci` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=521;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `filmiki`
--
ALTER TABLE `filmiki`
  ADD CONSTRAINT `filmiki_ibfk_1` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `komentarze`
--
ALTER TABLE `komentarze`
  ADD CONSTRAINT `komentarze_ibfk_1` FOREIGN KEY (`ID_postu`) REFERENCES `posty` (`ID_postu`) ON DELETE CASCADE,
  ADD CONSTRAINT `komentarze_ibfk_2` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `obserwujacy`
--
ALTER TABLE `obserwujacy`
  ADD CONSTRAINT `obserwujacy_ibfk_1` FOREIGN KEY (`ID_obserwujacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `obserwujacy_ibfk_2` FOREIGN KEY (`ID_obserwowanego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `posty`
--
ALTER TABLE `posty`
  ADD CONSTRAINT `posty_ibfk_1` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `wiadomosci`
--
ALTER TABLE `wiadomosci`
  ADD CONSTRAINT `wiadomosci_ibfk_1` FOREIGN KEY (`ID_wysylajacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `wiadomosci_ibfk_2` FOREIGN KEY (`ID_rozmowy`) REFERENCES `rozmowy` (`ID_rozmowy`) ON DELETE CASCADE;

--
-- Ograniczenia dla tabeli `znajomi`
--
ALTER TABLE `znajomi`
  ADD CONSTRAINT `znajomi_ibfk_1` FOREIGN KEY (`ID_znajomego1`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `znajomi_ibfk_2` FOREIGN KEY (`ID_znajomego2`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
