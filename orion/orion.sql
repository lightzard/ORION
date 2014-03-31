-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 31, 2014 at 09:30 AM
-- Server version: 5.5.25a
-- PHP Version: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `orion`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `username_admin` varchar(20) NOT NULL,
  `password_admin` varchar(20) NOT NULL,
  PRIMARY KEY (`username_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE IF NOT EXISTS `dosen` (
  `dosen_username` varchar(20) NOT NULL,
  `nip` char(10) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `email` varchar(25) NOT NULL,
  `foto` text,
  `list_publikasi` text,
  PRIMARY KEY (`dosen_username`,`nip`),
  UNIQUE KEY `nip` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `do_pencarian`
--

CREATE TABLE IF NOT EXISTS `do_pencarian` (
  `id` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`,`username`),
  UNIQUE KEY `id` (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE IF NOT EXISTS `mahasiswa` (
  `mhs_username` varchar(20) NOT NULL,
  `npm` char(10) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `email` varchar(25) NOT NULL,
  `foto` text,
  `ipk` decimal(4,0) DEFAULT NULL,
  `list_prestasi` text,
  PRIMARY KEY (`mhs_username`,`npm`),
  UNIQUE KEY `npm` (`npm`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` varchar(20) NOT NULL,
  `tanggal` char(8) NOT NULL,
  `isi` text NOT NULL,
  `subject` text NOT NULL,
  `dosen_username` varchar(20) NOT NULL,
  `mhs_username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `mhs_username` (`mhs_username`),
  KEY `dosen_username` (`dosen_username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pelamaran`
--

CREATE TABLE IF NOT EXISTS `pelamaran` (
  `id` varchar(20) NOT NULL,
  `tanggal` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  `message_id` varchar(20) NOT NULL,
  `topik_id` varchar(20) NOT NULL,
  `dosen_username` varchar(20) NOT NULL,
  `mhs_username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `message_id` (`message_id`),
  KEY `topik_id` (`topik_id`),
  KEY `dosen_username` (`dosen_username`),
  KEY `mhs_username` (`mhs_username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pencarian`
--

CREATE TABLE IF NOT EXISTS `pencarian` (
  `id` varchar(20) NOT NULL,
  `keyword` text NOT NULL,
  `byTopic` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE IF NOT EXISTS `pengguna` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `terhadap_pencarian`
--

CREATE TABLE IF NOT EXISTS `terhadap_pencarian` (
  `id_pencarian` varchar(20) NOT NULL,
  `id_topik` varchar(20) NOT NULL,
  PRIMARY KEY (`id_pencarian`,`id_topik`),
  UNIQUE KEY `id_pencarian` (`id_pencarian`),
  UNIQUE KEY `id_topik` (`id_topik`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `topik_riset`
--

CREATE TABLE IF NOT EXISTS `topik_riset` (
  `id` varchar(20) NOT NULL,
  `judul` varchar(30) NOT NULL,
  `deskripsi` text NOT NULL,
  `req` text NOT NULL,
  `dosen_username` varchar(20) NOT NULL,
  `admin_username` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `admin_username` (`admin_username`),
  KEY `dosen_username` (`dosen_username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`username_admin`) REFERENCES `pengguna` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`dosen_username`) REFERENCES `pengguna` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `do_pencarian`
--
ALTER TABLE `do_pencarian`
  ADD CONSTRAINT `do_pencarian_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pencarian` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `do_pencarian_ibfk_2` FOREIGN KEY (`username`) REFERENCES `pengguna` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_1` FOREIGN KEY (`mhs_username`) REFERENCES `pengguna` (`username`) ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`mhs_username`) REFERENCES `mahasiswa` (`mhs_username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`dosen_username`) REFERENCES `dosen` (`dosen_username`) ON UPDATE CASCADE;

--
-- Constraints for table `pelamaran`
--
ALTER TABLE `pelamaran`
  ADD CONSTRAINT `pelamaran_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pelamaran_ibfk_2` FOREIGN KEY (`topik_id`) REFERENCES `topik_riset` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pelamaran_ibfk_3` FOREIGN KEY (`dosen_username`) REFERENCES `dosen` (`dosen_username`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pelamaran_ibfk_4` FOREIGN KEY (`mhs_username`) REFERENCES `mahasiswa` (`mhs_username`) ON UPDATE CASCADE;

--
-- Constraints for table `terhadap_pencarian`
--
ALTER TABLE `terhadap_pencarian`
  ADD CONSTRAINT `terhadap_pencarian_ibfk_1` FOREIGN KEY (`id_pencarian`) REFERENCES `pencarian` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `terhadap_pencarian_ibfk_2` FOREIGN KEY (`id_topik`) REFERENCES `topik_riset` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `topik_riset`
--
ALTER TABLE `topik_riset`
  ADD CONSTRAINT `topik_riset_ibfk_1` FOREIGN KEY (`admin_username`) REFERENCES `admins` (`username_admin`) ON UPDATE CASCADE,
  ADD CONSTRAINT `topik_riset_ibfk_2` FOREIGN KEY (`dosen_username`) REFERENCES `dosen` (`dosen_username`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
