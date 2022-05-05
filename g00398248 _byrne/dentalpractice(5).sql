-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2022 at 02:31 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dentalpractice`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `AppointmentID` int(10) NOT NULL,
  `PatientID` int(25) NOT NULL,
  `AppointmentType` varchar(25) NOT NULL,
  `AppointmentDate` date NOT NULL,
  `isPaymentOverdue` tinyint(1) NOT NULL,
  `isFirstVisit` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`AppointmentID`, `PatientID`, `AppointmentType`, `AppointmentDate`, `isPaymentOverdue`, `isFirstVisit`) VALUES
(6745, 8286, 'phone', '2022-04-04', 0, 1),
(6746, 8287, 'phone', '2022-05-08', 1, 0),
(6747, 8288, 'Drop in', '2022-05-10', 1, 0),
(6749, 8290, 'phone', '2022-04-11', 0, 1),
(6750, 8291, 'phone', '2022-04-16', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `PatientID` int(10) NOT NULL,
  `PatientName` varchar(25) NOT NULL,
  `PatientAddress` varchar(50) NOT NULL,
  `TreatmentID` int(10) NOT NULL,
  `TreatmentName` varchar(25) NOT NULL,
  `SpecialistID` int(10) DEFAULT NULL,
  `BillID` int(25) DEFAULT NULL,
  `AppointmentID` int(10) NOT NULL,
  `AppointmentType` varchar(25) NOT NULL,
  `FollowUpDetails` varchar(50) DEFAULT NULL,
  `TreatmentPaid` tinyint(1) NOT NULL,
  `AmountDue` int(1) NOT NULL,
  `isPaymentOverdue` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`PatientID`, `PatientName`, `PatientAddress`, `TreatmentID`, `TreatmentName`, `SpecialistID`, `BillID`, `AppointmentID`, `AppointmentType`, `FollowUpDetails`, `TreatmentPaid`, `AmountDue`, `isPaymentOverdue`) VALUES
(8286, 'Fiona', 'Dublin 1', 12, 'Root Canal', NULL, 9001, 6745, 'phone', NULL, 0, 620, 0),
(8287, 'Frank', 'Dublin 2', 13, 'extraction', NULL, 9002, 6746, 'phone', NULL, 1, 480, 0),
(8288, 'Anne', 'Dublin 24', 14, 'clean', NULL, 9003, 6747, 'Drop in', NULL, 1, 180, 0),
(8289, 'John', 'Dublin 9', 15, 'braces', 6294, 9004, 6748, 'Drop in', 'Consult a specialist', 0, 1360, 1),
(8290, 'Simon', 'Dublin 3', 16, 'filling', NULL, NULL, 6770, 'phone', NULL, 1, 250, 0),
(8291, 'Amy', 'Dublin 17', 14, 'Whitening', 6295, NULL, 6749, 'phone', 'Consult a specialist', 1, 101, 0),
(8292, 'Mick', 'Dublin 6', 12, 'Root Canal', 6296, NULL, 6750, 'phone', 'consult a specialist', 1, 501, 0),
(8293, 'Sean', 'Dublin 4', 13, 'extraction', NULL, NULL, 6751, 'post', NULL, 1, 250, 0),
(8294, 'Jade', 'Dublin 9', 16, 'filling', NULL, NULL, 6752, 'phone', NULL, 1, 250, 0),
(8295, 'Peter', 'Dublin 1', 13, 'extraction', NULL, NULL, 6753, 'post', NULL, 1, 250, 0);

-- --------------------------------------------------------

--
-- Table structure for table `patientbills`
--

CREATE TABLE `patientbills` (
  `BillID` int(10) NOT NULL,
  `PatientID` int(10) NOT NULL,
  `AmountDue` int(10) NOT NULL,
  `BillExceeded` tinyint(1) DEFAULT NULL,
  `DaysAmountDue` int(10) NOT NULL,
  `TotalBill` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patientbills`
--

INSERT INTO `patientbills` (`BillID`, `PatientID`, `AmountDue`, `BillExceeded`, `DaysAmountDue`, `TotalBill`) VALUES
(9001, 8286, 120, 0, 15, 500),
(9002, 8287, 230, 1, 32, 620),
(9003, 8288, 80, 0, 45, 400),
(9004, 8289, 350, 1, 8, 800);

-- --------------------------------------------------------

--
-- Table structure for table `practices`
--

