-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 09:17 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `walaa_12`
--

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `MedicineID` int(11) NOT NULL,
  `MedicinName` varchar(500) NOT NULL,
  `Price` int(11) NOT NULL,
  `ExpiryDate` date NOT NULL,
  `Order_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicines`
--

INSERT INTO `medicines` (`MedicineID`, `MedicinName`, `Price`, `ExpiryDate`, `Order_ID`) VALUES
(1, 'נורופין', 50, '2025-05-25', 0),
(2, 'אקמול', 70, '2026-12-04', 0),
(3, 'אדוויל', 99, '2025-11-18', 0),
(5, 'אופטלגין', 55, '2026-11-07', 0),
(7, 'דקסמול', 30, '2026-09-23', 0),
(8, 'נרוסין', 43, '2025-12-30', 0),
(9, 'אדקס', 55, '2026-07-07', 0),
(10, 'אקסדרין', 88, '2026-08-11', 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `TotalPrice` double NOT NULL,
  `Adress` varchar(5000) NOT NULL,
  `OrderTime` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`Order_ID`, `TotalPrice`, `Adress`, `OrderTime`) VALUES
(1, 234, 'walaaplace', '2024-11-20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `FirstName` varchar(500) NOT NULL,
  `LastName` varchar(500) NOT NULL,
  `Password` varchar(500) NOT NULL,
  `CreatedDateTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `FirstName`, `LastName`, `Password`, `CreatedDateTime`) VALUES
(1, 'Walaa', 'Abo Hable', '0504822260', '2024-11-02 07:21:02'),
(2, 'walaa', 'abo hable', '2345678', '2024-11-02 07:21:51'),
(3, 'Test', 'Last', '', '2024-11-05 10:03:04'),
(4, 'rayan', 'daqqa', '56877', '2024-11-12 09:45:08'),
(8, 'Bob', 'momo', '123', '2024-11-12 10:02:16'),
(9, 'Bobaab', 'momoss', '12345', '2024-11-12 10:02:16'),
(10, 'Bob', 'momo', '123', '2024-11-12 10:03:59'),
(11, 'Bobaab', 'momoss', '12345', '2024-11-12 10:03:59'),
(12, 'Bob', 'momo', '123', '2024-11-12 10:11:27'),
(13, 'Bobaab', 'momoss', '12345', '2024-11-12 10:11:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`MedicineID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Order_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `MedicineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `Order_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
