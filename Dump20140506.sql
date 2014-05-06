CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `project`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `customer_accounts`
--

DROP TABLE IF EXISTS `customer_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_accounts` (
  `cust_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(255) NOT NULL,
  `cust_phoneno` varchar(11) NOT NULL,
  `cust_password` text NOT NULL,
  `cust_access_token` varchar(255) DEFAULT NULL,
  `cust_joined_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cust_id`),
  UNIQUE KEY `cust_phoneno_UNIQUE` (`cust_phoneno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dining_tables`
--

DROP TABLE IF EXISTS `dining_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dining_tables` (
  `tbl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tbl_rest_id` bigint(20) NOT NULL,
  `tbl_capacity` int(11) NOT NULL,
  `tbl_display_order` int(11) NOT NULL,
  PRIMARY KEY (`tbl_id`),
  KEY `tbl_dining_tables_restaurants_tbl_rest_id_idx` (`tbl_rest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dishes` (
  `d_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `d_rest_id` bigint(20) NOT NULL,
  `d_name` varchar(255) NOT NULL,
  `d_price` decimal(10,2) NOT NULL,
  `d_display_order` int(11) NOT NULL,
  PRIMARY KEY (`d_id`),
  KEY `fk_dishes_restaurants_rest_id_idx` (`d_rest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `inv_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inv_cust_id` bigint(20) NOT NULL,
  `inv_order_id` bigint(20) NOT NULL,
  `inv_is_host` enum('true','false') NOT NULL,
  `inv_created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `inv_status` char(1) NOT NULL,
  PRIMARY KEY (`inv_id`),
  KEY `fk_invitations_customer_accounts_inv_cust_id_idx` (`inv_cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `oitem_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `oitem_order_id` bigint(20) NOT NULL,
  `oitem_name` varchar(255) NOT NULL,
  `oitem_price` decimal(10,2) NOT NULL,
  `oitem_quantity` int(11) NOT NULL,
  PRIMARY KEY (`oitem_id`),
  KEY `fk_order_items_orders_oitem_order_id_idx` (`oitem_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `o_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `o_rest_id` bigint(20) NOT NULL,
  `o_cust_id` bigint(20) NOT NULL,
  `o_cust_phoneno` varchar(11) NOT NULL,
  `o_totalprice` decimal(10,2) NOT NULL,
  `o_num_people` tinyint(4) NOT NULL,
  `o_request_date` date NOT NULL,
  `o_request_period` tinyint(4) NOT NULL,
  `o_schedule_info` text,
  `o_status` tinyint(4) NOT NULL,
  `o_created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `o_updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`o_id`),
  KEY `fk_orders_restaurants_o_rest_id_idx` (`o_rest_id`),
  KEY `fk_orders_customer_accounts_o_cust_id_idx` (`o_cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurant_accounts`
--

DROP TABLE IF EXISTS `restaurant_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_accounts` (
  `ra_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ra_name` varchar(255) NOT NULL,
  `ra_password` text NOT NULL,
  `ra_created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ra_access_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ra_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurants` (
  `rest_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rest_owner_id` bigint(20) NOT NULL,
  `rest_name` varchar(255) NOT NULL,
  `rest_address` varchar(255) NOT NULL,
  `rest_geo_location` point DEFAULT NULL,
  `rest_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`rest_id`),
  KEY `fk_restaurants_restaurant_accounts_rest_owner_id_idx` (`rest_owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_schedules`
--

DROP TABLE IF EXISTS `table_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_schedules` (
  `ts_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ts_rest_id` bigint(20) NOT NULL,
  `ts_order_id` bigint(20) NOT NULL,
  `ts_table_id` bigint(20) NOT NULL,
  `ts_date` date NOT NULL,
  `ts_start_time` time NOT NULL,
  `ts_end_time` time NOT NULL,
  `ts_valid` enum('true','false') NOT NULL,
  PRIMARY KEY (`ts_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-06 13:26:57
