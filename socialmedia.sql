-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Lis 08, 2024 at 11:57 PM
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
-- Struktura tabeli dla tabeli `filmiki`
--

CREATE TABLE `filmiki` (
  `ID_filmu` int(11) NOT NULL,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Link_filmu` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obserwujacy`
--

CREATE TABLE `obserwujacy` (
  `ID_obserwowanego` int(11) NOT NULL,
  `ID_obserwujacego` int(11) NOT NULL,
  `Data_obserwacji` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '2024-11-07 12:56:42', 'Ukochany mąż'),
(2, '2024-11-07 12:56:42', 'Rodzina'),
(3, '2024-11-07 12:56:42', 'Przyjaciele'),
(4, '2024-11-07 12:56:42', 'Podróżnicy'),
(5, '2024-11-07 12:56:42', 'Muzyka');

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
  `Link_Zdjecia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD UNIQUE KEY `E-mail` (`Email`) USING BTREE,
  ADD UNIQUE KEY `Nick` (`Nick`) USING BTREE;

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
  MODIFY `ID_filmu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `komentarze`
--
ALTER TABLE `komentarze`
  MODIFY `ID_komentarza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `posty`
--
ALTER TABLE `posty`
  MODIFY `ID_postu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `rozmowy`
--
ALTER TABLE `rozmowy`
  MODIFY `ID_rozmowy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `ID_uzytkownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `wiadomosci`
--
ALTER TABLE `wiadomosci`
  MODIFY `ID_wiadomosci` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
-- Constraints for table `posty`
--
ALTER TABLE `posty`
  ADD CONSTRAINT `posty_ibfk_1` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE;

--
-- Constraints for table `wiadomosci`
--
ALTER TABLE `wiadomosci`
  ADD CONSTRAINT `wiadomosci_ibfk_1` FOREIGN KEY (`id_wysylajacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  ADD CONSTRAINT `wiadomosci_ibfk_2` FOREIGN KEY (`id_rozmowy`) REFERENCES `rozmowy` (`id_rozmowy`) ON DELETE CASCADE;

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
