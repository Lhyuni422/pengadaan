-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ci_barang
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `barang`
--

DROP TABLE IF EXISTS `barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barang` (
  `id_barang` char(7) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `stok` int NOT NULL,
  `satuan_id` int NOT NULL,
  `jenis_id` int NOT NULL,
  PRIMARY KEY (`id_barang`),
  KEY `satuan_id` (`satuan_id`),
  KEY `kategori_id` (`jenis_id`),
  CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`satuan_id`) REFERENCES `satuan` (`id_satuan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`jenis_id`) REFERENCES `jenis` (`id_jenis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang`
--

LOCK TABLES `barang` WRITE;
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
INSERT INTO `barang` VALUES ('B000001','Form Administrasi',0,1,3),('B000002','Samsung Galaxy J1 Ace',50,1,4),('B000003','Aqua 1,5 Liter',0,2,2),('B000004','Livi Hand Towel',8,2,2);
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barang_keluar`
--

DROP TABLE IF EXISTS `barang_keluar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barang_keluar` (
  `id_barang_keluar` char(16) NOT NULL,
  `user_id` int NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_keluar` int NOT NULL,
  `tanggal_keluar` date NOT NULL,
  PRIMARY KEY (`id_barang_keluar`),
  KEY `id_user` (`user_id`),
  KEY `barang_id` (`barang_id`),
  CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang_keluar`
--

LOCK TABLES `barang_keluar` WRITE;
/*!40000 ALTER TABLE `barang_keluar` DISABLE KEYS */;
INSERT INTO `barang_keluar` VALUES ('T-BK-19082000001',99,'B000003',35,'2019-08-20'),('T-BK-19082000002',99,'B000002',10,'2019-08-20'),('T-BK-19092000003',99,'B000001',5,'2019-09-20'),('T-BK-19092000004',99,'B000003',150,'2019-09-20'),('T-BK-19092200006',99,'B000003',100,'2019-09-22'),('T-BK-23071200001',99,'B000002',5,'2023-07-12');
/*!40000 ALTER TABLE `barang_keluar` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_stok_keluar` BEFORE INSERT ON `barang_keluar` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` - NEW.jumlah_keluar WHERE `barang`.`id_barang` = NEW.barang_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `barang_masuk`
--

DROP TABLE IF EXISTS `barang_masuk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barang_masuk` (
  `id_barang_masuk` char(16) NOT NULL,
  `supplier_id` int NOT NULL,
  `user_id` int NOT NULL,
  `barang_id` char(7) NOT NULL,
  `jumlah_masuk` int NOT NULL,
  `tanggal_masuk` date NOT NULL,
  PRIMARY KEY (`id_barang_masuk`),
  KEY `id_user` (`user_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `barang_id` (`barang_id`),
  CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barang_masuk_ibfk_3` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang_masuk`
--

LOCK TABLES `barang_masuk` WRITE;
/*!40000 ALTER TABLE `barang_masuk` DISABLE KEYS */;
INSERT INTO `barang_masuk` VALUES ('T-BM-19082000001',2,99,'B000003',800,'2019-08-20'),('T-BM-19082000002',3,99,'B000001',20,'2019-08-20'),('T-BM-19082000003',3,99,'B000002',10,'2019-08-20'),('T-BM-19092000005',3,99,'B000002',40,'2019-09-20'),('T-BM-19092000006',2,99,'B000003',50,'2019-09-20'),('T-BM-19092200008',1,99,'B000003',135,'2019-09-22'),('T-BM-23071200001',2,7,'B000004',6,'2023-04-20'),('T-BM-23071700001',1,7,'B000002',5,'2023-07-17'),('T-BM-23071700002',1,99,'B000004',2,'2023-07-17');
/*!40000 ALTER TABLE `barang_masuk` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_stok_masuk` BEFORE INSERT ON `barang_masuk` FOR EACH ROW UPDATE `barang` SET `barang`.`stok` = `barang`.`stok` + NEW.jumlah_masuk WHERE `barang`.`id_barang` = NEW.barang_id */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jenis`
--

DROP TABLE IF EXISTS `jenis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jenis` (
  `id_jenis` int NOT NULL AUTO_INCREMENT,
  `nama_jenis` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id_jenis`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenis`
--

LOCK TABLES `jenis` WRITE;
/*!40000 ALTER TABLE `jenis` DISABLE KEYS */;
INSERT INTO `jenis` VALUES (1,'ATK (Alat Tulis Kantor)'),(2,'BRT (Barang Rumah Tangga)'),(3,'Percetakan'),(4,'Perlengkapan Pasien'),(5,'Bahan Kebutuhan Medis');
/*!40000 ALTER TABLE `jenis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengajuan`
--

DROP TABLE IF EXISTS `pengajuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pengajuan` (
  `id_pengajuan` char(16) DEFAULT NULL,
  `tgl_pengajuan` date DEFAULT NULL,
  `barang_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `unit` varchar(30) DEFAULT NULL,
  `status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengajuan`
--

LOCK TABLES `pengajuan` WRITE;
/*!40000 ALTER TABLE `pengajuan` DISABLE KEYS */;
INSERT INTO `pengajuan` VALUES ('T-P-23071700001','2023-07-17','B000001',1,99,NULL,NULL);
/*!40000 ALTER TABLE `pengajuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permintaan`
--

DROP TABLE IF EXISTS `permintaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permintaan` (
  `id_req` char(16) NOT NULL,
  `barang_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `tgl_req` date DEFAULT NULL,
  `unit` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  `jenis_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permintaan`
--

LOCK TABLES `permintaan` WRITE;
/*!40000 ALTER TABLE `permintaan` DISABLE KEYS */;
INSERT INTO `permintaan` VALUES ('T-REQ-2307170000','B000001',1,99,'2023-07-17',NULL,NULL,NULL),('T-REQ-2307177000','B000004',2,99,'2023-07-17',NULL,NULL,NULL),('T-REQ-2307177700','B000001',1,99,'2023-07-17',NULL,NULL,NULL);
/*!40000 ALTER TABLE `permintaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permintaan_temp`
--

DROP TABLE IF EXISTS `permintaan_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permintaan_temp` (
  `id_req_temp` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tgl_req` date DEFAULT NULL,
  `barang_id` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `unit` varchar(30) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `jenis_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permintaan_temp`
--

LOCK TABLES `permintaan_temp` WRITE;
/*!40000 ALTER TABLE `permintaan_temp` DISABLE KEYS */;
INSERT INTO `permintaan_temp` VALUES ('T-REQT-23071700001','2023-07-17','B000002',15,3,NULL,NULL,NULL),('T-REQT-23071800001','2023-07-18','B000001',15,1,NULL,NULL,NULL),('T-REQT-23071900001','2023-07-19','B000001',15,2,NULL,NULL,NULL),('T-REQT-23071900002','2023-07-19','B000001',15,3,NULL,NULL,1),('T-REQT-23071900003','2023-07-19','B000002',15,1,NULL,NULL,1),('T-REQT-23071900004','2023-07-19','B000003',15,1,NULL,NULL,1);
/*!40000 ALTER TABLE `permintaan_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satuan`
--

DROP TABLE IF EXISTS `satuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `satuan` (
  `id_satuan` int NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(15) NOT NULL,
  PRIMARY KEY (`id_satuan`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satuan`
--

LOCK TABLES `satuan` WRITE;
/*!40000 ALTER TABLE `satuan` DISABLE KEYS */;
INSERT INTO `satuan` VALUES (1,'PCS'),(2,'Pack'),(3,'ml'),(5,'rim');
/*!40000 ALTER TABLE `satuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id_supplier` int NOT NULL AUTO_INCREMENT,
  `nama_supplier` varchar(50) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Toko Kertas Bandung','0224203807','Jl. Pajagalan No. 2, Karanganyar, Astanaanyar, Bandung, Jawa Barat 40241'),(2,'PT. Mitra Karya Nusaperdana','081312229364','Jl. Durman No.10, Kb. Jeruk, Kec. Andir, Kota Bandung, Jawa Barat 40181'),(3,'Ayongeprint.com','08211811821','Jl. HM. Idrus II, RT 001/01 No.5, Jatiasih, Cileunyi, Bandung 17421');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(15) NOT NULL,
  `role` enum('gudang','admin','pimpinan','unit') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` int NOT NULL,
  `foto` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `unit` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (7,'Arfan ID','arfandotid','arfandotid@gmail.com','081221528806','gudang','$2y$10$JRhmr7gMECjUK4rNWLud7e8UTXtpiZ.NWuGczQ82MAzXR6YBobXpi',1568691611,'user.png',1,'Gudang'),(8,'M. Ghifari Arfananda','mghifariarfan','mghifariarfan@gmail.com','085697442673','gudang','$2y$10$JRhmr7gMECjUK4rNWLud7e8UTXtpiZ.NWuGczQ82MAzXR6YBobXpi',1568691629,'user.png',1,'Gudang'),(13,'Arfan Kashilukato','arfankashilukato','arfankashilukato@gmail.com','081623123181','gudang','$2y$10$JRhmr7gMECjUK4rNWLud7e8UTXtpiZ.NWuGczQ82MAzXR6YBobXpi',1569192547,'user.png',1,'Gudang'),(14,'Tri Wahyuni','triwahyuni','thrie.18@gmail.com','081666555444','pimpinan','$2y$10$JRhmr7gMECjUK4rNWLud7e8UTXtpiZ.NWuGczQ82MAzXR6YBobXpi',1688751316,'user.png',1,'Administrasi'),(15,'Rian Cahyadi','Rian','rian.cahyadi@gmail.com','087794875831','unit','$2y$10$Er6S7nyaIJDXuLP/JyRghOAfpEaUMjbRx6OxVbgHN7Ub7iMSeroXa',1688752396,'user.png',1,'Rawat Inap'),(99,'Administrator','admin','admin@admin.com','025123456789','admin','$2y$10$JRhmr7gMECjUK4rNWLud7e8UTXtpiZ.NWuGczQ82MAzXR6YBobXpi',1568689561,'d5f22535b639d55be7d099a7315e1f7f.png',1,'Gudang'),(100,'Tri Wahyuni NN','Yuni','thrie.183@gmail.com','081221528806','unit','$2y$10$jmgs.juAPtEphr.80HEqzOSNOtCjGmszKENY7KvUXWZ2951rvwKwS',1689167467,'user.png',0,'UGD');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ci_barang'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-19 19:59:11
