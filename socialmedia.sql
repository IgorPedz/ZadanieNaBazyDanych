-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 29, 2024 at 02:34 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `socialmedia`
--

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `5_uzytkow_z_najwieksza_iloscia_obserwacji`
-- (See below for the actual view)
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
-- (See below for the actual view)
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
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  `Typ` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `filmiki`
--

INSERT INTO `filmiki` (`ID_filmu`, `ID_uzytkownika`, `Link_filmu`, `Data_publikacji`, `Typ`) VALUES
(10, 21, 'uploads/story_6748f49ead5847.19764860.mp4', '2024-11-29 11:58:19', 'youtube'),
(516, 23, 'uploads/story_6748f49ead5847.19764860.mp4', '2024-11-28 22:54:22', 'youtube'),
(524, 23, 'uploads/PRL 1973 Teatr Sensacji Kobra.mp4', '2024-11-29 13:01:07', ''),
(525, 23, 'uploads/PRL 1973 Teatr Sensacji Kobra.mp4', '2024-11-29 13:01:26', '');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `komentarze`
--

INSERT INTO `komentarze` (`ID_komentarza`, `ID_postu`, `ID_uzytkownika`, `Tresc`, `Data_publikacji`, `Data_edycji`, `Ilosc_polubien`) VALUES
(601, 644, 23, 'Czesc!', '2024-11-27 00:25:01', '2024-11-27 00:25:01', 0),
(605, 644, 36, 'Super Post!', '2024-11-29 11:13:22', '2024-11-29 11:13:22', 0),
(606, 641, 36, 'w', '2024-11-29 11:15:39', '2024-11-29 11:15:39', 0);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `komentarze_z_postami`
-- (See below for the actual view)
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
-- (See below for the actual view)
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
-- Zastąpiona struktura widoku `najpopularniejsze_hasztagi`
-- (See below for the actual view)
--
CREATE TABLE `najpopularniejsze_hasztagi` (
`hasztag` varchar(255)
,`ilosc` bigint(21)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `najwiecej_hasztagow`
-- (See below for the actual view)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obserwujacy`
--

INSERT INTO `obserwujacy` (`ID_obserwowanego`, `ID_obserwujacego`, `Data_obserwacji`) VALUES
(30, 23, '2024-11-26 23:55:05'),
(32, 23, '2024-11-29 12:41:16'),
(23, 32, '2024-11-27 16:51:04'),
(32, 36, '2024-11-29 11:13:55');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`) VALUES
(0, 'pedziwilk@gmail.com', '58813edc96c6c09484dbbc5157944b151b3422f852a4efb32dcf6b2ce729ff0de938c2dd15e0f65d1752493cea9923ef2f4e', '2024-11-23 13:38:23'),
(0, 'pedziwilk@gmail.com', '358389ffe014e9c49169a1cb3eaa570c8982939e020cd6d62e383d1ce07f3d3af28cbb21d59c95c5180d990bdb59f63a3e92', '2024-11-23 13:38:24'),
(0, 'pedziwilk@gmail.com', 'adb88fbf85f947256bcb4dda902536ba4a3647c1ce9c6afa86bd5f5723aecf1be2ca9e01b443a0d6d025be7bd22a1a89f0e7', '2024-11-23 13:39:50'),
(0, 'pedziwilk@gmail.com', '7db406cc5c9c9e54356cb56ea3c86da89ae50897e0eaff727d234371ee32d9d7f412ffade4621806bea42f572329572fe176', '2024-11-23 13:39:51'),
(0, 'pedziwilk@gmail.com', 'e74d8072a06ff57d523c113244ec456271775bc4dc1147387086c189d58626a91f6d9d6666571f92f931ce38821a5e66bf50', '2024-11-23 13:39:51'),
(0, 'pedziwilk@gmail.com', 'c3118d83d5504bef01a908b07c369d531f725cb2f2ecc23d3cf16225e77062ec5ed8f64ff2dffe6b1c3ffa478e376fee6257', '2024-11-23 13:39:51'),
(0, 'pedziwilk@gmail.com', '4ac116f2978317d2fdec9fc659451e16d8acd484b2c24e38b26e244d60d198926c9500beb086d483e7a49741da9f55f299e6', '2024-11-23 13:39:54'),
(0, 'pedziwilk@gmail.com', 'c2ef0f24888be8a0d55107323a92212f0b07d40e3cd311266052299a9edc3d3a380151319265955c195c0a086d74da610cf0', '2024-11-23 13:40:21'),
(0, 'pedziwilk@gmail.com', 'ab37c18ad88ba4f7d281e7897760be5e91ca8b175d41f4fc7b8fbf7f848b384ea6f3aca6b02b67a704d7e1081a9f39b04b07', '2024-11-23 13:41:19'),
(0, 'pedziwilk@gmail.com', 'c7c5fca64ea9929fa73a0bd805494f8de378c4b8426c56f82b4da8565ea91198ee1273a21554b127b613b7b0648e4eae919f', '2024-11-23 13:41:58'),
(0, 'pedziwilk@gmail.com', '4e2fab90a9ee77596c7fa3ae7ea21ee395831aca7b32bfcd28266ea3f57378bacd23b566e756985111ee48f566828a632444', '2024-11-23 13:42:30'),
(0, 'pedziwilk@gmail.com', '9de8e7764443ce37d8c9399085c54a7a8dbe52767bc694cf94e85733c4b082df96817d74e26f6e90a9d2f13865edf56c9e41', '2024-11-23 13:42:45'),
(0, 'pedziwilk@gmail.com', 'd08261aead5b04bf151ec7c59896dc502cb8cba9c57fcca1a508076c90fbc3349ebda11f9871d5f5a984ecd3f35fb65c4d83', '2024-11-23 13:43:07'),
(0, 'pedziwilk@gmail.com', '4c80b1830f5dab9c1aa2a32f64ab37e7e2caeac9e29fe71d60861ebdcf6197d5fcdf72952c8752f7ec00f870d053a22481fb', '2024-11-23 13:44:39');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `polubienia_komentarze`
--

