-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Host: co-project
-- Generation Time: May 22, 2011 at 01:28 PM
-- Server version: 5.1.55
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `team04`
--

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE IF NOT EXISTS `Department` (
  `Name` char(100) NOT NULL,
  `Code` char(4) NOT NULL,
  `Login` char(10) NOT NULL,
  `Password` char(10) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `Login` (`Login`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Department Information';

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`Name`, `Code`, `Login`, `Password`) VALUES
('Computer Science', 'CO', 'couser', 'passco'),
('Design School', 'DS', 'dsuser', 'passds'),
('Team 04', '', 'team04', 's7f72sdf'),
('Aeronautical and Automotive Engineering', 'TT', 'ttuser', 'passtt'),
('Chemical Engineering', 'CG', 'cguser', 'passcg'),
('Chemistry', 'CM', 'cmuser', 'passcm'),
('Civil and Building Engineering', 'CV', 'cvuser', 'passcv'),
('Economics', 'EC', 'ecuser', 'passec'),
('Electronic and Electrical Engineering', 'EL', 'eluser', 'passel'),
('English and Drama', 'EA', 'eauser', 'passea'),
('Politics, History and International Relations', 'EU', 'euuser', 'passeu'),
('Geography', 'GY', 'gyuser', 'passgy'),
('Information Science', 'IS', 'isuser', 'passis'),
('Materials', 'MP', 'mpuser', 'passmp'),
('Mathematical Sciences', 'MA', 'mauser', 'passma'),
('Mechanical and Manufacturing Engineering', 'MM', 'mmuser', 'passmm'),
('Physics', 'PH', 'phuser', 'passph'),
('School of the Arts', 'SA', 'sauser', 'passsa'),
('Social Sciences', 'SS', 'ssuser', 'passss'),
('School of Sport, Exercise & Health Sciences', 'PS', 'psuser', 'passps'),
('Business School', 'BS', 'bsuser', 'passbs');
