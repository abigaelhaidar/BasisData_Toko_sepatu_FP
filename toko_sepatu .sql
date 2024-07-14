-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 07:12 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tokosepatu`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_all_stock_ditambah10` ()   BEGIN
    UPDATE shoes SET stock = stock + 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stock_quantity` (`p_shoe_id` INT, `new_stock` INT)   BEGIN
	if EXISTS (SELECT * from shoes where shoe_id = p_shoe_id) THEN
		update shoes set stock = new_stock where shoe_id = p_shoe_id;
	else
		INSERT into shoes (shoe_id, stock) VALUES (p_shoe_id, new_stock);
	end if;
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total_sepatu` () RETURNS INT(11)  BEGIN
RETURN (select sum(stock) from shoes);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_sepatu_by_brand_category` (`p_brand_id` INT, `p_category_id` INT) RETURNS INT(11)  BEGIN
    RETURN (SELECT COUNT(*) 
            FROM shoes 
            WHERE brand_id = p_brand_id AND category_id = p_category_id);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brand`
--

CREATE TABLE `brand` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brand`
--

INSERT INTO `brand` (`brand_id`, `brand_name`) VALUES
(1, 'Nike'),
(2, 'Adidas'),
(3, 'Puma');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Running'),
(2, 'Casual'),
(3, 'Formal');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`, `phone`, `address`) VALUES
(1, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
(2, 'Jane Smith', 'jane.smith@example.com', '098-765-4321', '456 Elm St'),
(3, 'Mike Johnson', 'mike.johnson@example.com', '321-654-9870', '789 Maple St'),
(4, 'Emily Davis', 'emily.davis@example.com', '654-321-0987', '101 Pine St'),
(5, 'Sarah Brown', 'sarah.brown@example.com', '555-555-5555', '202 Oak St');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `detail_pesanan_id` int(11) NOT NULL,
  `pesanan_id` int(11) DEFAULT NULL,
  `shoe_id` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pesanan`
--

INSERT INTO `detail_pesanan` (`detail_pesanan_id`, `pesanan_id`, `shoe_id`, `jumlah`, `harga`) VALUES
(4, 4, 5, 1, 90),
(5, 5, 4, 1, 160);

-- --------------------------------------------------------

--
-- Stand-in structure for view `nama_shoe_vertical`
-- (See below for the actual view)
--
CREATE TABLE `nama_shoe_vertical` (
`shoe_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `pesanan_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `tanggal_pesan` date DEFAULT NULL,
  `total_jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`pesanan_id`, `customer_id`, `tanggal_pesan`, `total_jumlah`) VALUES
(1, 1, '2024-06-01', 240),
(2, 2, '2024-06-15', 70),
(3, 3, '2024-06-20', 180),
(4, 4, '2024-06-25', 90),
(5, 5, '2024-06-30', 160);

-- --------------------------------------------------------

--
-- Table structure for table `shoes`
--

