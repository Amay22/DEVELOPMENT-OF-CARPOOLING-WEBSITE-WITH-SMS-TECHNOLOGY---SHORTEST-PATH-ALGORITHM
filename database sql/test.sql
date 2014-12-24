-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2014 at 08:05 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_multi_sets`()
    DETERMINISTIC
begin
        select user() as first_col;
        select user() as first_col, now() as second_col;
        select user() as first_col, now() as second_col, now() as third_col;
        end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `counts`
--

CREATE TABLE IF NOT EXISTS `counts` (
  `Users` int(11) NOT NULL,
  `Groups` int(11) NOT NULL,
  `Hits` int(11) NOT NULL,
  `pri` int(11) NOT NULL,
  PRIMARY KEY (`pri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `counts`
--

INSERT INTO `counts` (`Users`, `Groups`, `Hits`, `pri`) VALUES
(0, 0, 227, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `C_id` int(4) NOT NULL AUTO_INCREMENT,
  `first` varchar(20) NOT NULL,
  `last` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `pwd` varchar(30) NOT NULL,
  `HouseNo` varchar(30) NOT NULL,
  `HomeAddr` varchar(255) DEFAULT NULL,
  `homelatlng` varchar(40) NOT NULL,
  `CountryCode` varchar(4) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(1) NOT NULL,
  `Photo` longblob,
  PRIMARY KEY (`C_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `cust_group`
--

CREATE TABLE IF NOT EXISTS `cust_group` (
  `C_id` int(4) NOT NULL,
  `G_id` int(4) NOT NULL,
  `Start_User` varchar(40) NOT NULL,
  `Stop_User` varchar(40) NOT NULL,
  UNIQUE KEY `C_id` (`C_id`,`G_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `G_id` int(4) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `C_id` int(4) NOT NULL,
  `capacity` int(4) NOT NULL,
  `cost` int(4) NOT NULL,
  `fuel_type` varchar(20) NOT NULL,
  `car_type` varchar(20) NOT NULL,
  `people_in` int(2) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `operation_days` varchar(7) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `centre` varchar(40) NOT NULL,
  `city` varchar(40) NOT NULL,
  `country` varchar(40) NOT NULL,
  `source` varchar(40) NOT NULL,
  `dest` varchar(40) NOT NULL,
  `euc_dist` double NOT NULL,
  `distance` double NOT NULL,
  `time` double NOT NULL,
  `p1` varchar(40) DEFAULT NULL,
  `p2` varchar(40) DEFAULT NULL,
  `p3` varchar(40) DEFAULT NULL,
  `p4` varchar(40) DEFAULT NULL,
  `p5` varchar(40) DEFAULT NULL,
  `p6` varchar(40) DEFAULT NULL,
  `p7` varchar(40) DEFAULT NULL,
  `p8` varchar(40) DEFAULT NULL,
  `p9` varchar(40) DEFAULT NULL,
  `p10` varchar(40) DEFAULT NULL,
  `p11` varchar(40) DEFAULT NULL,
  `p12` varchar(40) DEFAULT NULL,
  `p13` varchar(40) DEFAULT NULL,
  `p14` varchar(40) DEFAULT NULL,
  `p15` varchar(40) DEFAULT NULL,
  `p16` varchar(40) DEFAULT NULL,
  `Messages` text NOT NULL,
  PRIMARY KEY (`G_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