CREATE TABLE `practices` (
  `PraticeName` varchar(25) NOT NULL,
  `PraticeAddress` varchar(25) NOT NULL,
  `PraticeContact` int(10) NOT NULL,
  `PraticeExpertise` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `practices`
--

INSERT INTO `practices` (`PraticeName`, `PraticeAddress`, `PraticeContact`, `PraticeExpertise`) VALUES
('Cork Dental Care', '14 Union Quay', 876543219, 'Root Canal'),
('Monahan Dental Care', '12 Popes Quay', 878643219, 'Dental Imaging'),
('The Lodge Dental Practice', 'Togher Cross, Cork', 876547819, 'Dental Surgery');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `PatientID` int(10) NOT NULL,
  `PraticeAddress` varchar(50) DEFAULT NULL,
  `AppointmentID` int(10) NOT NULL,
  `AppointmentTime` int(10) DEFAULT NULL,
  `AppointmentNextWeek` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reminders`
--

INSERT INTO `reminders` (`PatientID`, `PraticeAddress`, `AppointmentID`, `AppointmentTime`, `AppointmentNextWeek`) VALUES
(8286, '', 6745, 0, 0),
(8287, '', 6746, 0, 1),
(8288, NULL, 6747, NULL, 1),
(8290, NULL, 6749, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `specialist`
--

CREATE TABLE `specialist` (
  `SpecialistID` int(10) NOT NULL,
  `SpecialistName` varchar(25) NOT NULL,
  `TreatmentID` int(10) NOT NULL,
  `TreatmentName` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `specialistview`
-- (See below for the actual view)
--
CREATE TABLE `specialistview` (
`PatientID` int(10)
,`PatientName` varchar(25)
,`PatientAddress` varchar(50)
,`TreatmentID` int(10)
,`TreatmentName` varchar(25)
,`SpecialistID` int(10)
,`AppointmentID` int(10)
,`AppointmentType` varchar(25)
,`FollowUpDetails` varchar(50)
,`TreatmentPaid` tinyint(1)
,`AmountDue` int(1)
,`isPaymentOverdue` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `TransactionID` int(10) NOT NULL,
  `BillID` int(10) NOT NULL,
  `PatientID` int(10) NOT NULL,
  `TransactionType` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatmentbills`
--

CREATE TABLE `treatmentbills` (
  `TreatmentID` int(10) NOT NULL,
  `TreatmentName` varchar(25) NOT NULL,
  `TreatmentFees` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `treatments`
--

CREATE TABLE `treatments` (
  `TreatmentID` int(10) NOT NULL,
  `TreatmentName` varchar(25) NOT NULL,
  `TreatmentFees` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `treatments`
--

INSERT INTO `treatments` (`TreatmentID`, `TreatmentName`, `TreatmentFees`) VALUES
(12, 'Root Canal', 500),
(13, 'extraction', 250),
(14, 'Clean', 100),
(15, 'Braces', 1000),
(16, 'Whitening', 250);

-- --------------------------------------------------------

--
-- Table structure for table `visitsdone`
--

CREATE TABLE `visitsdone` (
  `PatientID` int(10) NOT NULL,
  `AppointmentID` int(10) NOT NULL,
  `TreatmentID` int(10) NOT NULL,
  `TransactionID` int(10) NOT NULL,
  `SpecialistID` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure for view `specialistview`
--
DROP TABLE IF EXISTS `specialistview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `specialistview`  AS   (select `patient`.`PatientID` AS `PatientID`,`patient`.`PatientName` AS `PatientName`,`patient`.`PatientAddress` AS `PatientAddress`,`patient`.`TreatmentID` AS `TreatmentID`,`patient`.`TreatmentName` AS `TreatmentName`,`patient`.`SpecialistID` AS `SpecialistID`,`patient`.`AppointmentID` AS `AppointmentID`,`patient`.`AppointmentType` AS `AppointmentType`,`patient`.`FollowUpDetails` AS `FollowUpDetails`,`patient`.`TreatmentPaid` AS `TreatmentPaid`,`patient`.`AmountDue` AS `AmountDue`,`patient`.`isPaymentOverdue` AS `isPaymentOverdue` from `patient` where `patient`.`SpecialistID` is not null)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`AppointmentID`),
  ADD KEY `PatientIDFK` (`PatientID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`PatientID`),
  ADD KEY `TreatmentIDFK` (`TreatmentID`),
  ADD KEY `AppointmentIDFK` (`AppointmentID`),
  ADD KEY `BillIDFK` (`BillID`);

--
-- Indexes for table `patientbills`
--
ALTER TABLE `patientbills`
  ADD PRIMARY KEY (`BillID`);

--
-- Indexes for table `practices`
--
ALTER TABLE `practices`
  ADD PRIMARY KEY (`PraticeName`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`PatientID`),
  ADD KEY `AppointmentIDFK` (`AppointmentID`);

--
-- Indexes for table `treatments`
--
ALTER TABLE `treatments`
  ADD PRIMARY KEY (`TreatmentID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`);

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`BillID`) REFERENCES `patientbills` (`BillID`),
  ADD CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`TreatmentID`) REFERENCES `treatments` (`TreatmentID`);

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_ibfk_1` FOREIGN KEY (`AppointmentID`) REFERENCES `appointments` (`AppointmentID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