CREATE TABLE `polubienia_komentarze` (
  `ID_komentarza` int(11) NOT NULL,
  `ID_uzytkownika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `polubienia_komentarze`
--

INSERT INTO `polubienia_komentarze` (`ID_komentarza`, `ID_uzytkownika`) VALUES
(601, 23),
(606, 32),
(601, 32),
(605, 32);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `polubienia_posty`
--

CREATE TABLE `polubienia_posty` (
  `ID_postu` int(11) NOT NULL,
  `ID_uzytkownika` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `polubienia_posty`
--

INSERT INTO `polubienia_posty` (`ID_postu`, `ID_uzytkownika`) VALUES
(641, 32),
(656, 36),
(644, 32),
(656, 32);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `popular_hashtags`
-- (See below for the actual view)
--
CREATE TABLE `popular_hashtags` (
`hashtag` varchar(255)
,`count` bigint(21)
);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posty`
--

INSERT INTO `posty` (`ID_postu`, `ID_uzytkownika`, `Tresc`, `Link_zdjecia`, `Tytul`, `Data_publikacji`, `Data_edycji`, `Hasztagi`, `Ilosc_polubien`) VALUES
(641, 30, 'est', NULL, 'testt', '2024-11-22 15:35:58', '2024-11-28 19:56:05', '#test', 2),
(644, 32, 'to jest testowy post', NULL, 'Test działania', '2024-11-23 21:20:12', '2024-11-29 11:24:17', '#test', 1),
(656, 23, 'elo', NULL, 'elo', '2024-11-28 19:58:48', '2024-11-29 11:23:47', '#rozwój', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rozmowy`
--

CREATE TABLE `rozmowy` (
  `ID_rozmowy` int(11) NOT NULL,
  `Data_utworzenia` timestamp NOT NULL DEFAULT current_timestamp(),
  `Nazwa_rozmowy` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rozmowy`
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
  `Data_Urodzenia` date DEFAULT NULL,
  `Link_Zdjecia` varchar(255) DEFAULT NULL,
  `Kraj` varchar(50) NOT NULL,
  `Bio` text NOT NULL,
  `resetToken` varchar(255) NOT NULL,
  `tokenExpiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`ID_uzytkownika`, `Imie`, `Nazwisko`, `Nick`, `Email`, `Haslo`, `Data_Urodzenia`, `Link_Zdjecia`, `Kraj`, `Bio`, `resetToken`, `tokenExpiry`) VALUES
(21, 'test', 'test', 'test_test', 'test@wp.pl', '$2y$10$kLHXBJhEhTe/SmFGsa6hKeXRbyk5OxWOttjl27KixKT1U6MGeLyv6', NULL, NULL, '', '', '', NULL),
(22, 'testowy', 'testowy', 'testowy_testowy', 'testowy@wp.pl', '$2y$10$j2z3s7nEmcOXhCNI2eGtHOiBKFjDMqsth1pmMLWcjj18QWiO2l3dK', NULL, NULL, '', '', '', NULL),
(23, 'Igor ', 'Pędziwilk', 'PędziwilkIgor', 'pedziwilk@gmail.com', '$2y$10$41cc/4zClVl2puvjkWOpCejlskWyd0Wb.EAtvEHZdPWXscnQ/dy4C', '2007-04-04', 'uploads/profile_6747407cc92826.63697798.png', 'Polska', 'administatortrator jeszczeraz', '', NULL),
(24, 'igor', 'pedziwilk', 'igor_pedziwilk', 'qigorq@wp.pl', '$2y$10$FKDYZPkrRciI2xzipYE5qe.4RaQkFmQDv5HWOxHVqU.m.Wlien526', NULL, NULL, '', '', '', NULL),
(25, 'test', 'test', 'test_test', 'testtest@wp.pl', '$2y$10$JJF6z17WakR6L3io9T1jL.gkiw0y6EoY1KT1SkQmhbmrAH3acLeeG', NULL, NULL, '', '', '', NULL),
(26, 'tester', 'tester', 'tester_tester', 'tester@wp.pl', '$2y$10$ZiEus8euNC.q2KtqxeZJSevzoHVqGEL4unAOqVABcp5dxnn/GRSzq', NULL, NULL, '', '', '', NULL),
(27, 't', 't', 't_t', 't@wp.pl', '$2y$10$wxg7B9Bcm2qJyiDmrXCWGOrFXfyGW92pgLfxA2kIAOPvFzlJIZT9K', NULL, NULL, '', '', '', NULL),
(28, 'tester', 'tester', 'tester_tester', 'testertest@wp.pl', '$2y$10$ZM0cUwBs9PwaH8UeL58N/.dxjVIADSy3HYR97Dl8D5OjyjnsyQPPC', NULL, NULL, '', '', '', NULL),
(29, 'testowy2', 'testowy2', 'testowy2_testowy2', 'testowy2@wp.pl', '$2y$10$tqjWD1B6B8vwNyNMLTGmNOFoRJmqbQNsOdARpv1NYrvP2RykqW/Uy', NULL, NULL, '', '', '', NULL),
(30, 'igor', 'igor', 'igor_igor', 'igor@onet.pl', '$2y$10$t0ResADRtD2X7iexXS3qTeehl2zHxmaeAKCPV1pej1HGYifMHyIJK', NULL, NULL, '', '', '', NULL),
(31, 'igor', 'igoerrr', 'igor_igoerrr', 'igoer@wp.pl', '$2y$10$PRNjQT2VTjwYXpmJZCZAJOmJqH2secbEPmrxc4Nb7SHAld4LyQAvC', NULL, NULL, '', '', '', NULL),
(32, 'omletowy', 'omletowy', 'omletowy_omletowy', 'igorrpedziwilk@gmail.com', '$2y$10$eNMksHTdjyH.c14TGIHTAekromieEJQv2TtL3ymUZEDdJZ1/eKqJC', NULL, 'uploads/profile_6741edc8b7ec68.16578397.png', '', '', '', NULL),
(33, 'TestowyZawodnik', 'TestowyZawodnik', 'TestowyZawodnik_TestowyZawodnik', 'TestowyZawodnik@wp.pl', '$2y$10$6iIvNCG.V5vfzcSvk4lONuaYUc09UDX7t4pw9BXN0nsAjQz2rLIgm', NULL, NULL, '', '', '', NULL),
(34, 'TestowyZawodnik1', 'TestowyZawodnik1', 'TestowyZawodnik1_TestowyZawodnik1', 'TestowyZawodnik@onet.pl', '$2y$10$jfx7eJVgBtUx0sG9UY0SYOrsdcMyanolCgIljVGlg8Kkja9bxLlii', NULL, NULL, '2006-05-26', '', '', NULL),
(35, 'TestowyZawodnik12', 'TestowyZawodnik12', 'TestowyZawodnik12_TestowyZawodnik12', 'TestowyZawodnik@onet.plw', '$2y$10$dZHRN7yGG6xfgArxZGu6O.qolfXTGswTDqZIhFMzjCi3qLSXnpdnS', '2006-05-26', 'uploads/profile_6745ed5e1ccae5.85952748.jpg', 'Polska', '', '', NULL),
(36, 'tester1000', 'tester1000', 'tester1000_tester1000', 'tester1000@wp.pl', '$2y$10$Z98Y12cU6QItSBFTasYJQeVt7SesrQ9ux/SjRtiLU1IwuCVUjAIby', '2024-11-09', NULL, 'Polska', 'testowy zwodnik 123', '', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wiadomosci`
--

CREATE TABLE `wiadomosci` (
  `ID_wiadomosci` int(11) NOT NULL,
  `ID_wysylajacego` int(11) DEFAULT NULL,
  `ID_odbierajacego` int(11) NOT NULL,
  `ID_rozmowy` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Wyslano` timestamp NOT NULL DEFAULT current_timestamp(),
  `Przeczytano` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wiadomosci`
--

INSERT INTO `wiadomosci` (`ID_wiadomosci`, `ID_wysylajacego`, `ID_odbierajacego`, `ID_rozmowy`, `Tresc`, `Wyslano`, `Przeczytano`) VALUES
(502, 2, 3, 1, 'Dobrze, dziękuję! A ty?', '2024-04-01 08:05:00', 1),
(503, 3, 4, 2, 'Pamiętasz o projekcie?', '2024-04-02 09:00:00', 0),
(504, 4, 3, 2, 'Tak, już pracuję nad tym!', '2024-04-02 09:10:00', 1),
(505, 5, 4, 3, 'Hej, masz czas na spotkanie?', '2024-04-03 10:00:00', 0),
(506, 6, 5, 3, 'Oczywiście, kiedy ci pasuje?', '2024-04-03 10:05:00', 1),
(507, 7, 6, 4, 'Przypomnienie o zadaniu.', '2024-04-04 11:00:00', 0),
(508, 8, 7, 4, 'Okej, zajmuję się tym teraz.', '2024-04-04 11:10:00', 0),
(509, 9, 7, 5, 'Czy przeczytałeś raport?', '2024-04-05 12:00:00', 1),
(510, 10, 6, 5, 'Tak, już przeczytałem.', '2024-04-05 12:05:00', 1),
(511, 11, 9, 6, 'Co u ciebie słychać?', '2024-04-06 13:00:00', 0),
(512, 12, 9, 6, 'Wszystko w porządku, a u ciebie?', '2024-04-06 13:05:00', 1),
(513, 13, 8, 7, 'Zadanie zostało ukończone!', '2024-04-07 14:00:00', 0),
(514, 20, 11, 7, 'Świetnie, czekam na raport.', '2024-04-07 14:05:00', 1),
(515, 15, 12, 8, 'Czy masz czas na spotkanie?', '2024-04-08 15:00:00', 1),
(517, 17, 13, 9, 'Musimy porozmawiać o projekcie.', '2024-04-09 16:00:00', 0),
(518, 18, 14, 9, 'Zgadza się, kiedy ci pasuje?', '2024-04-09 16:05:00', 0),
(519, 19, 15, 10, 'Zakończyłem pierwszą część zadania.', '2024-04-10 17:00:00', 1),
(520, 20, 16, 10, 'Świetnie, teraz przejdźmy do drugiej części.', '2024-04-10 17:05:00', 1),
(534, 32, 36, NULL, 'Czesc to ja! a ty?', '2024-11-29 11:22:57', 0),
(535, 36, 32, NULL, 'miło poznać', '2024-11-29 11:23:16', 0);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `wiadomosci_niewyslane`
-- (See below for the actual view)
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
-- (See below for the actual view)
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
-- (See below for the actual view)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `znajomi`
--

INSERT INTO `znajomi` (`ID_znajomego1`, `ID_znajomego2`, `Status_znajomosci`, `Poczatek_znajomosci`) VALUES
(23, 30, 'oczekująca', '2024-11-27 22:05:33'),
(23, 32, 'oczekująca', '2024-11-29 12:38:41'),
(23, 36, 'oczekująca', '2024-11-29 12:41:42'),
(32, 30, 'oczekująca', '2024-11-27 22:00:05');

-- --------------------------------------------------------

--
-- Struktura widoku `5_uzytkow_z_najwieksza_iloscia_obserwacji`
--
DROP TABLE IF EXISTS `5_uzytkow_z_najwieksza_iloscia_obserwacji`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `5_uzytkow_z_najwieksza_iloscia_obserwacji`  AS SELECT `uzy`.`ID_uzytkownika` AS `ID_uzytkownika`, `uzy`.`Imie` AS `Imie`, `uzy`.`Nazwisko` AS `Nazwisko`, `uzy`.`Nick` AS `Nick`, count(`obser`.`ID_obserwujacego`) AS `Liczba_Obserwujacych` FROM (`uzytkownicy` `uzy` join `obserwujacy` `obser` on(`uzy`.`ID_uzytkownika` = `obser`.`ID_obserwowanego`)) GROUP BY `uzy`.`ID_uzytkownika` ORDER BY count(`obser`.`ID_obserwujacego`) DESC LIMIT 0, 5 ;

-- --------------------------------------------------------

--
-- Struktura widoku `aktywnosc_uzytkownikow`
--
DROP TABLE IF EXISTS `aktywnosc_uzytkownikow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `aktywnosc_uzytkownikow`  AS SELECT `user`.`ID_uzytkownika` AS `ID_uzytkownika`, `user`.`Imie` AS `Imie`, `user`.`Nazwisko` AS `Nazwisko`, `user`.`Nick` AS `Nick`, coalesce(count(distinct `posts`.`ID_postu`),0) AS `Liczba_Postow`, coalesce(count(distinct `comms`.`ID_komentarza`),0) AS `Liczba_Komentarzy`, coalesce(count(distinct `films`.`ID_filmu`),0) AS `Liczba_Filmow`, coalesce(count(distinct `msgs`.`ID_wiadomosci`),0) AS `Liczba_Wiadomosci` FROM ((((`uzytkownicy` `user` left join `posty` `posts` on(`user`.`ID_uzytkownika` = `posts`.`ID_uzytkownika`)) left join `komentarze` `comms` on(`user`.`ID_uzytkownika` = `comms`.`ID_uzytkownika`)) left join `filmiki` `films` on(`user`.`ID_uzytkownika` = `films`.`ID_uzytkownika`)) left join `wiadomosci` `msgs` on(`user`.`ID_uzytkownika` = `msgs`.`ID_wysylajacego`)) GROUP BY `user`.`ID_uzytkownika` ;

-- --------------------------------------------------------

--
-- Struktura widoku `komentarze_z_postami`
--
DROP TABLE IF EXISTS `komentarze_z_postami`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `komentarze_z_postami`  AS SELECT `comms`.`ID_komentarza` AS `ID_komentarza`, `comms`.`Tresc` AS `Komentarz`, `comms`.`Ilosc_polubien` AS `Komentarz_Polubienia`, `posts`.`Tytul` AS `Post_Tytul`, `posts`.`Tresc` AS `Post_Tresc`, `posts`.`Ilosc_polubien` AS `Post_Polubienia`, `user1`.`Imie` AS `Komentujacy_Imie`, `user1`.`Nazwisko` AS `Komentujacy_Nazwisko`, `user2`.`Imie` AS `Autor_Postu_Imie`, `user2`.`Nazwisko` AS `Autor_Postu_Nazwisko` FROM (((`komentarze` `comms` join `posty` `posts` on(`comms`.`ID_postu` = `posts`.`ID_postu`)) join `uzytkownicy` `user1` on(`comms`.`ID_uzytkownika` = `user1`.`ID_uzytkownika`)) join `uzytkownicy` `user2` on(`posts`.`ID_uzytkownika` = `user2`.`ID_uzytkownika`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `najbardziej_polubiane_komentarze`
--
DROP TABLE IF EXISTS `najbardziej_polubiane_komentarze`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najbardziej_polubiane_komentarze`  AS SELECT `kom`.`ID_komentarza` AS `ID_komentarza`, `kom`.`Tresc` AS `Komentarz_Tresc`, `kom`.`Ilosc_polubien` AS `Komentarz_Polubienia`, `uzy`.`Imie` AS `Komentujacy_Imie`, `uzy`.`Nazwisko` AS `Komentujacy_Nazwisko`, `pos`.`Tytul` AS `Post_Tytul`, `pos`.`Tresc` AS `Post_Tresc`, `pos`.`Ilosc_polubien` AS `Post_Polubienia`, `kom`.`Data_publikacji` AS `Komentarz_Data_Publikacji` FROM ((`komentarze` `kom` join `uzytkownicy` `uzy` on(`kom`.`ID_uzytkownika` = `uzy`.`ID_uzytkownika`)) join `posty` `pos` on(`kom`.`ID_postu` = `pos`.`ID_postu`)) ORDER BY `kom`.`Ilosc_polubien` DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `najpopularniejsze_hasztagi`
--
DROP TABLE IF EXISTS `najpopularniejsze_hasztagi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najpopularniejsze_hasztagi`  AS SELECT `hashtags`.`hasztag` AS `hasztag`, count(0) AS `ilosc` FROM (select trim(substring_index(substring_index(`posty`.`Hasztagi`,' ',`n`.`n`),' ',-1)) AS `hasztag` from (`posty` join (select 1 AS `n` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9` union all select 10 AS `10`) `n` on(char_length(`posty`.`Hasztagi`) - char_length(replace(`posty`.`Hasztagi`,' ','')) >= `n`.`n` - 1))) AS `hashtags` GROUP BY `hashtags`.`hasztag` ORDER BY count(0) DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Struktura widoku `najwiecej_hasztagow`
--
DROP TABLE IF EXISTS `najwiecej_hasztagow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `najwiecej_hasztagow`  AS SELECT `p`.`Hasztagi` AS `Hasztagi`, count(`p`.`ID_postu`) AS `liczba_postow` FROM `posty` AS `p` GROUP BY `p`.`Hasztagi` ORDER BY count(`p`.`ID_postu`) DESC LIMIT 0, 5 ;

-- --------------------------------------------------------

--
-- Struktura widoku `popular_hashtags`
--
DROP TABLE IF EXISTS `popular_hashtags`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `popular_hashtags`  AS SELECT `hashtags`.`hashtag` AS `hashtag`, count(0) AS `count` FROM (select trim(substring_index(substring_index(`posty`.`Hasztagi`,' ',`n`.`n`),' ',-1)) AS `hashtag` from (`posty` join (select 1 AS `n` union all select 2 AS `2` union all select 3 AS `3` union all select 4 AS `4` union all select 5 AS `5` union all select 6 AS `6` union all select 7 AS `7` union all select 8 AS `8` union all select 9 AS `9` union all select 10 AS `10`) `n` on(char_length(`posty`.`Hasztagi`) - char_length(replace(`posty`.`Hasztagi`,' ','')) >= `n`.`n` - 1))) AS `hashtags` GROUP BY `hashtags`.`hashtag` ORDER BY count(0) DESC ;

-- --------------------------------------------------------

--
-- Struktura widoku `wiadomosci_niewyslane`
--
DROP TABLE IF EXISTS `wiadomosci_niewyslane`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wiadomosci_niewyslane`  AS SELECT `wiadomosc`.`ID_wiadomosci` AS `ID_wiadomosci`, `wiadomosc`.`Tresc` AS `Tresc`, `wiadomosc`.`Wyslano` AS `Wyslano`, `wiadomosc`.`Przeczytano` AS `Przeczytano`, `uzytkownik`.`Imie` AS `Imie`, `uzytkownik`.`Nazwisko` AS `Nazwisko`, `rozmowa`.`Nazwa_rozmowy` AS `Nazwa_rozmowy` FROM ((`wiadomosci` `wiadomosc` join `uzytkownicy` `uzytkownik` on(`wiadomosc`.`ID_wysylajacego` = `uzytkownik`.`ID_uzytkownika`)) join `rozmowy` `rozmowa` on(`wiadomosc`.`ID_rozmowy` = `rozmowa`.`ID_rozmowy`)) WHERE `wiadomosc`.`Przeczytano` = 0 ;

-- --------------------------------------------------------

--
-- Struktura widoku `widok_top_10_posty`
--
DROP TABLE IF EXISTS `widok_top_10_posty`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `widok_top_10_posty`  AS SELECT `p`.`ID_postu` AS `ID_postu`, `p`.`Tytul` AS `Tytul`, `p`.`Tresc` AS `Tresc`, `p`.`Ilosc_polubien` AS `Ilosc_polubien`, `p`.`Data_publikacji` AS `Data_publikacji`, `u`.`Imie` AS `Imie`, `u`.`Nazwisko` AS `Nazwisko`, `u`.`Nick` AS `Nick` FROM (`posty` `p` join `uzytkownicy` `u` on(`p`.`ID_uzytkownika` = `u`.`ID_uzytkownika`)) ORDER BY `p`.`Ilosc_polubien` DESC LIMIT 0, 10 ;

-- --------------------------------------------------------

--
-- Struktura widoku `znaj`
--
DROP TABLE IF EXISTS `znaj`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `znaj`  AS SELECT `znajomy`.`ID_znajomego1` AS `ID_uzytkownika`, `uzytkownik1`.`Imie` AS `Imie_uzytkownika`, `uzytkownik1`.`Nazwisko` AS `Nazwisko_uzytkownika`, `znajomy`.`Status_znajomosci` AS `Status_znajomosci`, `znajomy`.`Poczatek_znajomosci` AS `Poczatek_znajomosci`, `uzytkownik2`.`Imie` AS `Imie_znajomego`, `uzytkownik2`.`Nazwisko` AS `Nazwisko_znajomego` FROM ((`znajomi` `znajomy` join `uzytkownicy` `uzytkownik1` on(`znajomy`.`ID_znajomego1` = `uzytkownik1`.`ID_uzytkownika`)) join `uzytkownicy` `uzytkownik2` on(`znajomy`.`ID_znajomego2` = `uzytkownik2`.`ID_uzytkownika`)) ;

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
-- Indeksy dla tabeli `polubienia_komentarze`
--
ALTER TABLE `polubienia_komentarze`
  ADD KEY `polubienia_komentarze_ibfk_1` (`ID_komentarza`),
  ADD KEY `polubienia_komentarze_ibfk_2` (`ID_uzytkownika`);

--
-- Indeksy dla tabeli `polubienia_posty`
--
ALTER TABLE `polubienia_posty`
  ADD KEY `polubienia_posty_ibfk_1` (`ID_postu`),
  ADD KEY `polubienia_posty_ibfk_2` (`ID_uzytkownika`);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `filmiki`
--
ALTER TABLE `filmiki`
  MODIFY `ID_filmu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=526;

--
-- AUTO_INCREMENT for table `komentarze`
--
ALTER TABLE `komentarze`
  MODIFY `ID_komentarza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=607;

--
-- AUTO_INCREMENT for table `posty`
--
ALTER TABLE `posty`
  MODIFY `ID_postu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=659;

--
-- AUTO_INCREMENT for table `rozmowy`
--
ALTER TABLE `rozmowy`
  MODIFY `ID_rozmowy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `ID_uzytkownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `wiadomosci`
--
ALTER TABLE `wiadomosci`
  MODIFY `ID_wiadomosci` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=536;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `filmiki`
--
ALTER TABLE `filmiki`
  ADD CONSTRAINT `filmiki_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `komentarze`
--
ALTER TABLE `komentarze`
  ADD CONSTRAINT `komentarze_ibfk_1` FOREIGN KEY (`id_postu`) REFERENCES `posty` (`ID_postu`) ON DELETE CASCADE,
  ADD CONSTRAINT `komentarze_ibfk_2` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `obserwujacy`
--
ALTER TABLE `obserwujacy`
  ADD CONSTRAINT `obserwujacy_ibfk_1` FOREIGN KEY (`id_obserwujacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `obserwujacy_ibfk_2` FOREIGN KEY (`id_obserwowanego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `polubienia_komentarze`
--
ALTER TABLE `polubienia_komentarze`
  ADD CONSTRAINT `polubienia_komentarze_ibfk_1` FOREIGN KEY (`ID_komentarza`) REFERENCES `komentarze` (`id_komentarza`) ON DELETE CASCADE,
  ADD CONSTRAINT `polubienia_komentarze_ibfk_2` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `polubienia_posty`
--
ALTER TABLE `polubienia_posty`
  ADD CONSTRAINT `polubienia_posty_ibfk_1` FOREIGN KEY (`ID_postu`) REFERENCES `posty` (`ID_postu`) ON DELETE CASCADE,
  ADD CONSTRAINT `polubienia_posty_ibfk_2` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `posty`
--
ALTER TABLE `posty`
  ADD CONSTRAINT `posty_ibfk_1` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `znajomi`
--
ALTER TABLE `znajomi`
  ADD CONSTRAINT `znajomi_ibfk_1` FOREIGN KEY (`id_znajomego1`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `znajomi_ibfk_2` FOREIGN KEY (`id_znajomego2`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
