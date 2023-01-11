-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2023 at 01:38 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trundle`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `company_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phn_no` varchar(30) NOT NULL,
  `place` varchar(40) NOT NULL,
  `file` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_id`, `login_id`, `name`, `email`, `phn_no`, `place`, `file`, `status`) VALUES
(1, 0, 'ab', 'ab@gmail.com', '1234567890', 'kozhikode', '', '0'),
(2, 8, 'company2', 'com2gmail.com', '0099887766', 'kozhikode', '387183901.jfif', '1'),
(3, 9, 'company001', 'co@gmail.com', '3344556677', 'kozhikode', '1912873719.jfif', '0'),
(4, 10, 'company', 'com@futu.com', '22222222', '', '', '0'),
(5, 11, 'company', 'com@futu.com', '22222222', '', '2080352337.png', '1');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `login_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `dob` varchar(20) NOT NULL,
  `place` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `login_id`, `name`, `email`, `mobile`, `dob`, `place`) VALUES
(1, 2, 'xxxxxxxxxxxxxx', 'abcd@gmail.com', '1122334455', '05/01/2023', 'kozhikode');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `feedback` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `customer_id`, `feedback`) VALUES
(1, 2, 'good');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(40) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `username`, `password`, `type`) VALUES
(1, 'admin', 'admin', 'admin'),
(2, 'customer', 'password', 'customer'),
(3, 'ab', 'ab00', 'company'),
(4, '', '', 'customer'),
(5, 'comp', 'com123', 'customer'),
(6, 'comp', 'com123', 'customer'),
(7, 'comp', 'com123', 'customer'),
(8, 'comp', 'com123', 'customer'),
(9, 'comp', 'com123', 'company'),
(10, 'company', 'password', 'company'),
(11, 'company', 'password', 'company');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `content` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `title`, `content`) VALUES
(1, 'notification1', 'djfgsdyfguwegfywegfywety'),
(2, 'sdfwe', 'sdfs'),
(3, 'df', 'wfw');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `place` varchar(30) NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `company_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `type`, `name`, `place`, `mobile`, `company_id`) VALUES
(1, 'mechanic', 'qqq', 'kozhikode', '1234567890', 3);

-- --------------------------------------------------------

--
-- Table structure for table `service_book`
--

CREATE TABLE `service_book` (
  `book_id` int(11) NOT NULL,
  `customer_id` int(30) NOT NULL,
  `service_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service_book`
--

INSERT INTO `service_book` (`book_id`, `customer_id`, `service_id`, `status`) VALUES
(1, 2, 1, 0),
(2, 2, 1, 0),
(3, 2, 1, 1),
(4, 2, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `reg_no` varchar(30) NOT NULL,
  `type` varchar(30) NOT NULL,
  `fuel_type` varchar(30) NOT NULL,
  `price` varchar(30) NOT NULL,
  `color` varchar(30) NOT NULL,
  `image` varchar(150) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicle_id`, `company_id`, `name`, `reg_no`, `type`, `fuel_type`, `price`, `color`, `image`, `status`) VALUES
(1, 3, 'BMW', '001067', 'car', 'petrol', '800', 'black', '', '0'),
(4, 9, 'asd', '12345', 'car', 'desel', '100000', 'black', '1727545536.jfif', '0'),
(6, 11, 'Benz', 'KL 11 X 1111', 'car', '', '2000', 'black', '73755287.jpg', '0'),
(7, 11, 'Benz', 'KL 11 X 1111', 'car', 'diesel', '2000', 'black', '97436003.jpg', '0'),
(8, 11, 'BMW', 'KL 11 X 111', 'car', 'diesel', '2000', 'black', '1401939514.jpg', '0'),
(9, 11, 'Ferrari', 'KL 11 A 1111', 'car', 'electric', '10', 'white', '1716731.jpg', '0'),
(10, 11, 'Ferrari', 'KL 11 A 1111', 'car', 'electric', '10', 'white', '60008060.jpg', '0'),
(11, 11, 'Ferrari', 'KL 11 A 1111', 'car', 'electric', '10', 'white', '1099713050.jpg', '0'),
(12, 11, 'Tesla', 'kl 22 22222', 'car', 'electric', '80000', 'red', '1556968079.jpg', '0'),
(13, 11, 'Toyota', 'TN 10 S 5874', 'pickup', 'diesel', '6000', 'blue', '1076812003.jpg', '0'),
(14, 11, 'Honda', 'fhczjfs', 'vvud', 'fhrt', '500', 'vhdg', '237426967.jpg', '0'),
(15, 11, 'maruti', 'tjftg', 'vfhj ', 'vehg', '856', 'csgvt', '1640628309.jpg', '0'),
(16, 11, 'sabarinath', 'kl6667', 'cycle', 'oil', '25', 'blue', '1183407276.jpg', '0'),
(17, 11, 'sabarinath', 'kl6667', 'cycle', 'oil', '25', 'blue', '467336017.jpg', '0'),
(18, 11, 'sabarinath', 'kl6667', 'cycle', 'oil', '25', 'blue', '411567016.jpg', '0'),
(19, 11, 'sabarinath ', 'h133', 'cycle', 'oil', '25', 'bl', '1907976235.jpg', '0'),
(20, 11, 'sabarinath ', 'h133', 'cycle', 'oil', '25', 'bl', '1233530621.jpg', '0'),
(21, 11, 'xfj', 'rux', 'rux', 'rxu', '382', ',dy', '862279744.jpg', '0'),
(22, 9, 'asd', '12345', 'car', 'desel', '100000', 'black', '673360933.jfif', '0');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_book`
--

CREATE TABLE `vehicle_book` (
  `book_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `status` int(11) DEFAULT 0,
  `return_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicle_book`
--

INSERT INTO `vehicle_book` (`book_id`, `vehicle_id`, `customer_id`, `status`, `return_status`) VALUES
(1, 1, 2, 0, 0),
(7, 1, 2, 2, 1),
(8, 1, 2, 0, 0),
(9, 1, 2, 0, 0),
(10, 13, 2, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`);

--
-- Indexes for table `service_book`
--
ALTER TABLE `service_book`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`);

--
-- Indexes for table `vehicle_book`
--
ALTER TABLE `vehicle_book`
  ADD PRIMARY KEY (`book_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service_book`
--
ALTER TABLE `service_book`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `vehicle_book`
--
ALTER TABLE `vehicle_book`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
