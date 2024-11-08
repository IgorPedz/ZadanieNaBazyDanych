-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: socialmedia
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `5_uzytkow_z_najwieksza_iloscia_obserwacji`
--

DROP TABLE IF EXISTS `5_uzytkow_z_najwieksza_iloscia_obserwacji`;
/*!50001 DROP VIEW IF EXISTS `5_uzytkow_z_najwieksza_iloscia_obserwacji`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `5_uzytkow_z_najwieksza_iloscia_obserwacji` AS SELECT
 1 AS `ID_uzytkownika`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nick`,
  1 AS `Liczba_Obserwujacych` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `aktywnosc_uzytkownikow`
--

DROP TABLE IF EXISTS `aktywnosc_uzytkownikow`;
/*!50001 DROP VIEW IF EXISTS `aktywnosc_uzytkownikow`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `aktywnosc_uzytkownikow` AS SELECT
 1 AS `ID_uzytkownika`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nick`,
  1 AS `Liczba_Postow`,
  1 AS `Liczba_Komentarzy`,
  1 AS `Liczba_Filmow`,
  1 AS `Liczba_Wiadomosci` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `filmiki`
--

DROP TABLE IF EXISTS `filmiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filmiki` (
  `ID_filmu` int(11) NOT NULL AUTO_INCREMENT,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Link_filmu` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID_filmu`),
  KEY `id_uzytkownika` (`ID_uzytkownika`),
  CONSTRAINT `filmiki_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filmiki`
--

LOCK TABLES `filmiki` WRITE;
/*!40000 ALTER TABLE `filmiki` DISABLE KEYS */;
INSERT INTO `filmiki` VALUES (1,1,'https://example.com/las.mp4','2024-09-06 08:00:00'),(2,2,'https://example.com/ogrod.mp4','2024-09-07 08:15:00'),(3,3,'https://example.com/gory.mp4','2024-09-08 04:10:00'),(4,4,'https://example.com/bieganie.mp4','2024-09-09 06:50:00'),(5,5,'https://example.com/koncert.mp4','2024-09-10 12:20:00'),(6,6,'https://example.com/fotografia.mp4','2024-09-11 14:25:00'),(7,7,'https://example.com/podroz.mp4','2024-09-12 17:30:00'),(8,8,'https://example.com/las.mp4','2024-09-13 06:10:00'),(9,9,'https://example.com/wystawa.mp4','2024-09-14 08:15:00');
/*!40000 ALTER TABLE `filmiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `komentarze`
--

DROP TABLE IF EXISTS `komentarze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `komentarze` (
  `ID_komentarza` int(11) NOT NULL AUTO_INCREMENT,
  `ID_postu` int(11) DEFAULT NULL,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  `Data_edycji` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Ilosc_polubien` int(11) DEFAULT 0,
  PRIMARY KEY (`ID_komentarza`),
  KEY `id_postu` (`ID_postu`),
  KEY `id_uzytkownika` (`ID_uzytkownika`),
  CONSTRAINT `komentarze_ibfk_1` FOREIGN KEY (`id_postu`) REFERENCES `posty` (`ID_postu`) ON DELETE CASCADE,
  CONSTRAINT `komentarze_ibfk_2` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `komentarze`
--

LOCK TABLES `komentarze` WRITE;
/*!40000 ALTER TABLE `komentarze` DISABLE KEYS */;
INSERT INTO `komentarze` VALUES (1,1,2,'Nie mogłem się doczekać powrotu sezonu na maliny!','2024-09-06 08:15:00','2024-09-06 08:20:00',5),(2,2,3,'Ogrodnictwo to moja pasja, super post!','2024-09-07 08:10:00','2024-09-07 08:15:00',3),(3,3,4,'Góry to magiczne miejsce, cudowna fotografia!','2024-09-08 04:05:00','2024-09-08 04:10:00',8),(4,4,5,'Bieganie to najlepszy sposób na formę!','2024-09-09 06:45:00','2024-09-09 06:50:00',6),(5,5,6,'Zdecydowanie muszę to zobaczyć na żywo!','2024-09-10 12:30:00','2024-09-10 12:35:00',4),(6,6,7,'Zima w podróży to prawdziwa magia!','2024-09-11 14:15:00','2024-09-11 14:20:00',2),(7,7,8,'Zgadzam się, poznajmy się!','2024-09-12 17:15:00','2024-09-12 17:20:00',1),(8,8,9,'Bieganie po lesie to czysta przyjemność!','2024-09-13 06:05:00','2024-09-13 06:10:00',5);
/*!40000 ALTER TABLE `komentarze` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `komentarze_z_postami`
--

DROP TABLE IF EXISTS `komentarze_z_postami`;
/*!50001 DROP VIEW IF EXISTS `komentarze_z_postami`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `komentarze_z_postami` AS SELECT
 1 AS `ID_komentarza`,
  1 AS `Komentarz`,
  1 AS `Komentarz_Polubienia`,
  1 AS `Post_Tytul`,
  1 AS `Post_Tresc`,
  1 AS `Post_Polubienia`,
  1 AS `Komentujacy_Imie`,
  1 AS `Komentujacy_Nazwisko`,
  1 AS `Autor_Postu_Imie`,
  1 AS `Autor_Postu_Nazwisko` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `najbardziej_polubiane_komentarze`
--

DROP TABLE IF EXISTS `najbardziej_polubiane_komentarze`;
/*!50001 DROP VIEW IF EXISTS `najbardziej_polubiane_komentarze`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `najbardziej_polubiane_komentarze` AS SELECT
 1 AS `ID_komentarza`,
  1 AS `Komentarz_Tresc`,
  1 AS `Komentarz_Polubienia`,
  1 AS `Komentujacy_Imie`,
  1 AS `Komentujacy_Nazwisko`,
  1 AS `Post_Tytul`,
  1 AS `Post_Tresc`,
  1 AS `Post_Polubienia`,
  1 AS `Komentarz_Data_Publikacji` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `obserwujacy`
--

DROP TABLE IF EXISTS `obserwujacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obserwujacy` (
  `ID_obserwowanego` int(11) NOT NULL,
  `ID_obserwujacego` int(11) NOT NULL,
  `Data_obserwacji` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID_obserwujacego`,`ID_obserwowanego`),
  KEY `id_obserwowanego` (`ID_obserwowanego`),
  CONSTRAINT `obserwujacy_ibfk_1` FOREIGN KEY (`id_obserwujacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  CONSTRAINT `obserwujacy_ibfk_2` FOREIGN KEY (`id_obserwowanego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obserwujacy`
--

LOCK TABLES `obserwujacy` WRITE;
/*!40000 ALTER TABLE `obserwujacy` DISABLE KEYS */;
INSERT INTO `obserwujacy` VALUES (2,1,'2024-11-07 12:58:10'),(1,2,'2024-11-07 12:58:10'),(4,3,'2024-11-07 12:58:10'),(3,4,'2024-11-07 12:58:10'),(6,5,'2024-11-07 12:58:10'),(5,6,'2024-11-07 12:58:10'),(8,7,'2024-11-07 12:58:10'),(7,8,'2024-11-07 12:58:10'),(10,9,'2024-11-07 12:58:10'),(9,10,'2024-11-07 12:58:10');
/*!40000 ALTER TABLE `obserwujacy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posty`
--

DROP TABLE IF EXISTS `posty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posty` (
  `ID_postu` int(11) NOT NULL AUTO_INCREMENT,
  `ID_uzytkownika` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Link_zdjecia` varchar(255) DEFAULT NULL,
  `Tytul` varchar(255) NOT NULL,
  `Data_publikacji` timestamp NOT NULL DEFAULT current_timestamp(),
  `Data_edycji` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Hasztagi` varchar(255) DEFAULT NULL,
  `Ilosc_polubien` int(11) DEFAULT 0,
  PRIMARY KEY (`ID_postu`),
  KEY `id_uzytkownika` (`ID_uzytkownika`),
  CONSTRAINT `posty_ibfk_1` FOREIGN KEY (`ID_uzytkownika`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posty`
--

LOCK TABLES `posty` WRITE;
/*!40000 ALTER TABLE `posty` DISABLE KEYS */;
INSERT INTO `posty` VALUES (1,1,'Sierpien - miesiąc zbioru malin!','https://example.com/maliny.jpg','Maliny - najzdrowszy owoc','2024-09-06 07:00:00','2024-09-07 07:10:00','#sierpien #maliny #zdrowie',7),(2,2,'Nadszedł czas na porządek w ogrodzie!','https://example.com/ogrod.jpg','Porządek w ogrodzie','2024-09-07 08:00:00','2024-09-07 08:10:00','#ogrod #porzadek #jesien',3),(3,3,'Piękny poranek na górze!','https://example.com/gory.jpg','Wschód słońca w górach','2024-09-08 03:30:00','2024-09-08 04:00:00','#gory #wschodslońca #piękno',12),(4,4,'Zapraszam na najnowszy film o bieganiu!','https://example.com/bieganie.jpg','Biegaj z nami','2024-09-09 06:30:00','2024-09-09 06:40:00','#bieganie #zdrowie #motywacja',9),(5,5,'Przygotowania do koncertu!','https://example.com/koncert.jpg','Koncert Marzeń','2024-09-10 12:00:00','2024-09-10 12:10:00','#muzyka #koncert #pasja',15),(6,6,'Zimowe zdjęcia z moich podróży!','https://example.com/zima.jpg','Zima w obiektywie','2024-09-11 14:00:00','2024-09-11 14:20:00','#zimowe #podróże #fotografia',5),(7,7,'Poznajmy się lepiej!','https://example.com/poznajmy.jpg','Witajcie na moim profilu','2024-09-12 17:00:00','2024-09-12 17:10:00','#nowi #poznajmy #socjal',4),(8,8,'Bieganie po lesie - cudowna przygoda','https://example.com/las.jpg','Biegaj w lesie','2024-09-13 05:45:00','2024-09-13 06:00:00','#bieganie #las #przygoda',8),(9,9,'Wielka wystawa w mieście!','https://example.com/wystawa.jpg','Wystawa sztuki','2024-09-14 08:00:00','2024-09-14 08:15:00','#sztuka #wystawa #kultura',10);
/*!40000 ALTER TABLE `posty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rozmowy`
--

DROP TABLE IF EXISTS `rozmowy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rozmowy` (
  `ID_rozmowy` int(11) NOT NULL AUTO_INCREMENT,
  `Data_utworzenia` timestamp NOT NULL DEFAULT current_timestamp(),
  `Nazwa_rozmowy` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_rozmowy`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rozmowy`
--

LOCK TABLES `rozmowy` WRITE;
/*!40000 ALTER TABLE `rozmowy` DISABLE KEYS */;
INSERT INTO `rozmowy` VALUES (1,'2024-11-07 12:56:42','Ukochany mąż'),(2,'2024-11-07 12:56:42','Rodzina'),(3,'2024-11-07 12:56:42','Przyjaciele'),(4,'2024-11-07 12:56:42','Podróżnicy'),(5,'2024-11-07 12:56:42','Muzyka');
/*!40000 ALTER TABLE `rozmowy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uzytkownicy`
--

DROP TABLE IF EXISTS `uzytkownicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uzytkownicy` (
  `ID_uzytkownika` int(11) NOT NULL AUTO_INCREMENT,
  `Imie` varchar(100) NOT NULL,
  `Nazwisko` varchar(100) NOT NULL,
  `Nick` varchar(50) DEFAULT NULL,
  `Email` varchar(100) NOT NULL,
  `Haslo` varchar(255) NOT NULL,
  `Data_Urodzenia` date DEFAULT NULL,
  `Link_Zdjecia` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_uzytkownika`),
  UNIQUE KEY `E-mail` (`Email`) USING BTREE,
  UNIQUE KEY `Nick` (`Nick`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uzytkownicy`
--

LOCK TABLES `uzytkownicy` WRITE;
/*!40000 ALTER TABLE `uzytkownicy` DISABLE KEYS */;
INSERT INTO `uzytkownicy` VALUES (1,'Kasia','Malinowska','MalKaska','Malinowska.kas@wp.pl','DomToDomek','1995-10-12','https://example.com/profilowe.jpg'),(2,'Maciek','Lasowski','lasMaciek','las.Maciek@gmail.com','PasjaLasu','1993-05-07','https://example.com/maciek.png'),(3,'Anna','Nowak','AnkaNowak','anna.nowak@wp.pl','ZielonaPolana','1990-03-21','https://example.com/anna.jpg'),(4,'Piotr','Kowalski','Pitek94','piotr.kowalski@o2.pl','SportowyPiotr','1994-07-15','https://example.com/piotr.jpg'),(5,'Marek','Zawisza','MarekZ','marek.zawisza@interia.pl','MuzycznyMarek','1988-11-23','https://example.com/marek.jpg'),(6,'Julia','Mazur','Jula123','julia.mazur@gmail.com','Juleczka','1997-02-11','https://example.com/julia.jpg'),(7,'Karol','Wójcik','KaroL89','karol.wojcik@wp.pl','ZafascynowanyLasem','1989-12-04','https://example.com/karol.jpg'),(8,'Ewa','Kaczmarek','EwaKacz','ewa.kaczmarek@outlook.com','BiegaczkaEwa','1992-09-18','https://example.com/ewa.jpg'),(9,'Jakub','Szymański','SzymonJakub','jakub.szymanski@gmail.com','FotografJakub','1995-06-30','https://example.com/jakub.jpg'),(10,'Martyna','Jankowska','Martyniaczka','martyna.jankowska@wp.pl','JogaMartyna','1996-01-05','https://example.com/martyna.jpg');
/*!40000 ALTER TABLE `uzytkownicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiadomosci`
--

DROP TABLE IF EXISTS `wiadomosci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiadomosci` (
  `ID_wiadomosci` int(11) NOT NULL AUTO_INCREMENT,
  `ID_wysylajacego` int(11) DEFAULT NULL,
  `ID_rozmowy` int(11) DEFAULT NULL,
  `Tresc` varchar(255) NOT NULL,
  `Wyslano` timestamp NOT NULL DEFAULT current_timestamp(),
  `Przeczytano` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_wiadomosci`),
  KEY `id_wysylajacego` (`ID_wysylajacego`),
  KEY `id_rozmowy` (`ID_rozmowy`),
  CONSTRAINT `wiadomosci_ibfk_1` FOREIGN KEY (`id_wysylajacego`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  CONSTRAINT `wiadomosci_ibfk_2` FOREIGN KEY (`id_rozmowy`) REFERENCES `rozmowy` (`id_rozmowy`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiadomosci`
--

LOCK TABLES `wiadomosci` WRITE;
/*!40000 ALTER TABLE `wiadomosci` DISABLE KEYS */;
INSERT INTO `wiadomosci` VALUES (1,1,1,'Cześć, pójdziemy razem na maliny?','2024-11-07 12:57:45',1),(2,2,1,'Zawsze, razem!','2024-11-07 12:57:45',1),(3,3,2,'Kiedy spotykamy się na obiad?','2024-11-07 12:57:45',1),(4,4,2,'Jutro o 13:00, świetnie będzie!','2024-11-07 12:57:45',1),(5,5,3,'Cześć, jak się czujesz po biegu?','2024-11-07 12:57:45',1),(6,6,3,'Świetnie, dziękuję!','2024-11-07 12:57:45',1),(7,7,4,'Podziel się swoimi zdjęciami z podróży!','2024-11-07 12:57:45',1),(8,8,4,'Jasne, już wrzucam!','2024-11-07 12:57:45',1),(9,3,2,'Jednak mnie nie będzie na obiedzie!','2024-11-07 13:03:13',0),(10,8,4,'Kurde, weź ty coś wrzuć mi te zdjęcia strasznie rozmazane są :( ','2024-11-07 13:04:55',0);
/*!40000 ALTER TABLE `wiadomosci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `wiadomosci_niewyslane`
--

DROP TABLE IF EXISTS `wiadomosci_niewyslane`;
/*!50001 DROP VIEW IF EXISTS `wiadomosci_niewyslane`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `wiadomosci_niewyslane` AS SELECT
 1 AS `ID_wiadomosci`,
  1 AS `Tresc`,
  1 AS `Wyslano`,
  1 AS `Przeczytano`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nazwa_rozmowy` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `widok_aktywni_uzytkownicy`
--

DROP TABLE IF EXISTS `widok_aktywni_uzytkownicy`;
/*!50001 DROP VIEW IF EXISTS `widok_aktywni_uzytkownicy`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `widok_aktywni_uzytkownicy` AS SELECT
 1 AS `ID_uzytkownika`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nick` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `widok_rozmowy_i_ostatnia_wiadomosc`
--

DROP TABLE IF EXISTS `widok_rozmowy_i_ostatnia_wiadomosc`;
/*!50001 DROP VIEW IF EXISTS `widok_rozmowy_i_ostatnia_wiadomosc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `widok_rozmowy_i_ostatnia_wiadomosc` AS SELECT
 1 AS `ID_rozmowy`,
  1 AS `Nazwa_rozmowy`,
  1 AS `Ostatnia_Wiadomosc`,
  1 AS `Ostatnia_Wiadomosc_Data`,
  1 AS `Wysylajacy_Imie`,
  1 AS `Wysylajacy_Nazwisko` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `widok_top_10_posty`
--

DROP TABLE IF EXISTS `widok_top_10_posty`;
/*!50001 DROP VIEW IF EXISTS `widok_top_10_posty`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `widok_top_10_posty` AS SELECT
 1 AS `ID_postu`,
  1 AS `Tytul`,
  1 AS `Tresc`,
  1 AS `Ilosc_polubien`,
  1 AS `Data_publikacji`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nick` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych`
--

DROP TABLE IF EXISTS `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych`;
/*!50001 DROP VIEW IF EXISTS `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych` AS SELECT
 1 AS `ID_uzytkownika`,
  1 AS `Imie`,
  1 AS `Nazwisko`,
  1 AS `Nick`,
  1 AS `Liczba_Obserwujacych` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `znaj`
--

DROP TABLE IF EXISTS `znaj`;
/*!50001 DROP VIEW IF EXISTS `znaj`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `znaj` AS SELECT
 1 AS `ID_uzytkownika`,
  1 AS `Imie_uzytkownika`,
  1 AS `Nazwisko_uzytkownika`,
  1 AS `Status_znajomosci`,
  1 AS `Poczatek_znajomosci`,
  1 AS `Imie_znajomego`,
  1 AS `Nazwisko_znajomego` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `znajomi`
--

DROP TABLE IF EXISTS `znajomi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `znajomi` (
  `ID_znajomego1` int(11) NOT NULL,
  `ID_znajomego2` int(11) NOT NULL,
  `Status_znajomosci` enum('zatwierdzona','oczekująca','','') NOT NULL,
  `Poczatek_znajomosci` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID_znajomego1`,`ID_znajomego2`),
  KEY `id_znajomego2` (`ID_znajomego2`),
  CONSTRAINT `znajomi_ibfk_1` FOREIGN KEY (`id_znajomego1`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE,
  CONSTRAINT `znajomi_ibfk_2` FOREIGN KEY (`id_znajomego2`) REFERENCES `uzytkownicy` (`ID_uzytkownika`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `znajomi`
--

LOCK TABLES `znajomi` WRITE;
/*!40000 ALTER TABLE `znajomi` DISABLE KEYS */;
INSERT INTO `znajomi` VALUES (1,2,'zatwierdzona','2024-09-01 12:00:00'),(2,1,'zatwierdzona','2024-09-01 12:00:00'),(3,4,'oczekująca','2024-09-02 13:00:00'),(4,3,'oczekująca','2024-09-02 13:10:00'),(5,6,'zatwierdzona','2024-09-03 14:00:00'),(6,5,'zatwierdzona','2024-09-03 14:05:00'),(7,8,'oczekująca','2024-09-04 15:00:00'),(8,7,'oczekująca','2024-09-04 15:10:00'),(9,10,'zatwierdzona','2024-09-05 16:00:00'),(10,9,'zatwierdzona','2024-09-05 16:05:00');
/*!40000 ALTER TABLE `znajomi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `5_uzytkow_z_najwieksza_iloscia_obserwacji`
--

/*!50001 DROP VIEW IF EXISTS `5_uzytkow_z_najwieksza_iloscia_obserwacji`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `5_uzytkow_z_najwieksza_iloscia_obserwacji` AS select `uzy`.`ID_uzytkownika` AS `ID_uzytkownika`,`uzy`.`Imie` AS `Imie`,`uzy`.`Nazwisko` AS `Nazwisko`,`uzy`.`Nick` AS `Nick`,count(`obser`.`ID_obserwujacego`) AS `Liczba_Obserwujacych` from (`uzytkownicy` `uzy` join `obserwujacy` `obser` on(`uzy`.`ID_uzytkownika` = `obser`.`ID_obserwowanego`)) group by `uzy`.`ID_uzytkownika` order by count(`obser`.`ID_obserwujacego`) desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `aktywnosc_uzytkownikow`
--

/*!50001 DROP VIEW IF EXISTS `aktywnosc_uzytkownikow`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `aktywnosc_uzytkownikow` AS select `user`.`ID_uzytkownika` AS `ID_uzytkownika`,`user`.`Imie` AS `Imie`,`user`.`Nazwisko` AS `Nazwisko`,`user`.`Nick` AS `Nick`,coalesce(count(distinct `posts`.`ID_postu`),0) AS `Liczba_Postow`,coalesce(count(distinct `comms`.`ID_komentarza`),0) AS `Liczba_Komentarzy`,coalesce(count(distinct `films`.`ID_filmu`),0) AS `Liczba_Filmow`,coalesce(count(distinct `msgs`.`ID_wiadomosci`),0) AS `Liczba_Wiadomosci` from ((((`uzytkownicy` `user` left join `posty` `posts` on(`user`.`ID_uzytkownika` = `posts`.`ID_uzytkownika`)) left join `komentarze` `comms` on(`user`.`ID_uzytkownika` = `comms`.`ID_uzytkownika`)) left join `filmiki` `films` on(`user`.`ID_uzytkownika` = `films`.`ID_uzytkownika`)) left join `wiadomosci` `msgs` on(`user`.`ID_uzytkownika` = `msgs`.`ID_wysylajacego`)) group by `user`.`ID_uzytkownika` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `komentarze_z_postami`
--

/*!50001 DROP VIEW IF EXISTS `komentarze_z_postami`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `komentarze_z_postami` AS select `comms`.`ID_komentarza` AS `ID_komentarza`,`comms`.`Tresc` AS `Komentarz`,`comms`.`Ilosc_polubien` AS `Komentarz_Polubienia`,`posts`.`Tytul` AS `Post_Tytul`,`posts`.`Tresc` AS `Post_Tresc`,`posts`.`Ilosc_polubien` AS `Post_Polubienia`,`user1`.`Imie` AS `Komentujacy_Imie`,`user1`.`Nazwisko` AS `Komentujacy_Nazwisko`,`user2`.`Imie` AS `Autor_Postu_Imie`,`user2`.`Nazwisko` AS `Autor_Postu_Nazwisko` from (((`komentarze` `comms` join `posty` `posts` on(`comms`.`ID_postu` = `posts`.`ID_postu`)) join `uzytkownicy` `user1` on(`comms`.`ID_uzytkownika` = `user1`.`ID_uzytkownika`)) join `uzytkownicy` `user2` on(`posts`.`ID_uzytkownika` = `user2`.`ID_uzytkownika`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `najbardziej_polubiane_komentarze`
--

/*!50001 DROP VIEW IF EXISTS `najbardziej_polubiane_komentarze`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `najbardziej_polubiane_komentarze` AS select `kom`.`ID_komentarza` AS `ID_komentarza`,`kom`.`Tresc` AS `Komentarz_Tresc`,`kom`.`Ilosc_polubien` AS `Komentarz_Polubienia`,`uzy`.`Imie` AS `Komentujacy_Imie`,`uzy`.`Nazwisko` AS `Komentujacy_Nazwisko`,`pos`.`Tytul` AS `Post_Tytul`,`pos`.`Tresc` AS `Post_Tresc`,`pos`.`Ilosc_polubien` AS `Post_Polubienia`,`kom`.`Data_publikacji` AS `Komentarz_Data_Publikacji` from ((`komentarze` `kom` join `uzytkownicy` `uzy` on(`kom`.`ID_uzytkownika` = `uzy`.`ID_uzytkownika`)) join `posty` `pos` on(`kom`.`ID_postu` = `pos`.`ID_postu`)) order by `kom`.`Ilosc_polubien` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `wiadomosci_niewyslane`
--

/*!50001 DROP VIEW IF EXISTS `wiadomosci_niewyslane`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `wiadomosci_niewyslane` AS select `wiadomosc`.`ID_wiadomosci` AS `ID_wiadomosci`,`wiadomosc`.`Tresc` AS `Tresc`,`wiadomosc`.`Wyslano` AS `Wyslano`,`wiadomosc`.`Przeczytano` AS `Przeczytano`,`uzytkownik`.`Imie` AS `Imie`,`uzytkownik`.`Nazwisko` AS `Nazwisko`,`rozmowa`.`Nazwa_rozmowy` AS `Nazwa_rozmowy` from ((`wiadomosci` `wiadomosc` join `uzytkownicy` `uzytkownik` on(`wiadomosc`.`ID_wysylajacego` = `uzytkownik`.`ID_uzytkownika`)) join `rozmowy` `rozmowa` on(`wiadomosc`.`ID_rozmowy` = `rozmowa`.`ID_rozmowy`)) where `wiadomosc`.`Przeczytano` = 0 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `widok_aktywni_uzytkownicy`
--

/*!50001 DROP VIEW IF EXISTS `widok_aktywni_uzytkownicy`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `widok_aktywni_uzytkownicy` AS select distinct `u`.`ID_uzytkownika` AS `ID_uzytkownika`,`u`.`Imie` AS `Imie`,`u`.`Nazwisko` AS `Nazwisko`,`u`.`Nick` AS `Nick` from ((((`uzytkownicy` `u` left join `posty` `p` on(`u`.`ID_uzytkownika` = `p`.`ID_uzytkownika`)) left join `filmiki` `f` on(`u`.`ID_uzytkownika` = `f`.`ID_uzytkownika`)) left join `komentarze` `k` on(`u`.`ID_uzytkownika` = `k`.`ID_uzytkownika`)) left join `wiadomosci` `w` on(`u`.`ID_uzytkownika` = `w`.`ID_wysylajacego`)) where `p`.`ID_postu` is not null or `f`.`ID_filmu` is not null or `k`.`ID_komentarza` is not null or `w`.`ID_wiadomosci` is not null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `widok_rozmowy_i_ostatnia_wiadomosc`
--

/*!50001 DROP VIEW IF EXISTS `widok_rozmowy_i_ostatnia_wiadomosc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `widok_rozmowy_i_ostatnia_wiadomosc` AS select `r`.`ID_rozmowy` AS `ID_rozmowy`,`r`.`Nazwa_rozmowy` AS `Nazwa_rozmowy`,`w`.`Tresc` AS `Ostatnia_Wiadomosc`,`w`.`Wyslano` AS `Ostatnia_Wiadomosc_Data`,`u`.`Imie` AS `Wysylajacy_Imie`,`u`.`Nazwisko` AS `Wysylajacy_Nazwisko` from ((`rozmowy` `r` join `wiadomosci` `w` on(`r`.`ID_rozmowy` = `w`.`ID_rozmowy`)) join `uzytkownicy` `u` on(`w`.`ID_wysylajacego` = `u`.`ID_uzytkownika`)) where `w`.`ID_wiadomosci` = (select max(`wiadomosci`.`ID_wiadomosci`) from `wiadomosci` where `wiadomosci`.`ID_rozmowy` = `r`.`ID_rozmowy`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `widok_top_10_posty`
--

/*!50001 DROP VIEW IF EXISTS `widok_top_10_posty`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `widok_top_10_posty` AS select `p`.`ID_postu` AS `ID_postu`,`p`.`Tytul` AS `Tytul`,`p`.`Tresc` AS `Tresc`,`p`.`Ilosc_polubien` AS `Ilosc_polubien`,`p`.`Data_publikacji` AS `Data_publikacji`,`u`.`Imie` AS `Imie`,`u`.`Nazwisko` AS `Nazwisko`,`u`.`Nick` AS `Nick` from (`posty` `p` join `uzytkownicy` `u` on(`p`.`ID_uzytkownika` = `u`.`ID_uzytkownika`)) order by `p`.`Ilosc_polubien` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych`
--

/*!50001 DROP VIEW IF EXISTS `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `widok_top_5_uzytkownicy_z_najwiecej_obserwujacych` AS select `u`.`ID_uzytkownika` AS `ID_uzytkownika`,`u`.`Imie` AS `Imie`,`u`.`Nazwisko` AS `Nazwisko`,`u`.`Nick` AS `Nick`,count(`o`.`ID_obserwujacego`) AS `Liczba_Obserwujacych` from (`uzytkownicy` `u` join `obserwujacy` `o` on(`u`.`ID_uzytkownika` = `o`.`ID_obserwowanego`)) group by `u`.`ID_uzytkownika` order by count(`o`.`ID_obserwujacego`) desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `znaj`
--

/*!50001 DROP VIEW IF EXISTS `znaj`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `znaj` AS select `znajomy`.`ID_znajomego1` AS `ID_uzytkownika`,`uzytkownik1`.`Imie` AS `Imie_uzytkownika`,`uzytkownik1`.`Nazwisko` AS `Nazwisko_uzytkownika`,`znajomy`.`Status_znajomosci` AS `Status_znajomosci`,`znajomy`.`Poczatek_znajomosci` AS `Poczatek_znajomosci`,`uzytkownik2`.`Imie` AS `Imie_znajomego`,`uzytkownik2`.`Nazwisko` AS `Nazwisko_znajomego` from ((`znajomi` `znajomy` join `uzytkownicy` `uzytkownik1` on(`znajomy`.`ID_znajomego1` = `uzytkownik1`.`ID_uzytkownika`)) join `uzytkownicy` `uzytkownik2` on(`znajomy`.`ID_znajomego2` = `uzytkownik2`.`ID_uzytkownika`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-08 12:21:33