CREATE TABLE `shoes` (
  `shoe_id` int(11) NOT NULL,
  `shoe_name` varchar(255) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shoes`
--

INSERT INTO `shoes` (`shoe_id`, `shoe_name`, `price`, `stock`, `brand_id`, `category_id`) VALUES
(4, 'Polygon', 10, 35, 1, 1),
(5, 'Hommiepet', 65, 25, 2, 2),
(6, 'Air Force', 120, 50, 1, 1),
(8, 'Air Drone', 120, 50, 1, 1),
(9, 'Air Force', 120, 50, 1, 1),
(10, 'Air Max 100', 120, 50, 1, 1),
(11, 'Air Max', 50, NULL, NULL, NULL),
(12, 'Air Max', 120, 50, 1, 1),
(13, 'Air Max Baru', 120, 50, 1, 1),
(14, 'Air Max Baru', 50, NULL, NULL, NULL),
(15, 'New Shoe', 130, NULL, NULL, NULL),
(134, 'Sample Shoe', NULL, NULL, NULL, NULL),
(135, 'Sample Shoe', NULL, NULL, NULL, NULL);

--
-- Triggers `shoes`
--
DELIMITER $$
CREATE TRIGGER `after_shoe_delete` AFTER DELETE ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_log (shoe_id, change_time, operation, old_stock) 
    VALUES (OLD.shoe_id, NOW(), 'AFTER DELETE', OLD.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_shoe_insert` AFTER INSERT ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_log (shoe_id, change_time, operation, new_stock) 
    VALUES (NEW.shoe_id, NOW(), 'AFTER INSERT', NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_shoe_update` AFTER UPDATE ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_log (shoe_id, change_time, operation, old_stock, new_stock) 
    VALUES (OLD.shoe_id, NOW(), 'AFTER UPDATE', OLD.stock, NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_shoe_delete` BEFORE DELETE ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_log (shoe_id, change_time, operation, old_stock) 
    VALUES (OLD.shoe_id, NOW(), 'BEFORE DELETE', OLD.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_shoe_insert` BEFORE INSERT ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_Log (shoe_id, change_time, operation, new_stock) 
    VALUES (NEW.shoe_id, NOW(), 'BEFORE INSERT', NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_shoe_update` BEFORE UPDATE ON `shoes` FOR EACH ROW BEGIN
    INSERT INTO shoe_log (shoe_id, change_time, operation, old_stock, new_stock) 
    VALUES (OLD.shoe_id, NOW(), 'BEFORE UPDATE', OLD.stock, NEW.stock);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `shoe_horizontal`
-- (See below for the actual view)
--
CREATE TABLE `shoe_horizontal` (
`shoe_id` int(11)
,`shoe_name` varchar(255)
,`price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `shoe_log`
--

CREATE TABLE `shoe_log` (
  `log_id` int(11) NOT NULL,
  `shoe_id` int(11) DEFAULT NULL,
  `change_time` datetime DEFAULT NULL,
  `operation` varchar(50) DEFAULT NULL,
  `old_stock` int(11) DEFAULT NULL,
  `new_stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shoe_log`
--

INSERT INTO `shoe_log` (`log_id`, `shoe_id`, `change_time`, `operation`, `old_stock`, `new_stock`) VALUES
(2, 0, '2024-07-14 16:26:48', 'BEFORE INSERT', NULL, 50),
(3, 2, '2024-07-14 16:34:21', 'BEFORE UPDATE', 40, 50),
(4, 2, '2024-07-14 16:44:03', 'BEFORE DELETE', 50, NULL),
(5, 0, '2024-07-14 16:48:37', 'BEFORE INSERT', NULL, 50),
(6, 10, '2024-07-14 16:48:37', 'AFTER INSERT', NULL, 50),
(7, 3, '2024-07-14 16:54:10', 'BEFORE UPDATE', 30, 50),
(8, 3, '2024-07-14 16:54:10', 'AFTER UPDATE', 30, 50),
(9, 3, '2024-07-14 16:58:49', 'BEFORE DELETE', 50, NULL),
(10, 3, '2024-07-14 16:58:49', 'AFTER DELETE', 50, NULL),
(11, 4, '2024-07-14 17:25:08', 'BEFORE UPDATE', 35, 35),
(12, 4, '2024-07-14 17:25:08', 'AFTER UPDATE', 35, 35),
(13, 4, '2024-07-14 17:25:54', 'BEFORE UPDATE', 35, 35),
(14, 4, '2024-07-14 17:25:54', 'AFTER UPDATE', 35, 35),
(15, 0, '2024-07-14 20:16:07', 'BEFORE INSERT', NULL, NULL),
(16, 11, '2024-07-14 20:16:07', 'AFTER INSERT', NULL, NULL),
(17, 5, '2024-07-14 20:48:27', 'BEFORE UPDATE', 25, 25),
(18, 5, '2024-07-14 20:48:27', 'AFTER UPDATE', 25, 25),
(19, 0, '2024-07-14 21:36:04', 'BEFORE INSERT', NULL, 50),
(20, 12, '2024-07-14 21:36:04', 'AFTER INSERT', NULL, 50),
(21, 0, '2024-07-14 21:36:15', 'BEFORE INSERT', NULL, 50),
(22, 13, '2024-07-14 21:36:15', 'AFTER INSERT', NULL, 50),
(23, 0, '2024-07-14 21:51:59', 'BEFORE INSERT', NULL, NULL),
(24, 14, '2024-07-14 21:51:59', 'AFTER INSERT', NULL, NULL),
(25, 0, '2024-07-14 22:35:13', 'BEFORE INSERT', NULL, NULL),
(26, 15, '2024-07-14 22:35:13', 'AFTER INSERT', NULL, NULL),
(27, 4, '2024-07-14 22:48:36', 'BEFORE UPDATE', 35, 35),
(28, 4, '2024-07-14 22:48:36', 'AFTER UPDATE', 35, 35),
(29, 134, '2024-07-14 22:50:15', 'BEFORE INSERT', NULL, NULL),
(30, 134, '2024-07-14 22:50:15', 'AFTER INSERT', NULL, NULL),
(31, 0, '2024-07-14 22:59:52', 'BEFORE INSERT', NULL, NULL),
(32, 135, '2024-07-14 22:59:52', 'AFTER INSERT', NULL, NULL),
(33, 5, '2024-07-14 23:01:31', 'BEFORE UPDATE', 25, 25),
(34, 5, '2024-07-14 23:01:31', 'AFTER UPDATE', 25, 25);

-- --------------------------------------------------------

--
-- Stand-in structure for view `shoe_vertical`
-- (See below for the actual view)
--
CREATE TABLE `shoe_vertical` (
`shoe_id` int(11)
,`shoe_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `shoe_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `address`, `contact_person`, `email`, `shoe_id`) VALUES
(1, 'Supplier A', '123 Supplier St, Supplier City', 'John Doe', 'supplierA@example.com', NULL),
(2, 'Supplier B', '456 Supplier Ave, Supplier Town', 'Jane Smith', 'supplierB@example.com', NULL),
(3, 'Supplier C', '789 Supplier Rd, Supplier Village', 'Mike Johnson', 'supplierC@example.com', NULL),
(4, 'Supplier D', '321 Supplier Blvd, Supplier County', 'Emily Davis', 'supplierD@example.com', NULL),
(5, 'Supplier E', '654 Supplier Lane, Supplier District', 'Sarah Brown', 'supplierE@example.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `transaction_date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `transaction_date`, `amount`, `customer_id`) VALUES
(1, '2024-07-01', 120.00, 1),
(2, '2024-07-05', 90.00, 2),
(3, '2024-07-10', 150.00, 3),
(4, '2024-07-15', 180.00, 4),
(5, '2024-07-20', 200.00, 5);

-- --------------------------------------------------------

--
-- Structure for view `nama_shoe_vertical`
--
DROP TABLE IF EXISTS `nama_shoe_vertical`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nama_shoe_vertical`  AS SELECT `shoe_vertical`.`shoe_name` AS `shoe_name` FROM `shoe_vertical` WHERE `shoe_vertical`.`shoe_id` is not nullWITH LOCALCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `shoe_horizontal`
--
DROP TABLE IF EXISTS `shoe_horizontal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shoe_horizontal`  AS SELECT `shoes`.`shoe_id` AS `shoe_id`, `shoes`.`shoe_name` AS `shoe_name`, `shoes`.`price` AS `price` FROM `shoes` ;

-- --------------------------------------------------------

--
-- Structure for view `shoe_vertical`
--
DROP TABLE IF EXISTS `shoe_vertical`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shoe_vertical`  AS SELECT `shoes`.`shoe_id` AS `shoe_id`, `shoes`.`shoe_name` AS `shoe_name` FROM `shoes` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`detail_pesanan_id`),
  ADD KEY `pesanan_id` (`pesanan_id`),
  ADD KEY `detail_pesanan_id` (`shoe_id`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`pesanan_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `shoes`
--
ALTER TABLE `shoes`
  ADD PRIMARY KEY (`shoe_id`),
  ADD KEY `brand_id` (`brand_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `shoe_log`
--
ALTER TABLE `shoe_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `fk_supplier_shoe` (`shoe_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brand`
--
ALTER TABLE `brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `detail_pesanan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `pesanan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `shoes`
--
ALTER TABLE `shoes`
  MODIFY `shoe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `shoe_log`
--
ALTER TABLE `shoe_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`pesanan_id`) REFERENCES `pesanan` (`pesanan_id`),
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`shoe_id`) REFERENCES `shoes` (`shoe_id`),
  ADD CONSTRAINT `detail_pesanan_id` FOREIGN KEY (`shoe_id`) REFERENCES `shoes` (`shoe_id`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `shoes`
--
ALTER TABLE `shoes`
  ADD CONSTRAINT `shoes_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`),
  ADD CONSTRAINT `shoes_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `fk_supplier_shoe` FOREIGN KEY (`shoe_id`) REFERENCES `shoes` (`shoe_id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
