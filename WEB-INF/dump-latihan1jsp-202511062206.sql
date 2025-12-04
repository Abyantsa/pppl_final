-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: latihan1jsp
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `jenis_kelamin`
--

DROP TABLE IF EXISTS `jenis_kelamin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenis_kelamin` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenis_kelamin`
--

LOCK TABLES `jenis_kelamin` WRITE;
/*!40000 ALTER TABLE `jenis_kelamin` DISABLE KEYS */;
INSERT INTO `jenis_kelamin` VALUES (1,'Laki - Laki'),(2,'Perempuan');
/*!40000 ALTER TABLE `jenis_kelamin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jenjang`
--

DROP TABLE IF EXISTS `jenjang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenjang` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenjang`
--

LOCK TABLES `jenjang` WRITE;
/*!40000 ALTER TABLE `jenjang` DISABLE KEYS */;
INSERT INTO `jenjang` VALUES (1,'S1'),(2,'S2'),(3,'S3'),(4,'D3'),(5,'D4');
/*!40000 ALTER TABLE `jenjang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mahasiswa`
--

DROP TABLE IF EXISTS `mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mahasiswa` (
  `nim` varchar(20) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `kode_jenis_kelamin` int(10) unsigned NOT NULL,
  `kode_prodi` int(10) unsigned NOT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`nim`),
  KEY `mahasiswa_prodi_FK` (`kode_prodi`),
  KEY `mahasiswa_user_FK` (`username`),
  KEY `mahasiswa_jenis_kelamin_FK` (`kode_jenis_kelamin`),
  CONSTRAINT `mahasiswa_jenis_kelamin_FK` FOREIGN KEY (`kode_jenis_kelamin`) REFERENCES `jenis_kelamin` (`kode`),
  CONSTRAINT `mahasiswa_prodi_FK` FOREIGN KEY (`kode_prodi`) REFERENCES `prodi` (`kode`),
  CONSTRAINT `mahasiswa_user_FK` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mahasiswa`
--

LOCK TABLES `mahasiswa` WRITE;
/*!40000 ALTER TABLE `mahasiswa` DISABLE KEYS */;
INSERT INTO `mahasiswa` VALUES ('NIM-MHS-1','Mahasiswa Pertama',1,1,'mhs1');
/*!40000 ALTER TABLE `mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodi`
--

DROP TABLE IF EXISTS `prodi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prodi` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kode_jenjang` int(10) unsigned NOT NULL,
  PRIMARY KEY (`kode`),
  KEY `prodi_jenjang_FK` (`kode_jenjang`),
  CONSTRAINT `prodi_jenjang_FK` FOREIGN KEY (`kode_jenjang`) REFERENCES `jenjang` (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodi`
--

LOCK TABLES `prodi` WRITE;
/*!40000 ALTER TABLE `prodi` DISABLE KEYS */;
INSERT INTO `prodi` VALUES (1,'Sistem Informasi',1);
/*!40000 ALTER TABLE `prodi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `kode` int(10) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN'),(2,'DOSEN'),(3,'TENDIK'),(4,'MAHASISWA');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `kode_role` int(10) unsigned NOT NULL,
  PRIMARY KEY (`username`),
  KEY `user_role_FK` (`kode_role`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`kode_role`) REFERENCES `role` (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('mhs1','79f6a8779d6f41d312bcd4d72cf66e0f',4),('mhs2','41f1b79f6392e10a3c4bd10272576826',4),('radit','ac43724f16e9241d990427ab7c8f4228',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'latihan1jsp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-06 22:06:27
