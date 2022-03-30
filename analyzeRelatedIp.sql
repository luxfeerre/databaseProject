-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: analyzeRelatedIp
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `File`
--

DROP TABLE IF EXISTS `File`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `File` (
  `Hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FileName` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CaseNumber` bigint DEFAULT NULL,
  PRIMARY KEY (`Hash`),
  KEY `CaseNumber` (`CaseNumber`),
  CONSTRAINT `File_ibfk_1` FOREIGN KEY (`CaseNumber`) REFERENCES `Investigation` (`CaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `File`
--

LOCK TABLES `File` WRITE;
/*!40000 ALTER TABLE `File` DISABLE KEYS */;
INSERT INTO `File` VALUES ('1e39354a6e481dac48375bfebb126fd96aed4e23bab3c53ed6ecf1c5e4d5736d','ls',1),('21dbdfbe5f554a6ac8d2374246e4688345087045890becc9077d4b94f5726277','lz4',5),('256ecd1632b07ff8bbab6092f7d2db0562c61c376ae0193a1214e0934458a03e','whereis',4),('4764ac50184c3092d7e529b07d95f103644229f12cfc1de6759bd1da0e6c56c7','mkdir',2),('87e5bd81850e11eeec2d3bb696b626b2a7f45673241cbbd64769c83580432869','cat',1),('8c8e79ccf51c391e840fbc24e86e1fd261ac80516ebb52f09a28e594fba25844','zip',2),('927edde6890317009fb6664c0dedf8d15b136c516a6d53965579f7f94f08fa42','who',3),('92a2bade19a90a1bd81e4d2c2de646ddf971aba9c78df6e31b2b567c94fde175','find',3);
/*!40000 ALTER TABLE `File` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FileIpRelation`
--

DROP TABLE IF EXISTS `FileIpRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FileIpRelation` (
  `Hash` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IP_ID` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  UNIQUE KEY `Hash` (`Hash`,`IP_ID`),
  KEY `IP_ID` (`IP_ID`),
  CONSTRAINT `FileIpRelation_ibfk_1` FOREIGN KEY (`Hash`) REFERENCES `File` (`Hash`),
  CONSTRAINT `FileIpRelation_ibfk_2` FOREIGN KEY (`IP_ID`) REFERENCES `IP_Address` (`IP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FileIpRelation`
--

LOCK TABLES `FileIpRelation` WRITE;
/*!40000 ALTER TABLE `FileIpRelation` DISABLE KEYS */;
INSERT INTO `FileIpRelation` VALUES ('927edde6890317009fb6664c0dedf8d15b136c516a6d53965579f7f94f08fa42','1483d79d69db28cd29f2ffe334d9b83b5a61eab2eb70113f4f34899ada2897f0'),('21dbdfbe5f554a6ac8d2374246e4688345087045890becc9077d4b94f5726277','20550e473e1d650c5e22dd4eb8d24a7ec3281499fdfdbc38c4d6ef8e1ca09e26'),('1e39354a6e481dac48375bfebb126fd96aed4e23bab3c53ed6ecf1c5e4d5736d','216ea483b7fd8f805ebe67613e194d9057c72c869256329967f69150d79af64a'),('87e5bd81850e11eeec2d3bb696b626b2a7f45673241cbbd64769c83580432869','216ea483b7fd8f805ebe67613e194d9057c72c869256329967f69150d79af64a'),('92a2bade19a90a1bd81e4d2c2de646ddf971aba9c78df6e31b2b567c94fde175','325135cedbea894cbc48ed4c27023dc31ad1c120288ecd635d067c3baa384d37'),('8c8e79ccf51c391e840fbc24e86e1fd261ac80516ebb52f09a28e594fba25844','70e063464590bfa6ab694303d9308a59a1e90a6931a3ed22830cdab8d27edb26'),('92a2bade19a90a1bd81e4d2c2de646ddf971aba9c78df6e31b2b567c94fde175','8e149d686842a229c99a568eb55a573a7eb55e8ed9033f2adfaa4f67a8cc5d6a'),('4764ac50184c3092d7e529b07d95f103644229f12cfc1de6759bd1da0e6c56c7','9abb6659e84adf701c36a3e2843c3acab0c0030d9b9cae602e3e9222874ed7d8'),('256ecd1632b07ff8bbab6092f7d2db0562c61c376ae0193a1214e0934458a03e','b59e272c4ec114312151f482309b2191ee405a1c90f2b401eb3531be4c4c4b02'),('4764ac50184c3092d7e529b07d95f103644229f12cfc1de6759bd1da0e6c56c7','b89acce6f22d29ac86267a5e30df78f59d1c9947a8bca7684009604755b05e29'),('21dbdfbe5f554a6ac8d2374246e4688345087045890becc9077d4b94f5726277','ff639ee46642b80824c5ee19ad562ba80067f1ba75ef2a90ed89df53aede136f');
/*!40000 ALTER TABLE `FileIpRelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IP_Address`
--

DROP TABLE IF EXISTS `IP_Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IP_Address` (
  `IP_ID` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IP` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `DomainName` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Ports` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `CountryCode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `GeoData` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`IP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IP_Address`
--

LOCK TABLES `IP_Address` WRITE;
/*!40000 ALTER TABLE `IP_Address` DISABLE KEYS */;
INSERT INTO `IP_Address` VALUES ('1483d79d69db28cd29f2ffe334d9b83b5a61eab2eb70113f4f34899ada2897f0','31.13.72.36','[\'facebook.com\', \'edge-star-mini-shv-01-arn2.facebook.com\', \'messenger.com\']','[80, 443]','SE','59.32938,18.06871'),('20550e473e1d650c5e22dd4eb8d24a7ec3281499fdfdbc38c4d6ef8e1ca09e26','104.18.13.238','[]','[8080, 2082, 2083, 2087, 80, 8880, 8443, 443]','US','37.7621,-122.3971'),('216ea483b7fd8f805ebe67613e194d9057c72c869256329967f69150d79af64a','1.1.1.1','[\'one.one.one.one\']','[80, 443, 53, 69]','US','34.0522,-118.2437'),('325135cedbea894cbc48ed4c27023dc31ad1c120288ecd635d067c3baa384d37','194.47.110.17','[\'lnu.se\']','[80, 443]','SE','59.32938,18.06871'),('70e063464590bfa6ab694303d9308a59a1e90a6931a3ed22830cdab8d27edb26','35.186.238.101','[\'101.238.186.35.bc.googleusercontent.com\']','[9092, 5900, 5901, 1935, 8080, 8081, 8085, 8086, 8089, 25, 8090, 8863, 20000, 8099, 5672, 43, 11211, 5432, 443, 3389, 195, 9100, 587, 143, 80, 465, 83, 84, 85, 87, 1883, 993, 995, 5222, 6379, 110, 9200, 9300]','US','37.4056,-122.0775'),('8e149d686842a229c99a568eb55a573a7eb55e8ed9033f2adfaa4f67a8cc5d6a','1.1.1.1','[\'getvitalsource.org\', \'one.one.one.one\', \'sni.cloudflaressl.com\']','[80, 443, 53, 69]','US','34.0522,-118.2437'),('9abb6659e84adf701c36a3e2843c3acab0c0030d9b9cae602e3e9222874ed7d8','9.9.9.9','[\'dns9.quad9.net\']','[443, 53]','US','39.0437,-77.4875'),('b59e272c4ec114312151f482309b2191ee405a1c90f2b401eb3531be4c4c4b02','31.13.72.174','[\'instagram.com\', \'igcdn.com\', \'instagram-p42-shv-01-arn2.fbcdn.net\', \'cdninstagram.com\', \'igsonar.com\']','[80, 443]','SE','59.32938,18.06871'),('b89acce6f22d29ac86267a5e30df78f59d1c9947a8bca7684009604755b05e29','8.8.8.8','[\'dns.google\']','[443, 53]','US','37.4056,-122.0775'),('ff639ee46642b80824c5ee19ad562ba80067f1ba75ef2a90ed89df53aede136f','65.9.81.58','[\'www.mozilla.org\', \'www.mozorg.moz.works\', \'server-65-9-81-58.ams1.r.cloudfront.net\', \'mozilla.org\']','[80, 443]','NL','52.37403,4.88969');
/*!40000 ALTER TABLE `IP_Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Investigation`
--

DROP TABLE IF EXISTS `Investigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Investigation` (
  `CaseNumber` bigint NOT NULL,
  `investigationStart` datetime NOT NULL,
  `Handler` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`CaseNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Investigation`
--

LOCK TABLES `Investigation` WRITE;
/*!40000 ALTER TABLE `Investigation` DISABLE KEYS */;
INSERT INTO `Investigation` VALUES (1,'2022-03-30 19:15:54','Joakim'),(2,'2022-03-30 19:23:16','Philip'),(3,'2022-03-30 19:34:34','Joakim'),(4,'2022-03-30 20:33:08','Joakim'),(5,'2022-03-30 20:44:59','Joakim');
/*!40000 ALTER TABLE `Investigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `InvestigationDetails`
--

DROP TABLE IF EXISTS `InvestigationDetails`;
/*!50001 DROP VIEW IF EXISTS `InvestigationDetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `InvestigationDetails` AS SELECT 
 1 AS `CaseNumber`,
 1 AS `FileName`,
 1 AS `Hash`,
 1 AS `IP`,
 1 AS `DomainName`,
 1 AS `Ports`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `InvestigationDetails`
--

/*!50001 DROP VIEW IF EXISTS `InvestigationDetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `InvestigationDetails` AS select `Investigation`.`CaseNumber` AS `CaseNumber`,`File`.`FileName` AS `FileName`,`File`.`Hash` AS `Hash`,`IP_Address`.`IP` AS `IP`,`IP_Address`.`DomainName` AS `DomainName`,`IP_Address`.`Ports` AS `Ports` from (((`Investigation` join `File` on((`File`.`CaseNumber` = `Investigation`.`CaseNumber`))) join `FileIpRelation` on((`File`.`Hash` = `FileIpRelation`.`Hash`))) join `IP_Address` on((`IP_Address`.`IP_ID` = `FileIpRelation`.`IP_ID`))) */;
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

-- Dump completed on 2022-03-30 21:03:51
