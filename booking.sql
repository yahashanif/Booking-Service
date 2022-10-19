-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2022 at 08:48 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `tgl_booking` date NOT NULL,
  `total` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `id_pelanggan`, `tgl_booking`, `total`) VALUES
(22, 1, '2022-10-20', 650000);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Spare Part'),
(2, 'Aksesoris'),
(3, 'Jasa');

-- --------------------------------------------------------

--
-- Table structure for table `detail_booking`
--

CREATE TABLE `detail_booking` (
  `id_booking` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 1,
  `subtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_booking`
--

INSERT INTO `detail_booking` (`id_booking`, `id_product`, `qty`, `subtotal`) VALUES
(22, 1, 1, 575000),
(22, 4, 1, 75000);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `no_hp` varchar(13) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `name`, `no_hp`, `alamat`) VALUES
(1, 'Hanif Aulia Sabri', '082290342356', 'padang Panjang');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `id_kat` int(11) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `harga` double NOT NULL,
  `image_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `id_kat`, `stock`, `harga`, `image_url`) VALUES
(1, 'UNIT COMP,CDI', 1, 2, 575000, '1.jpg'),
(2, 'ARM COMP VALVE ROCKER', 1, 3, 575000, '2.jpg'),
(3, 'PROTECTOR, MUFFLER', 1, 3, 55000, '.jpg'),
(4, 'HEADLIGHT UNITR', 1, 2, 75000, '4.jpg'),
(5, 'MIRROR COMP L', 1, 3, 57000, '1.jpg'),
(6, 'KEY SET', 1, 3, 575000, '4.jpg'),
(7, 'GASKET,CYLINDER', 1, 3, 55000, '5.jpg'),
(8, 'ARM, R. PILLION STEP', 1, 3, 75000, '2.jpg'),
(9, 'ARM COMP VALVE ', 1, 3, 75000, '1.jpg'),
(10, 'ARM', 1, 3, 55000, '1.jpg'),
(11, 'UNIT DI', 2, 3, 575000, '2.jpg'),
(12, 'Stiker', 2, 3, 57000, '1.jpg'),
(13, 'Jok', 2, 3, 57000, '3.jpg'),
(14, 'UNIT DIdd', 2, 3, 575000, '4.jpg'),
(15, 'Stiker Dora', 2, 3, 57000, '4.jpg'),
(16, 'Jok Pelampis', 2, 3, 57000, '3.jpg'),
(17, 'Stiker Naruto', 2, 3, 57000, '1.jpg'),
(18, 'Jok Naruto', 2, 3, 57000, '3.jpg'),
(19, 'UNIT DIdd', 2, 3, 575000, '4.jpg'),
(20, 'Stiker Doraemon', 2, 3, 57000, '4.jpg'),
(21, 'Sevices 1000 KM', 3, 0, 50000, '1.jpg'),
(22, 'Sevices 3000 KM', 3, 0, 50000, '1.jpg'),
(23, 'Ganti Oli', 3, 0, 50000, '2.jpg'),
(24, 'Ganti Oli Gandan', 3, 0, 50000, '3.jpg'),
(25, 'Ganti Rooller', 3, 0, 50000, '4.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `profil_path_url` text NOT NULL,
  `level` enum('admin','user') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `username`, `email`, `password`, `profil_path_url`, `level`) VALUES
(3, 'Hanif Aulia sabri', 'hanif_as', 'hanifauliasabriii@gmail.com', '$2a$10$kMZ3gofWRhDc457L5RWSguuVEivDpUx5BF2rn44qt5vKjARtaKhdK', 'hitam putih foto.JPG', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
