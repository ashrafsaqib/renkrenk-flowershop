-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 16, 2026 at 02:47 PM
-- Server version: 10.2.44-MariaDB
-- PHP Version: 8.1.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ren2ddnkcomtr_staging`
--

-- --------------------------------------------------------

--
-- Table structure for table `oc_address`
--

CREATE TABLE `oc_address` (
  `address_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_1` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_2` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_id` int(11) DEFAULT 0,
  `zone_id` int(11) DEFAULT 0,
  `custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_address`
--

INSERT INTO `oc_address` (`address_id`, `customer_id`, `firstname`, `lastname`, `company`, `address_1`, `address_2`, `city`, `postcode`, `country_id`, `zone_id`, `custom_field`, `default`) VALUES
(1, 1, 'saqib', 'ashraf', '', 'hs 194 Al hafeez garden phase 1 manawan', '', '', '54000', 264, 4791, '[]', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_address_format`
--

CREATE TABLE `oc_address_format` (
  `address_format_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_format` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_address_format`
--

INSERT INTO `oc_address_format` (`address_format_id`, `name`, `address_format`) VALUES
(1, 'Address Format', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}');

-- --------------------------------------------------------

--
-- Table structure for table `oc_antispam`
--

CREATE TABLE `oc_antispam` (
  `antispam_id` int(11) NOT NULL,
  `keyword` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_api`
--

CREATE TABLE `oc_api` (
  `api_id` int(11) NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_api`
--

INSERT INTO `oc_api` (`api_id`, `username`, `key`, `status`, `date_added`, `date_modified`) VALUES
(1, 'Default', '25a5983d57b53ed4d2bb218dde1af0be86db2298f07c8a941a2870979ba9842e38a6ab01d1ce7d528123fd4ce7c78cf54499005b8289d40a2509df7693c86a82f33280ab6659924d86cf13abfce588079d9d0ed2df5916687b708945f3ba0170c08784219ff77109a8fdf6217163518f345ef67604172071193e18aa27e6b666', 1, '2025-11-15 13:45:53', '2025-11-15 13:45:53');

-- --------------------------------------------------------

--
-- Table structure for table `oc_api_history`
--

CREATE TABLE `oc_api_history` (
  `api_history_id` int(11) NOT NULL,
  `api_id` int(11) DEFAULT NULL,
  `call` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_api_ip`
--

CREATE TABLE `oc_api_ip` (
  `api_ip_id` int(11) NOT NULL,
  `api_id` int(11) DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_article`
--

CREATE TABLE `oc_article` (
  `article_id` int(11) NOT NULL,
  `topic_id` int(11) DEFAULT 0,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_article`
--

INSERT INTO `oc_article` (`article_id`, `topic_id`, `author`, `rating`, `status`, `date_added`, `date_modified`) VALUES
(1, 0, 'John Doe', 0, 1, '2026-01-01 15:56:40', '2026-01-01 15:56:40'),
(2, 0, 'John Doe', 0, 1, '2026-01-01 15:57:00', '2026-01-01 15:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_article_comment`
--

CREATE TABLE `oc_article_comment` (
  `article_comment_id` int(11) NOT NULL,
  `article_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_article_description`
--

CREATE TABLE `oc_article_description` (
  `article_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_article_description`
--

INSERT INTO `oc_article_description` (`article_id`, `language_id`, `name`, `description`, `image`, `tag`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(1, 1, 'ABOUT US', '', '', '', 'ABOUT US', '', ''),
(2, 1, 'VISIT OUR BOUTIQUES', '', '', '', 'VISIT OUR BOUTIQUES', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_article_rating`
--

CREATE TABLE `oc_article_rating` (
  `article_rating_id` int(11) NOT NULL,
  `article_comment_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `rating` tinyint(1) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_article_to_layout`
--

CREATE TABLE `oc_article_to_layout` (
  `article_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_article_to_store`
--

CREATE TABLE `oc_article_to_store` (
  `article_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_article_to_store`
--

INSERT INTO `oc_article_to_store` (`article_id`, `store_id`) VALUES
(1, 0),
(2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute`
--

CREATE TABLE `oc_attribute` (
  `attribute_id` int(11) NOT NULL,
  `attribute_group_id` int(11) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_attribute`
--

INSERT INTO `oc_attribute` (`attribute_id`, `attribute_group_id`, `sort_order`) VALUES
(1, 6, 1),
(2, 6, 5),
(3, 6, 3),
(4, 3, 1),
(5, 3, 2),
(6, 3, 3),
(7, 3, 4),
(8, 3, 5),
(9, 3, 6),
(10, 3, 7),
(11, 3, 8);

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_description`
--

CREATE TABLE `oc_attribute_description` (
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_attribute_description`
--

INSERT INTO `oc_attribute_description` (`attribute_id`, `language_id`, `name`) VALUES
(1, 1, 'Description'),
(2, 1, 'No. of Cores'),
(3, 1, 'Clockspeed'),
(4, 1, 'test 1'),
(5, 1, 'test 2'),
(6, 1, 'test 3'),
(7, 1, 'test 4'),
(8, 1, 'test 5'),
(9, 1, 'test 6'),
(10, 1, 'test 7'),
(11, 1, 'test 8');

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_group`
--

CREATE TABLE `oc_attribute_group` (
  `attribute_group_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_attribute_group`
--

INSERT INTO `oc_attribute_group` (`attribute_group_id`, `sort_order`) VALUES
(3, 2),
(4, 1),
(5, 3),
(6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_group_description`
--

CREATE TABLE `oc_attribute_group_description` (
  `attribute_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_attribute_group_description`
--

INSERT INTO `oc_attribute_group_description` (`attribute_group_id`, `language_id`, `name`) VALUES
(3, 1, 'Memory'),
(4, 1, 'Technical'),
(5, 1, 'Motherboard'),
(6, 1, 'Processor');

-- --------------------------------------------------------

--
-- Table structure for table `oc_banner`
--

CREATE TABLE `oc_banner` (
  `banner_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_banner`
--

INSERT INTO `oc_banner` (`banner_id`, `name`, `status`) VALUES
(6, 'HP Products', 1),
(7, 'Home Page Slideshow', 1),
(8, 'Manufacturers', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_banner_image`
--

CREATE TABLE `oc_banner_image` (
  `banner_image_id` int(11) NOT NULL,
  `banner_id` int(11) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_banner_image`
--

INSERT INTO `oc_banner_image` (`banner_image_id`, `banner_id`, `language_id`, `title`, `link`, `image`, `sort_order`) VALUES
(87, 6, 1, 'HP Banner', 'index.php?route=product/manufacturer.info&amp;manufacturer_id=7', 'catalog/demo/compaq_presario.jpg', 0),
(88, 8, 1, 'Harley Davidson', '', 'catalog/demo/manufacturer/harley.png', 0),
(89, 8, 1, 'Dell', '', 'catalog/demo/manufacturer/dell.png', 0),
(90, 8, 1, 'Disney', '', 'catalog/demo/manufacturer/disney.png', 0),
(91, 8, 1, 'Coca Cola', '', 'catalog/demo/manufacturer/cocacola.png', 0),
(92, 8, 1, 'Burger King', '', 'catalog/demo/manufacturer/burgerking.png', 0),
(93, 8, 1, 'Canon', '', 'catalog/demo/manufacturer/canon.png', 0),
(94, 8, 1, 'NFL', '', 'catalog/demo/manufacturer/nfl.png', 0),
(95, 8, 1, 'RedBull', '', 'catalog/demo/manufacturer/redbull.png', 0),
(96, 8, 1, 'Sony', '', 'catalog/demo/manufacturer/sony.png', 0),
(97, 8, 1, 'Starbucks', '', 'catalog/demo/manufacturer/starbucks.png', 0),
(98, 8, 1, 'Nintendo', '', 'catalog/demo/manufacturer/nintendo.png', 0),
(99, 7, 1, 'iPhone 6', 'index.php?route=product/subscription_list&amp;language=en-gb', 'catalog/banner/banner.webp', 1),
(100, 7, 1, 'MacBookAir', 'index.php?route=product/subscription_list&amp;language=en-gb', 'catalog/banner/banner2.webp', 2);

-- --------------------------------------------------------

--
-- Table structure for table `oc_cart`
--

CREATE TABLE `oc_cart` (
  `cart_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `session_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `subscription_plan_id` int(11) DEFAULT 0,
  `option` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `override` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(15,4) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_category`
--

CREATE TABLE `oc_category` (
  `category_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_category`
--

INSERT INTO `oc_category` (`category_id`, `image`, `parent_id`, `sort_order`, `status`) VALUES
(59, '', 0, 0, 1),
(60, '', 0, 2, 1),
(61, '', 0, 3, 1),
(62, '', 60, 1, 1),
(63, '', 60, 2, 1),
(64, '', 61, 1, 1),
(65, '', 61, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_description`
--

CREATE TABLE `oc_category_description` (
  `category_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_category_description`
--

INSERT INTO `oc_category_description` (`category_id`, `language_id`, `name`, `description`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(59, 1, 'Flowers', '', 'Flowers', '', ''),
(60, 1, 'Ocassions', '', 'Ocassions', '', ''),
(61, 1, 'Home Decor', '', 'Home Decor', '', ''),
(62, 1, 'Birthday Flowers', '', 'Birthday Flowers', '', ''),
(63, 1, 'Engagement Flowers', '', 'Engagement Flowers', '', ''),
(64, 1, 'Candles', '', 'Candles', '', ''),
(65, 1, 'Vases', '', 'Vases', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_filter`
--

CREATE TABLE `oc_category_filter` (
  `category_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_path`
--

CREATE TABLE `oc_category_path` (
  `category_id` int(11) NOT NULL,
  `path_id` int(11) NOT NULL,
  `level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_category_path`
--

INSERT INTO `oc_category_path` (`category_id`, `path_id`, `level`) VALUES
(59, 59, 0),
(60, 60, 0),
(61, 61, 0),
(62, 60, 0),
(62, 62, 1),
(63, 60, 0),
(63, 63, 1),
(64, 61, 0),
(64, 64, 1),
(65, 61, 0),
(65, 65, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_to_layout`
--

CREATE TABLE `oc_category_to_layout` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_to_store`
--

CREATE TABLE `oc_category_to_store` (
  `category_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_category_to_store`
--

INSERT INTO `oc_category_to_store` (`category_id`, `store_id`) VALUES
(59, 0),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_country`
--

CREATE TABLE `oc_country` (
  `country_id` int(11) NOT NULL,
  `iso_code_2` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_code_3` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_format_id` int(11) DEFAULT 0,
  `postcode_required` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_country`
--

INSERT INTO `oc_country` (`country_id`, `iso_code_2`, `iso_code_3`, `address_format_id`, `postcode_required`, `status`) VALUES
(259, NULL, NULL, 0, NULL, 1),
(260, NULL, NULL, 0, NULL, 1),
(261, NULL, NULL, 0, NULL, 1),
(262, NULL, NULL, 0, NULL, 1),
(263, NULL, NULL, 0, NULL, 1),
(264, NULL, NULL, 0, NULL, 1),
(265, NULL, NULL, 0, NULL, 1),
(266, NULL, NULL, 0, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_country_description`
--

CREATE TABLE `oc_country_description` (
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_country_description`
--

INSERT INTO `oc_country_description` (`country_id`, `language_id`, `name`) VALUES
(264, 1, 'Adana'),
(260, 1, 'Ankara'),
(262, 1, 'Antalya'),
(263, 1, 'Bursa'),
(265, 1, 'Gaziantep'),
(259, 1, 'İstanbul'),
(261, 1, 'İzmir'),
(266, 1, 'Konya');

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon`
--

CREATE TABLE `oc_coupon` (
  `coupon_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` decimal(15,4) DEFAULT NULL,
  `logged` tinyint(1) DEFAULT 0,
  `shipping` tinyint(1) DEFAULT 0,
  `total` decimal(15,4) DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `uses_total` int(11) DEFAULT 0,
  `uses_customer` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_coupon`
--

INSERT INTO `oc_coupon` (`coupon_id`, `name`, `code`, `type`, `discount`, `logged`, `shipping`, `total`, `date_start`, `date_end`, `uses_total`, `uses_customer`, `status`, `date_added`) VALUES
(1, '-10% Discount', '2222', 'P', 10.0000, 0, 0, 0.0000, '2014-01-01', '2020-01-01', 10, 10, 0, '2009-01-27 13:55:03'),
(2, 'Free Shipping', '3333', 'P', 0.0000, 0, 1, 100.0000, '2014-01-01', '2014-02-01', 10, 10, 0, '2009-03-14 21:13:53'),
(3, '-10.00 Discount', '1111', 'F', 10.0000, 0, 0, 10.0000, '2014-01-01', '2020-01-01', 100000, 10000, 0, '2009-03-14 21:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_category`
--

CREATE TABLE `oc_coupon_category` (
  `coupon_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_history`
--

CREATE TABLE `oc_coupon_history` (
  `coupon_history_id` int(11) NOT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `amount` decimal(15,4) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_product`
--

CREATE TABLE `oc_coupon_product` (
  `coupon_product_id` int(11) NOT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_cron`
--

CREATE TABLE `oc_cron` (
  `cron_id` int(11) NOT NULL,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cycle` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_cron`
--

INSERT INTO `oc_cron` (`cron_id`, `code`, `description`, `cycle`, `action`, `status`, `date_added`, `date_modified`) VALUES
(1, 'currency', 'Updates currency conversion values.', 'day', 'cron/currency', 1, '2014-09-25 14:40:00', '2014-09-25 14:40:00'),
(2, 'gdpr', 'Deletes and send emails to customers who have requested their GPDR data to be deleted.', 'day', 'cron/gdpr', 1, '2014-09-25 14:40:00', '2014-09-25 14:40:00'),
(3, 'subscription', 'Processes subscriptions by creating new orders, charging customers and sending mails to customers telling them that their subscription has been processed.', 'day', 'cron/subscription', 0, '2014-09-25 14:40:00', '2014-09-25 14:40:00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_currency`
--

CREATE TABLE `oc_currency` (
  `currency_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol_left` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol_right` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimal_place` int(11) DEFAULT 2,
  `value` double(15,8) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_currency`
--

INSERT INTO `oc_currency` (`currency_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_place`, `value`, `status`, `date_modified`) VALUES
(2, 'Türk Lirası', 'TRY', '₺', '', 2, 43.18969374, 1, '2026-01-16 11:46:23'),
(4, 'Hong Kong Dollar', 'HKD', 'HK$', '', 2, 7.79912251, 0, '2026-01-16 11:46:23'),
(5, 'Indian Rupee', 'INR', '₹', '', 2, 90.29998279, 0, '2026-01-16 11:46:23'),
(6, 'Russian Ruble', 'RUB', '', '₽', 2, 56.40360000, 0, '2018-02-16 12:00:00'),
(7, 'Chinese Yuan Renminbi', 'CNY', '¥', '', 2, 6.96730902, 0, '2026-01-16 11:46:23'),
(8, 'Australian Dollar', 'AUD', '$', '', 2, 1.49535444, 0, '2026-01-16 11:46:23');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer`
--

CREATE TABLE `oc_customer` (
  `customer_id` int(11) NOT NULL,
  `customer_group_id` int(11) DEFAULT 0,
  `store_id` int(11) DEFAULT 0,
  `language_id` int(11) DEFAULT 0,
  `firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `newsletter` tinyint(1) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `safe` tinyint(1) DEFAULT 0,
  `commenter` tinyint(1) DEFAULT 0,
  `token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_customer`
--

INSERT INTO `oc_customer` (`customer_id`, `customer_group_id`, `store_id`, `language_id`, `firstname`, `lastname`, `email`, `telephone`, `password`, `custom_field`, `newsletter`, `ip`, `status`, `safe`, `commenter`, `token`, `code`, `date_added`) VALUES
(1, 1, 0, 1, 'saqib', 'Ashraf', 'linktosaqib@gmail.com', '', '$2y$10$ftGIswZvgYdt/IiUHoeqNeoSeNz587JvBLbsOyhS/lYIwbaYHqvXG', '[]', 0, '39.37.138.162', 1, 0, 0, NULL, NULL, '2025-12-01 17:23:55');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_activity`
--

CREATE TABLE `oc_customer_activity` (
  `customer_activity_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_affiliate`
--

CREATE TABLE `oc_customer_affiliate` (
  `customer_id` int(11) NOT NULL,
  `company` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tracking` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` decimal(15,4) DEFAULT NULL,
  `commission` decimal(4,2) DEFAULT 0.00,
  `tax` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_branch_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_swift_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_number` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_affiliate_report`
--

CREATE TABLE `oc_customer_affiliate_report` (
  `customer_affiliate_report_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_approval`
--

CREATE TABLE `oc_customer_approval` (
  `customer_approval_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `type` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_authorize`
--

CREATE TABLE `oc_customer_authorize` (
  `customer_authorize_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `token` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_expire` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_group`
--

CREATE TABLE `oc_customer_group` (
  `customer_group_id` int(11) NOT NULL,
  `approval` int(11) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_customer_group`
--

INSERT INTO `oc_customer_group` (`customer_group_id`, `approval`, `sort_order`) VALUES
(1, 0, 1),
(2, 0, 2),
(3, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_group_description`
--

CREATE TABLE `oc_customer_group_description` (
  `customer_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_customer_group_description`
--

INSERT INTO `oc_customer_group_description` (`customer_group_id`, `language_id`, `name`, `description`) VALUES
(1, 1, 'Default', 'Default customer group'),
(2, 1, 'Retail', 'Retail customers'),
(3, 1, 'Wholesale', 'Wholesale customers');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_history`
--

CREATE TABLE `oc_customer_history` (
  `customer_history_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_ip`
--

CREATE TABLE `oc_customer_ip` (
  `customer_ip_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_customer_ip`
--

INSERT INTO `oc_customer_ip` (`customer_ip_id`, `customer_id`, `store_id`, `ip`, `country`, `date_added`) VALUES
(1, 1, 0, '39.37.164.110', '', '2025-12-05 11:02:32'),
(2, 1, 0, '182.185.136.247', '', '2025-12-10 12:46:41'),
(3, 1, 0, '39.37.138.162', '', '2025-12-24 10:37:49'),
(4, 1, 0, '39.37.138.162', '', '2025-12-24 10:38:41');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_login`
--

CREATE TABLE `oc_customer_login` (
  `customer_login_id` int(11) NOT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int(11) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_online`
--

CREATE TABLE `oc_customer_online` (
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int(11) DEFAULT 0,
  `url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_reward`
--

CREATE TABLE `oc_customer_reward` (
  `customer_reward_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT 0,
  `order_id` int(11) DEFAULT 0,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_search`
--

CREATE TABLE `oc_customer_search` (
  `customer_search_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `language_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT 0,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sub_category` tinyint(1) DEFAULT NULL,
  `description` tinyint(1) DEFAULT NULL,
  `products` int(11) DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_token`
--

CREATE TABLE `oc_customer_token` (
  `customer_token_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_transaction`
--

CREATE TABLE `oc_customer_transaction` (
  `customer_transaction_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT 0,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(15,4) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_wishlist`
--

CREATE TABLE `oc_customer_wishlist` (
  `customer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field`
--

CREATE TABLE `oc_custom_field` (
  `custom_field_id` int(11) NOT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_custom_field`
--

INSERT INTO `oc_custom_field` (`custom_field_id`, `type`, `value`, `validation`, `location`, `status`, `sort_order`) VALUES
(1, 'select', '', '', 'account', 0, 1),
(2, 'radio', '', '', 'account', 0, 2),
(3, 'checkbox', '', '', 'account', 0, 3),
(4, 'text', '', '', 'account', 0, 4),
(5, 'textarea', '', '', 'account', 0, 5),
(6, 'file', '', '', 'account', 0, 6),
(7, 'date', '', '', 'account', 0, 7),
(8, 'time', '', '', 'account', 0, 8),
(9, 'datetime', '', '', 'account', 0, 9),
(11, 'checkbox', '', '', 'address', 0, 3),
(12, 'time', '', '', 'address', 0, 8),
(13, 'date', '', '', 'address', 0, 7),
(14, 'datetime', '', '', 'address', 0, 9),
(15, 'file', '', '', 'address', 0, 6),
(16, 'radio', '', '', 'address', 0, 2),
(17, 'select', '', '', 'address', 0, 1),
(18, 'text', '', '', 'address', 0, 4),
(19, 'textarea', '', '', 'address', 0, 5),
(20, 'checkbox', '', '', 'affiliate', 0, 3),
(21, 'date', '', '', 'affiliate', 0, 8),
(22, 'datetime', '', '', 'affiliate', 0, 9),
(23, 'file', '', '', 'affiliate', 0, 6),
(24, 'radio', '', '', 'affiliate', 0, 2),
(25, 'select', '', '', 'affiliate', 0, 1),
(26, 'text', '', '', 'affiliate', 0, 4),
(27, 'textarea', '', '', 'affiliate', 0, 5),
(28, 'time', '', '', 'affiliate', 0, 8);

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_customer_group`
--

CREATE TABLE `oc_custom_field_customer_group` (
  `custom_field_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `required` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_custom_field_customer_group`
--

INSERT INTO `oc_custom_field_customer_group` (`custom_field_id`, `customer_group_id`, `required`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(5, 1, 1),
(6, 1, 1),
(7, 1, 1),
(8, 1, 1),
(9, 1, 1),
(11, 1, 1),
(12, 1, 1),
(13, 1, 1),
(14, 1, 1),
(15, 1, 1),
(16, 1, 1),
(17, 1, 1),
(18, 1, 1),
(19, 1, 1),
(20, 1, 1),
(21, 1, 1),
(22, 1, 1),
(23, 1, 1),
(24, 1, 1),
(25, 1, 1),
(26, 1, 1),
(27, 1, 1),
(28, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_description`
--

CREATE TABLE `oc_custom_field_description` (
  `custom_field_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_custom_field_description`
--

INSERT INTO `oc_custom_field_description` (`custom_field_id`, `language_id`, `name`) VALUES
(1, 1, 'Select'),
(2, 1, 'Radio'),
(3, 1, 'Checkbox'),
(4, 1, 'Text'),
(5, 1, 'Textarea'),
(6, 1, 'File'),
(7, 1, 'Date'),
(8, 1, 'Time'),
(9, 1, 'Date &amp; Time'),
(11, 1, 'Checkbox'),
(12, 1, 'Time'),
(13, 1, 'Date'),
(14, 1, 'Date &amp; Time'),
(15, 1, 'File'),
(16, 1, 'Radio'),
(17, 1, 'Select'),
(18, 1, 'Text'),
(19, 1, 'Textarea'),
(20, 1, 'Checkbox'),
(21, 1, 'Date'),
(22, 1, 'Date &amp; Time'),
(23, 1, 'File'),
(24, 1, 'Radio'),
(25, 1, 'Select'),
(26, 1, 'Text'),
(27, 1, 'Textarea'),
(28, 1, 'Time');

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_value`
--

CREATE TABLE `oc_custom_field_value` (
  `custom_field_value_id` int(11) NOT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_custom_field_value`
--

INSERT INTO `oc_custom_field_value` (`custom_field_value_id`, `custom_field_id`, `sort_order`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 1),
(5, 2, 2),
(6, 2, 3),
(7, 3, 1),
(8, 3, 2),
(9, 3, 3),
(20, 11, 1),
(21, 11, 2),
(22, 11, 3),
(32, 16, 1),
(33, 16, 2),
(34, 16, 3),
(35, 17, 1),
(36, 17, 2),
(37, 17, 3),
(38, 20, 1),
(39, 20, 2),
(40, 20, 3),
(41, 24, 1),
(42, 24, 2),
(43, 24, 3),
(44, 25, 0),
(45, 25, 0),
(46, 25, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_value_description`
--

CREATE TABLE `oc_custom_field_value_description` (
  `custom_field_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `custom_field_id` int(11) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_custom_field_value_description`
--

INSERT INTO `oc_custom_field_value_description` (`custom_field_value_id`, `language_id`, `custom_field_id`, `name`) VALUES
(1, 1, 1, 'Test 1'),
(2, 1, 1, 'test 2'),
(3, 1, 1, 'Test 3'),
(4, 1, 2, 'Test 1'),
(5, 1, 2, 'Test 2'),
(6, 1, 2, 'Test 3'),
(7, 1, 3, 'Test 1'),
(8, 1, 3, 'Test 2'),
(9, 1, 3, 'Test 3'),
(20, 1, 11, 'Test 1'),
(21, 1, 11, 'Test 2'),
(22, 1, 11, 'Test 3'),
(32, 1, 16, 'Test 1'),
(33, 1, 16, 'Test 2'),
(34, 1, 16, 'Test 3'),
(35, 1, 17, 'Test 1'),
(36, 1, 17, 'Test 2'),
(37, 1, 17, 'Test 3'),
(38, 1, 20, 'Test 1'),
(39, 1, 20, 'Test 2'),
(40, 1, 20, 'Test 3'),
(41, 1, 24, 'Test 1'),
(42, 1, 24, 'Test 2'),
(43, 1, 24, 'Test 3'),
(44, 1, 25, 'Test 1'),
(45, 1, 25, 'Test 2'),
(46, 1, 25, 'Test 3');

-- --------------------------------------------------------

--
-- Table structure for table `oc_download`
--

CREATE TABLE `oc_download` (
  `download_id` int(11) NOT NULL,
  `filename` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mask` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_download_description`
--

CREATE TABLE `oc_download_description` (
  `download_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_download_report`
--

CREATE TABLE `oc_download_report` (
  `download_report_id` int(11) NOT NULL,
  `download_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_event`
--

CREATE TABLE `oc_event` (
  `event_id` int(11) NOT NULL,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trigger` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_event`
--

INSERT INTO `oc_event` (`event_id`, `code`, `description`, `trigger`, `action`, `status`, `sort_order`) VALUES
(1, 'activity_customer_add', 'Adds new customer entry in the activity log.', 'catalog/model/account/customer.addCustomer/after', 'event/activity.addCustomer', 1, 1),
(2, 'activity_customer_edit', 'Adds edit customer entry in the activity log.', 'catalog/model/account/customer.editCustomer/after', 'event/activity.editCustomer', 1, 1),
(3, 'activity_customer_password', 'Adds edit password entry in the activity log.', 'catalog/model/account/customer.editPassword/after', 'event/activity.editPassword', 1, 1),
(4, 'activity_customer_forgotten', 'Adds forgotten password entry in the activity log.', 'catalog/model/account/customer.addToken/after', 'event/activity.forgotten', 1, 1),
(5, 'activity_customer_login', 'Adds edit customer entry in the activity log.', 'catalog/model/account/customer.deleteLoginAttempts/after', 'event/activity.login', 1, 1),
(6, 'activity_customer_transaction', 'Adds edit customer entry in the activity log.', 'catalog/model/account/customer.addTransaction/after', 'event/activity.addTransaction', 1, 1),
(7, 'activity_address_add', 'Adds new address entry in the activity log.', 'catalog/model/account/address.addAddress/after', 'event/activity.addAddress', 1, 1),
(8, 'activity_address_edit', 'Adds edit address entry in the activity log.', 'catalog/model/account/address.editAddress/after', 'event/activity.editAddress', 1, 1),
(9, 'activity_address_delete', 'Adds delete address entry in the activity log.', 'catalog/model/account/address.deleteAddress/after', 'event/activity.deleteAddress', 1, 1),
(10, 'activity_affiliate_add', 'Adds new affiliate entry in the activity log.', 'catalog/model/account/affiliate.addAffiliate/after', 'event/activity.addAffiliate', 1, 1),
(11, 'activity_affiliate_edit', 'Adds edit affiliate entry in the activity log.', 'catalog/model/account/affiliate.editAffiliate/after', 'event/activity.editAffiliate', 1, 1),
(12, 'activity_order_add', 'Adds new order entry in the activity log.', 'catalog/model/checkout/order.addHistory/before', 'event/activity.addHistory', 1, 1),
(13, 'activity_return_add', 'Adds new return entry in the activity log.', 'catalog/model/account/returns.addReturn/after', 'event/activity.addReturn', 1, 1),
(14, 'mail_customer_add', 'Sends mail to newly registered customers.', 'catalog/model/account/customer.addCustomer/after', 'mail/register', 1, 1),
(15, 'mail_customer_alert', 'Sends alert mail to store owner when a new customer registers.', 'catalog/model/account/customer.addCustomer/after', 'mail/register.alert', 1, 1),
(16, 'mail_customer_transaction', 'Sends mail to the customer when their transaction balance is updated.', 'catalog/model/account/customer.addTransaction/after', 'mail/transaction', 1, 1),
(17, 'mail_customer_forgotten', 'Sends mail to customers who have forgotten their password.', 'catalog/model/account/customer.addToken/after', 'mail/forgotten', 1, 1),
(18, 'mail_customer_authorize', 'Sends mail login code to customers email to authorize login from a new device.', 'catalog/controller/account/authorize.send/after', 'mail/authorize', 1, 1),
(19, 'mail_customer_authorize_reset', 'Sends reset link to user who`s account is locked out after 3 wrong authorize code login attempts.', 'catalog/model/account/customer.addToken/after', 'mail/authorize.reset', 1, 1),
(20, 'mail_affiliate_add', 'Sends mail to newly registered affiliates.', 'catalog/model/account/affiliate.addAffiliate/after', 'mail/affiliate', 1, 1),
(21, 'mail_affiliate_alert', 'Sends mail to new customers.', 'catalog/model/account/affiliate.addAffiliate/after', 'mail/affiliate.alert', 1, 1),
(22, 'mail_order', 'Sends mail to customer when they make an order.', 'catalog/model/checkout/order.addHistory/before', 'mail/order', 1, 1),
(23, 'mail_order_alert', 'Sends alert mail to new store owner when a new order is made.', 'catalog/model/checkout/order.addHistory/before', 'mail/order.alert', 1, 1),
(24, 'mail_gdpr', 'Sends mail to customers who have requested their data exported or deleted.', 'catalog/model/account/gdpr.addGdpr/after', 'mail/gdpr', 1, 1),
(25, 'mail_gdpr_delete', 'Sends mail to customers to let them know their GDPR data has been deleted.', 'catalog/model/account/gdpr.editStatus/after', 'mail/gdpr.remove', 1, 1),
(26, 'mail_review', 'Sends mail to store owner that a new review has been submitted.', 'catalog/model/catalog/review.addReview/after', 'mail/review', 1, 1),
(27, 'mail_subscription', 'Sends mail to store owner that a new subscription has been created.', 'catalog/model/checkout/subscription.addSubscription/after', 'mail/subscription', 1, 1),
(28, 'statistics_review_add', 'Updates review statistics when a new review is added.', 'catalog/model/catalog/review.addReview/after', 'event/statistics.addReview', 1, 1),
(29, 'statistics_return_add', 'Updates return statistics when a new return is added.', 'catalog/model/account/returns.addReturn/after', 'event/statistics.addReturn', 1, 1),
(30, 'statistics_return_delete', 'Updates return statistics when a return is deleted.', 'admin/model/sale/returns.deleteReturn/after', 'event/statistics.deleteReturn', 1, 1),
(31, 'statistics_order_history', 'Updates order status statistics when a order has been updated.', 'catalog/model/checkout/order.addHistory/before', 'event/statistics.addHistory', 1, 1),
(32, 'admin_currency_add', 'Updates currencies when a new currency is added.', 'admin/model/localisation/currency.addCurrency/after', 'event/currency', 1, 1),
(33, 'admin_currency_edit', 'Updates currencies when a currency is edited.', 'admin/model/localisation/currency.editCurrency/after', 'event/currency', 1, 1),
(34, 'admin_currency_setting', 'Updates currencies when settings are saved.', 'admin/model/setting/setting.editSetting/after', 'event/currency', 1, 1),
(35, 'admin_mail_gdpr', 'Sends approval or denial mail to customer who requested GDPR data export or deletion.', 'admin/model/customer/gdpr.editStatus/after', 'mail/gdpr', 1, 1),
(36, 'admin_mail_affiliate_approve', 'Sends mail to the affiliate when their account is approved.', 'admin/model/customer/customer_approval.approveAffiliate/after', 'mail/affiliate.approve', 1, 1),
(37, 'admin_mail_affiliate_deny', 'Sends mail to the affiliate when their account is denied.', 'admin/model/customer/customer_approval.denyAffiliate/after', 'mail/affiliate.deny', 1, 1),
(38, 'admin_mail_customer_approve', 'Sends mail to the customer when their account is approved.', 'admin/model/customer/customer_approval.approveCustomer/after', 'mail/customer.approve', 1, 1),
(39, 'admin_mail_customer_deny', 'Sends mail to the customer when their account is denied.', 'admin/model/customer/customer_approval.denyCustomer/after', 'mail/customer.deny', 1, 1),
(40, 'admin_mail_customer_transaction', 'Sends mail to the customer when their transaction balance is updated.', 'admin/model/customer/customer.addTransaction/after', 'mail/transaction', 1, 1),
(41, 'admin_mail_reward', 'Sends mail to the customer when their reward balance is updated.', 'admin/model/customer/customer.addReward/after', 'mail/reward', 1, 1),
(42, 'admin_mail_return', 'Sends mail to customer when their return status is changed.', 'admin/model/sale/returns.addHistory/after', 'mail/returns', 1, 1),
(43, 'admin_mail_user_forgotten', 'Sends mail to users who have forgotten their password.', 'admin/model/user/user.addToken/after', 'mail/forgotten', 1, 1),
(44, 'admin_mail_user_authorize', 'Sends mail login code to users email to authorize login from a new device.', 'admin/controller/common/authorize.send/after', 'mail/authorize', 1, 1),
(45, 'admin_mail_user_authorize_reset', 'Sends reset link to user who`s account is locked out after 3 wrong authorize code login attempts.', 'admin/model/user/user.addToken/after', 'mail/authorize.reset', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension`
--

CREATE TABLE `oc_extension` (
  `extension_id` int(11) NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_extension`
--

INSERT INTO `oc_extension` (`extension_id`, `extension`, `type`, `code`) VALUES
(1, 'opencart', 'currency', 'ecb'),
(2, 'opencart', 'module', 'featured'),
(3, 'opencart', 'module', 'banner'),
(4, 'opencart', 'payment', 'cod'),
(5, 'opencart', 'payment', 'free_checkout'),
(6, 'opencart', 'module', 'category'),
(7, 'opencart', 'module', 'account'),
(9, 'opencart', 'shipping', 'flat'),
(10, 'opencart', 'theme', 'basic'),
(11, 'opencart', 'total', 'credit'),
(12, 'opencart', 'total', 'shipping'),
(13, 'opencart', 'total', 'sub_total'),
(14, 'opencart', 'total', 'tax'),
(15, 'opencart', 'total', 'total'),
(16, 'opencart', 'total', 'handling'),
(17, 'opencart', 'total', 'low_order_fee'),
(18, 'opencart', 'total', 'coupon'),
(19, 'opencart', 'total', 'reward'),
(20, 'opencart', 'dashboard', 'activity'),
(21, 'opencart', 'dashboard', 'sale'),
(22, 'opencart', 'dashboard', 'recent'),
(23, 'opencart', 'dashboard', 'order'),
(24, 'opencart', 'dashboard', 'online'),
(25, 'opencart', 'dashboard', 'map'),
(26, 'opencart', 'dashboard', 'customer'),
(27, 'opencart', 'dashboard', 'chart'),
(28, 'opencart', 'report', 'sale_coupon'),
(29, 'opencart', 'report', 'customer_search'),
(30, 'opencart', 'report', 'customer_transaction'),
(31, 'opencart', 'report', 'product_purchased'),
(32, 'opencart', 'report', 'product_viewed'),
(33, 'opencart', 'report', 'sale_return'),
(34, 'opencart', 'report', 'sale_order'),
(35, 'opencart', 'report', 'sale_shipping'),
(36, 'opencart', 'report', 'sale_tax'),
(37, 'opencart', 'report', 'customer_activity'),
(38, 'opencart', 'report', 'customer_order'),
(39, 'opencart', 'report', 'customer_reward'),
(40, 'opencart', 'report', 'marketing'),
(41, 'opencart', 'report', 'subscription'),
(42, 'opencart', 'report', 'customer');

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension_install`
--

CREATE TABLE `oc_extension_install` (
  `extension_install_id` int(11) NOT NULL,
  `extension_id` int(11) DEFAULT 0,
  `extension_download_id` int(11) DEFAULT 0,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_extension_install`
--

INSERT INTO `oc_extension_install` (`extension_install_id`, `extension_id`, `extension_download_id`, `name`, `description`, `code`, `version`, `author`, `link`, `status`, `date_added`) VALUES
(1, 0, 0, 'OpenCart Default Extensions', 'This extension contains all the default extensions for modules, currencies, payment methods, shipping methods, anti-fraud, themes, order totals and reports.', 'opencart', '1.0', 'OpenCart Ltd', 'http://www.opencart.com', 1, '2020-08-29 15:35:39');

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension_path`
--

CREATE TABLE `oc_extension_path` (
  `extension_path_id` int(11) NOT NULL,
  `extension_install_id` int(11) DEFAULT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_extension_path`
--

INSERT INTO `oc_extension_path` (`extension_path_id`, `extension_install_id`, `path`) VALUES
(1, 1, 'opencart'),
(2, 1, 'opencart/admin'),
(3, 1, 'opencart/admin/controller'),
(4, 1, 'opencart/admin/controller/analytics'),
(5, 1, 'opencart/admin/controller/analytics/index.html'),
(6, 1, 'opencart/admin/controller/captcha'),
(7, 1, 'opencart/admin/controller/captcha/basic.php'),
(8, 1, 'opencart/admin/controller/currency'),
(9, 1, 'opencart/admin/controller/currency/ecb.php'),
(10, 1, 'opencart/admin/controller/currency/fixer.php'),
(11, 1, 'opencart/admin/controller/dashboard'),
(12, 1, 'opencart/admin/controller/dashboard/activity.php'),
(13, 1, 'opencart/admin/controller/dashboard/chart.php'),
(14, 1, 'opencart/admin/controller/dashboard/customer.php'),
(15, 1, 'opencart/admin/controller/dashboard/map.php'),
(16, 1, 'opencart/admin/controller/dashboard/online.php'),
(17, 1, 'opencart/admin/controller/dashboard/order.php'),
(18, 1, 'opencart/admin/controller/dashboard/recent.php'),
(19, 1, 'opencart/admin/controller/dashboard/sale.php'),
(20, 1, 'opencart/admin/controller/feed'),
(21, 1, 'opencart/admin/controller/feed/index.html'),
(22, 1, 'opencart/admin/controller/fraud'),
(23, 1, 'opencart/admin/controller/fraud/ip.php'),
(24, 1, 'opencart/admin/controller/module'),
(25, 1, 'opencart/admin/controller/module/account.php'),
(26, 1, 'opencart/admin/controller/module/banner.php'),
(27, 1, 'opencart/admin/controller/module/bestseller.php'),
(28, 1, 'opencart/admin/controller/module/category.php'),
(29, 1, 'opencart/admin/controller/module/featured.php'),
(30, 1, 'opencart/admin/controller/module/filter.php'),
(31, 1, 'opencart/admin/controller/module/html.php'),
(32, 1, 'opencart/admin/controller/module/information.php'),
(33, 1, 'opencart/admin/controller/module/latest.php'),
(34, 1, 'opencart/admin/controller/module/special.php'),
(35, 1, 'opencart/admin/controller/module/store.php'),
(36, 1, 'opencart/admin/controller/payment'),
(37, 1, 'opencart/admin/controller/payment/bank_transfer.php'),
(38, 1, 'opencart/admin/controller/payment/cheque.php'),
(39, 1, 'opencart/admin/controller/payment/cod.php'),
(40, 1, 'opencart/admin/controller/payment/free_checkout.php'),
(41, 1, 'opencart/admin/controller/report'),
(42, 1, 'opencart/admin/controller/report/customer.php'),
(43, 1, 'opencart/admin/controller/report/customer_activity.php'),
(44, 1, 'opencart/admin/controller/report/customer_order.php'),
(45, 1, 'opencart/admin/controller/report/customer_reward.php'),
(46, 1, 'opencart/admin/controller/report/customer_search.php'),
(47, 1, 'opencart/admin/controller/report/subscription.php'),
(48, 1, 'opencart/admin/controller/report/customer_transaction.php'),
(49, 1, 'opencart/admin/controller/report/marketing.php'),
(50, 1, 'opencart/admin/controller/report/product_purchased.php'),
(51, 1, 'opencart/admin/controller/report/product_viewed.php'),
(52, 1, 'opencart/admin/controller/report/sale_coupon.php'),
(53, 1, 'opencart/admin/controller/report/sale_order.php'),
(54, 1, 'opencart/admin/controller/report/sale_return.php'),
(55, 1, 'opencart/admin/controller/report/sale_shipping.php'),
(56, 1, 'opencart/admin/controller/report/sale_tax.php'),
(57, 1, 'opencart/admin/controller/shipping'),
(58, 1, 'opencart/admin/controller/shipping/flat.php'),
(59, 1, 'opencart/admin/controller/shipping/free.php'),
(60, 1, 'opencart/admin/controller/shipping/item.php'),
(61, 1, 'opencart/admin/controller/shipping/pickup.php'),
(62, 1, 'opencart/admin/controller/shipping/weight.php'),
(63, 1, 'opencart/admin/controller/theme'),
(64, 1, 'opencart/admin/controller/theme/basic.php'),
(65, 1, 'opencart/admin/controller/total'),
(66, 1, 'opencart/admin/controller/total/coupon.php'),
(67, 1, 'opencart/admin/controller/total/credit.php'),
(68, 1, 'opencart/admin/controller/total/handling.php'),
(69, 1, 'opencart/admin/controller/total/low_order_fee.php'),
(70, 1, 'opencart/admin/controller/total/reward.php'),
(71, 1, 'opencart/admin/controller/total/shipping.php'),
(72, 1, 'opencart/admin/controller/total/sub_total.php'),
(73, 1, 'opencart/admin/controller/total/tax.php'),
(74, 1, 'opencart/admin/controller/total/total.php'),
(75, 1, 'opencart/admin/language'),
(76, 1, 'opencart/admin/language/en-gb'),
(77, 1, 'opencart/admin/language/en-gb/captcha'),
(78, 1, 'opencart/admin/language/en-gb/captcha/basic.php'),
(79, 1, 'opencart/admin/language/en-gb/currency'),
(80, 1, 'opencart/admin/language/en-gb/currency/ecb.php'),
(81, 1, 'opencart/admin/language/en-gb/currency/fixer.php'),
(82, 1, 'opencart/admin/language/en-gb/dashboard'),
(83, 1, 'opencart/admin/language/en-gb/dashboard/activity.php'),
(84, 1, 'opencart/admin/language/en-gb/dashboard/chart.php'),
(85, 1, 'opencart/admin/language/en-gb/dashboard/customer.php'),
(86, 1, 'opencart/admin/language/en-gb/dashboard/map.php'),
(87, 1, 'opencart/admin/language/en-gb/dashboard/online.php'),
(88, 1, 'opencart/admin/language/en-gb/dashboard/order.php'),
(89, 1, 'opencart/admin/language/en-gb/dashboard/recent.php'),
(90, 1, 'opencart/admin/language/en-gb/dashboard/sale.php'),
(91, 1, 'opencart/admin/language/en-gb/fraud'),
(92, 1, 'opencart/admin/language/en-gb/fraud/ip.php'),
(93, 1, 'opencart/admin/language/en-gb/module'),
(94, 1, 'opencart/admin/language/en-gb/module/account.php'),
(95, 1, 'opencart/admin/language/en-gb/module/banner.php'),
(96, 1, 'opencart/admin/language/en-gb/module/bestseller.php'),
(97, 1, 'opencart/admin/language/en-gb/module/category.php'),
(98, 1, 'opencart/admin/language/en-gb/module/featured.php'),
(99, 1, 'opencart/admin/language/en-gb/module/filter.php'),
(100, 1, 'opencart/admin/language/en-gb/module/html.php'),
(101, 1, 'opencart/admin/language/en-gb/module/information.php'),
(102, 1, 'opencart/admin/language/en-gb/module/latest.php'),
(103, 1, 'opencart/admin/language/en-gb/module/special.php'),
(104, 1, 'opencart/admin/language/en-gb/module/store.php'),
(105, 1, 'opencart/admin/language/en-gb/payment'),
(106, 1, 'opencart/admin/language/en-gb/payment/bank_transfer.php'),
(107, 1, 'opencart/admin/language/en-gb/payment/cheque.php'),
(108, 1, 'opencart/admin/language/en-gb/payment/cod.php'),
(109, 1, 'opencart/admin/language/en-gb/payment/free_checkout.php'),
(110, 1, 'opencart/admin/language/en-gb/report'),
(111, 1, 'opencart/admin/language/en-gb/report/customer.php'),
(112, 1, 'opencart/admin/language/en-gb/report/customer_activity.php'),
(113, 1, 'opencart/admin/language/en-gb/report/customer_order.php'),
(114, 1, 'opencart/admin/language/en-gb/report/customer_reward.php'),
(115, 1, 'opencart/admin/language/en-gb/report/customer_search.php'),
(116, 1, 'opencart/admin/language/en-gb/report/subscription.php'),
(117, 1, 'opencart/admin/language/en-gb/report/customer_transaction.php'),
(118, 1, 'opencart/admin/language/en-gb/report/marketing.php'),
(119, 1, 'opencart/admin/language/en-gb/report/product_purchased.php'),
(120, 1, 'opencart/admin/language/en-gb/report/product_viewed.php'),
(121, 1, 'opencart/admin/language/en-gb/report/sale_coupon.php'),
(122, 1, 'opencart/admin/language/en-gb/report/sale_order.php'),
(123, 1, 'opencart/admin/language/en-gb/report/sale_return.php'),
(124, 1, 'opencart/admin/language/en-gb/report/sale_shipping.php'),
(125, 1, 'opencart/admin/language/en-gb/report/sale_tax.php'),
(126, 1, 'opencart/admin/language/en-gb/shipping'),
(127, 1, 'opencart/admin/language/en-gb/shipping/flat.php'),
(128, 1, 'opencart/admin/language/en-gb/shipping/free.php'),
(129, 1, 'opencart/admin/language/en-gb/shipping/item.php'),
(130, 1, 'opencart/admin/language/en-gb/shipping/pickup.php'),
(131, 1, 'opencart/admin/language/en-gb/shipping/weight.php'),
(132, 1, 'opencart/admin/language/en-gb/theme'),
(133, 1, 'opencart/admin/language/en-gb/theme/basic.php'),
(134, 1, 'opencart/admin/language/en-gb/total'),
(135, 1, 'opencart/admin/language/en-gb/total/coupon.php'),
(136, 1, 'opencart/admin/language/en-gb/total/credit.php'),
(137, 1, 'opencart/admin/language/en-gb/total/handling.php'),
(138, 1, 'opencart/admin/language/en-gb/total/low_order_fee.php'),
(139, 1, 'opencart/admin/language/en-gb/total/reward.php'),
(140, 1, 'opencart/admin/language/en-gb/total/shipping.php'),
(141, 1, 'opencart/admin/language/en-gb/total/sub_total.php'),
(142, 1, 'opencart/admin/language/en-gb/total/tax.php'),
(143, 1, 'opencart/admin/language/en-gb/total/total.php'),
(144, 1, 'opencart/admin/model'),
(145, 1, 'opencart/admin/model/dashboard'),
(146, 1, 'opencart/admin/model/dashboard/map.php'),
(147, 1, 'opencart/admin/model/fraud'),
(148, 1, 'opencart/admin/model/fraud/ip.php'),
(149, 1, 'opencart/admin/model/module'),
(150, 1, 'opencart/admin/model/module/bestseller.php'),
(151, 1, 'opencart/admin/model/report'),
(152, 1, 'opencart/admin/model/report/activity.php'),
(153, 1, 'opencart/admin/model/report/coupon.php'),
(154, 1, 'opencart/admin/model/report/customer.php'),
(155, 1, 'opencart/admin/model/report/subscription.php'),
(156, 1, 'opencart/admin/model/report/customer_transaction.php'),
(157, 1, 'opencart/admin/model/report/marketing.php'),
(158, 1, 'opencart/admin/model/report/product_purchased.php'),
(159, 1, 'opencart/admin/model/report/product_viewed.php'),
(160, 1, 'opencart/admin/model/report/returns.php'),
(161, 1, 'opencart/admin/model/report/sale.php'),
(162, 1, 'opencart/admin/view'),
(163, 1, 'opencart/admin/view/image'),
(164, 1, 'opencart/admin/view/image/basic.png'),
(165, 1, 'opencart/admin/view/template'),
(166, 1, 'opencart/admin/view/template/captcha'),
(167, 1, 'opencart/admin/view/template/captcha/basic.twig'),
(168, 1, 'opencart/admin/view/template/currency'),
(169, 1, 'opencart/admin/view/template/currency/ecb.twig'),
(170, 1, 'opencart/admin/view/template/currency/fixer.twig'),
(171, 1, 'opencart/admin/view/template/dashboard'),
(172, 1, 'opencart/admin/view/template/dashboard/activity_form.twig'),
(173, 1, 'opencart/admin/view/template/dashboard/activity_info.twig'),
(174, 1, 'opencart/admin/view/template/dashboard/chart_form.twig'),
(175, 1, 'opencart/admin/view/template/dashboard/chart_info.twig'),
(176, 1, 'opencart/admin/view/template/dashboard/customer_form.twig'),
(177, 1, 'opencart/admin/view/template/dashboard/customer_info.twig'),
(178, 1, 'opencart/admin/view/template/dashboard/map_form.twig'),
(179, 1, 'opencart/admin/view/template/dashboard/map_info.twig'),
(180, 1, 'opencart/admin/view/template/dashboard/online_form.twig'),
(181, 1, 'opencart/admin/view/template/dashboard/online_info.twig'),
(182, 1, 'opencart/admin/view/template/dashboard/order_form.twig'),
(183, 1, 'opencart/admin/view/template/dashboard/order_info.twig'),
(184, 1, 'opencart/admin/view/template/dashboard/recent_form.twig'),
(185, 1, 'opencart/admin/view/template/dashboard/recent_info.twig'),
(186, 1, 'opencart/admin/view/template/dashboard/sale_form.twig'),
(187, 1, 'opencart/admin/view/template/dashboard/sale_info.twig'),
(188, 1, 'opencart/admin/view/template/fraud'),
(189, 1, 'opencart/admin/view/template/fraud/ip.twig'),
(190, 1, 'opencart/admin/view/template/fraud/ip_ip.twig'),
(191, 1, 'opencart/admin/view/template/module'),
(192, 1, 'opencart/admin/view/template/module/account.twig'),
(193, 1, 'opencart/admin/view/template/module/banner.twig'),
(194, 1, 'opencart/admin/view/template/module/bestseller.twig'),
(195, 1, 'opencart/admin/view/template/module/bestseller_report.twig'),
(196, 1, 'opencart/admin/view/template/module/category.twig'),
(197, 1, 'opencart/admin/view/template/module/featured.twig'),
(198, 1, 'opencart/admin/view/template/module/filter.twig'),
(199, 1, 'opencart/admin/view/template/module/html.twig'),
(200, 1, 'opencart/admin/view/template/module/information.twig'),
(201, 1, 'opencart/admin/view/template/module/latest.twig'),
(202, 1, 'opencart/admin/view/template/module/special.twig'),
(203, 1, 'opencart/admin/view/template/module/store.twig'),
(204, 1, 'opencart/admin/view/template/payment'),
(205, 1, 'opencart/admin/view/template/payment/bank_transfer.twig'),
(206, 1, 'opencart/admin/view/template/payment/cheque.twig'),
(207, 1, 'opencart/admin/view/template/payment/cod.twig'),
(208, 1, 'opencart/admin/view/template/payment/free_checkout.twig'),
(209, 1, 'opencart/admin/view/template/payment/order.twig'),
(210, 1, 'opencart/admin/view/template/report'),
(211, 1, 'opencart/admin/view/template/report/affiliate.twig'),
(212, 1, 'opencart/admin/view/template/report/affiliate_form.twig'),
(213, 1, 'opencart/admin/view/template/report/customer.twig'),
(214, 1, 'opencart/admin/view/template/report/customer_activity.twig'),
(215, 1, 'opencart/admin/view/template/report/customer_activity_form.twig'),
(216, 1, 'opencart/admin/view/template/report/customer_activity_list.twig'),
(217, 1, 'opencart/admin/view/template/report/customer_form.twig'),
(218, 1, 'opencart/admin/view/template/report/customer_list.twig'),
(219, 1, 'opencart/admin/view/template/report/customer_order.twig'),
(220, 1, 'opencart/admin/view/template/report/customer_order_form.twig'),
(221, 1, 'opencart/admin/view/template/report/customer_order_list.twig'),
(222, 1, 'opencart/admin/view/template/report/customer_reward.twig'),
(223, 1, 'opencart/admin/view/template/report/customer_reward_form.twig'),
(224, 1, 'opencart/admin/view/template/report/customer_reward_list.twig'),
(225, 1, 'opencart/admin/view/template/report/customer_search.twig'),
(226, 1, 'opencart/admin/view/template/report/customer_search_form.twig'),
(227, 1, 'opencart/admin/view/template/report/customer_search_list.twig'),
(228, 1, 'opencart/admin/view/template/report/subscription.twig'),
(229, 1, 'opencart/admin/view/template/report/subscription_form.twig'),
(230, 1, 'opencart/admin/view/template/report/subscription_list.twig'),
(231, 1, 'opencart/admin/view/template/report/customer_transaction.twig'),
(232, 1, 'opencart/admin/view/template/report/customer_transaction_form.twig'),
(233, 1, 'opencart/admin/view/template/report/customer_transaction_list.twig'),
(234, 1, 'opencart/admin/view/template/report/marketing.twig'),
(235, 1, 'opencart/admin/view/template/report/marketing_form.twig'),
(236, 1, 'opencart/admin/view/template/report/marketing_list.twig'),
(237, 1, 'opencart/admin/view/template/report/product_purchased.twig'),
(238, 1, 'opencart/admin/view/template/report/product_purchased_form.twig'),
(239, 1, 'opencart/admin/view/template/report/product_purchased_list.twig'),
(240, 1, 'opencart/admin/view/template/report/product_viewed.twig'),
(241, 1, 'opencart/admin/view/template/report/product_viewed_form.twig'),
(242, 1, 'opencart/admin/view/template/report/product_viewed_list.twig'),
(243, 1, 'opencart/admin/view/template/report/sale_coupon.twig'),
(244, 1, 'opencart/admin/view/template/report/sale_coupon_form.twig'),
(245, 1, 'opencart/admin/view/template/report/sale_coupon_list.twig'),
(246, 1, 'opencart/admin/view/template/report/sale_order.twig'),
(247, 1, 'opencart/admin/view/template/report/sale_order_form.twig'),
(248, 1, 'opencart/admin/view/template/report/sale_order_list.twig'),
(249, 1, 'opencart/admin/view/template/report/sale_return.twig'),
(250, 1, 'opencart/admin/view/template/report/sale_return_form.twig'),
(251, 1, 'opencart/admin/view/template/report/sale_return_list.twig'),
(252, 1, 'opencart/admin/view/template/report/sale_shipping.twig'),
(253, 1, 'opencart/admin/view/template/report/sale_shipping_form.twig'),
(254, 1, 'opencart/admin/view/template/report/sale_shipping_list.twig'),
(255, 1, 'opencart/admin/view/template/report/sale_tax.twig'),
(256, 1, 'opencart/admin/view/template/report/sale_tax_form.twig'),
(257, 1, 'opencart/admin/view/template/report/sale_tax_list.twig'),
(258, 1, 'opencart/admin/view/template/shipping'),
(259, 1, 'opencart/admin/view/template/shipping/flat.twig'),
(260, 1, 'opencart/admin/view/template/shipping/free.twig'),
(261, 1, 'opencart/admin/view/template/shipping/item.twig'),
(262, 1, 'opencart/admin/view/template/shipping/pickup.twig'),
(263, 1, 'opencart/admin/view/template/shipping/weight.twig'),
(264, 1, 'opencart/admin/view/template/theme'),
(265, 1, 'opencart/admin/view/template/theme/basic.twig'),
(266, 1, 'opencart/admin/view/template/total'),
(267, 1, 'opencart/admin/view/template/total/coupon.twig'),
(268, 1, 'opencart/admin/view/template/total/credit.twig'),
(269, 1, 'opencart/admin/view/template/total/handling.twig'),
(270, 1, 'opencart/admin/view/template/total/low_order_fee.twig'),
(271, 1, 'opencart/admin/view/template/total/reward.twig'),
(272, 1, 'opencart/admin/view/template/total/shipping.twig'),
(273, 1, 'opencart/admin/view/template/total/sub_total.twig'),
(274, 1, 'opencart/admin/view/template/total/tax.twig'),
(275, 1, 'opencart/admin/view/template/total/total.twig'),
(276, 1, 'opencart/catalog'),
(277, 1, 'opencart/catalog/controller'),
(278, 1, 'opencart/catalog/controller/captcha'),
(279, 1, 'opencart/catalog/controller/captcha/basic.php'),
(280, 1, 'opencart/catalog/controller/currency'),
(281, 1, 'opencart/catalog/controller/currency/ecb.php'),
(282, 1, 'opencart/catalog/controller/currency/fixer.php'),
(283, 1, 'opencart/catalog/controller/module'),
(284, 1, 'opencart/catalog/controller/module/account.php'),
(285, 1, 'opencart/catalog/controller/module/banner.php'),
(286, 1, 'opencart/catalog/controller/module/bestseller.php'),
(287, 1, 'opencart/catalog/controller/module/category.php'),
(288, 1, 'opencart/catalog/controller/module/featured.php'),
(289, 1, 'opencart/catalog/controller/module/filter.php'),
(290, 1, 'opencart/catalog/controller/module/html.php'),
(291, 1, 'opencart/catalog/controller/module/information.php'),
(292, 1, 'opencart/catalog/controller/module/latest.php'),
(293, 1, 'opencart/catalog/controller/module/special.php'),
(294, 1, 'opencart/catalog/controller/module/store.php'),
(295, 1, 'opencart/catalog/controller/payment'),
(296, 1, 'opencart/catalog/controller/payment/bank_transfer.php'),
(297, 1, 'opencart/catalog/controller/payment/cheque.php'),
(298, 1, 'opencart/catalog/controller/payment/cod.php'),
(299, 1, 'opencart/catalog/controller/payment/free_checkout.php'),
(300, 1, 'opencart/catalog/controller/total'),
(301, 1, 'opencart/catalog/controller/total/coupon.php'),
(302, 1, 'opencart/catalog/controller/total/reward.php'),
(303, 1, 'opencart/catalog/controller/total/shipping.php'),
(304, 1, 'opencart/catalog/language'),
(305, 1, 'opencart/catalog/language/de-de'),
(306, 1, 'opencart/catalog/language/de-de/module'),
(307, 1, 'opencart/catalog/language/de-de/module/featured.php'),
(308, 1, 'opencart/catalog/language/de-de/payment'),
(309, 1, 'opencart/catalog/language/de-de/payment/cod.php'),
(310, 1, 'opencart/catalog/language/en-gb'),
(311, 1, 'opencart/catalog/language/en-gb/captcha'),
(312, 1, 'opencart/catalog/language/en-gb/captcha/basic.php'),
(313, 1, 'opencart/catalog/language/en-gb/module'),
(314, 1, 'opencart/catalog/language/en-gb/module/account.php'),
(315, 1, 'opencart/catalog/language/en-gb/module/bestseller.php'),
(316, 1, 'opencart/catalog/language/en-gb/module/category.php'),
(317, 1, 'opencart/catalog/language/en-gb/module/featured.php'),
(318, 1, 'opencart/catalog/language/en-gb/module/filter.php'),
(319, 1, 'opencart/catalog/language/en-gb/module/information.php'),
(320, 1, 'opencart/catalog/language/en-gb/module/latest.php'),
(321, 1, 'opencart/catalog/language/en-gb/module/special.php'),
(322, 1, 'opencart/catalog/language/en-gb/module/store.php'),
(323, 1, 'opencart/catalog/language/en-gb/payment'),
(324, 1, 'opencart/catalog/language/en-gb/payment/bank_transfer.php'),
(325, 1, 'opencart/catalog/language/en-gb/payment/cheque.php'),
(326, 1, 'opencart/catalog/language/en-gb/payment/cod.php'),
(327, 1, 'opencart/catalog/language/en-gb/payment/free_checkout.php'),
(328, 1, 'opencart/catalog/language/en-gb/shipping'),
(329, 1, 'opencart/catalog/language/en-gb/shipping/flat.php'),
(330, 1, 'opencart/catalog/language/en-gb/shipping/free.php'),
(331, 1, 'opencart/catalog/language/en-gb/shipping/item.php'),
(332, 1, 'opencart/catalog/language/en-gb/shipping/pickup.php'),
(333, 1, 'opencart/catalog/language/en-gb/shipping/weight.php'),
(334, 1, 'opencart/catalog/language/en-gb/total'),
(335, 1, 'opencart/catalog/language/en-gb/total/coupon.php'),
(336, 1, 'opencart/catalog/language/en-gb/total/credit.php'),
(337, 1, 'opencart/catalog/language/en-gb/total/handling.php'),
(338, 1, 'opencart/catalog/language/en-gb/total/low_order_fee.php'),
(339, 1, 'opencart/catalog/language/en-gb/total/reward.php'),
(340, 1, 'opencart/catalog/language/en-gb/total/shipping.php'),
(341, 1, 'opencart/catalog/language/en-gb/total/sub_total.php'),
(342, 1, 'opencart/catalog/language/en-gb/total/total.php'),
(343, 1, 'opencart/catalog/model'),
(344, 1, 'opencart/catalog/model/fraud'),
(345, 1, 'opencart/catalog/model/fraud/ip.php'),
(346, 1, 'opencart/catalog/model/module'),
(347, 1, 'opencart/catalog/model/module/bestseller.php'),
(348, 1, 'opencart/catalog/model/module/latest.php'),
(349, 1, 'opencart/catalog/model/payment'),
(350, 1, 'opencart/catalog/model/payment/bank_transfer.php'),
(351, 1, 'opencart/catalog/model/payment/cheque.php'),
(352, 1, 'opencart/catalog/model/payment/cod.php'),
(353, 1, 'opencart/catalog/model/payment/free_checkout.php'),
(354, 1, 'opencart/catalog/model/shipping'),
(355, 1, 'opencart/catalog/model/shipping/flat.php'),
(356, 1, 'opencart/catalog/model/shipping/free.php'),
(357, 1, 'opencart/catalog/model/shipping/item.php'),
(358, 1, 'opencart/catalog/model/shipping/pickup.php'),
(359, 1, 'opencart/catalog/model/shipping/weight.php'),
(360, 1, 'opencart/catalog/model/total'),
(361, 1, 'opencart/catalog/model/total/coupon.php'),
(362, 1, 'opencart/catalog/model/total/credit.php'),
(363, 1, 'opencart/catalog/model/total/handling.php'),
(364, 1, 'opencart/catalog/model/total/low_order_fee.php'),
(365, 1, 'opencart/catalog/model/total/reward.php'),
(366, 1, 'opencart/catalog/model/total/shipping.php'),
(367, 1, 'opencart/catalog/model/total/sub_total.php'),
(368, 1, 'opencart/catalog/model/total/tax.php'),
(369, 1, 'opencart/catalog/model/total/total.php'),
(370, 1, 'opencart/catalog/view'),
(371, 1, 'opencart/catalog/view/template'),
(372, 1, 'opencart/catalog/view/template/captcha'),
(373, 1, 'opencart/catalog/view/template/captcha/basic.twig'),
(374, 1, 'opencart/catalog/view/template/module'),
(375, 1, 'opencart/catalog/view/template/module/account.twig'),
(376, 1, 'opencart/catalog/view/template/module/banner.twig'),
(377, 1, 'opencart/catalog/view/template/module/bestseller.twig'),
(378, 1, 'opencart/catalog/view/template/module/category.twig'),
(379, 1, 'opencart/catalog/view/template/module/featured.twig'),
(380, 1, 'opencart/catalog/view/template/module/filter.twig'),
(381, 1, 'opencart/catalog/view/template/module/html.twig'),
(382, 1, 'opencart/catalog/view/template/module/information.twig'),
(383, 1, 'opencart/catalog/view/template/module/latest.twig'),
(384, 1, 'opencart/catalog/view/template/module/special.twig'),
(385, 1, 'opencart/catalog/view/template/module/store.twig'),
(386, 1, 'opencart/catalog/view/template/payment'),
(387, 1, 'opencart/catalog/view/template/payment/bank_transfer.twig'),
(388, 1, 'opencart/catalog/view/template/payment/cheque.twig'),
(389, 1, 'opencart/catalog/view/template/payment/cod.twig'),
(390, 1, 'opencart/catalog/view/template/payment/free_checkout.twig'),
(391, 1, 'opencart/catalog/view/template/total'),
(392, 1, 'opencart/catalog/view/template/total/coupon.twig'),
(393, 1, 'opencart/catalog/view/template/total/reward.twig'),
(394, 1, 'opencart/catalog/view/template/total/shipping.twig'),
(395, 1, 'opencart/install.json');

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter`
--

CREATE TABLE `oc_filter` (
  `filter_id` int(11) NOT NULL,
  `filter_group_id` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_description`
--

CREATE TABLE `oc_filter_description` (
  `filter_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_group`
--

CREATE TABLE `oc_filter_group` (
  `filter_group_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_group_description`
--

CREATE TABLE `oc_filter_group_description` (
  `filter_group_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_gdpr`
--

CREATE TABLE `oc_gdpr` (
  `gdpr_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `language_id` int(11) DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_geo_zone`
--

CREATE TABLE `oc_geo_zone` (
  `geo_zone_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_geo_zone`
--

INSERT INTO `oc_geo_zone` (`geo_zone_id`, `name`, `description`) VALUES
(3, 'UK VAT Zone', 'UK VAT'),
(4, 'UK Shipping', 'UK Shipping Zones');

-- --------------------------------------------------------

--
-- Table structure for table `oc_identifier`
--

CREATE TABLE `oc_identifier` (
  `identifier_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(48) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_identifier`
--

INSERT INTO `oc_identifier` (`identifier_id`, `name`, `code`, `validation`, `status`) VALUES
(1, 'Stock Keeping Unit', 'SKU', NULL, 1),
(2, 'Universal Product Code', 'UPC', NULL, 1),
(3, 'European Article Number', 'EAN', NULL, 1),
(4, 'Japanese Article Number', 'JAN', NULL, 1),
(5, 'International Standard Book Number', 'ISBN', NULL, 1),
(6, 'Manufacturer Part Number', 'MPN', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_information`
--

CREATE TABLE `oc_information` (
  `information_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_information`
--

INSERT INTO `oc_information` (`information_id`, `sort_order`, `status`) VALUES
(1, 3, 1),
(2, 1, 1),
(3, 4, 1),
(4, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_description`
--

CREATE TABLE `oc_information_description` (
  `information_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_information_description`
--

INSERT INTO `oc_information_description` (`information_id`, `language_id`, `title`, `description`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(1, 1, 'About Us', '&lt;p&gt;\r\n	About Us&lt;/p&gt;\r\n', 'About Us', '', ''),
(2, 1, 'Terms &amp; Conditions', '&lt;p&gt;\r\n	Terms &amp;amp; Conditions&lt;/p&gt;\r\n', 'Terms &amp; Conditions', '', ''),
(3, 1, 'Privacy Policy', '&lt;p&gt;\r\n	Privacy Policy&lt;/p&gt;\r\n', 'Privacy Policy', '', ''),
(4, 1, 'Delivery Information', '&lt;p&gt;\r\n	Delivery Information&lt;/p&gt;\r\n', 'Delivery Information', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_to_layout`
--

CREATE TABLE `oc_information_to_layout` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_to_store`
--

CREATE TABLE `oc_information_to_store` (
  `information_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_information_to_store`
--

INSERT INTO `oc_information_to_store` (`information_id`, `store_id`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_language`
--

CREATE TABLE `oc_language` (
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_language`
--

INSERT INTO `oc_language` (`language_id`, `name`, `code`, `locale`, `extension`, `sort_order`, `status`) VALUES
(1, 'English', 'en-gb', 'en-gb,en', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout`
--

CREATE TABLE `oc_layout` (
  `layout_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_layout`
--

INSERT INTO `oc_layout` (`layout_id`, `name`) VALUES
(1, 'Home'),
(2, 'Product'),
(3, 'Category'),
(4, 'Default'),
(5, 'Manufacturer'),
(6, 'Account'),
(7, 'Checkout'),
(8, 'Contact'),
(9, 'Sitemap'),
(10, 'Affiliate'),
(11, 'Information'),
(12, 'Compare'),
(13, 'Search'),
(14, 'Blog');

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout_module`
--

CREATE TABLE `oc_layout_module` (
  `layout_module_id` int(11) NOT NULL,
  `layout_id` int(11) DEFAULT 0,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_layout_module`
--

INSERT INTO `oc_layout_module` (`layout_module_id`, `layout_id`, `code`, `position`, `sort_order`) VALUES
(1, 10, 'opencart.account', 'column_right', 1),
(2, 6, 'opencart.account', 'column_right', 1),
(9, 3, 'opencart.category', 'column_left', 1),
(15, 1, 'opencart.banner.3', 'content_top', 0),
(16, 1, 'opencart.featured.2', 'content_top', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout_route`
--

CREATE TABLE `oc_layout_route` (
  `layout_route_id` int(11) NOT NULL,
  `layout_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `route` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_layout_route`
--

INSERT INTO `oc_layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(1, 6, 0, 'account/%'),
(2, 6, 0, 'information/gdpr'),
(3, 10, 0, 'affiliate/%'),
(6, 2, 0, 'product/product'),
(7, 11, 0, 'information/information'),
(8, 7, 0, 'checkout/%'),
(9, 8, 0, 'information/contact'),
(10, 9, 0, 'information/sitemap'),
(11, 4, 0, ''),
(12, 5, 0, 'product/manufacturer'),
(13, 12, 0, 'product/compare'),
(14, 13, 0, 'product/search'),
(15, 14, 0, 'cms/blog'),
(16, 14, 0, 'cms/blog.info'),
(17, 3, 0, 'product/category'),
(20, 1, 0, 'common/home');

-- --------------------------------------------------------

--
-- Table structure for table `oc_length_class`
--

CREATE TABLE `oc_length_class` (
  `length_class_id` int(11) NOT NULL,
  `value` decimal(15,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_length_class`
--

INSERT INTO `oc_length_class` (`length_class_id`, `value`) VALUES
(1, 1.00000000),
(2, 10.00000000),
(3, 0.39370000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_length_class_description`
--

CREATE TABLE `oc_length_class_description` (
  `length_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_length_class_description`
--

INSERT INTO `oc_length_class_description` (`length_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'Centimeter', 'cm'),
(2, 1, 'Millimeter', 'mm'),
(3, 1, 'Inch', 'in');

-- --------------------------------------------------------

--
-- Table structure for table `oc_location`
--

CREATE TABLE `oc_location` (
  `location_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `geocode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `open` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_manufacturer`
--

CREATE TABLE `oc_manufacturer` (
  `manufacturer_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_manufacturer`
--

INSERT INTO `oc_manufacturer` (`manufacturer_id`, `name`, `image`, `sort_order`) VALUES
(5, 'HTC', 'catalog/demo/htc_logo.jpg', 0),
(6, 'Palm', 'catalog/demo/palm_logo.jpg', 0),
(7, 'Hewlett-Packard', 'catalog/demo/hp_logo.jpg', 0),
(8, 'Apple', 'catalog/demo/apple_logo.jpg', 0),
(9, 'Canon', 'catalog/demo/canon_logo.jpg', 0),
(10, 'Sony', 'catalog/demo/sony_logo.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_manufacturer_to_layout`
--

CREATE TABLE `oc_manufacturer_to_layout` (
  `manufacturer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_manufacturer_to_store`
--

CREATE TABLE `oc_manufacturer_to_store` (
  `manufacturer_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_manufacturer_to_store`
--

INSERT INTO `oc_manufacturer_to_store` (`manufacturer_id`, `store_id`) VALUES
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_marketing`
--

CREATE TABLE `oc_marketing` (
  `marketing_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clicks` int(11) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_marketing_report`
--

CREATE TABLE `oc_marketing_report` (
  `marketing_report_id` int(11) NOT NULL,
  `marketing_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_modification`
--

CREATE TABLE `oc_modification` (
  `modification_id` int(11) NOT NULL,
  `extension_install_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `xml` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_module`
--

CREATE TABLE `oc_module` (
  `module_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `setting` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_notification`
--

CREATE TABLE `oc_notification` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_option`
--

CREATE TABLE `oc_option` (
  `option_id` int(11) NOT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_option`
--

INSERT INTO `oc_option` (`option_id`, `type`, `validation`, `sort_order`) VALUES
(1, 'radio', NULL, 1),
(2, 'checkbox', NULL, 2),
(4, 'text', '', 3),
(5, 'select', NULL, 4),
(6, 'textarea', '', 5),
(7, 'file', NULL, 6),
(8, 'date', NULL, 7),
(9, 'time', NULL, 8),
(10, 'datetime', NULL, 9),
(11, 'radio', '', 1),
(12, 'date', '', 110);

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_description`
--

CREATE TABLE `oc_option_description` (
  `option_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_option_description`
--

INSERT INTO `oc_option_description` (`option_id`, `language_id`, `name`) VALUES
(1, 1, 'Radio'),
(2, 1, 'Checkbox'),
(4, 1, 'Wrapping Text'),
(5, 1, 'Select'),
(6, 1, 'Wrapping Message'),
(7, 1, 'File'),
(8, 1, 'Date'),
(9, 1, 'Time'),
(10, 1, 'Date &amp; Time'),
(11, 1, 'SIZE'),
(12, 1, 'Delivery Date');

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_value`
--

CREATE TABLE `oc_option_value` (
  `option_value_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_option_value`
--

INSERT INTO `oc_option_value` (`option_value_id`, `option_id`, `image`, `sort_order`) VALUES
(23, 2, '', 1),
(24, 2, '', 2),
(31, 1, '', 2),
(32, 1, '', 1),
(39, 5, '', 1),
(40, 5, '', 2),
(41, 5, '', 3),
(42, 5, '', 4),
(43, 1, '', 3),
(44, 2, '', 3),
(45, 2, '', 4),
(46, 11, '', 1),
(47, 11, '', 2),
(48, 11, '', 3),
(49, 11, '', 4),
(50, 11, '', 5);

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_value_description`
--

CREATE TABLE `oc_option_value_description` (
  `option_value_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_option_value_description`
--

INSERT INTO `oc_option_value_description` (`option_value_id`, `language_id`, `option_id`, `name`) VALUES
(23, 1, 2, 'Checkbox 1'),
(24, 1, 2, 'Checkbox 2'),
(31, 1, 1, 'Medium'),
(32, 1, 1, 'Small'),
(39, 1, 5, 'Red'),
(40, 1, 5, 'Blue'),
(41, 1, 5, 'Green'),
(42, 1, 5, 'Yellow'),
(43, 1, 1, 'Large'),
(44, 1, 2, 'Checkbox 3'),
(45, 1, 2, 'Checkbox 4'),
(46, 1, 11, '20 STEMS'),
(47, 1, 11, '30 STEMS'),
(48, 1, 11, '50 STEMS'),
(49, 1, 11, '70 STEMS'),
(50, 1, 11, '100 STEMS');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order`
--

CREATE TABLE `oc_order` (
  `order_id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT 0,
  `invoice_no` int(11) DEFAULT 0,
  `invoice_prefix` varchar(26) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `store_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT 0,
  `customer_group_id` int(11) DEFAULT 0,
  `firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_address_id` int(11) DEFAULT 0,
  `payment_firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_company` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_address_1` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_address_2` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_country` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_country_id` int(11) DEFAULT 0,
  `payment_zone` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_zone_id` int(11) DEFAULT 0,
  `payment_address_format` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_id` int(11) DEFAULT NULL,
  `shipping_firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_company` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_1` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_2` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_city` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_country_id` int(11) DEFAULT 0,
  `shipping_zone` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_zone_id` int(11) DEFAULT 0,
  `shipping_address_format` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_custom_field` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(15,4) DEFAULT 0.0000,
  `order_status_id` int(11) DEFAULT 0,
  `affiliate_id` int(11) DEFAULT 0,
  `commission` decimal(15,4) DEFAULT NULL,
  `marketing_id` int(11) DEFAULT 0,
  `tracking` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `language_code` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_value` decimal(15,8) DEFAULT 1.00000000,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forwarded_ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accept_language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order`
--

INSERT INTO `oc_order` (`order_id`, `subscription_id`, `invoice_no`, `invoice_prefix`, `transaction_id`, `store_id`, `store_name`, `store_url`, `customer_id`, `customer_group_id`, `firstname`, `lastname`, `email`, `telephone`, `custom_field`, `payment_address_id`, `payment_firstname`, `payment_lastname`, `payment_company`, `payment_address_1`, `payment_address_2`, `payment_city`, `payment_postcode`, `payment_country`, `payment_country_id`, `payment_zone`, `payment_zone_id`, `payment_address_format`, `payment_custom_field`, `payment_method`, `shipping_address_id`, `shipping_firstname`, `shipping_lastname`, `shipping_company`, `shipping_address_1`, `shipping_address_2`, `shipping_city`, `shipping_postcode`, `shipping_country`, `shipping_country_id`, `shipping_zone`, `shipping_zone_id`, `shipping_address_format`, `shipping_custom_field`, `shipping_method`, `comment`, `total`, `order_status_id`, `affiliate_id`, `commission`, `marketing_id`, `tracking`, `language_id`, `language_code`, `currency_id`, `currency_code`, `currency_value`, `ip`, `forwarded_ip`, `user_agent`, `accept_language`, `date_added`, `date_modified`) VALUES
(1, 0, 0, 'INV-2025-00', NULL, 0, 'Your Store', 'https://renkrenk.com.tr/staging/', 1, 1, 'saqib', 'Ashraf', 'linktosaqib@gmail.com', '', '[]', 0, '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '{\"code\":\"free_checkout.free_checkout\",\"name\":\"Free Checkout\"}', 0, '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 0.0000, 1, 0, 0.0000, 0, '', 1, 'en-gb', 2, 'USD', 1.00000000, '182.185.136.225', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'en-US,en;q=0.9,pt;q=0.8,ur;q=0.7,fr;q=0.6', '2025-12-01 17:24:02', '2025-12-01 17:24:02'),
(2, 0, 0, 'INV-2025-00', NULL, 0, 'Your Store', 'https://renkrenk.com.tr/staging/', 1, 1, 'saqib', 'Ashraf', 'linktosaqib@gmail.com', '', '[]', 0, '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '{\"code\":\"cod.cod\",\"name\":\"Cash On Delivery\"}', 1, 'saqib', 'ashraf', '', 'hs 194 Al hafeez garden phase 1 manawan', '', '', '54000', 'Adana', 264, 'Ceyhan', 4791, '', '[]', '{\"code\":\"flat.flat\",\"name\":\"Flat Shipping Rate\",\"cost\":\"5.00\",\"tax_class_id\":\"9\",\"text\":\"$5.00\"}', '', 195.0000, 5, 0, 0.0000, 0, '', 1, 'en-gb', 2, 'USD', 1.00000000, '182.185.136.247', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'en-US,en;q=0.9,pt;q=0.8,ur;q=0.7,fr;q=0.6', '2025-12-10 12:56:44', '2025-12-10 12:56:44');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_history`
--

CREATE TABLE `oc_order_history` (
  `order_history_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `order_status_id` int(11) DEFAULT 0,
  `notify` tinyint(1) DEFAULT 0,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order_history`
--

INSERT INTO `oc_order_history` (`order_history_id`, `order_id`, `order_status_id`, `notify`, `comment`, `date_added`) VALUES
(1, 1, 1, 0, '', '2025-12-01 17:24:05'),
(2, 2, 5, 0, '', '2025-12-10 13:15:15');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_option`
--

CREATE TABLE `oc_order_option` (
  `order_option_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `order_product_id` int(11) DEFAULT NULL,
  `product_option_id` int(11) DEFAULT NULL,
  `product_option_value_id` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_product`
--

CREATE TABLE `oc_order_product` (
  `order_product_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `master_id` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(15,4) DEFAULT 0.0000,
  `total` decimal(15,4) DEFAULT 0.0000,
  `tax` decimal(15,4) DEFAULT 0.0000,
  `reward` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order_product`
--

INSERT INTO `oc_order_product` (`order_product_id`, `order_id`, `product_id`, `master_id`, `name`, `model`, `quantity`, `price`, `total`, `tax`, `reward`) VALUES
(1, 1, 0, 0, '', '', 1, 0.0000, 0.0000, 0.0000, 0),
(2, 2, 0, 0, '', '', 1, 90.0000, 90.0000, 0.0000, 0),
(3, 2, 47, 0, 'HP LP3065', 'Product 21', 1, 100.0000, 100.0000, 0.0000, 300);

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_status`
--

CREATE TABLE `oc_order_status` (
  `order_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order_status`
--

INSERT INTO `oc_order_status` (`order_status_id`, `language_id`, `name`) VALUES
(1, 1, 'Pending'),
(2, 1, 'Processing'),
(3, 1, 'Shipped'),
(5, 1, 'Complete'),
(7, 1, 'Canceled'),
(8, 1, 'Denied'),
(9, 1, 'Canceled Reversal'),
(10, 1, 'Failed'),
(11, 1, 'Refunded'),
(12, 1, 'Reversed'),
(13, 1, 'Chargeback'),
(14, 1, 'Expired'),
(15, 1, 'Processed'),
(16, 1, 'Voided');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_subscription`
--

CREATE TABLE `oc_order_subscription` (
  `order_subscription_id` int(11) NOT NULL,
  `order_product_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `subscription_plan_id` int(11) DEFAULT NULL,
  `subscription_plan_frequency_id` int(11) DEFAULT 0,
  `delivery_date` datetime DEFAULT NULL,
  `is_gift` tinyint(1) DEFAULT 0,
  `gift_id` int(11) DEFAULT 0,
  `vase_id` int(11) DEFAULT 0,
  `trial_price` decimal(10,4) DEFAULT NULL,
  `trial_tax` decimal(15,4) DEFAULT NULL,
  `trial_frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_cycle` smallint(6) DEFAULT NULL,
  `trial_duration` smallint(6) DEFAULT NULL,
  `trial_status` tinyint(1) DEFAULT 0,
  `price` decimal(10,4) DEFAULT NULL,
  `tax` decimal(15,4) DEFAULT NULL,
  `frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cycle` smallint(6) DEFAULT 1,
  `duration` smallint(6) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order_subscription`
--

INSERT INTO `oc_order_subscription` (`order_subscription_id`, `order_product_id`, `order_id`, `product_id`, `quantity`, `subscription_plan_id`, `subscription_plan_frequency_id`, `delivery_date`, `is_gift`, `gift_id`, `vase_id`, `trial_price`, `trial_tax`, `trial_frequency`, `trial_cycle`, `trial_duration`, `trial_status`, `price`, `tax`, `frequency`, `cycle`, `duration`) VALUES
(1, 1, 1, 0, 1, 1, 24, '2025-12-27 00:00:00', 1, 0, 0, 0.0000, 0.0000, 'day', 0, 0, 0, 0.0000, 0.0000, 'day', 1, 0),
(2, 2, 2, 0, 1, 3, 32, '2025-12-31 00:00:00', 1, 47, 0, 0.0000, 0.0000, 'day', 0, 0, 0, 90.0000, 0.0000, 'day', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_total`
--

CREATE TABLE `oc_order_total` (
  `order_total_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(15,4) DEFAULT 0.0000,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_order_total`
--

INSERT INTO `oc_order_total` (`order_total_id`, `order_id`, `extension`, `code`, `title`, `value`, `sort_order`) VALUES
(1, 1, 'opencart', 'sub_total', 'Sub-Total', 0.0000, 1),
(2, 1, 'opencart', 'total', 'Total', 0.0000, 9),
(3, 2, 'opencart', 'sub_total', 'Sub-Total', 190.0000, 1),
(4, 2, 'opencart', 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(5, 2, 'opencart', 'total', 'Total', 195.0000, 9);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product`
--

CREATE TABLE `oc_product` (
  `product_id` int(11) NOT NULL,
  `master_id` int(11) DEFAULT 0,
  `model` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upc` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ean` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `jan` varchar(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isbn` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mpn` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `override` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `stock_status_id` int(11) DEFAULT 0,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT 0,
  `shipping` tinyint(1) DEFAULT 1,
  `price` decimal(15,4) DEFAULT 0.0000,
  `points` int(11) DEFAULT 0,
  `tax_class_id` int(11) DEFAULT 0,
  `date_available` date DEFAULT NULL,
  `weight` decimal(15,8) DEFAULT 0.00000000,
  `weight_class_id` int(11) DEFAULT 0,
  `length` decimal(15,8) DEFAULT 0.00000000,
  `width` decimal(15,8) DEFAULT 0.00000000,
  `height` decimal(15,8) DEFAULT 0.00000000,
  `length_class_id` int(11) DEFAULT 0,
  `subtract` tinyint(1) DEFAULT 1,
  `minimum` int(11) DEFAULT 1,
  `rating` int(11) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product`
--

INSERT INTO `oc_product` (`product_id`, `master_id`, `model`, `sku`, `upc`, `ean`, `jan`, `isbn`, `mpn`, `location`, `variant`, `override`, `quantity`, `stock_status_id`, `image`, `manufacturer_id`, `shipping`, `price`, `points`, `tax_class_id`, `date_available`, `weight`, `weight_class_id`, `length`, `width`, `height`, `length_class_id`, `subtract`, `minimum`, `rating`, `sort_order`, `status`, `date_added`, `date_modified`) VALUES
(28, 0, 'Product 1', '', '', '', '', '', '', '', '', '', 939, 7, 'catalog/rose_orange_naranga_rose_vase_2.webp', 5, 1, 100.0000, 200, 9, '2009-02-03', 146.40000000, 2, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 16:06:50', '2025-12-05 11:11:27'),
(29, 0, 'Product 2', '', '', '', '', '', '', '', '', '', 999, 6, 'catalog/demo/palm_treo_pro_1.jpg', 6, 1, 279.9900, 0, 9, '2009-02-03', 133.00000000, 2, 0.00000000, 0.00000000, 0.00000000, 3, 1, 1, 0, 0, 1, '2009-02-03 16:42:17', '2011-09-30 01:06:08'),
(30, 0, 'Product 3', '', '', '', '', '', '', '', '', '', 7, 6, 'catalog/demo/canon_eos_5d_1.jpg', 9, 1, 100.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 16:59:00', '2011-09-30 01:05:23'),
(31, 0, 'Product 4', '', '', '', '', '', '', '', '', '', 1000, 6, 'catalog/demo/nikon_d300_1.jpg', 0, 1, 80.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 3, 1, 1, 0, 0, 1, '2009-02-03 17:00:10', '2011-09-30 01:06:00'),
(32, 0, 'Product 5', '', '', '', '', '', '', '', '', '', 999, 6, 'catalog/demo/ipod_touch_1.jpg', 8, 1, 100.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 17:07:26', '2011-09-30 01:07:22'),
(33, 0, 'Product 6', '', '', '', '', '', '', '', '', '', 1000, 6, 'catalog/demo/samsung_syncmaster_941bw.jpg', 0, 1, 200.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 17:08:31', '2011-09-30 01:06:29'),
(34, 0, 'Product 7', '', '', '', '', '', '', '', '', '', 1000, 6, 'catalog/demo/ipod_shuffle_1.jpg', 8, 1, 100.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 18:07:54', '2011-09-30 01:07:17'),
(35, 0, 'Product 8', '', '', '', '', '', '', '', '', '', 1000, 5, '', 0, 0, 100.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 18:08:31', '2011-09-30 01:06:17'),
(36, 0, 'Product 9', '', '', '', '', '', '', '', '', '', 994, 6, 'catalog/rose_peach_avalanche_rose_stem_9.webp', 8, 0, 100.0000, 100, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 18:09:19', '2026-01-14 14:09:54'),
(40, 0, 'product 11', '', '', '', '', '', '', '', '', '', 970, 5, 'catalog/demo/iphone_1.jpg', 8, 1, 101.0000, 0, 9, '2009-02-03', 10.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 21:07:12', '2011-09-30 01:06:53'),
(41, 0, 'Product 14', '', '', '', '', '', '', '', '', '', 977, 5, 'catalog/demo/imac_1.jpg', 8, 1, 100.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 0, 1, '2009-02-03 21:07:26', '2011-09-30 01:06:44'),
(42, 0, 'Product 15', '', '', '', '', '', '', '', '', '', 990, 5, 'catalog/demo/apple_cinema_30.jpg', 8, 1, 100.0000, 400, 9, '2009-02-04', 12.50000000, 1, 1.00000000, 2.00000000, 3.00000000, 1, 1, 2, 0, 0, 1, '2009-02-03 21:07:37', '2011-09-30 00:46:19'),
(43, 0, 'Product 16', '', '', '', '', '', '', '', '', '', 929, 5, 'catalog/demo/macbook_1.jpg', 8, 0, 500.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 21:07:49', '2011-09-30 01:05:46'),
(44, 0, 'Product 17', '', '', '', '', '', '', '', '', '', 1000, 5, 'catalog/demo/macbook_air_1.jpg', 8, 1, 1000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 21:08:00', '2011-09-30 01:05:53'),
(45, 0, 'Product 18', '', '', '', '', '', '', '', '', '', 998, 5, 'catalog/demo/macbook_pro_1.jpg', 8, 1, 2000.0000, 0, 100, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 21:08:17', '2011-09-15 22:22:01'),
(46, 0, 'Product 19', '', '', '', '', '', '', '', '', '', 1000, 5, 'catalog/demo/sony_vaio_1.jpg', 10, 1, 1000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-03 21:08:29', '2011-09-30 01:06:39'),
(47, 0, 'Product 21', '', '', '', '', '', '', '', '', '', 1000, 5, 'catalog/demo/hp_1.jpg', 7, 1, 100.0000, 400, 9, '2009-02-03', 1.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 0, 1, 0, 0, 1, '2009-02-03 21:08:40', '2025-11-19 10:39:30'),
(48, 0, 'product 20', 'test 1', '', '', '', '', '', 'test 2', '', '', 995, 5, 'catalog/demo/ipod_classic_1.jpg', 8, 1, 100.0000, 0, 9, '2009-02-08', 1.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 0, 1, '2009-02-08 17:21:51', '2011-09-30 01:07:06'),
(49, 0, 'SAM1', '', '', '', '', '', '', '', '', '', 0, 8, 'catalog/demo/samsung_tab_1.jpg', 0, 1, 199.9900, 0, 9, '2011-04-25', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 1, '2011-04-26 08:57:34', '2011-09-30 01:06:23'),
(50, 0, 'Mini Trio Candle Set', NULL, NULL, NULL, NULL, NULL, NULL, '', '', '', 1, 6, 'catalog/dataentry/canldes.webp', 0, 1, 95.0000, 0, 0, '2026-01-16', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 1, '2026-01-16 11:30:03', '2026-01-16 11:30:32');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_attribute`
--

CREATE TABLE `oc_product_attribute` (
  `product_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_attribute`
--

INSERT INTO `oc_product_attribute` (`product_id`, `attribute_id`, `language_id`, `text`) VALUES
(42, 3, 1, '100mhz'),
(43, 2, 1, '1'),
(43, 4, 1, '8gb'),
(47, 2, 1, '4'),
(47, 4, 1, '16GB');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_code`
--

CREATE TABLE `oc_product_code` (
  `product_code_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `code` varchar(48) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_description`
--

CREATE TABLE `oc_product_description` (
  `product_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `care` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_description`
--

INSERT INTO `oc_product_description` (`product_id`, `language_id`, `name`, `description`, `short_description`, `size`, `care`, `delivery`, `tag`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(28, 1, 'Red Rose', '&lt;p&gt;HTC Touch - in High Definition. Watch music videos and streaming content in awe-inspiring high definition clarity for a mobile experience you never thought possible. Seductively sleek, the HTC Touch HD provides the next generation of mobile functionality, all at a simple touch. Fully integrated with Windows Mobile Professional 6.1, ultrafast 3.5G, GPS, 5MP camera, plus lots more - all delivered on a breathtakingly crisp 3.8&quot; WVGA touchscreen - you can take control of your mobile world with the HTC Touch HD.&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;strong&gt;Features&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;ul&gt;\r\n	&lt;li&gt;Processor Qualcomm® MSM 7201A™ 528 MHz&lt;/li&gt;\r\n	&lt;li&gt;Windows Mobile® 6.1 Professional Operating System&lt;/li&gt;\r\n	&lt;li&gt;Memory: 512 MB ROM, 288 MB RAM&lt;/li&gt;\r\n	&lt;li&gt;Dimensions: 115 mm x 62.8 mm x 12 mm / 146.4 grams&lt;/li&gt;\r\n	&lt;li&gt;3.8-inch TFT-LCD flat touch-sensitive screen with 480 x 800 WVGA resolution&lt;/li&gt;\r\n	&lt;li&gt;HSDPA/WCDMA: Europe/Asia: 900/2100 MHz; Up to 2 Mbps up-link and 7.2 Mbps down-link speeds&lt;/li&gt;\r\n	&lt;li&gt;Quad-band GSM/GPRS/EDGE: Europe/Asia: 850/900/1800/1900 MHz (Band frequency, HSUPA availability, and data speed are operator dependent.)&lt;/li&gt;\r\n	&lt;li&gt;Device Control via HTC TouchFLO™ 3D &amp;amp; Touch-sensitive front panel buttons&lt;/li&gt;\r\n	&lt;li&gt;GPS and A-GPS ready&lt;/li&gt;\r\n	&lt;li&gt;Bluetooth® 2.0 with Enhanced Data Rate and A2DP for wireless stereo headsets&lt;/li&gt;\r\n	&lt;li&gt;Wi-Fi®: IEEE 802.11 b/g&lt;/li&gt;\r\n	&lt;li&gt;HTC ExtUSB™ (11-pin mini-USB 2.0)&lt;/li&gt;\r\n	&lt;li&gt;5 megapixel color camera with auto focus&lt;/li&gt;\r\n	&lt;li&gt;VGA CMOS color camera&lt;/li&gt;\r\n	&lt;li&gt;Built-in 3.5 mm audio jack, microphone, speaker, and FM radio&lt;/li&gt;\r\n	&lt;li&gt;Ring tone formats: AAC, AAC+, eAAC+, AMR-NB, AMR-WB, QCP, MP3, WMA, WAV&lt;/li&gt;\r\n	&lt;li&gt;40 polyphonic and standard MIDI format 0 and 1 (SMF)/SP MIDI&lt;/li&gt;\r\n	&lt;li&gt;Rechargeable Lithium-ion or Lithium-ion polymer 1350 mAh battery&lt;/li&gt;\r\n	&lt;li&gt;Expansion Slot: microSD™ memory card (SD 2.0 compatible)&lt;/li&gt;\r\n	&lt;li&gt;AC Adapter Voltage range/frequency: 100 ~ 240V AC, 50/60 Hz DC output: 5V and 1A&lt;/li&gt;\r\n	&lt;li&gt;Special Features: FM Radio, G-Sensor&lt;/li&gt;\r\n&lt;/ul&gt;', NULL, NULL, NULL, NULL, '', 'HTC Touch HD', '', ''),
(29, 1, 'Palm Treo Pro', '&lt;p&gt;\r\n	Redefine your workday with the Palm Treo Pro smartphone. Perfectly balanced, you can respond to business and personal email, stay on top of appointments and contacts, and use Wi-Fi or GPS when you&amp;rsquo;re out and about. Then watch a video on YouTube, catch up with news and sports on the web, or listen to a few songs. Balance your work and play the way you like it, with the Palm Treo Pro.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Features&lt;/strong&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Windows Mobile&amp;reg; 6.1 Professional Edition&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Qualcomm&amp;reg; MSM7201 400MHz Processor&lt;/li&gt;\r\n	&lt;li&gt;\r\n		320x320 transflective colour TFT touchscreen&lt;/li&gt;\r\n	&lt;li&gt;\r\n		HSDPA/UMTS/EDGE/GPRS/GSM radio&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Tri-band UMTS &amp;mdash; 850MHz, 1900MHz, 2100MHz&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Quad-band GSM &amp;mdash; 850/900/1800/1900&lt;/li&gt;\r\n	&lt;li&gt;\r\n		802.11b/g with WPA, WPA2, and 801.1x authentication&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Built-in GPS&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Bluetooth Version: 2.0 + Enhanced Data Rate&lt;/li&gt;\r\n	&lt;li&gt;\r\n		256MB storage (100MB user available), 128MB RAM&lt;/li&gt;\r\n	&lt;li&gt;\r\n		2.0 megapixel camera, up to 8x digital zoom and video capture&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Removable, rechargeable 1500mAh lithium-ion battery&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Up to 5.0 hours talk time and up to 250 hours standby&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MicroSDHC card expansion (up to 32GB supported)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MicroUSB 2.0 for synchronization and charging&lt;/li&gt;\r\n	&lt;li&gt;\r\n		3.5mm stereo headset jack&lt;/li&gt;\r\n	&lt;li&gt;\r\n		60mm (W) x 114mm (L) x 13.5mm (D) / 133g&lt;/li&gt;\r\n&lt;/ul&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Palm Treo Pro', '', ''),
(30, 1, 'Canon EOS 5D', '&lt;p&gt;\r\n	Canon\'s press material for the EOS 5D states that it \'defines (a) new D-SLR category\', while we\'re not typically too concerned with marketing talk this particular statement is clearly pretty accurate. The EOS 5D is unlike any previous digital SLR in that it combines a full-frame (35 mm sized) high resolution sensor (12.8 megapixels) with a relatively compact body (slightly larger than the EOS 20D, although in your hand it feels noticeably \'chunkier\'). The EOS 5D is aimed to slot in between the EOS 20D and the EOS-1D professional digital SLR\'s, an important difference when compared to the latter is that the EOS 5D doesn\'t have any environmental seals. While Canon don\'t specifically refer to the EOS 5D as a \'professional\' digital SLR it will have obvious appeal to professionals who want a high quality digital SLR in a body lighter than the EOS-1D. It will also no doubt appeal to current EOS 20D owners (although lets hope they\'ve not bought too many EF-S lenses...) äë&lt;/p&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Canon EOS 5D', '', ''),
(31, 1, 'Nikon D300', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		Engineered with pro-level features and performance, the 12.3-effective-megapixel D300 combines brand new technologies with advanced features inherited from Nikon&amp;#39;s newly announced D3 professional digital SLR camera to offer serious photographers remarkable performance combined with agility.&lt;br /&gt;\r\n		&lt;br /&gt;\r\n		Similar to the D3, the D300 features Nikon&amp;#39;s exclusive EXPEED Image Processing System that is central to driving the speed and processing power needed for many of the camera&amp;#39;s new features. The D300 features a new 51-point autofocus system with Nikon&amp;#39;s 3D Focus Tracking feature and two new LiveView shooting modes that allow users to frame a photograph using the camera&amp;#39;s high-resolution LCD monitor. The D300 shares a similar Scene Recognition System as is found in the D3; it promises to greatly enhance the accuracy of autofocus, autoexposure, and auto white balance by recognizing the subject or scene being photographed and applying this information to the calculations for the three functions.&lt;br /&gt;\r\n		&lt;br /&gt;\r\n		The D300 reacts with lightning speed, powering up in a mere 0.13 seconds and shooting with an imperceptible 45-millisecond shutter release lag time. The D300 is capable of shooting at a rapid six frames per second and can go as fast as eight frames per second when using the optional MB-D10 multi-power battery pack. In continuous bursts, the D300 can shoot up to 100 shots at full 12.3-megapixel resolution. (NORMAL-LARGE image setting, using a SanDisk Extreme IV 1GB CompactFlash card.)&lt;br /&gt;\r\n		&lt;br /&gt;\r\n		The D300 incorporates a range of innovative technologies and features that will significantly improve the accuracy, control, and performance photographers can get from their equipment. Its new Scene Recognition System advances the use of Nikon&amp;#39;s acclaimed 1,005-segment sensor to recognize colors and light patterns that help the camera determine the subject and the type of scene being photographed before a picture is taken. This information is used to improve the accuracy of autofocus, autoexposure, and auto white balance functions in the D300. For example, the camera can track moving subjects better and by identifying them, it can also automatically select focus points faster and with greater accuracy. It can also analyze highlights and more accurately determine exposure, as well as infer light sources to deliver more accurate white balance detection.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', NULL, NULL, NULL, NULL, '', 'Nikon D300', '', ''),
(32, 1, 'iPod Touch', '&lt;p&gt;\r\n	&lt;strong&gt;Revolutionary multi-touch interface.&lt;/strong&gt;&lt;br /&gt;\r\n	iPod touch features the same multi-touch screen technology as iPhone. Pinch to zoom in on a photo. Scroll through your songs and videos with a flick. Flip through your library by album artwork with Cover Flow.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Gorgeous 3.5-inch widescreen display.&lt;/strong&gt;&lt;br /&gt;\r\n	Watch your movies, TV shows, and photos come alive with bright, vivid color on the 320-by-480-pixel display.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Music downloads straight from iTunes.&lt;/strong&gt;&lt;br /&gt;\r\n	Shop the iTunes Wi-Fi Music Store from anywhere with Wi-Fi.1 Browse or search to find the music youre looking for, preview it, and buy it with just a tap.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Surf the web with Wi-Fi.&lt;/strong&gt;&lt;br /&gt;\r\n	Browse the web using Safari and watch YouTube videos on the first iPod with Wi-Fi built in&lt;br /&gt;\r\n	&amp;nbsp;&lt;/p&gt;\r\n', NULL, NULL, NULL, NULL, '', '	 iPod Touch', '', ''),
(33, 1, 'Samsung SyncMaster 941BW', '&lt;div&gt;\r\n	Imagine the advantages of going big without slowing down. The big 19&amp;quot; 941BW monitor combines wide aspect ratio with fast pixel response time, for bigger images, more room to work and crisp motion. In addition, the exclusive MagicBright 2, MagicColor and MagicTune technologies help deliver the ideal image in every situation, while sleek, narrow bezels and adjustable stands deliver style just the way you want it. With the Samsung 941BW widescreen analog/digital LCD monitor, it&amp;#39;s not hard to imagine.&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Samsung SyncMaster 941BW', '', ''),
(34, 1, 'iPod Shuffle', '&lt;div&gt;\r\n	&lt;strong&gt;Born to be worn.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Clip on the worlds most wearable music player and take up to 240 songs with you anywhere. Choose from five colors including four new hues to make your musical fashion statement.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Random meets rhythm.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		With iTunes autofill, iPod shuffle can deliver a new musical experience every time you sync. For more randomness, you can shuffle songs during playback with the slide of a switch.&lt;/p&gt;\r\n	&lt;strong&gt;Everything is easy.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Charge and sync with the included USB dock. Operate the iPod shuffle controls with one hand. Enjoy up to 12 hours straight of skip-free music playback.&lt;/p&gt;\r\n&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'iPod Shuffle', '', ''),
(35, 1, 'Product 8', '&lt;p&gt;\r\n	Product 8&lt;/p&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Product 8', '', ''),
(36, 1, 'Peach Avalanche Rose', '&lt;div&gt;\r\n&lt;p&gt;&lt;strong&gt;Video in your pocket.&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;Its the small iPod with one very big idea: video. The worlds most popular music player now lets you enjoy movies, TV shows, and more on a two-inch display thats 65% brighter than before.&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;strong&gt;Cover Flow.&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;Browse through your music collection by flipping through album art. Select an album to turn it over and see the track list.&lt;strong&gt;&amp;nbsp;&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;strong&gt;Enhanced interface.&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;Experience a whole new way to browse and view your music and video.&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;strong&gt;Sleek and colorful.&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;With an anodized aluminum and polished stainless steel enclosure and a choice of five colors, iPod nano is dressed to impress.&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;strong&gt;iTunes.&lt;/strong&gt;&lt;/p&gt;\r\n\r\n&lt;p&gt;Available as a free download, iTunes makes it easy to browse and buy millions of songs, movies, TV shows, audiobooks, and games and download free podcasts all at the iTunes Store. And you can import your own music, manage your whole media library, and sync your iPod or iPhone with ease.&lt;/p&gt;\r\n&lt;/div&gt;', 'Bright flowered branches\r\nDry your Mimosa to enjoy their beauty for longer\r\nSymbolises strength\r\nHand-wrapped in London\r\nComplimentary gift wrapping', '&lt;p&gt;&lt;img src=&quot;https://www.flowerbx.com/media/wysiwyg/NewSilhouettes/Mimosa-55cm.jpg&quot; /&gt;&lt;/p&gt;', '&lt;p&gt;Mimosa as a cut branch and will traditionally last 3-4 days in the right conditions. After this, you can remove water from your vase, and preserve Mimosa by drying. Leave in a dry vase, or tie and hang upside down for drying results. For vase life care:&lt;/p&gt;\r\n\r\n&lt;p&gt;- Recut stems at a sharp diagonal&lt;/p&gt;\r\n\r\n&lt;p&gt;-&amp;nbsp;Split base of branch vertically about 1cm&amp;nbsp;to allow water to move more easily up the stem&lt;/p&gt;\r\n\r\n&lt;p&gt;- Remove all excess foliage which would be below the level of the water&lt;/p&gt;\r\n\r\n&lt;p&gt;-&amp;nbsp;Keep branches in a cooler area, away from direct heat, sunlight and any draughts&lt;/p&gt;\r\n\r\n&lt;p&gt;- It is crucial that you&amp;nbsp;change water regularly&lt;/p&gt;\r\n\r\n&lt;p&gt;- If stems start to drop, to try and prolong, re-cut stems with a fresh diagonal cut and add tepid water, this will help hydrate and clear any small blockages in the stems&lt;/p&gt;\r\n\r\n&lt;p&gt;*As this is a naturally occurring product, there will be a slight size and colour&amp;nbsp;variation throughout the season.&lt;/p&gt;\r\n\r\n&lt;p&gt;** Please keep away from pets as can be hazardous if swallowed&lt;/p&gt;', '&lt;p&gt;&lt;em&gt;Please note that flowers are not delivered with a vase and that the candle is not included. Discover our collection of&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/eu/home-accessories&quot;&gt;home accessories&lt;/a&gt;&amp;nbsp;to browse our signature vases and home fragrances.&lt;/em&gt;&lt;/p&gt;', '', 'iPod Nano', '', ''),
(40, 1, 'iPhone', '&lt;p class=&quot;intro&quot;&gt;\r\n	iPhone is a revolutionary new mobile phone that allows you to make a call by simply tapping a name or number in your address book, a favorites list, or a call log. It also automatically syncs all your contacts from a PC, Mac, or Internet service. And it lets you select and listen to voicemail messages in whatever order you want just like email.&lt;/p&gt;\r\n', NULL, NULL, NULL, NULL, '', 'iPhone', '', ''),
(41, 1, 'iMac', '&lt;div&gt;\r\n	Just when you thought iMac had everything, now there&acute;s even more. More powerful Intel Core 2 Duo processors. And more memory standard. Combine this with Mac OS X Leopard and iLife &acute;08, and it&acute;s more all-in-one than ever. iMac packs amazing performance into a stunningly slim space.&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'iMac', '', ''),
(42, 1, 'Apple Cinema 30&quot;', '&lt;p&gt;\r\n	&lt;font face=&quot;helvetica,geneva,arial&quot; size=&quot;2&quot;&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;The 30-inch Apple Cinema HD Display delivers an amazing 2560 x 1600 pixel resolution. Designed specifically for the creative professional, this display provides more space for easier access to all the tools and palettes needed to edit, format and composite your work. Combine this display with a Mac Pro, MacBook Pro, or PowerMac G5 and there\'s no limit to what you can achieve. &lt;br&gt;\r\n	&lt;br&gt;\r\n	&lt;/font&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;The Cinema HD features an active-matrix liquid crystal display that produces flicker-free images that deliver twice the brightness, twice the sharpness and twice the contrast ratio of a typical CRT display. Unlike other flat panels, it\'s designed with a pure digital interface to deliver distortion-free images that never need adjusting. With over 4 million digital pixels, the display is uniquely suited for scientific and technical applications such as visualizing molecular structures or analyzing geological data. &lt;br&gt;\r\n	&lt;br&gt;\r\n	&lt;/font&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;Offering accurate, brilliant color performance, the Cinema HD delivers up to 16.7 million colors across a wide gamut allowing you to see subtle nuances between colors from soft pastels to rich jewel tones. A wide viewing angle ensures uniform color from edge to edge. Apple\'s ColorSync technology allows you to create custom profiles to maintain consistent color onscreen and in print. The result: You can confidently use this display in all your color-critical applications. &lt;br&gt;\r\n	&lt;br&gt;\r\n	&lt;/font&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;Housed in a new aluminum design, the display has a very thin bezel that enhances visual accuracy. Each display features two FireWire 400 ports and two USB 2.0 ports, making attachment of desktop peripherals, such as iSight, iPod, digital and still cameras, hard drives, printers and scanners, even more accessible and convenient. Taking advantage of the much thinner and lighter footprint of an LCD, the new displays support the VESA (Video Electronics Standards Association) mounting interface standard. Customers with the optional Cinema Display VESA Mount Adapter kit gain the flexibility to mount their display in locations most appropriate for their work environment. &lt;br&gt;\r\n	&lt;br&gt;\r\n	&lt;/font&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;The Cinema HD features a single cable design with elegant breakout for the USB 2.0, FireWire 400 and a pure digital connection using the industry standard Digital Video Interface (DVI) interface. The DVI connection allows for a direct pure-digital connection.&lt;br&gt;\r\n	&lt;/font&gt;&lt;/font&gt;&lt;/p&gt;\r\n&lt;h3&gt;\r\n	Features:&lt;/h3&gt;\r\n&lt;p&gt;\r\n	Unrivaled display performance&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch (viewable) active-matrix liquid crystal display provides breathtaking image quality and vivid, richly saturated color.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for 2560-by-1600 pixel resolution for display of high definition still and video imagery.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Wide-format design for simultaneous display of two full pages of text and graphics.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Industry standard DVI connector for direct attachment to Mac- and Windows-based desktops and notebooks&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Incredibly wide (170 degree) horizontal and vertical viewing angle for maximum visibility and color performance.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Lightning-fast pixel response for full-motion digital video playback.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for 16.7 million saturated colors, for use in all graphics-intensive applications.&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Simple setup and operation&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Single cable with elegant breakout for connection to DVI, USB and FireWire ports&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Built-in two-port USB 2.0 hub for easy connection of desktop peripheral devices.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Two FireWire 400 ports to support iSight and other desktop peripherals&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Sleek, elegant design&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Huge virtual workspace, very small footprint.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Narrow Bezel design to minimize visual impact of using dual displays&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Unique hinge design for effortless adjustment&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for VESA mounting solutions (Apple Cinema Display VESA Mount Adapter sold separately)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;h3&gt;\r\n	Technical specifications&lt;/h3&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen size (diagonal viewable image size)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Apple Cinema HD Display: 30 inches (29.7-inch viewable)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen type&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Thin film transistor (TFT) active-matrix liquid crystal display (AMLCD)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Resolutions&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		2560 x 1600 pixels (optimum resolution)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		2048 x 1280&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1920 x 1200&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1280 x 800&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1024 x 640&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Display colors (maximum)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		16.7 million&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Viewing angle (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		170° horizontal; 170° vertical&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Brightness (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch Cinema HD Display: 400 cd/m2&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Contrast ratio (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		700:1&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Response time (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		16 ms&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Pixel pitch&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch Cinema HD Display: 0.250 mm&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen treatment&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Antiglare hardcoat&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;User controls (hardware and software)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Display Power,&lt;/li&gt;\r\n	&lt;li&gt;\r\n		System sleep, wake&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Brightness&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Monitor tilt&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Connectors and cables&lt;/b&gt;&lt;br&gt;\r\n	Cable&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		DVI (Digital Visual Interface)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		FireWire 400&lt;/li&gt;\r\n	&lt;li&gt;\r\n		USB 2.0&lt;/li&gt;\r\n	&lt;li&gt;\r\n		DC power (24 V)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Connectors&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Two-port, self-powered USB 2.0 hub&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Two FireWire 400 ports&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Kensington security port&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;VESA mount adapter&lt;/b&gt;&lt;br&gt;\r\n	Requires optional Cinema Display VESA Mount Adapter (M9649G/A)&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Compatible with VESA FDMI (MIS-D, 100, C) compliant mounting solutions&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Electrical requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Input voltage: 100-240 VAC 50-60Hz&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Maximum power when operating: 150W&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Energy saver mode: 3W or less&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Environmental requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Operating temperature: 50° to 95° F (10° to 35° C)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Storage temperature: -40° to 116° F (-40° to 47° C)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Operating humidity: 20% to 80% noncondensing&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Maximum operating altitude: 10,000 feet&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Agency approvals&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		FCC Part 15 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN55022 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN55024&lt;/li&gt;\r\n	&lt;li&gt;\r\n		VCCI Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		AS/NZS 3548 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		CNS 13438 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ICES-003 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ISO 13406 part 2&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MPR II&lt;/li&gt;\r\n	&lt;li&gt;\r\n		IEC 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		UL 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		CSA 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ENERGY STAR&lt;/li&gt;\r\n	&lt;li&gt;\r\n		TCO \'03&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Size and weight&lt;/b&gt;&lt;br&gt;\r\n	30-inch Apple Cinema HD Display&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Height: 21.3 inches (54.3 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Width: 27.2 inches (68.8 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Depth: 8.46 inches (21.5 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Weight: 27.5 pounds (12.5 kg)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;System Requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Mac Pro, all graphic options&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MacBook Pro&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Power Mac G5 (PCI-X) with ATI Radeon 9650 or better or NVIDIA GeForce 6800 GT DDL or better&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Power Mac G5 (PCI Express), all graphics options&lt;/li&gt;\r\n	&lt;li&gt;\r\n		PowerBook G4 with dual-link DVI support&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Windows PC and graphics card that supports DVI ports with dual-link digital bandwidth and VESA DDC standard for plug-and-play setup&lt;/li&gt;\r\n&lt;/ul&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Apple Cinema 30', '', ''),
(43, 1, 'MacBook', '&lt;div&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Intel Core 2 Duo processor&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Powered by an Intel Core 2 Duo processor at speeds up to 2.16GHz, the new MacBook is the fastest ever.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;1GB memory, larger hard drives&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		The new MacBook now comes with 1GB of memory standard and larger hard drives for the entire line perfect for running more of your favorite applications and storing growing media collections.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Sleek, 1.08-inch-thin design&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Built-in iSight camera&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Right out of the box, you can have a video chat with friends or family,2 record a video at your desk, or take fun pictures with Photo Booth&lt;/p&gt;\r\n&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'MacBook', '', ''),
(44, 1, 'MacBook Air', '&lt;div&gt;\r\n	MacBook Air is ultrathin, ultraportable, and ultra unlike anything else. But you don&amp;rsquo;t lose inches and pounds overnight. It&amp;rsquo;s the result of rethinking conventions. Of multiple wireless innovations. And of breakthrough design. With MacBook Air, mobile computing suddenly has a new standard.&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'MacBook Air', '', ''),
(45, 1, 'MacBook Pro', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Latest Intel mobile architecture&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Powered by the most advanced mobile processors from Intel, the new Core 2 Duo MacBook Pro is over 50% faster than the original Core Duo MacBook Pro and now supports up to 4GB of RAM.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Leading-edge graphics&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			The NVIDIA GeForce 8600M GT delivers exceptional graphics processing power. For the ultimate creative canvas, you can even configure the 17-inch model with a 1920-by-1200 resolution display.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Designed for life on the road&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Innovations such as a magnetic power connection and an illuminated keyboard with ambient light sensor put the MacBook Pro in a class by itself.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Connect. Create. Communicate.&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Quickly set up a video conference with the built-in iSight camera. Control presentations and media from up to 30 feet away with the included Apple Remote. Connect to high-bandwidth peripherals with FireWire 800 and DVI.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Next-generation wireless&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Featuring 802.11n wireless technology, the MacBook Pro delivers up to five times the performance and up to twice the range of previous-generation technologies.&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', NULL, NULL, NULL, NULL, '', 'MacBook Pro', '', ''),
(46, 1, 'Sony VAIO', '&lt;div&gt;\r\n	Unprecedented power. The next generation of processing technology has arrived. Built into the newest VAIO notebooks lies Intel&amp;#39;s latest, most powerful innovation yet: Intel&amp;reg; Centrino&amp;reg; 2 processor technology. Boasting incredible speed, expanded wireless connectivity, enhanced multimedia support and greater energy efficiency, all the high-performance essentials are seamlessly combined into a single chip.&lt;/div&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Sony VAIO', '', ''),
(47, 1, 'HP LP3065', '&lt;p&gt;Stop your co-workers in their tracks with the stunning new 30-inch diagonal HP LP3065 Flat Panel Monitor. This flagship monitor features best-in-class performance and presentation features on a huge wide-aspect screen while letting you work as comfortably as possible - you might even forget you\'re at the office&lt;/p&gt;', NULL, NULL, NULL, NULL, '', 'HP LP3065', '', ''),
(48, 1, 'iPod Classic', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;More room to move.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			With 80GB or 160GB of storage and up to 40 hours of battery life, the new iPod classic lets you enjoy up to 40,000 songs or up to 200 hours of video or any combination wherever you go.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Cover Flow.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Browse through your music collection by flipping through album art. Select an album to turn it over and see the track list.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Enhanced interface.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Experience a whole new way to browse and view your music and video.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Sleeker design.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Beautiful, durable, and sleeker than ever, iPod classic now features an anodized aluminum and polished stainless steel enclosure with rounded edges.&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', NULL, NULL, NULL, NULL, '', 'iPod Classic', '', ''),
(49, 1, 'Samsung Galaxy Tab 10.1', '&lt;p&gt;\r\n	Samsung Galaxy Tab 10.1, is the world&amp;rsquo;s thinnest tablet, measuring 8.6 mm thickness, running with Android 3.0 Honeycomb OS on a 1GHz dual-core Tegra 2 processor, similar to its younger brother Samsung Galaxy Tab 8.9.&lt;/p&gt;\r\n&lt;p&gt;\r\n	Samsung Galaxy Tab 10.1 gives pure Android 3.0 experience, adding its new TouchWiz UX or TouchWiz 4.0 &amp;ndash; includes a live panel, which lets you to customize with different content, such as your pictures, bookmarks, and social feeds, sporting a 10.1 inches WXGA capacitive touch screen with 1280 x 800 pixels of resolution, equipped with 3 megapixel rear camera with LED flash and a 2 megapixel front camera, HSPA+ connectivity up to 21Mbps, 720p HD video recording capability, 1080p HD playback, DLNA support, Bluetooth 2.1, USB 2.0, gyroscope, Wi-Fi 802.11 a/b/g/n, micro-SD slot, 3.5mm headphone jack, and SIM slot, including the Samsung Stick &amp;ndash; a Bluetooth microphone that can be carried in a pocket like a pen and sound dock with powered subwoofer.&lt;/p&gt;\r\n&lt;p&gt;\r\n	Samsung Galaxy Tab 10.1 will come in 16GB / 32GB / 64GB verities and pre-loaded with Social Hub, Reader&amp;rsquo;s Hub, Music Hub and Samsung Mini Apps Tray &amp;ndash; which gives you access to more commonly used apps to help ease multitasking and it is capable of Adobe Flash Player 10.2, powered by 6860mAh battery that gives you 10hours of video-playback time.&amp;nbsp;&amp;auml;&amp;ouml;&lt;/p&gt;\r\n', NULL, NULL, NULL, NULL, '', 'Samsung Galaxy Tab 10.1', '', ''),
(50, 1, 'Mini Trio Candle Set', '', '', '', '', '', '', 'Mini Trio Candle Set', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_discount`
--

CREATE TABLE `oc_product_discount` (
  `product_discount_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `priority` int(11) DEFAULT 1,
  `price` decimal(15,4) DEFAULT 0.0000,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT 'P',
  `special` tinyint(1) DEFAULT 0,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_discount`
--

INSERT INTO `oc_product_discount` (`product_discount_id`, `product_id`, `customer_group_id`, `quantity`, `priority`, `price`, `type`, `special`, `date_start`, `date_end`) VALUES
(438, 42, 1, 10, 1, 88.0000, 'P', 0, '0000-00-00', '0000-00-00'),
(439, 42, 1, 20, 1, 77.0000, 'P', 0, '0000-00-00', '0000-00-00'),
(440, 42, 1, 30, 1, 66.0000, 'P', 0, '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_filter`
--

CREATE TABLE `oc_product_filter` (
  `product_id` int(11) NOT NULL,
  `filter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_image`
--

CREATE TABLE `oc_product_image` (
  `product_image_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_image`
--

INSERT INTO `oc_product_image` (`product_image_id`, `product_id`, `image`, `sort_order`) VALUES
(1968, 43, 'catalog/demo/macbook_3.jpg', 0),
(1969, 43, 'catalog/demo/macbook_2.jpg', 0),
(1970, 43, 'catalog/demo/macbook_4.jpg', 0),
(1971, 43, 'catalog/demo/macbook_5.jpg', 0),
(1972, 44, 'catalog/demo/macbook_air_3.jpg', 0),
(1973, 44, 'catalog/demo/macbook_air_2.jpg', 0),
(1974, 44, 'catalog/demo/macbook_air_4.jpg', 0),
(1975, 45, 'catalog/demo/macbook_pro_4.jpg', 0),
(1976, 45, 'catalog/demo/macbook_pro_3.jpg', 0),
(1977, 45, 'catalog/demo/macbook_pro_2.jpg', 0),
(1978, 40, 'catalog/demo/iphone_4.jpg', 0),
(1979, 40, 'catalog/demo/iphone_3.jpg', 0),
(1980, 40, 'catalog/demo/iphone_5.jpg', 0),
(1981, 40, 'catalog/demo/iphone_2.jpg', 0),
(1982, 40, 'catalog/demo/iphone_6.jpg', 0),
(1983, 31, 'catalog/demo/nikon_d300_5.jpg', 0),
(1984, 31, 'catalog/demo/nikon_d300_4.jpg', 0),
(1985, 31, 'catalog/demo/nikon_d300_2.jpg', 0),
(1986, 31, 'catalog/demo/nikon_d300_3.jpg', 0),
(1987, 29, 'catalog/demo/palm_treo_pro_2.jpg', 0),
(1988, 29, 'catalog/demo/palm_treo_pro_3.jpg', 0),
(1989, 48, 'catalog/demo/ipod_classic_2.jpg', 0),
(1990, 48, 'catalog/demo/ipod_classic_3.jpg', 0),
(1991, 48, 'catalog/demo/ipod_classic_4.jpg', 0),
(1992, 46, 'catalog/demo/sony_vaio_3.jpg', 0),
(1993, 46, 'catalog/demo/sony_vaio_2.jpg', 0),
(1994, 46, 'catalog/demo/sony_vaio_4.jpg', 0),
(1995, 46, 'catalog/demo/sony_vaio_5.jpg', 0),
(2002, 34, 'catalog/demo/ipod_shuffle_3.jpg', 0),
(2003, 34, 'catalog/demo/ipod_shuffle_2.jpg', 0),
(2004, 34, 'catalog/demo/ipod_shuffle_4.jpg', 0),
(2005, 34, 'catalog/demo/ipod_shuffle_5.jpg', 0),
(2006, 32, 'catalog/demo/ipod_touch_4.jpg', 0),
(2007, 32, 'catalog/demo/ipod_touch_3.jpg', 0),
(2008, 32, 'catalog/demo/ipod_touch_2.jpg', 0),
(2009, 32, 'catalog/demo/ipod_touch_5.jpg', 0),
(2010, 32, 'catalog/demo/ipod_touch_6.jpg', 0),
(2011, 32, 'catalog/demo/ipod_touch_7.jpg', 0),
(2313, 42, 'catalog/demo/canon_eos_5d_2.jpg', 0),
(2314, 42, 'catalog/demo/canon_eos_5d_1.jpg', 0),
(2315, 42, 'catalog/demo/compaq_presario.jpg', 0),
(2316, 42, 'catalog/demo/hp_1.jpg', 0),
(2317, 42, 'catalog/demo/canon_logo.jpg', 0),
(2322, 49, 'catalog/demo/samsung_tab_2.jpg', 0),
(2323, 49, 'catalog/demo/samsung_tab_3.jpg', 0),
(2324, 49, 'catalog/demo/samsung_tab_4.jpg', 0),
(2325, 49, 'catalog/demo/samsung_tab_5.jpg', 0),
(2326, 49, 'catalog/demo/samsung_tab_6.jpg', 0),
(2327, 49, 'catalog/demo/samsung_tab_7.jpg', 0),
(2344, 30, 'catalog/demo/canon_eos_5d_3.jpg', 0),
(2345, 30, 'catalog/demo/canon_eos_5d_2.jpg', 0),
(2350, 41, 'catalog/demo/imac_2.jpg', 0),
(2351, 41, 'catalog/demo/imac_3.jpg', 0),
(2352, 47, 'catalog/demo/hp_2.jpg', 0),
(2353, 47, 'catalog/demo/hp_3.jpg', 0),
(2394, 28, 'catalog/demo/htc_touch_hd_3.jpg', 0),
(2395, 28, 'catalog/demo/htc_touch_hd_2.jpg', 0),
(2396, 36, 'catalog/demo/ipod_nano_3.jpg', 0),
(2397, 36, 'catalog/demo/ipod_nano_2.jpg', 0),
(2398, 36, 'catalog/demo/ipod_nano_4.jpg', 0),
(2399, 36, 'catalog/demo/ipod_nano_5.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_option`
--

CREATE TABLE `oc_product_option` (
  `product_option_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `required` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_option`
--

INSERT INTO `oc_product_option` (`product_option_id`, `product_id`, `option_id`, `value`, `required`) VALUES
(208, 42, 4, 'test', 1),
(209, 42, 6, '', 1),
(217, 42, 5, '', 1),
(218, 42, 1, '', 1),
(219, 42, 8, '2011-02-20', 1),
(220, 42, 10, '2011-02-20 22:25', 1),
(221, 42, 9, '22:25', 1),
(222, 42, 7, '', 1),
(223, 42, 2, '', 1),
(224, 35, 11, '', 1),
(225, 47, 12, '2011-04-22', 1),
(226, 30, 5, '', 1),
(227, 36, 11, NULL, 1),
(229, 36, 6, '', 1),
(230, 36, 12, '', 1),
(244, 28, 11, NULL, 1),
(245, 28, 6, '', 0),
(246, 28, 12, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_option_value`
--

CREATE TABLE `oc_product_option_value` (
  `product_option_value_id` int(11) NOT NULL,
  `product_option_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `option_value_id` int(11) DEFAULT 0,
  `quantity` int(11) DEFAULT 0,
  `subtract` tinyint(1) DEFAULT 0,
  `price` decimal(15,4) DEFAULT NULL,
  `price_prefix` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `points` int(11) DEFAULT 0,
  `points_prefix` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` decimal(15,8) DEFAULT NULL,
  `weight_prefix` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_option_value`
--

INSERT INTO `oc_product_option_value` (`product_option_value_id`, `product_option_id`, `product_id`, `option_id`, `option_value_id`, `quantity`, `subtract`, `price`, `price_prefix`, `points`, `points_prefix`, `weight`, `weight_prefix`) VALUES
(1, 217, 42, 5, 41, 100, 0, 1.0000, '+', 0, '+', 1.00000000, '+'),
(2, 217, 42, 5, 42, 200, 1, 2.0000, '+', 0, '+', 2.00000000, '+'),
(3, 217, 42, 5, 40, 300, 0, 3.0000, '+', 0, '+', 3.00000000, '+'),
(4, 217, 42, 5, 39, 92, 1, 4.0000, '+', 0, '+', 4.00000000, '+'),
(5, 218, 42, 1, 32, 96, 1, 10.0000, '+', 1, '+', 10.00000000, '+'),
(6, 218, 42, 1, 31, 146, 1, 20.0000, '+', 2, '-', 20.00000000, '+'),
(7, 218, 42, 1, 43, 300, 1, 30.0000, '+', 3, '+', 30.00000000, '+'),
(8, 223, 42, 2, 23, 48, 1, 10.0000, '+', 0, '+', 10.00000000, '+'),
(9, 223, 42, 2, 24, 194, 1, 20.0000, '+', 0, '+', 20.00000000, '+'),
(10, 223, 42, 2, 44, 2696, 1, 30.0000, '+', 0, '+', 30.00000000, '+'),
(11, 223, 42, 2, 45, 3998, 1, 40.0000, '+', 0, '+', 40.00000000, '+'),
(12, 224, 35, 11, 46, 0, 1, 5.0000, '+', 0, '+', 0.00000000, '+'),
(13, 224, 35, 11, 47, 10, 1, 10.0000, '+', 0, '+', 0.00000000, '+'),
(14, 224, 35, 11, 48, 15, 1, 15.0000, '+', 0, '+', 0.00000000, '+'),
(15, 226, 30, 5, 39, 2, 1, 0.0000, '+', 0, '+', 0.00000000, '+'),
(16, 226, 30, 5, 40, 5, 1, 0.0000, '+', 0, '+', 0.00000000, '+'),
(17, 227, 36, 11, 46, 1, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(18, 227, 36, 11, 47, 1, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(19, 227, 36, 11, 48, 1, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(20, 227, 36, 11, 49, 1, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(21, 227, 36, 11, 50, 1, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(41, 244, 28, 11, 50, 111, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(42, 244, 28, 11, 49, 111, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(43, 244, 28, 11, 48, 111, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(44, 244, 28, 11, 47, 111, 0, 0.0000, '+', 0, '+', 0.00000000, '+'),
(45, 244, 28, 11, 46, 111, 0, 0.0000, '+', 0, '+', 0.00000000, '+');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_related`
--

CREATE TABLE `oc_product_related` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_related`
--

INSERT INTO `oc_product_related` (`product_id`, `related_id`) VALUES
(28, 36),
(30, 36),
(32, 36),
(34, 36),
(36, 28),
(36, 30),
(36, 32),
(36, 34),
(36, 40),
(36, 41),
(36, 42),
(36, 47),
(36, 48),
(40, 36),
(40, 42),
(41, 36),
(41, 42),
(42, 36),
(42, 40),
(42, 41),
(47, 36),
(48, 36);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_report`
--

CREATE TABLE `oc_product_report` (
  `product_report_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_reward`
--

CREATE TABLE `oc_product_reward` (
  `product_reward_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT 0,
  `customer_group_id` int(11) DEFAULT 0,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_reward`
--

INSERT INTO `oc_product_reward` (`product_reward_id`, `product_id`, `customer_group_id`, `points`) VALUES
(329, 43, 1, 600),
(331, 44, 1, 700),
(333, 45, 1, 800),
(335, 40, 1, 0),
(337, 31, 1, 0),
(339, 29, 1, 0),
(343, 48, 1, 0),
(345, 33, 1, 0),
(347, 46, 1, 0),
(353, 34, 1, 0),
(355, 32, 1, 0),
(425, 35, 1, 0),
(515, 42, 1, 100),
(521, 49, 1, 1000),
(539, 30, 1, 200),
(545, 41, 1, 0),
(546, 47, 1, 300),
(553, 28, 1, 400);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_subscription`
--

CREATE TABLE `oc_product_subscription` (
  `product_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `trial_price` decimal(10,4) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_addon`
--

CREATE TABLE `oc_product_to_addon` (
  `product_id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_category`
--

CREATE TABLE `oc_product_to_category` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_to_category`
--

INSERT INTO `oc_product_to_category` (`product_id`, `category_id`) VALUES
(36, 59),
(50, 64);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_color`
--

CREATE TABLE `oc_product_to_color` (
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_product_to_color`
--

INSERT INTO `oc_product_to_color` (`product_id`, `color_id`) VALUES
(28, 36),
(36, 28);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_country`
--

CREATE TABLE `oc_product_to_country` (
  `product_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oc_product_to_country`
--

INSERT INTO `oc_product_to_country` (`product_id`, `country_id`) VALUES
(47, 259),
(47, 261),
(47, 264);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_download`
--

CREATE TABLE `oc_product_to_download` (
  `product_id` int(11) NOT NULL,
  `download_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_layout`
--

CREATE TABLE `oc_product_to_layout` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_store`
--

CREATE TABLE `oc_product_to_store` (
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_product_to_store`
--

INSERT INTO `oc_product_to_store` (`product_id`, `store_id`) VALUES
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(40, 0),
(41, 0),
(42, 0),
(43, 0),
(44, 0),
(45, 0),
(46, 0),
(47, 0),
(48, 0),
(49, 0),
(50, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_vase`
--

CREATE TABLE `oc_product_to_vase` (
  `product_id` int(11) NOT NULL,
  `vase_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_product_to_vase`
--

INSERT INTO `oc_product_to_vase` (`product_id`, `vase_id`) VALUES
(28, 40),
(28, 41),
(28, 42),
(28, 47),
(36, 28),
(36, 30),
(36, 41),
(36, 47);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_zone`
--

CREATE TABLE `oc_product_to_zone` (
  `product_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oc_product_to_zone`
--

INSERT INTO `oc_product_to_zone` (`product_id`, `country_id`, `zone_id`) VALUES
(47, 259, 4660),
(47, 261, 4724),
(47, 264, 4790);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_viewed`
--

CREATE TABLE `oc_product_viewed` (
  `product_id` int(11) NOT NULL,
  `viewed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return`
--

CREATE TABLE `oc_return` (
  `return_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) DEFAULT 0,
  `product` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `opened` tinyint(1) DEFAULT 0,
  `return_reason_id` int(11) DEFAULT 0,
  `return_action_id` int(11) DEFAULT 0,
  `return_status_id` int(11) DEFAULT 0,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_ordered` date DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_action`
--

CREATE TABLE `oc_return_action` (
  `return_action_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_return_action`
--

INSERT INTO `oc_return_action` (`return_action_id`, `language_id`, `name`) VALUES
(1, 1, 'Waiting for return'),
(2, 1, 'Credit Issued'),
(3, 1, 'Replacement Sent'),
(4, 1, 'Refunded');

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_history`
--

CREATE TABLE `oc_return_history` (
  `return_history_id` int(11) NOT NULL,
  `return_id` int(11) DEFAULT NULL,
  `return_status_id` int(11) DEFAULT 0,
  `notify` tinyint(1) DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_reason`
--

CREATE TABLE `oc_return_reason` (
  `return_reason_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_return_reason`
--

INSERT INTO `oc_return_reason` (`return_reason_id`, `language_id`, `name`) VALUES
(1, 1, 'Dead On Arrival'),
(2, 1, 'Received Wrong Item'),
(3, 1, 'Order Error'),
(4, 1, 'Faulty, please supply details'),
(5, 1, 'Other, please supply details');

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_status`
--

CREATE TABLE `oc_return_status` (
  `return_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_return_status`
--

INSERT INTO `oc_return_status` (`return_status_id`, `language_id`, `name`) VALUES
(1, 1, 'Pending'),
(2, 1, 'Awaiting Products'),
(3, 1, 'Complete');

-- --------------------------------------------------------

--
-- Table structure for table `oc_review`
--

CREATE TABLE `oc_review` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT 0,
  `author` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_seo_url`
--

CREATE TABLE `oc_seo_url` (
  `seo_url_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `language_id` int(11) DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keyword` varchar(768) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_seo_url`
--

INSERT INTO `oc_seo_url` (`seo_url_id`, `store_id`, `language_id`, `key`, `value`, `keyword`, `sort_order`) VALUES
(2, 0, 1, 'product_id', '48', 'ipod-classic', 1),
(4, 0, 1, 'product_id', '43', 'macbook', 1),
(5, 0, 1, 'product_id', '44', 'macbook-air', 1),
(6, 0, 1, 'product_id', '45', 'macbook-pro', 1),
(7, 0, 1, 'product_id', '30', 'canon-eos-5d', 1),
(8, 0, 1, 'product_id', '31', 'nikon-d300', 1),
(9, 0, 1, 'product_id', '29', 'palm-treo-pro', 1),
(10, 0, 1, 'product_id', '35', 'product-8', 1),
(11, 0, 1, 'product_id', '49', 'samsung-galaxy-tab-10-1', 1),
(12, 0, 1, 'product_id', '33', 'samsung-syncmaster-941bw', 1),
(13, 0, 1, 'product_id', '46', 'sony-vaio', 1),
(14, 0, 1, 'product_id', '41', 'imac', 1),
(15, 0, 1, 'product_id', '40', 'iphone', 1),
(17, 0, 1, 'product_id', '34', 'ipod-shuffle', 1),
(18, 0, 1, 'product_id', '32', 'ipod-touch', 1),
(20, 0, 1, 'product_id', '42', 'apple-cinema', 1),
(21, 0, 1, 'manufacturer_id', '5', 'htc', 0),
(22, 0, 1, 'manufacturer_id', '7', 'hewlett-packard', 0),
(23, 0, 1, 'manufacturer_id', '6', 'palm', 0),
(24, 0, 1, 'manufacturer_id', '10', 'sony', 0),
(25, 0, 1, 'manufacturer_id', '9', 'canon', 0),
(26, 0, 1, 'manufacturer_id', '8', 'apple', 0),
(27, 0, 1, 'path', '30', 'printer', 0),
(66, 0, 1, 'information_id', '1', 'about-us', 0),
(67, 0, 1, 'information_id', '2', 'terms', 0),
(68, 0, 1, 'information_id', '4', 'delivery', 0),
(69, 0, 1, 'information_id', '3', 'privacy', 0),
(70, 0, 1, 'language', 'en-gb', 'en-gb', -2),
(71, 0, 1, 'route', 'information/information.info', 'info', 0),
(72, 0, 1, 'route', 'information/information', 'information', -1),
(73, 0, 1, 'route', 'product/product', 'product', -1),
(74, 0, 1, 'route', 'product/category', 'catalog', -1),
(75, 0, 1, 'route', 'product/manufacturer', 'brands', -1),
(76, 0, 1, 'product_id', '47', 'hp-lp3065', 0),
(77, 0, 1, 'path', '59', 'Flowers', 0),
(91, 0, 1, 'product_id', '28', 'htc-touch-hd', 0),
(92, 0, 1, 'path', '60', 'Ocassions', 0),
(93, 0, 1, 'path', '61', 'home-decor', 0),
(94, 0, 1, 'path', '60_62', 'Ocassions/Birthday-Flowers', 0),
(95, 0, 1, 'path', '60_63', 'Ocassions/Engagement-Flowers', 0),
(96, 0, 1, 'path', '61_64', 'home-decor/Candles', 0),
(97, 0, 1, 'path', '61_65', 'home-decor/Vases', 0),
(98, 0, 1, 'topic_id', '1', 'flower-care', 0),
(99, 0, 1, 'topic_id', '2', 'events-blog', 0),
(100, 0, 1, 'article_id', '1', 'about-us-blog', 0),
(101, 0, 1, 'article_id', '2', 'visit-our-botique', 0),
(102, 0, 1, 'product_id', '36', 'ipod-nano', 0),
(104, 0, 1, 'product_id', '50', 'Mini-Trio-Candle-Set', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_session`
--

CREATE TABLE `oc_session` (
  `session_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expire` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_session`
--

INSERT INTO `oc_session` (`session_id`, `data`, `expire`) VALUES
('003b0e2e501d68efcc9b8bf438', '{\"currency\":\"USD\"}', '2026-01-17 06:10:49'),
('010677d2814dd5870f5a580786', '{\"currency\":\"USD\"}', '2026-01-16 14:53:46'),
('031c3cffce5b74b263edb533b5', '{\"currency\":\"USD\"}', '2026-01-17 01:29:29'),
('0475ed438797c85ea1f429f4aa', '{\"currency\":\"USD\"}', '2026-01-16 20:48:37'),
('0488907cf17619eb61e91bd5e4', '{\"currency\":\"USD\"}', '2026-01-17 11:36:02'),
('04f0475a9ef5136bd1b7c2e256', '{\"currency\":\"USD\"}', '2026-01-16 21:30:15'),
('056a81b950f0cdbc123633a4f3', '{\"currency\":\"USD\"}', '2026-01-16 23:38:33'),
('060dc7aacd0150423cdbe58321', '{\"currency\":\"USD\"}', '2026-01-17 08:06:08'),
('065315adb328bd180ab38f0402', '{\"currency\":\"USD\",\"upload_token\":\"3fa5e421a0009a63a7e94e54b794ff95\",\"review_token\":\"12038563ed3ff20f5b74bbccabca9fee\"}', '2026-01-17 06:55:42'),
('072fab25d56a8058196206a3b1', '{\"currency\":\"USD\"}', '2026-01-17 05:47:51'),
('07ae284ac293b25a2089a2d2c2', '{\"currency\":\"USD\"}', '2026-01-16 23:18:10'),
('09d45c8fc81b583ccd7bffb962', '{\"currency\":\"USD\"}', '2026-01-17 07:10:52'),
('0e0b913eaedf34485e548bd0b3', '{\"currency\":\"USD\",\"upload_token\":\"bd608f0d8a184c764c908a7cb40dadf6\",\"review_token\":\"34964a558680972e0f0e0ff27e12ffbd\"}', '2026-01-17 07:13:24'),
('0f1359b6f56d4ad82de9e9a648', '{\"currency\":\"USD\"}', '2026-01-16 13:21:19'),
('1038d8177ed930e6e0ac2ccf22', '{\"currency\":\"USD\"}', '2026-01-16 21:51:33'),
('10ad9f78813bed26ff3becf3e5', '{\"currency\":\"USD\"}', '2026-01-16 13:11:07'),
('1110bf18b37c8a8c09d1f0079a', '{\"currency\":\"USD\"}', '2026-01-17 02:15:08'),
('11804e7439cbb9f02b9ffb17ef', '{\"currency\":\"USD\"}', '2026-01-17 09:04:50'),
('12b2ba6a98deeae0bb8678931e', '{\"currency\":\"USD\"}', '2026-01-17 02:04:56'),
('12cfb038bc3479d81c1c7ecb9d', '{\"currency\":\"USD\"}', '2026-01-16 12:37:27'),
('12e67f521b8c297820a9193817', '{\"currency\":\"USD\"}', '2026-01-16 23:06:57'),
('1573ab614cb135399d41937bb2', '{\"currency\":\"USD\"}', '2026-01-17 02:52:33'),
('170f7aaec17bba347acc62a0c4', '{\"currency\":\"USD\"}', '2026-01-16 23:40:28'),
('1853936e1004c7e3ed8f4d2585', '{\"currency\":\"USD\",\"upload_token\":\"d81fc947bf903df3f54d3c3609bb9b3c\",\"review_token\":\"a4adcbfcbf49c55d358c8f5ac1c7d4a0\"}', '2026-01-17 10:10:04'),
('19020a60eac32f295e6ecbe078', '{\"currency\":\"USD\",\"upload_token\":\"25ea1fe432863bc553c417b1d861fc98\",\"review_token\":\"8c098ea67db035f56288a35532ec22e0\"}', '2026-01-17 02:53:38'),
('1ac3cf9c3f80fb2612029f3e88', '{\"currency\":\"USD\"}', '2026-01-17 07:18:46'),
('1b12149669afe1e0a7d096ad51', '{\"currency\":\"USD\"}', '2026-01-16 12:54:05'),
('1e085b25b911ad42aae0e89a19', '{\"currency\":\"USD\"}', '2026-01-16 12:45:33'),
('1fdc3d169d06c6b601f6b65bbf', '{\"currency\":\"USD\"}', '2026-01-17 02:28:56'),
('2145345143d42305fc2afd07c3', '{\"currency\":\"USD\"}', '2026-01-17 02:11:28'),
('21a6c2ae4da70f6d1e90fa99e0', '{\"currency\":\"USD\"}', '2026-01-17 06:26:57'),
('224a20f1c66815c12e5d2a7764', '{\"currency\":\"USD\"}', '2026-01-17 01:42:40'),
('2272ea9e2f548d77af30c1730f', '{\"currency\":\"USD\",\"upload_token\":\"45d9b85f287d26bb3a94eb3f8d5d5a79\",\"review_token\":\"fdb115d4222df82e27cf9f491c616a80\"}', '2026-01-17 10:51:06'),
('24af4954f1cfb23c6399688a35', '{\"currency\":\"USD\"}', '2026-01-17 07:42:58'),
('24afe34eeb5e5bd5fe776d156c', '{\"currency\":\"USD\"}', '2026-01-17 07:35:03'),
('27b49ba06b082cda2516554b5d', '{\"currency\":\"USD\"}', '2026-01-17 10:57:56'),
('27bc16c520bb703b2b476c55ca', '{\"currency\":\"USD\",\"upload_token\":\"b377e7f3c6d21e483969abc57e5a1e18\",\"review_token\":\"0815a49dfc46e70ab895f1de99a7f469\"}', '2026-01-17 11:42:10'),
('27cfbc71608e21b68b884d47ce', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/transaction&amp;language=en-gb\"}', '2026-01-16 22:18:19'),
('2852ff66fe8082e14ff40e4962', '{\"currency\":\"USD\"}', '2026-01-17 11:45:38'),
('286262dcf0b01fca46d6ac00cb', '{\"currency\":\"USD\",\"upload_token\":\"27880daa6dc63b856897c7206fbe5fbc\",\"review_token\":\"37fd520829e768d9262fac67c32a4cc9\"}', '2026-01-17 04:03:09'),
('2a81be9e946da2f0892f13c9a9', '{\"currency\":\"USD\"}', '2026-01-16 19:36:57'),
('2aca5d2163056fcd69100b7cac', '{\"currency\":\"USD\"}', '2026-01-17 10:11:08'),
('2d5b010ebac60ab970e8f8cd8a', '{\"currency\":\"USD\",\"login_token\":\"19185f679303a6f0468e7245c0\"}', '2026-01-17 11:01:05'),
('2de060ca36212939ed89c8283e', '{\"currency\":\"USD\"}', '2026-01-16 12:21:28'),
('2e8e18af3ea7c01a16d80a2b75', '{\"currency\":\"USD\"}', '2026-01-17 02:43:31'),
('3061d7df3cc4f765ada26d6cef', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/account&amp;language=en-gb\"}', '2026-01-17 11:01:03'),
('31b93fab78a3d6b3b8ceb86697', '{\"currency\":\"USD\",\"login_token\":\"c1f0a32283c99b2726361581a0\"}', '2026-01-16 20:06:30'),
('32baaaaf9dcfcc91317994af23', '{\"currency\":\"USD\"}', '2026-01-17 03:31:42'),
('32ed441a470de0bd760a409c89', '{\"currency\":\"USD\"}', '2026-01-17 08:35:35'),
('351a83b95fedf9f2d6516e9016', '{\"currency\":\"USD\"}', '2026-01-17 07:02:10'),
('37a2daa13102f95a2c85633b39', '{\"currency\":\"USD\"}', '2026-01-16 13:30:45'),
('37a60d9f7816b5a62cba961a64', '{\"currency\":\"USD\"}', '2026-01-16 22:25:23'),
('37efda8fc984f4c6a5352dc6cd', '{\"currency\":\"USD\"}', '2026-01-17 03:46:56'),
('38ee3147bb4a361dacd7f697bd', '{\"currency\":\"USD\"}', '2026-01-16 18:07:33'),
('395c518c89b2c05c554fa8957b', '{\"currency\":\"USD\"}', '2026-01-17 04:09:54'),
('3997aeab6082ff2c604f1029ab', '{\"currency\":\"USD\"}', '2026-01-16 16:03:33'),
('3a1897a903abd9d6324f957c2d', '{\"currency\":\"USD\"}', '2026-01-16 14:22:06'),
('3acf94cc30b61f6bc3c269616d', '{\"currency\":\"USD\"}', '2026-01-17 00:44:14'),
('3b0a046b8f595ebb62f59196ff', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/order&amp;language=en-gb\"}', '2026-01-16 15:52:49'),
('3b550fb4c223a16ae86b0f5aba', '{\"currency\":\"USD\",\"upload_token\":\"fa0aca7806b217cbccd83233cdd46875\",\"review_token\":\"635d82e104697d9c4354ed2fb5ea2269\"}', '2026-01-17 11:42:12'),
('3b5790247d03dae464eeb03071', '{\"currency\":\"USD\",\"upload_token\":\"140d45a28e9fe27a7ec2880a1f47e86c\",\"review_token\":\"0775d307d47599d5b90d97b586392a2c\"}', '2026-01-17 10:10:08'),
('3bbc71501c625995367a9f12d3', '{\"currency\":\"USD\"}', '2026-01-17 11:28:22'),
('3bd67d3eb2e8bf5c63fb370577', '{\"currency\":\"USD\"}', '2026-01-17 11:02:00'),
('3c9dfae12dc674e1e0a5cb2552', '{\"currency\":\"USD\"}', '2026-01-17 09:48:32'),
('3e3bd47703172c1f4f6ba08ec2', '{\"currency\":\"USD\"}', '2026-01-17 10:18:46'),
('402f844f7347987afe518f91e1', '{\"currency\":\"USD\"}', '2026-01-17 01:14:30'),
('422e2f2e9dab7a755ddb78d483', '{\"currency\":\"USD\"}', '2026-01-17 10:29:19'),
('43ee03a07b63b54111c7cf8443', '{\"currency\":\"USD\"}', '2026-01-17 03:00:21'),
('4477d0425e0df1cf9a9713015c', '{\"currency\":\"USD\"}', '2026-01-17 07:22:15'),
('44e4e4e9552c16d74c06259257', '{\"currency\":\"USD\"}', '2026-01-16 19:44:48'),
('46d993cbde57ff4394d4abee1d', '{\"currency\":\"USD\"}', '2026-01-17 09:50:19'),
('49506909423cac59b28d0f8eba', '{\"currency\":\"USD\"}', '2026-01-17 07:15:16'),
('4c65cd7875ea935cb5a7d8d5e9', '{\"currency\":\"USD\"}', '2026-01-16 19:14:40'),
('4d918e237ab20c58020c68d9d2', '{\"currency\":\"USD\"}', '2026-01-17 07:32:23'),
('4dd7a0cc8e86536a4b094dfed1', '{\"currency\":\"USD\"}', '2026-01-17 03:54:32'),
('4df0dec14dbbbdfe497976821e', '{\"currency\":\"USD\"}', '2026-01-16 18:44:16'),
('4e06e433fe5c212bcce1ae2d7a', '{\"currency\":\"USD\"}', '2026-01-16 14:13:49'),
('50420870c64fc271cbf004976c', '{\"currency\":\"USD\"}', '2026-01-17 00:36:29'),
('509e15ca28ab3561677296a030', '{\"currency\":\"USD\"}', '2026-01-17 05:43:22'),
('5120c31a68378c07c9aa1346e8', '{\"currency\":\"USD\"}', '2026-01-17 06:03:19'),
('512997696519ab1abe8ccf3769', '{\"currency\":\"USD\"}', '2026-01-16 20:41:21'),
('51d0178ee09a8cc3540c9afeca', '{\"currency\":\"USD\"}', '2026-01-17 10:29:46'),
('53b788cab90c0b2190db78c5bb', '{\"currency\":\"USD\"}', '2026-01-17 02:44:42'),
('55853297b2436a01dbe5fd5c95', '{\"currency\":\"USD\",\"login_token\":\"c84616a144f3f540c2e2d3ebbc\"}', '2026-01-16 20:22:55'),
('558b76f0c583799b28aefaf623', '{\"currency\":\"USD\"}', '2026-01-16 11:47:21'),
('563f4f3d5ce88b3e8bdbee96fb', '{\"currency\":\"USD\"}', '2026-01-16 22:51:19'),
('58126e44459b2c8e742d2466a0', '{\"currency\":\"USD\"}', '2026-01-17 05:31:11'),
('58223ca7607fad9350cdd93e19', '{\"currency\":\"USD\"}', '2026-01-17 08:35:17'),
('5a8afc84d43c7a114a87619426', '{\"currency\":\"USD\"}', '2026-01-17 06:32:52'),
('5e5f813cebcdffff3ba980b41a', '{\"currency\":\"USD\"}', '2026-01-17 04:33:29'),
('5fcbd3aca70aa736ba710c9e49', '{\"currency\":\"USD\"}', '2026-01-17 04:44:24'),
('6095ff5210467af29f1f3ccf01', '{\"currency\":\"USD\"}', '2026-01-17 05:33:14'),
('60b1192f6eaf541865e333fddd', '{\"currency\":\"USD\"}', '2026-01-16 23:43:28'),
('61f6e060f26d4d9120543a3eeb', '{\"currency\":\"USD\"}', '2026-01-17 03:08:14'),
('625ee294ad00f9573110cda96a', '{\"currency\":\"USD\"}', '2026-01-17 08:13:38'),
('62843f1723d2913415b8a574f4', '{\"currency\":\"USD\"}', '2026-01-17 11:28:13'),
('62c54c98f631ed0af76de8b374', '{\"currency\":\"USD\"}', '2026-01-16 21:17:10'),
('6419f833795be68f310fe05059', '{\"currency\":\"USD\"}', '2026-01-17 03:16:22'),
('66ba847102f2b67e6a7e2e93aa', '{\"currency\":\"USD\"}', '2026-01-17 01:49:20'),
('67560a3bcc46c56c423bf5c516', '{\"currency\":\"USD\"}', '2026-01-16 22:00:04'),
('67ac7b2cb3a471bd19daba0098', '{\"currency\":\"USD\"}', '2026-01-16 15:22:31'),
('6809effdb5d96bdc987cf967a6', '{\"currency\":\"USD\"}', '2026-01-16 19:29:39'),
('685de7a71ea8b6043ca9d07916', '{\"currency\":\"USD\",\"upload_token\":\"770ea818ce682d776db21d4e0a775926\",\"review_token\":\"5572493d9ba9435b246cf9bdc974b22a\"}', '2026-01-17 06:55:44'),
('6897f3b02f3b378c437011e601', '{\"currency\":\"USD\"}', '2026-01-17 10:50:00'),
('693bea1768a260041a36261fa5', '{\"currency\":\"USD\"}', '2026-01-17 06:42:15'),
('6996bf7b30168e5d45a35375ca', '{\"currency\":\"USD\"}', '2026-01-16 21:10:39'),
('6a383fc920eb052ae7ee5d39e3', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/account&amp;language=en-gb\"}', '2026-01-17 06:04:56'),
('6a59dda0929925292ffbf18c44', '{\"currency\":\"USD\"}', '2026-01-17 00:01:18'),
('6a71a4cd1b9b8508e274dec449', '{\"currency\":\"USD\"}', '2026-01-16 15:25:54'),
('6aaa4cc178a614c3afdb6c6d53', '{\"currency\":\"USD\"}', '2026-01-16 17:52:05'),
('6b81929e514dca11b2d4c5d31f', '{\"currency\":\"USD\"}', '2026-01-17 02:12:23'),
('6bad3f1865d16fe0959cf14f7d', '{\"currency\":\"USD\"}', '2026-01-17 04:54:08'),
('6c7600d1e54b3761188082a8c8', '{\"currency\":\"USD\"}', '2026-01-17 00:09:08'),
('6de2b0b6d93e1ab8a7bcf3043d', '{\"currency\":\"USD\"}', '2026-01-16 18:36:54'),
('6f1a4ff34f73280dbb914ca723', '{\"currency\":\"USD\"}', '2026-01-17 09:15:13'),
('6f2ce6b9f968b3e331dc4f8455', '{\"currency\":\"USD\"}', '2026-01-17 07:58:30'),
('714b4a3b4ec2e0fc6b1169d833', '{\"currency\":\"USD\"}', '2026-01-16 14:05:33'),
('723ecc3ff4d33acc6586a19877', '{\"currency\":\"USD\"}', '2026-01-17 05:55:59'),
('73121f557c4dd5e4b0cd7069d9', '{\"currency\":\"USD\"}', '2026-01-17 05:25:26'),
('7368a2a17d33a41197341ec37e', '{\"currency\":\"USD\"}', '2026-01-16 23:15:16'),
('73ba87ca8333976f2d4c1f0577', '{\"currency\":\"USD\"}', '2026-01-17 08:20:59'),
('799df981b0fe080a8d75587bd7', '{\"currency\":\"USD\"}', '2026-01-17 04:02:22'),
('79f625dedf5c92f7fe44d013d4', '{\"currency\":\"USD\"}', '2026-01-17 09:55:58'),
('7a4d913cdbc8f9479888be8f40', '{\"currency\":\"USD\"}', '2026-01-17 01:16:37'),
('7a684243e86dab8b5efe83c139', '{\"currency\":\"USD\"}', '2026-01-16 22:59:32'),
('7ca03555fc2ce6a13010ffbc18', '{\"currency\":\"USD\"}', '2026-01-17 07:51:51'),
('7d052131618d886758bd4adef1', '{\"currency\":\"USD\"}', '2026-01-16 22:26:56'),
('800db9e99d630de6e845917a59', '{\"currency\":\"USD\"}', '2026-01-17 08:56:57'),
('8078bed4abbe745bba4e041896', '{\"currency\":\"USD\"}', '2026-01-17 06:37:49'),
('81d1d2cb1b54294b976b4703c7', '{\"currency\":\"USD\"}', '2026-01-17 11:26:53'),
('850716463caff13dba62be43d3', '{\"currency\":\"USD\"}', '2026-01-16 13:48:25'),
('85deb3d10bcfaf5afbc4c07daf', '{\"currency\":\"USD\",\"login_token\":\"9edc5e30d8115fe5aee0e2e890\"}', '2026-01-16 22:18:26'),
('85f010ac0c056f4d9da9501946', '{\"currency\":\"USD\"}', '2026-01-17 10:33:55'),
('87c641b39ced053ff253311c89', '{\"currency\":\"USD\"}', '2026-01-17 03:39:06'),
('88b5ec42218973251c98dfb336', '{\"currency\":\"USD\"}', '2026-01-17 02:30:35'),
('88e1b9da8830967290be827d80', '{\"currency\":\"USD\"}', '2026-01-17 06:50:57'),
('89228baf319cc9077641751b2e', '{\"currency\":\"USD\"}', '2026-01-17 08:13:36'),
('8924a1aa081ecc950c55d20b3d', '{\"currency\":\"USD\"}', '2026-01-17 11:13:04'),
('89560e56df93813e4e0ae571c7', '{\"currency\":\"USD\",\"upload_token\":\"6b8c8360239080851e8ca815de70b282\",\"review_token\":\"f5d576c2e311467a5198fb0a49f073f5\"}', '2026-01-17 01:36:36'),
('8985a812aecc7d9d1735e194f5', '{\"currency\":\"USD\"}', '2026-01-16 23:22:52'),
('89cdc51a449dd437eddf776414', '{\"currency\":\"USD\"}', '2026-01-17 08:50:08'),
('8a3645898415ee8c2553f2ebe7', '{\"currency\":\"USD\"}', '2026-01-17 11:05:30'),
('8bcf4cc9689df056549222751b', '{\"currency\":\"USD\"}', '2026-01-16 11:55:29'),
('8c0330c954a54c5605cee93d49', '{\"currency\":\"USD\"}', '2026-01-17 06:34:11'),
('8e2abbf76482d3b8fc42c5d135', '{\"currency\":\"USD\"}', '2026-01-16 21:37:04'),
('901a08446f20ee63499548b013', '{\"currency\":\"USD\",\"compare\":[]}', '2026-01-17 09:24:23'),
('93378d50cbc3642db5be9c672d', '{\"currency\":\"USD\"}', '2026-01-16 20:10:44'),
('93cbf3e6377a1705ea021ca16e', '{\"currency\":\"USD\"}', '2026-01-17 05:07:52'),
('94f30b45977004ae81e797666d', '{\"currency\":\"USD\"}', '2026-01-16 15:42:13'),
('98a400bbd4d455d449938e4efc', '{\"currency\":\"USD\"}', '2026-01-16 21:03:14'),
('99521011b13c1de9d06093602e', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/wishlist&amp;language=en-gb\"}', '2026-01-17 11:09:02'),
('99b462058f41428012fa650d59', '{\"currency\":\"USD\"}', '2026-01-16 12:04:38'),
('9aeea07d2f89f01acfaada400e', '{\"currency\":\"USD\"}', '2026-01-17 11:04:44'),
('9c772df5b825b8abf49eb229fb', '{\"currency\":\"USD\"}', '2026-01-16 22:34:24'),
('9c7f8d9c50cea77edf5b712c8f', '{\"currency\":\"USD\"}', '2026-01-16 23:53:33'),
('9e807bddaaac5eaa7dd8ceb7dd', '{\"currency\":\"USD\"}', '2026-01-17 06:16:34'),
('9f3652c25fe3dfbeb296975476', '{\"currency\":\"USD\"}', '2026-01-16 22:29:40'),
('a01845f528754c7e3befd2ecce', '{\"currency\":\"USD\"}', '2026-01-17 10:14:26'),
('a0692b18db605bca5b61285a44', '{\"currency\":\"USD\",\"upload_token\":\"352d642cf24f81b91731e04541e0d984\",\"review_token\":\"55cb9ecad45cabd0a4ca10c1ae673b97\"}', '2026-01-17 04:03:11'),
('a0fc8c68a9c8e341125c547075', '{\"currency\":\"USD\"}', '2026-01-16 18:51:49'),
('a319eff82639afdde448ee7dca', '{\"currency\":\"USD\"}', '2026-01-17 05:40:39'),
('a50988457398b70d69007436f7', '{\"currency\":\"USD\"}', '2026-01-16 20:26:23'),
('a572e39cb5420a61c2a3e77d95', '{\"currency\":\"USD\",\"upload_token\":\"6f44e5e50f604e59eb09a9b5f4178e1b\",\"review_token\":\"273ec9f52f3e93c36aeae0c371ba3afe\"}', '2026-01-17 10:51:04'),
('a63cc6ff4471b2a8de1638cab0', '{\"currency\":\"TRY\",\"user_city\":\"Adana\",\"user_district\":\"\",\"user_id\":\"1\",\"user_token\":\"5a8e629055bc532e62306d3ddff56903\",\"upload_token\":\"30675efbfeca0c429a462951ea9e11c2\",\"review_token\":\"b17cc6ea88702ac4f7dcf5b3cd5c74d0\"}', '2026-01-17 11:46:48'),
('a6add8128f6c84c3638f06b8d4', '{\"currency\":\"USD\"}', '2026-01-17 06:51:32'),
('a8e9cfd97a95341014e8278c3f', '{\"currency\":\"USD\"}', '2026-01-16 22:18:53'),
('a913ecaadef94b3c092aa610d7', '{\"currency\":\"USD\"}', '2026-01-17 00:59:36'),
('ab53638f43b309c4e5a7fb4985', '{\"currency\":\"USD\"}', '2026-01-17 05:46:51'),
('adc2d597c8115cce90cb0b7e84', '{\"currency\":\"USD\"}', '2026-01-17 11:41:56'),
('ae446a33c7410cfa55bf9b5dae', '{\"currency\":\"USD\"}', '2026-01-17 01:07:20'),
('af564286cab9127bc3ca6c67e6', '{\"currency\":\"USD\"}', '2026-01-16 13:02:35'),
('b233b33a8222500f6727507de5', '{\"currency\":\"USD\",\"upload_token\":\"1cc347f0e881063b3d32667a208a9c46\",\"review_token\":\"5a8c21788bb11233cf85a2b48adeefa6\"}', '2026-01-17 08:07:11'),
('b35eb2b8a13e27cac92152af91', '{\"currency\":\"USD\"}', '2026-01-17 10:41:45'),
('b47b967a03fd6007879a59a64b', '{\"currency\":\"USD\"}', '2026-01-16 12:13:27'),
('b4d6f55229a445d4bc6762964f', '{\"currency\":\"USD\"}', '2026-01-17 11:42:50'),
('b5d781181c1a0b45362336373b', '{\"currency\":\"USD\"}', '2026-01-17 03:29:36'),
('b6b3f83e6069491e775da9d192', '{\"currency\":\"USD\"}', '2026-01-17 06:18:34'),
('b70077c566868d51c98fd69a03', '{\"currency\":\"USD\"}', '2026-01-17 11:24:35'),
('b7b734cdbd04c4354aed96a6e8', '{\"currency\":\"USD\"}', '2026-01-16 15:09:28'),
('bc61acab3629338ac4a9d3df18', '{\"currency\":\"USD\"}', '2026-01-17 09:35:03'),
('bd195d5e9460ae97a659b9d2d3', '{\"currency\":\"USD\"}', '2026-01-16 23:45:54'),
('bd4f1aadfe3d96bfb430f39022', '{\"currency\":\"USD\"}', '2026-01-17 01:21:42'),
('be74bc6015257536f8c9f1bcca', '{\"currency\":\"USD\"}', '2026-01-17 05:02:20'),
('bf0aca82b6ebac0b1eb8f3efb0', '{\"currency\":\"USD\"}', '2026-01-17 06:26:13'),
('c09600ac0a4a25af28ab123bdd', '{\"currency\":\"USD\"}', '2026-01-16 19:06:44'),
('c195f54bbb575555c1994dfb5d', '{\"currency\":\"USD\"}', '2026-01-16 16:58:44'),
('c20ce858ea66a2ae8cbecb3106', '{\"currency\":\"USD\"}', '2026-01-17 06:48:05'),
('c29c4d3ba2b25eb826cff98652', '{\"currency\":\"USD\"}', '2026-01-16 21:44:13'),
('c2a8877c53a561a5c084bc05f1', '{\"currency\":\"USD\"}', '2026-01-17 07:15:14'),
('c5dbb7636ff6654b597a4ae6e9', '{\"currency\":\"USD\"}', '2026-01-16 18:29:48'),
('c722e22cdc9d9fe813d73df6c1', '{\"currency\":\"USD\"}', '2026-01-16 17:34:20'),
('c8c3100f13cd416005f49421b0', '{\"currency\":\"USD\"}', '2026-01-16 20:39:57'),
('c900df0f7c3687e948e9cd8a55', '{\"currency\":\"USD\"}', '2026-01-16 20:18:30'),
('cdd4e858a9379f4256f7d0895b', '{\"currency\":\"USD\"}', '2026-01-17 00:13:53'),
('cfd2b8cfa7a1782107013d5c26', '{\"currency\":\"USD\"}', '2026-01-17 02:09:03'),
('d06c7c6060b754211784aea29a', '{\"currency\":\"USD\"}', '2026-01-17 07:51:02'),
('d111cacab9c2f3ec75cd301d63', '{\"currency\":\"USD\"}', '2026-01-16 14:37:40'),
('d3499650b76a07e9754b886950', '{\"currency\":\"USD\"}', '2026-01-17 08:43:01'),
('d3d736fdff432c30a0df5d5253', '{\"currency\":\"USD\"}', '2026-01-17 03:35:24'),
('d46be4d4e2f9d94cf09ae339d1', '{\"currency\":\"USD\"}', '2026-01-17 03:31:47'),
('d4c0e6703e39e3b4effda857b5', '{\"currency\":\"USD\"}', '2026-01-17 10:26:05'),
('d4ed3d34a26ebe892b5c5d21a0', '{\"currency\":\"USD\"}', '2026-01-17 07:15:15'),
('d5555a61d30962a1399c4b67dc', '{\"currency\":\"USD\"}', '2026-01-17 02:36:57'),
('d6bff2d9379be5d85311f8edf5', '{\"currency\":\"USD\"}', '2026-01-17 02:18:47'),
('d7032a340b7d9555468041e4d7', '{\"currency\":\"USD\"}', '2026-01-17 00:18:55'),
('d70461131cd471577b01d9922e', '{\"currency\":\"USD\"}', '2026-01-16 20:55:54'),
('d80d36a7943bb66b018f3e89a9', '{\"currency\":\"USD\",\"upload_token\":\"7a6f27034d1e92c38b80485dda32239b\",\"review_token\":\"4b81d8bc46bfaf936e6a1673429e90d8\"}', '2026-01-16 20:01:46'),
('d9a1805b5b1e45710cdcaa8314', '{\"currency\":\"USD\"}', '2026-01-17 02:19:50'),
('db48456603b4932d51fc49e0c6', '{\"currency\":\"USD\",\"upload_token\":\"501068794b09f99c5a5ad492ea230e0b\",\"review_token\":\"318070db0f93269a8216cb286efd11cb\"}', '2026-01-17 04:09:00'),
('dcd035bc157441ff44a008c58e', '{\"currency\":\"USD\"}', '2026-01-16 19:21:55'),
('df86ffb0bf46dd34196b832683', '{\"currency\":\"USD\"}', '2026-01-16 18:59:13'),
('dfb20571c5b0851afe148d0922', '{\"currency\":\"USD\"}', '2026-01-16 18:22:32'),
('dfb6c301cc594d77797fc4461d', '{\"currency\":\"USD\"}', '2026-01-16 14:29:45'),
('e06446b9137f2f26c9f158d675', '{\"currency\":\"USD\",\"login_token\":\"a302cb8a6ee5db820c56592b38\"}', '2026-01-16 15:53:11'),
('e0929b6033a9d1401ac6ec130f', '{\"currency\":\"USD\"}', '2026-01-16 20:33:59'),
('e0ae25ff1695f1a8ad53b7d039', '{\"currency\":\"USD\"}', '2026-01-16 16:42:03'),
('e1aa50d4fa33999a2c9e08baae', '{\"currency\":\"USD\"}', '2026-01-17 06:30:28'),
('e1db3530bc49d6f068b2071ad9', '{\"currency\":\"USD\"}', '2026-01-16 22:26:33'),
('e1e16dbe5c1554a95112ecd411', '{\"currency\":\"USD\"}', '2026-01-16 21:23:45'),
('e1e6623748d9651adbbae16970', '{\"currency\":\"USD\"}', '2026-01-17 10:29:03'),
('e2f27c98a30809227656079cd8', '{\"currency\":\"USD\"}', '2026-01-17 11:21:28'),
('e3de8f584dc1fab12d857123c3', '{\"currency\":\"USD\"}', '2026-01-16 12:29:33'),
('e403bae3d5e6fc472722b790c6', '{\"currency\":\"USD\"}', '2026-01-17 05:10:05'),
('e4a5ae386420ec0c573bc771eb', '{\"currency\":\"USD\"}', '2026-01-17 08:14:01'),
('e4c0e3ec89b95d53bae4454b7c', '{\"currency\":\"USD\"}', '2026-01-17 09:40:22'),
('e5c52298aa1e5f56fc8098ec27', '{\"currency\":\"USD\",\"redirect\":\"https:\\/\\/renkrenk.com.tr\\/index.php?route=account\\/wishlist&amp;language=en-gb\"}', '2026-01-17 06:23:38'),
('e6825585472a94687f3325b269', '{\"currency\":\"USD\"}', '2026-01-17 09:32:21'),
('e8875991e62f4c35beae63a9d6', '{\"currency\":\"USD\"}', '2026-01-17 07:26:47'),
('e8b6fa27a7cdfade56ac9a3096', '{\"currency\":\"USD\"}', '2026-01-16 22:43:02'),
('e905d5f5c69f3df9b86fc6f324', '{\"currency\":\"USD\"}', '2026-01-16 12:25:52'),
('e946c6222c75f37ddd7ada7a8f', '{\"currency\":\"USD\"}', '2026-01-16 22:09:34'),
('eb035f24283567c463c441d306', '{\"currency\":\"USD\"}', '2026-01-16 14:45:22'),
('eb8562f99a38c8fc14f2860b31', '{\"currency\":\"USD\"}', '2026-01-17 05:55:16'),
('ec62cb21588a2de01bcd447815', '{\"currency\":\"USD\"}', '2026-01-16 17:16:32'),
('ec79b87998ea85e1c1044fcd0a', '{\"currency\":\"USD\",\"login_token\":\"4f6a61ade2adc51c7a2dc0222e\"}', '2026-01-16 22:22:57'),
('ec7e48ea3762251bb93bcd4c42', '{\"currency\":\"USD\",\"upload_token\":\"085df119b9d717269236c8525581fc30\",\"review_token\":\"bb9bdd7b441985fdc7b7efcf27cd7a18\"}', '2026-01-17 07:13:26'),
('ed2282b4be3df7f3550fa891c8', '{\"currency\":\"USD\"}', '2026-01-17 08:28:10'),
('ed3440b6eaedf0c50ac9de5d27', '{\"currency\":\"USD\"}', '2026-01-17 05:17:44'),
('edc3c24d971e9001ac88a1898f', '{\"currency\":\"USD\"}', '2026-01-17 10:03:15'),
('ee528aec3467fe2643b7395efc', '{\"currency\":\"USD\"}', '2026-01-17 04:17:28'),
('efd4278eb40ff778bf48e196a5', '{\"currency\":\"USD\"}', '2026-01-17 07:05:09'),
('f0ab70453f2517ec4250aa7973', '{\"currency\":\"USD\"}', '2026-01-17 00:27:55'),
('f10522a61fb4ce296affb0eb90', '{\"currency\":\"USD\"}', '2026-01-16 13:40:11'),
('f1153b2284b8fcd0cc7cc4f6d2', '{\"currency\":\"USD\"}', '2026-01-17 03:24:03'),
('f2b6e2ff4a84e3be312dfe49f8', '{\"currency\":\"USD\"}', '2026-01-17 01:57:16'),
('f39563a74951efa29a7e7f8685', '{\"currency\":\"USD\"}', '2026-01-17 01:35:59'),
('f4ba0f7c082598576f76c3c363', '{\"currency\":\"USD\"}', '2026-01-17 06:28:19'),
('f4fae356fd20d2b90e2a6861b1', '{\"currency\":\"USD\"}', '2026-01-16 23:30:42'),
('f6dbd10b398f7f2eed7d0d9612', '{\"currency\":\"USD\"}', '2026-01-17 04:25:15'),
('f6e739f2a121ac3cbba66c1522', '{\"currency\":\"USD\",\"login_token\":\"02049e6759c97493d3346282bc\"}', '2026-01-17 06:04:57'),
('f7ad602d6f01e404015ba1957c', '{\"currency\":\"USD\"}', '2026-01-16 19:51:58'),
('f8f4d8d33539a048c622cbe887', '{\"currency\":\"USD\"}', '2026-01-17 09:29:31'),
('f9a7fd1d752d77aa80bb945589', '{\"currency\":\"USD\"}', '2026-01-17 00:51:58'),
('f9b5f9783442bd7ca9dc3aad5f', '{\"currency\":\"USD\"}', '2026-01-17 07:00:41'),
('fa926e0b828fa6c9c61471bef7', '{\"currency\":\"USD\"}', '2026-01-17 11:07:50'),
('face21b2719b43e538b44af576', '{\"currency\":\"USD\"}', '2026-01-16 13:48:45'),
('faf044109f0701f86b2e5687b4', '{\"currency\":\"USD\"}', '2026-01-16 18:15:13'),
('fc320b6fad6f83f08f8f3d1072', '{\"currency\":\"USD\"}', '2026-01-17 06:31:24'),
('fdda9649baab02738733c1a190', '{\"currency\":\"USD\"}', '2026-01-16 16:23:08'),
('fe266e25110c6d93aef906205b', '{\"currency\":\"USD\"}', '2026-01-17 05:37:29'),
('fe43f85e2cbdbcb535e4f8c62e', '{\"currency\":\"USD\"}', '2026-01-16 14:08:12'),
('fe97d67c9a8aec11eeb5444dd5', '{\"currency\":\"USD\"}', '2026-01-16 13:56:58'),
('ff06746d0471721af282e8e54a', '{\"currency\":\"USD\"}', '2026-01-17 10:10:57'),
('ffbcf5b38983b0b953e85430b4', '{\"currency\":\"USD\",\"upload_token\":\"fdf749e177ea5ca4f2b8e23c18888cb4\",\"review_token\":\"9bfbea77b1326c04d83829fcf6ff1a6f\"}', '2026-01-17 08:07:15');

-- --------------------------------------------------------

--
-- Table structure for table `oc_setting`
--

CREATE TABLE `oc_setting` (
  `setting_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serialized` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_setting`
--

INSERT INTO `oc_setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(130, 0, 'currency_ecb', 'currency_ecb_status', '1', 0),
(131, 0, 'dashboard_activity', 'dashboard_activity_status', '1', 0),
(132, 0, 'dashboard_activity', 'dashboard_activity_sort_order', '7', 0),
(133, 0, 'dashboard_sale', 'dashboard_sale_status', '1', 0),
(134, 0, 'dashboard_sale', 'dashboard_sale_width', '3', 0),
(135, 0, 'dashboard_chart', 'dashboard_chart_status', '1', 0),
(136, 0, 'dashboard_chart', 'dashboard_chart_width', '6', 0),
(137, 0, 'dashboard_customer', 'dashboard_customer_status', '1', 0),
(138, 0, 'dashboard_customer', 'dashboard_customer_width', '3', 0),
(139, 0, 'dashboard_map', 'dashboard_map_status', '1', 0),
(140, 0, 'dashboard_map', 'dashboard_map_width', '6', 0),
(141, 0, 'dashboard_online', 'dashboard_online_status', '1', 0),
(142, 0, 'dashboard_online', 'dashboard_online_width', '3', 0),
(143, 0, 'dashboard_order', 'dashboard_order_sort_order', '1', 0),
(144, 0, 'dashboard_order', 'dashboard_order_status', '1', 0),
(145, 0, 'dashboard_order', 'dashboard_order_width', '3', 0),
(146, 0, 'dashboard_sale', 'dashboard_sale_sort_order', '2', 0),
(147, 0, 'dashboard_customer', 'dashboard_customer_sort_order', '3', 0),
(148, 0, 'dashboard_online', 'dashboard_online_sort_order', '4', 0),
(149, 0, 'dashboard_map', 'dashboard_map_sort_order', '5', 0),
(150, 0, 'dashboard_chart', 'dashboard_chart_sort_order', '6', 0),
(151, 0, 'dashboard_recent', 'dashboard_recent_status', '1', 0),
(152, 0, 'dashboard_recent', 'dashboard_recent_sort_order', '8', 0),
(153, 0, 'dashboard_activity', 'dashboard_activity_width', '4', 0),
(154, 0, 'dashboard_recent', 'dashboard_recent_width', '8', 0),
(155, 0, 'developer', 'developer_sass', '1', 0),
(156, 0, 'module_category', 'module_category_status', '1', 0),
(157, 0, 'module_account', 'module_account_status', '1', 0),
(167, 0, 'report_customer_activity', 'report_customer_activity_status', '1', 0),
(168, 0, 'report_customer_activity', 'report_customer_activity_sort_order', '1', 0),
(169, 0, 'report_customer_order', 'report_customer_order_status', '1', 0),
(170, 0, 'report_customer_order', 'report_customer_order_sort_order', '2', 0),
(171, 0, 'report_customer_reward', 'report_customer_reward_status', '1', 0),
(172, 0, 'report_customer_reward', 'report_customer_reward_sort_order', '3', 0),
(173, 0, 'report_customer_search', 'report_customer_search_status', '1', 0),
(174, 0, 'report_customer_search', 'report_customer_search_sort_order', '4', 0),
(175, 0, 'report_customer_transaction', 'report_customer_transaction_status', '1', 0),
(176, 0, 'report_customer_transaction', 'report_customer_transaction_sort_order', '5', 0),
(177, 0, 'report_customer', 'report_customer_status', '1', 0),
(178, 0, 'report_customer', 'report_customer_sort_order', '6', 0),
(179, 0, 'report_sale_tax', 'report_sale_tax_status', '1', 0),
(180, 0, 'report_sale_tax', 'report_sale_tax_sort_order', '8', 0),
(181, 0, 'report_sale_shipping', 'report_sale_shipping_status', '1', 0),
(182, 0, 'report_sale_shipping', 'report_sale_shipping_sort_order', '9', 0),
(183, 0, 'report_sale_return', 'report_sale_return_status', '1', 0),
(184, 0, 'report_sale_return', 'report_sale_return_sort_order', '10', 0),
(185, 0, 'report_sale_order', 'report_sale_order_status', '1', 0),
(186, 0, 'report_sale_order', 'report_sale_order_sort_order', '11', 0),
(187, 0, 'report_sale_coupon', 'report_sale_coupon_status', '1', 0),
(188, 0, 'report_sale_coupon', 'report_sale_coupon_sort_order', '12', 0),
(189, 0, 'report_product_viewed', 'report_product_viewed_status', '1', 0),
(190, 0, 'report_product_viewed', 'report_product_viewed_sort_order', '13', 0),
(191, 0, 'report_product_purchased', 'report_product_purchased_status', '1', 0),
(192, 0, 'report_product_purchased', 'report_product_purchased_sort_order', '14', 0),
(193, 0, 'report_marketing', 'report_marketing_status', '1', 0),
(194, 0, 'report_marketing', 'report_marketing_sort_order', '15', 0),
(195, 0, 'report_subscription', 'report_subscription_status', '1', 0),
(196, 0, 'report_subscription', 'report_subscription_sort_order', '16', 0),
(197, 0, 'shipping_flat', 'shipping_flat_sort_order', '1', 0),
(198, 0, 'shipping_flat', 'shipping_flat_status', '1', 0),
(199, 0, 'shipping_flat', 'shipping_flat_geo_zone_id', '0', 0),
(200, 0, 'shipping_flat', 'shipping_flat_tax_class_id', '9', 0),
(201, 0, 'shipping_flat', 'shipping_flat_cost', '5.00', 0),
(202, 0, 'theme_basic', 'theme_basic_status', '1', 0),
(203, 0, 'total_shipping', 'total_shipping_sort_order', '3', 0),
(204, 0, 'total_sub_total', 'total_sub_total_sort_order', '1', 0),
(205, 0, 'total_sub_total', 'total_sub_total_status', '1', 0),
(206, 0, 'total_tax', 'total_tax_sort_order', '5', 0),
(207, 0, 'total_tax', 'total_tax_status', '1', 0),
(208, 0, 'total_total', 'total_total_sort_order', '9', 0),
(209, 0, 'total_total', 'total_total_status', '1', 0),
(210, 0, 'total_credit', 'total_credit_sort_order', '7', 0),
(211, 0, 'total_credit', 'total_credit_status', '1', 0),
(212, 0, 'total_reward', 'total_reward_sort_order', '2', 0),
(213, 0, 'total_reward', 'total_reward_status', '1', 0),
(214, 0, 'total_shipping', 'total_shipping_status', '1', 0),
(215, 0, 'total_shipping', 'total_shipping_estimator', '1', 0),
(216, 0, 'total_coupon', 'total_coupon_sort_order', '4', 0),
(217, 0, 'total_coupon', 'total_coupon_status', '1', 0),
(501, 0, 'payment_cod', 'payment_cod_order_status_id', '5', 0),
(502, 0, 'payment_cod', 'payment_cod_geo_zone_id', '0', 0),
(503, 0, 'payment_cod', 'payment_cod_status', '1', 0),
(504, 0, 'payment_cod', 'payment_cod_sort_order', '5', 0),
(505, 0, 'payment_free_checkout', 'payment_free_checkout_order_status_id', '5', 0),
(506, 0, 'payment_free_checkout', 'payment_free_checkout_status', '1', 0),
(507, 0, 'payment_free_checkout', 'payment_free_checkout_sort_order', '1', 0),
(1492, 0, 'config', 'config_name', 'RenkRenk', 0),
(1493, 0, 'config', 'config_theme', 'basic', 0),
(1494, 0, 'config', 'config_layout_id', '4', 0),
(1495, 0, 'config', 'config_logo', 'catalog/opencart-logo.png', 0),
(1496, 0, 'config', 'config_icon', 'catalog/opencart.ico', 0),
(1497, 0, 'config', 'config_description', '{\"1\":{\"meta_title\":\"RenkRenk\",\"meta_description\":\"\",\"meta_keyword\":\"\"}}', 1),
(1498, 0, 'config', 'config_owner', 'Your Name', 0),
(1499, 0, 'config', 'config_address', 'Address 1', 0),
(1500, 0, 'config', 'config_geocode', '', 0),
(1501, 0, 'config', 'config_email', 'admin@gmail.com', 0),
(1502, 0, 'config', 'config_telephone', '123456789', 0),
(1503, 0, 'config', 'config_image', '', 0),
(1504, 0, 'config', 'config_open', '', 0),
(1505, 0, 'config', 'config_comment', '', 0),
(1506, 0, 'config', 'config_country_id', '264', 0),
(1507, 0, 'config', 'config_zone_id', '', 0),
(1508, 0, 'config', 'config_timezone', 'UTC', 0),
(1509, 0, 'config', 'config_language_catalog', 'en-gb', 0),
(1510, 0, 'config', 'config_language_admin', 'en-gb', 0),
(1511, 0, 'config', 'config_currency', 'USD', 0),
(1512, 0, 'config', 'config_currency_engine', 'ecb', 0),
(1513, 0, 'config', 'config_currency_auto', '1', 0),
(1514, 0, 'config', 'config_length_class_id', '1', 0),
(1515, 0, 'config', 'config_weight_class_id', '1', 0),
(1516, 0, 'config', 'config_product_description_length', '100', 0),
(1517, 0, 'config', 'config_pagination', '10', 0),
(1518, 0, 'config', 'config_product_count', '0', 0),
(1519, 0, 'config', 'config_pagination_admin', '10', 0),
(1520, 0, 'config', 'config_autocomplete_limit', '5', 0),
(1521, 0, 'config', 'config_product_report_status', '0', 0),
(1522, 0, 'config', 'config_review_status', '1', 0),
(1523, 0, 'config', 'config_review_purchased', '0', 0),
(1524, 0, 'config', 'config_review_guest', '1', 0),
(1525, 0, 'config', 'config_article_description_length', '600', 0),
(1526, 0, 'config', 'config_comment_status', '0', 0),
(1527, 0, 'config', 'config_comment_approve', '0', 0),
(1528, 0, 'config', 'config_comment_interval', '', 0),
(1529, 0, 'config', 'config_cookie_id', '0', 0),
(1530, 0, 'config', 'config_gdpr_id', '0', 0),
(1531, 0, 'config', 'config_gdpr_limit', '180', 0),
(1532, 0, 'config', 'config_tax', '0', 0),
(1533, 0, 'config', 'config_tax_default', 'shipping', 0),
(1534, 0, 'config', 'config_tax_customer', 'shipping', 0),
(1535, 0, 'config', 'config_customer_online', '0', 0),
(1536, 0, 'config', 'config_customer_online_expire', '1', 0),
(1537, 0, 'config', 'config_customer_activity', '0', 0),
(1538, 0, 'config', 'config_customer_search', '0', 0),
(1539, 0, 'config', 'config_customer_group_id', '1', 0),
(1540, 0, 'config', 'config_customer_group_display', '[\"1\"]', 1),
(1541, 0, 'config', 'config_customer_price', '0', 0),
(1542, 0, 'config', 'config_telephone_display', '0', 0),
(1543, 0, 'config', 'config_telephone_required', '0', 0),
(1544, 0, 'config', 'config_account_id', '3', 0),
(1545, 0, 'config', 'config_2fa', '0', 0),
(1546, 0, 'config', 'config_login_attempts', '5', 0),
(1547, 0, 'config', 'config_password_length', '6', 0),
(1548, 0, 'config', 'config_invoice_prefix', 'INV-2025-00', 0),
(1549, 0, 'config', 'config_cart_weight', '1', 0),
(1550, 0, 'config', 'config_checkout_guest', '1', 0),
(1551, 0, 'config', 'config_checkout_payment_address', '0', 0),
(1552, 0, 'config', 'config_checkout_shipping_address', '0', 0),
(1553, 0, 'config', 'config_checkout_id', '0', 0),
(1554, 0, 'config', 'config_order_status_id', '1', 0),
(1555, 0, 'config', 'config_processing_status', '[\"5\",\"1\",\"2\",\"12\",\"3\"]', 1),
(1556, 0, 'config', 'config_complete_status', '[\"5\",\"3\"]', 1),
(1557, 0, 'config', 'config_failed_status_id', '7', 0),
(1558, 0, 'config', 'config_void_status_id', '16', 0),
(1559, 0, 'config', 'config_fraud_status_id', '8', 0),
(1560, 0, 'config', 'config_api_id', '1', 0),
(1561, 0, 'config', 'config_subscription_status_id', '1', 0),
(1562, 0, 'config', 'config_subscription_active_status_id', '2', 0),
(1563, 0, 'config', 'config_subscription_expired_status_id', '3', 0),
(1564, 0, 'config', 'config_subscription_suspended_status_id', '4', 0),
(1565, 0, 'config', 'config_subscription_canceled_status_id', '5', 0),
(1566, 0, 'config', 'config_subscription_failed_status_id', '6', 0),
(1567, 0, 'config', 'config_subscription_denied_status_id', '7', 0),
(1568, 0, 'config', 'config_stock_display', '0', 0),
(1569, 0, 'config', 'config_stock_warning', '0', 0),
(1570, 0, 'config', 'config_stock_checkout', '0', 0),
(1571, 0, 'config', 'config_stock_status_id', '7', 0),
(1572, 0, 'config', 'config_affiliate_status', '1', 0),
(1573, 0, 'config', 'config_affiliate_group_id', '1', 0),
(1574, 0, 'config', 'config_affiliate_approval', '0', 0),
(1575, 0, 'config', 'config_affiliate_auto', '0', 0),
(1576, 0, 'config', 'config_affiliate_commission', '5', 0),
(1577, 0, 'config', 'config_affiliate_expire', '', 0),
(1578, 0, 'config', 'config_affiliate_id', '4', 0),
(1579, 0, 'config', 'config_return_status_id', '2', 0),
(1580, 0, 'config', 'config_return_id', '0', 0),
(1581, 0, 'config', 'config_captcha', '', 0),
(1582, 0, 'config', 'config_captcha_page', '[\"review\",\"contact\"]', 1),
(1583, 0, 'config', 'config_image_default_width', '300', 0),
(1584, 0, 'config', 'config_image_default_height', '300', 0),
(1585, 0, 'config', 'config_image_category_width', '300', 0),
(1586, 0, 'config', 'config_image_category_height', '300', 0),
(1587, 0, 'config', 'config_image_thumb_width', '700', 0),
(1588, 0, 'config', 'config_image_thumb_height', '700', 0),
(1589, 0, 'config', 'config_image_popup_width', '800', 0),
(1590, 0, 'config', 'config_image_popup_height', '800', 0),
(1591, 0, 'config', 'config_image_product_width', '330', 0),
(1592, 0, 'config', 'config_image_product_height', '250', 0),
(1593, 0, 'config', 'config_image_additional_width', '74', 0),
(1594, 0, 'config', 'config_image_additional_height', '74', 0),
(1595, 0, 'config', 'config_image_related_width', '330', 0),
(1596, 0, 'config', 'config_image_related_height', '250', 0),
(1597, 0, 'config', 'config_image_article_width', '1140', 0),
(1598, 0, 'config', 'config_image_article_height', '380', 0),
(1599, 0, 'config', 'config_image_topic_width', '1140', 0),
(1600, 0, 'config', 'config_image_topic_height', '380', 0),
(1601, 0, 'config', 'config_image_compare_width', '90', 0),
(1602, 0, 'config', 'config_image_compare_height', '90', 0),
(1603, 0, 'config', 'config_image_wishlist_width', '47', 0),
(1604, 0, 'config', 'config_image_wishlist_height', '47', 0),
(1605, 0, 'config', 'config_image_cart_width', '47', 0),
(1606, 0, 'config', 'config_image_cart_height', '47', 0),
(1607, 0, 'config', 'config_image_location_width', '268', 0),
(1608, 0, 'config', 'config_image_location_height', '268', 0),
(1609, 0, 'config', 'config_mail_engine', '', 0),
(1610, 0, 'config', 'config_mail_parameter', '', 0),
(1611, 0, 'config', 'config_mail_smtp_hostname', '', 0),
(1612, 0, 'config', 'config_mail_smtp_username', '', 0),
(1613, 0, 'config', 'config_mail_smtp_password', '', 0),
(1614, 0, 'config', 'config_mail_smtp_port', '25', 0),
(1615, 0, 'config', 'config_mail_smtp_timeout', '5', 0),
(1616, 0, 'config', 'config_mail_alert', '[\"order\"]', 1),
(1617, 0, 'config', 'config_mail_alert_email', '', 0),
(1618, 0, 'config', 'config_maintenance', '0', 0),
(1619, 0, 'config', 'config_session_expire', '86400', 0),
(1620, 0, 'config', 'config_session_samesite', 'Strict', 0),
(1621, 0, 'config', 'config_seo_url', '0', 0),
(1622, 0, 'config', 'config_compression', '0', 0),
(1623, 0, 'config', 'config_user_2fa', '0', 0),
(1624, 0, 'config', 'config_2fa_expire', '90', 0),
(1625, 0, 'config', 'config_user_password_length', '', 0),
(1626, 0, 'config', 'config_shared', '0', 0),
(1627, 0, 'config', 'config_file_max_size', '20', 0),
(1628, 0, 'config', 'config_file_ext_allowed', 'zip\r\ntxt\r\npng\r\njpe\r\njpeg\r\nwebp\r\njpg\r\ngif\r\nbmp\r\nico\r\ntiff\r\ntif\r\nsvg\r\nsvgz\r\nzip\r\nrar\r\nmsi\r\ncab\r\nmp3\r\nmp4\r\nqt\r\nmov\r\npdf\r\npsd\r\nai\r\neps\r\nps\r\ndoc', 0),
(1629, 0, 'config', 'config_file_mime_allowed', 'text/plain\r\nimage/png\r\nimage/webp\r\nimage/jpeg\r\nimage/gif\r\nimage/bmp\r\nimage/tiff\r\nimage/svg+xml\r\napplication/zip\r\napplication/x-zip\r\napplication/x-zip-compressed\r\napplication/rar\r\napplication/x-rar\r\napplication/x-rar-compressed\r\napplication/octet-stream\r\naudio/mpeg\r\nvideo/mp4\r\nvideo/quicktime\r\napplication/pdf', 0),
(1630, 0, 'config', 'config_error_display', '1', 0),
(1631, 0, 'config', 'config_error_log', '1', 0),
(1632, 0, 'config', 'config_error_filename', 'error.log', 0),
(1678, 0, 'homepage', 'homepage_slideshow', '[{\"image\":\"catalog\\/bannerlive\\/banner2.webp\",\"link\":\"#link1\"},{\"image\":\"catalog\\/bannerlive\\/banner.webp\",\"link\":\"#link2\"}]', 1),
(1679, 0, 'homepage', 'homepage_featured_products_header', 'OUR TOP RECOMMENDATIONS OF THE WEEK', 0),
(1680, 0, 'homepage', 'homepage_featured_products', '[\"42\",\"30\",\"47\",\"41\"]', 1),
(1681, 0, 'homepage', 'homepage_text_block_heading', 'EXTRAORDINARY QUALITY. EXTRAORDINARY SERVICE. EXTRAORDINARY LUXURY.', 0),
(1682, 0, 'homepage', 'homepage_text_block', 'Our team are known for setting the standard when it comes to the world\'s most iconic floral arrangements.&lt;br&gt;\r\nWhether you\'re planning an event or seeking everyday joy at home, let us tell your story through flowers...', 0),
(1683, 0, 'homepage', 'homepage_featured_categories', '[{\"category_id\":\"59\",\"custom_image\":\"catalog\\/homeblog.png\"},{\"category_id\":\"64\",\"custom_image\":\"catalog\\/homeblog1.png\"},{\"category_id\":\"62\",\"custom_image\":\"catalog\\/homeblog.png\"}]', 1),
(1684, 0, 'homepage', 'homepage_gift_subscriptions_image', 'catalog/homegiftbox.webp', 0),
(1685, 0, 'homepage', 'homepage_static_image', 'catalog/fullwidthhome.webp', 0),
(1686, 0, 'homepage', 'homepage_static_image_header', 'FRESH FLOWERS, ALL YEAR LONG', 0),
(1687, 0, 'homepage', 'homepage_static_image_text', 'Bring beauty into every week with a flower subscription designed to brighten your home. Subscriptions start from £45.', 0),
(1688, 0, 'homepage', 'homepage_featured_header', 'DISCOVER THE WORLD OF FLOWERBX', 0),
(1689, 0, 'homepage', 'homepage_featured_items', '[{\"id\":\"A-1\",\"type\":\"article\",\"custom_image\":\"catalog\\/homeblog.png\",\"description\":\"Find out more about the world of FLOWERBX \\u2013 from our founder\'s story to our full range of services.\"},{\"id\":\"A-2\",\"type\":\"article\",\"custom_image\":\"catalog\\/homeblog1.png\",\"description\":\"London calling! Stop by to see us at our boutiques at The Chancery Rosewood &amp; Corinthia London.\"},{\"id\":\"T-1\",\"type\":\"topic\",\"custom_image\":\"catalog\\/homeblog1.png\",\"description\":\"From vase life to choosing the right varieties, here\'s everything you need to know to help your florals shine.\"}]', 1),
(1690, 0, 'homepage', 'homepage_meet_image', 'catalog/meetimage.webp', 0),
(1691, 0, 'homepage', 'homepage_meet_header', 'MEET LONDON\'S LEADING FLORIST', 0),
(1692, 0, 'homepage', 'homepage_meet_paragraph', 'FLOWERBX was founded in London in 2015, offering businesses the highest quality, premium-grade flowers, for everything from luxury events to gala dinners, bespoke bouquets, private residences, and collaborations.  \r\n\r\nWith a flagship atelier in the fashion-hub of West London – alongside flower studios in Manhattan, Los Angeles and, now, Dubai – FLOWERBX has been bringing extraordinary beauty, service, and style to brands, private clients, and world-leading names for a decade. \r\n\r\nWith the likes of Gucci, Chanel and Tiffany &amp; Co on our client list, FLOWERBX is established as the industry leader in fashion-led floral curation.', 0),
(1693, 0, 'homepage', 'homepage_banner_image', 'catalog/lastbanner.webp', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_startup`
--

CREATE TABLE `oc_startup` (
  `startup_id` int(11) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_statistics`
--

CREATE TABLE `oc_statistics` (
  `statistics_id` int(11) NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(15,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_statistics`
--

INSERT INTO `oc_statistics` (`statistics_id`, `code`, `value`) VALUES
(1, 'order_sale', 585.0000),
(2, 'order_processing', 4.0000),
(3, 'order_complete', 3.0000),
(4, 'order_other', 0.0000),
(5, 'returns', 0.0000),
(6, 'product', 0.0000),
(7, 'review', 0.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_stock_status`
--

CREATE TABLE `oc_stock_status` (
  `stock_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_stock_status`
--

INSERT INTO `oc_stock_status` (`stock_status_id`, `language_id`, `name`) VALUES
(5, 1, 'Out Of Stock'),
(6, 1, '2-3 Days'),
(7, 1, 'In Stock'),
(8, 1, 'Pre-Order');

-- --------------------------------------------------------

--
-- Table structure for table `oc_store`
--

CREATE TABLE `oc_store` (
  `store_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription`
--

CREATE TABLE `oc_subscription` (
  `subscription_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT 0,
  `store_id` int(11) DEFAULT 0,
  `customer_id` int(11) DEFAULT NULL,
  `payment_address_id` int(11) DEFAULT 0,
  `payment_method` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_id` int(11) DEFAULT 0,
  `shipping_method` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_plan_id` int(11) DEFAULT 0,
  `subscription_plan_frequency_id` int(11) DEFAULT 0,
  `delivery_date` date DEFAULT NULL,
  `is_gift` tinyint(1) DEFAULT 0,
  `gift_id` int(11) DEFAULT 0,
  `vase_id` int(11) DEFAULT 0,
  `duration_id` int(11) DEFAULT 0,
  `paused_until` date DEFAULT NULL COMMENT 'Date until which subscription is paused',
  `skip_next_delivery` tinyint(1) DEFAULT 0 COMMENT 'Skip the next delivery',
  `last_modified_by` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'system' COMMENT 'Who last modified: customer, admin, or system',
  `trial_price` decimal(10,4) DEFAULT NULL,
  `trial_tax` decimal(10,4) DEFAULT NULL,
  `trial_frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_cycle` smallint(6) DEFAULT 0,
  `trial_duration` smallint(6) DEFAULT 0,
  `trial_remaining` smallint(6) DEFAULT 0,
  `trial_status` tinyint(1) DEFAULT 0,
  `price` decimal(10,4) DEFAULT NULL,
  `tax` decimal(10,4) DEFAULT NULL,
  `frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cycle` smallint(6) DEFAULT 0,
  `duration` smallint(6) DEFAULT 0,
  `remaining` smallint(6) DEFAULT 0,
  `date_next` datetime DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_status_id` int(11) DEFAULT 0,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription`
--

INSERT INTO `oc_subscription` (`subscription_id`, `order_id`, `store_id`, `customer_id`, `payment_address_id`, `payment_method`, `shipping_address_id`, `shipping_method`, `subscription_plan_id`, `subscription_plan_frequency_id`, `delivery_date`, `is_gift`, `gift_id`, `vase_id`, `duration_id`, `paused_until`, `skip_next_delivery`, `last_modified_by`, `trial_price`, `trial_tax`, `trial_frequency`, `trial_cycle`, `trial_duration`, `trial_remaining`, `trial_status`, `price`, `tax`, `frequency`, `cycle`, `duration`, `remaining`, `date_next`, `comment`, `subscription_status_id`, `language`, `currency`, `date_added`, `date_modified`) VALUES
(1, 2, 0, 1, 0, '{\"code\":\"cod.cod\",\"name\":\"Cash On Delivery\"}', 1, '{\"code\":\"flat.flat\",\"name\":\"Flat Shipping Rate\",\"cost\":\"5.00\",\"tax_class_id\":\"9\",\"text\":\"$5.00\"}', 3, 32, '2025-12-31', 1, 47, 0, 0, NULL, 0, 'system', 0.0000, 0.0000, 'day', 0, 0, 0, 0, 90.0000, 0.0000, 'day', 1, 0, 0, '2025-12-31 00:00:00', '', 0, 'en-gb', 'USD', '2025-12-10 12:56:46', '2025-12-10 12:56:46'),
(2, 2, 0, 1, 0, '{\"code\":\"cod.cod\",\"name\":\"Cash On Delivery\"}', 1, '{\"code\":\"flat.flat\",\"name\":\"Flat Shipping Rate\",\"cost\":\"5.00\",\"tax_class_id\":\"9\",\"text\":\"$5.00\"}', 3, 32, '2025-12-31', 1, 47, 0, 0, NULL, 0, 'system', 0.0000, 0.0000, 'day', 0, 0, 0, 0, 90.0000, 0.0000, 'day', 1, 0, 0, '2025-12-31 00:00:00', '', 0, 'en-gb', 'USD', '2025-12-10 12:56:55', '2025-12-10 12:56:55'),
(3, 2, 0, 1, 0, '{\"code\":\"cod.cod\",\"name\":\"Cash On Delivery\"}', 1, '{\"code\":\"flat.flat\",\"name\":\"Flat Shipping Rate\",\"cost\":\"5.00\",\"tax_class_id\":\"9\",\"text\":\"$5.00\"}', 3, 33, '2025-12-31', 1, 47, 0, 0, NULL, 0, 'customer', 0.0000, 0.0000, 'day', 0, 0, 0, 0, 90.0000, 0.0000, 'day', 33, 0, 0, '2026-01-12 00:00:00', '', 2, 'en-gb', 'USD', '2025-12-10 13:15:15', '2025-12-24 10:39:22');

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_history`
--

CREATE TABLE `oc_subscription_history` (
  `subscription_history_id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `subscription_status_id` int(11) DEFAULT 0,
  `action_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'pause, skip, frequency_change, delivery_date_change, plan_change, cancel, resume',
  `old_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Previous value (JSON format for complex data)',
  `new_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'New value (JSON format for complex data)',
  `notify` tinyint(1) DEFAULT 0,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modified_by` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'customer' COMMENT 'customer, admin, or system',
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription_history`
--

INSERT INTO `oc_subscription_history` (`subscription_history_id`, `subscription_id`, `subscription_status_id`, `action_type`, `old_value`, `new_value`, `notify`, `comment`, `modified_by`, `date_added`) VALUES
(1, 3, 2, NULL, NULL, NULL, 0, '', 'customer', '2025-12-10 13:15:15'),
(2, 3, 0, 'pause', NULL, '2025-12-27', 0, '', 'customer', '2025-12-10 13:17:58'),
(3, 3, 0, 'frequency_change', '{\"frequency_id\":\"32\",\"frequency\":\"day\",\"cycle\":\"1\"}', '{\"frequency_id\":33,\"frequency\":\"day\",\"cycle\":33}', 0, '', 'customer', '2025-12-10 13:20:00'),
(4, 3, 0, 'resume', '2025-12-27', NULL, 0, '', 'customer', '2025-12-24 10:39:22');

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_log`
--

CREATE TABLE `oc_subscription_log` (
  `subscription_log_id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `code` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_option`
--

CREATE TABLE `oc_subscription_option` (
  `subscription_option_id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `subscription_product_id` int(11) DEFAULT NULL,
  `product_option_id` int(11) DEFAULT NULL,
  `product_option_value_id` int(11) DEFAULT 0,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_order`
--

CREATE TABLE `oc_subscription_order` (
  `subscription_order_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `is_initial_order` tinyint(1) DEFAULT 0 COMMENT '1 if this is the first order that created the subscription',
  `iteration_number` int(11) DEFAULT 1 COMMENT 'Which iteration of the subscription this order represents',
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oc_subscription_order`
--

INSERT INTO `oc_subscription_order` (`subscription_order_id`, `subscription_id`, `order_id`, `is_initial_order`, `iteration_number`, `date_added`) VALUES
(1, 3, 2, 1, 1, '2025-12-10 13:15:15');

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan`
--

CREATE TABLE `oc_subscription_plan` (
  `subscription_plan_id` int(11) NOT NULL,
  `trial_frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_duration` int(11) DEFAULT 0,
  `trial_cycle` int(11) DEFAULT 0,
  `trial_status` tinyint(4) DEFAULT 0,
  `frequency` enum('day','week','semi_month','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int(11) DEFAULT 0,
  `cycle` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `price` decimal(15,4) NOT NULL DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription_plan`
--

INSERT INTO `oc_subscription_plan` (`subscription_plan_id`, `trial_frequency`, `trial_duration`, `trial_cycle`, `trial_status`, `frequency`, `duration`, `cycle`, `status`, `sort_order`, `image`, `price`) VALUES
(1, 'day', 0, 0, 0, 'day', 0, 1, 1, 0, 'catalog/prestige.webp', 100.0000),
(2, 'day', 0, 0, 0, 'month', 10, 1, 1, 0, 'catalog/tulip.webp', 85.0000),
(3, 'day', 0, 0, 0, 'day', 0, 1, 1, 0, 'catalog/signature.webp', 90.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_description`
--

CREATE TABLE `oc_subscription_plan_description` (
  `subscription_plan_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription_plan_description`
--

INSERT INTO `oc_subscription_plan_description` (`subscription_plan_id`, `language_id`, `name`, `description`) VALUES
(1, 1, 'PRESTIGE', '&lt;p&gt;&lt;strong&gt;THE SEASONAL SUBSCRIPTION - TULIPS&lt;/strong&gt;&lt;br /&gt;\r\n&lt;em&gt;Meet The Seasonal Subscription: Tulips.&lt;br /&gt;\r\nOur curation of what\'s current.&lt;/em&gt;&lt;br /&gt;\r\nFor those who want to embrace the beauty of the seasons from spring to winter, the Seasonal Subscription is for you.&lt;/p&gt;\r\n\r\n&lt;p&gt;Featuring rolling deliveries of the best-in-bloom varieties, changing with the months to celebrate every floral highlight.&lt;br /&gt;\r\nThe Seasonal Subscription – Tulips is here to bring some extra floral joy to the first months of the new year. Expect classic Dutch and delicate double styles in a range of colour-pop shades, as well as speciality fringed and parrot beauties you won\'t find elsewhere.&amp;nbsp;Creating the ultimate gift or treat for yourself.&amp;nbsp;&lt;br /&gt;\r\nFor more on what to expect from your subscription, click&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal/what-to-expect&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;When you start The Seasonal Subscription – you\'re in control, with the option to manage your subscription with just a few clicks.&lt;br /&gt;\r\nFind out more about The Seasonal Subscription&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;Have a question about our flower subscriptions? Get in touch with our team at&amp;nbsp;&lt;a href=&quot;mailto:contact@flowerbx.com&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;contact@flowerbx.com&lt;/a&gt;&amp;nbsp;or find out more in our subscription frequently asked questions&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/frequently-asked-questions&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;'),
(2, 1, 'TULIPS', '&lt;p&gt;&lt;strong&gt;THE SEASONAL SUBSCRIPTION - TULIPS&lt;/strong&gt;&lt;br /&gt;\r\n&lt;em&gt;Meet The Seasonal Subscription: Tulips.&lt;br /&gt;\r\nOur curation of what\'s current.&lt;/em&gt;&lt;br /&gt;\r\nFor those who want to embrace the beauty of the seasons from spring to winter, the Seasonal Subscription is for you.&lt;/p&gt;\r\n\r\n&lt;p&gt;Featuring rolling deliveries of the best-in-bloom varieties, changing with the months to celebrate every floral highlight.&lt;br /&gt;\r\nThe Seasonal Subscription – Tulips is here to bring some extra floral joy to the first months of the new year. Expect classic Dutch and delicate double styles in a range of colour-pop shades, as well as speciality fringed and parrot beauties you won\'t find elsewhere.&amp;nbsp;Creating the ultimate gift or treat for yourself.&amp;nbsp;&lt;br /&gt;\r\nFor more on what to expect from your subscription, click&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal/what-to-expect&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;When you start The Seasonal Subscription – you\'re in control, with the option to manage your subscription with just a few clicks.&lt;br /&gt;\r\nFind out more about The Seasonal Subscription&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;Have a question about our flower subscriptions? Get in touch with our team at&amp;nbsp;&lt;a href=&quot;mailto:contact@flowerbx.com&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;contact@flowerbx.com&lt;/a&gt;&amp;nbsp;or find out more in our subscription frequently asked questions&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/frequently-asked-questions&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;'),
(3, 1, 'SIGNATURE', '&lt;p&gt;&lt;strong&gt;THE SEASONAL SUBSCRIPTION - TULIPS&lt;/strong&gt;&lt;br /&gt;\r\n&lt;em&gt;Meet The Seasonal Subscription: Tulips.&lt;br /&gt;\r\nOur curation of what\'s current.&lt;/em&gt;&lt;br /&gt;\r\nFor those who want to embrace the beauty of the seasons from spring to winter, the Seasonal Subscription is for you.&lt;/p&gt;\r\n\r\n&lt;p&gt;Featuring rolling deliveries of the best-in-bloom varieties, changing with the months to celebrate every floral highlight.&lt;br /&gt;\r\nThe Seasonal Subscription – Tulips is here to bring some extra floral joy to the first months of the new year. Expect classic Dutch and delicate double styles in a range of colour-pop shades, as well as speciality fringed and parrot beauties you won\'t find elsewhere.&amp;nbsp;Creating the ultimate gift or treat for yourself.&amp;nbsp;&lt;br /&gt;\r\nFor more on what to expect from your subscription, click&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal/what-to-expect&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;When you start The Seasonal Subscription – you\'re in control, with the option to manage your subscription with just a few clicks.&lt;br /&gt;\r\nFind out more about The Seasonal Subscription&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/seasonal&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;\r\n\r\n&lt;p&gt;Have a question about our flower subscriptions? Get in touch with our team at&amp;nbsp;&lt;a href=&quot;mailto:contact@flowerbx.com&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;contact@flowerbx.com&lt;/a&gt;&amp;nbsp;or find out more in our subscription frequently asked questions&amp;nbsp;&lt;a href=&quot;https://www.flowerbx.com/luxury-flower-subscription/frequently-asked-questions&quot; rel=&quot;noopener&quot; target=&quot;_blank&quot;&gt;here&lt;/a&gt;.&lt;/p&gt;');

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_duration`
--

CREATE TABLE `oc_subscription_plan_duration` (
  `subscription_plan_duration_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `duration` int(11) NOT NULL COMMENT 'Duration in months',
  `label` varchar(255) NOT NULL,
  `price` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_subscription_plan_duration`
--

INSERT INTO `oc_subscription_plan_duration` (`subscription_plan_duration_id`, `subscription_plan_id`, `duration`, `label`, `price`) VALUES
(22, 1, 2, '2 Months', 2.0000),
(23, 1, 4, '4 Months', 4.0000),
(24, 1, 8, '8 Months', 8.0000),
(25, 3, 1, '1 Month', 1.0000),
(26, 3, 2, '2 Months', 2.0000),
(27, 3, 3, '3 Months', 3.0000),
(28, 2, 3, '3 Months', 10.0000),
(29, 2, 6, '6 Months', 10.0000),
(30, 2, 9, '10 Months', 20.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_frequency`
--

CREATE TABLE `oc_subscription_plan_frequency` (
  `subscription_plan_frequency_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `frequency` varchar(10) NOT NULL,
  `cycle` smallint(6) NOT NULL,
  `price` decimal(10,4) NOT NULL DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_subscription_plan_frequency`
--

INSERT INTO `oc_subscription_plan_frequency` (`subscription_plan_frequency_id`, `subscription_plan_id`, `frequency`, `cycle`, `price`) VALUES
(37, 1, 'day', 7, 100.0000),
(38, 1, 'day', 14, 200.0000),
(39, 1, 'day', 28, 300.0000),
(40, 3, 'day', 11, 50.0000),
(41, 3, 'day', 22, 150.0000),
(42, 3, 'day', 33, 250.0000),
(43, 2, 'day', 10, 80.0000),
(44, 2, 'day', 20, 160.0000),
(45, 2, 'day', 30, 240.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_gift`
--

CREATE TABLE `oc_subscription_plan_gift` (
  `subscription_plan_gift_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_subscription_plan_gift`
--

INSERT INTO `oc_subscription_plan_gift` (`subscription_plan_gift_id`, `subscription_plan_id`, `product_id`) VALUES
(13, 1, 42),
(14, 1, 28),
(15, 3, 42),
(16, 3, 47),
(17, 2, 30),
(18, 2, 28);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_image`
--

CREATE TABLE `oc_subscription_plan_image` (
  `subscription_plan_image_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oc_subscription_plan_image`
--

INSERT INTO `oc_subscription_plan_image` (`subscription_plan_image_id`, `subscription_plan_id`, `image`, `sort_order`) VALUES
(13, 3, 'catalog/demo/product/samsungtab.jpg', 0),
(14, 3, 'catalog/demo/hp_3.jpg', 0),
(15, 2, 'catalog/demo/hp_2.jpg', 0),
(16, 2, 'catalog/demo/canon_eos_5d_3.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_related`
--

CREATE TABLE `oc_subscription_plan_related` (
  `subscription_plan_related_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_subscription_plan_related`
--

INSERT INTO `oc_subscription_plan_related` (`subscription_plan_related_id`, `subscription_plan_id`, `product_id`) VALUES
(10, 3, 42),
(11, 3, 30),
(12, 3, 47),
(13, 3, 28);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_plan_vase`
--

CREATE TABLE `oc_subscription_plan_vase` (
  `subscription_plan_vase_id` int(11) NOT NULL,
  `subscription_plan_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `oc_subscription_plan_vase`
--

INSERT INTO `oc_subscription_plan_vase` (`subscription_plan_vase_id`, `subscription_plan_id`, `product_id`) VALUES
(13, 1, 30),
(14, 1, 28),
(15, 3, 42),
(16, 3, 47),
(17, 2, 41),
(18, 2, 28);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_product`
--

CREATE TABLE `oc_subscription_product` (
  `subscription_product_id` int(11) NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT 0,
  `order_product_id` int(11) DEFAULT 0,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT 0,
  `trial_price` decimal(10,4) DEFAULT NULL,
  `trial_tax` decimal(15,4) DEFAULT 0.0000,
  `price` decimal(10,4) DEFAULT NULL,
  `tax` decimal(15,4) DEFAULT 0.0000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription_product`
--

INSERT INTO `oc_subscription_product` (`subscription_product_id`, `subscription_id`, `order_id`, `order_product_id`, `product_id`, `name`, `model`, `quantity`, `trial_price`, `trial_tax`, `price`, `tax`) VALUES
(1, 3, 2, 2, 0, '', '', 1, 0.0000, 0.0000, 90.0000, 0.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_subscription_status`
--

CREATE TABLE `oc_subscription_status` (
  `subscription_status_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_subscription_status`
--

INSERT INTO `oc_subscription_status` (`subscription_status_id`, `language_id`, `name`) VALUES
(1, 1, 'Pending'),
(2, 1, 'Active'),
(3, 1, 'Expired'),
(4, 1, 'Suspended'),
(5, 1, 'Cancelled'),
(6, 1, 'Failed'),
(7, 1, 'Denied');

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_class`
--

CREATE TABLE `oc_tax_class` (
  `tax_class_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_tax_class`
--

INSERT INTO `oc_tax_class` (`tax_class_id`, `title`, `description`) VALUES
(9, 'Taxable Goods', 'Taxed goods'),
(10, 'Downloadable Products', 'Downloadable');

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rate`
--

CREATE TABLE `oc_tax_rate` (
  `tax_rate_id` int(11) NOT NULL,
  `geo_zone_id` int(11) DEFAULT 0,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(15,4) DEFAULT 0.0000,
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_tax_rate`
--

INSERT INTO `oc_tax_rate` (`tax_rate_id`, `geo_zone_id`, `name`, `rate`, `type`) VALUES
(86, 3, 'VAT (20%)', 20.0000, 'P'),
(87, 3, 'Eco Tax (-2.00)', 2.0000, 'F');

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rate_to_customer_group`
--

CREATE TABLE `oc_tax_rate_to_customer_group` (
  `tax_rate_id` int(11) NOT NULL,
  `customer_group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_tax_rate_to_customer_group`
--

INSERT INTO `oc_tax_rate_to_customer_group` (`tax_rate_id`, `customer_group_id`) VALUES
(86, 1),
(87, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rule`
--

CREATE TABLE `oc_tax_rule` (
  `tax_rule_id` int(11) NOT NULL,
  `tax_class_id` int(11) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `based` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_tax_rule`
--

INSERT INTO `oc_tax_rule` (`tax_rule_id`, `tax_class_id`, `tax_rate_id`, `based`, `priority`) VALUES
(120, 10, 87, 'store', 0),
(121, 10, 86, 'payment', 1),
(127, 9, 87, 'shipping', 2),
(128, 9, 86, 'shipping', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_theme`
--

CREATE TABLE `oc_theme` (
  `theme_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `route` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_topic`
--

CREATE TABLE `oc_topic` (
  `topic_id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_topic`
--

INSERT INTO `oc_topic` (`topic_id`, `sort_order`, `status`) VALUES
(1, 0, 1),
(2, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_topic_description`
--

CREATE TABLE `oc_topic_description` (
  `topic_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_topic_description`
--

INSERT INTO `oc_topic_description` (`topic_id`, `language_id`, `name`, `description`, `image`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(1, 1, 'FLOWER CARE', '', '', 'FLOWER CARE', '', ''),
(2, 1, 'EVENTS', '', '', 'EVENTS', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_topic_to_layout`
--

CREATE TABLE `oc_topic_to_layout` (
  `topic_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `layout_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_topic_to_store`
--

CREATE TABLE `oc_topic_to_store` (
  `topic_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_topic_to_store`
--

INSERT INTO `oc_topic_to_store` (`topic_id`, `store_id`) VALUES
(1, 0),
(2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_translation`
--

CREATE TABLE `oc_translation` (
  `translation_id` int(11) NOT NULL,
  `store_id` int(11) DEFAULT 0,
  `language_id` int(11) DEFAULT NULL,
  `route` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_upload`
--

CREATE TABLE `oc_upload` (
  `upload_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_user`
--

CREATE TABLE `oc_user` (
  `user_id` int(11) NOT NULL,
  `user_group_id` int(11) DEFAULT 0,
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_user`
--

INSERT INTO `oc_user` (`user_id`, `user_group_id`, `username`, `password`, `firstname`, `lastname`, `email`, `image`, `ip`, `status`, `date_added`) VALUES
(1, 1, 'admin', '$2y$10$jP9SafzLKfEv1XgCWBShZuAwwRpe/9k8j2ICzevALuc4fTDD3lEta', 'John', 'Doe', 'admin@gmail.com', '', '182.185.150.43', 1, '2025-11-15 13:45:53');

-- --------------------------------------------------------

--
-- Table structure for table `oc_user_authorize`
--

CREATE TABLE `oc_user_authorize` (
  `user_authorize_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(96) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int(11) DEFAULT 0,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `date_added` datetime DEFAULT NULL,
  `date_expire` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_user_group`
--

CREATE TABLE `oc_user_group` (
  `user_group_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_user_group`
--

INSERT INTO `oc_user_group` (`user_group_id`, `name`, `permission`) VALUES
(1, 'Administrator', '{\"access\":[\"catalog\\/attribute\",\"catalog\\/attribute_group\",\"catalog\\/category\",\"catalog\\/download\",\"catalog\\/filter\",\"catalog\\/filter_group\",\"catalog\\/identifier\",\"catalog\\/information\",\"catalog\\/manufacturer\",\"catalog\\/option\",\"catalog\\/product\",\"catalog\\/review\",\"catalog\\/subscription_plan\",\"cms\\/antispam\",\"cms\\/article\",\"cms\\/comment\",\"cms\\/topic\",\"common\\/developer\",\"common\\/filemanager\",\"common\\/security\",\"customer\\/address\",\"customer\\/custom_field\",\"customer\\/customer\",\"customer\\/customer_approval\",\"customer\\/customer_group\",\"customer\\/gdpr\",\"design\\/banner\",\"design\\/homepage\",\"design\\/layout\",\"design\\/seo_url\",\"design\\/theme\",\"design\\/translation\",\"error\\/exception\",\"event\\/modification\",\"extension\\/analytics\",\"extension\\/captcha\",\"extension\\/currency\",\"extension\\/dashboard\",\"extension\\/feed\",\"extension\\/fraud\",\"extension\\/language\",\"extension\\/marketplace\",\"extension\\/module\",\"extension\\/other\",\"extension\\/payment\",\"extension\\/report\",\"extension\\/shipping\",\"extension\\/theme\",\"extension\\/total\",\"localisation\\/address_format\",\"localisation\\/country\",\"localisation\\/currency\",\"localisation\\/geo_zone\",\"localisation\\/language\",\"localisation\\/length_class\",\"localisation\\/location\",\"localisation\\/order_status\",\"localisation\\/return_action\",\"localisation\\/return_reason\",\"localisation\\/return_status\",\"localisation\\/stock_status\",\"localisation\\/subscription_status\",\"localisation\\/tax_class\",\"localisation\\/tax_rate\",\"localisation\\/weight_class\",\"localisation\\/zone\",\"mail\\/affiliate\",\"mail\\/authorize\",\"mail\\/customer\",\"mail\\/forgotten\",\"mail\\/gdpr\",\"mail\\/returns\",\"mail\\/reward\",\"mail\\/subscription\",\"mail\\/transaction\",\"marketing\\/affiliate\",\"marketing\\/contact\",\"marketing\\/coupon\",\"marketing\\/marketing\",\"marketplace\\/api\",\"marketplace\\/cron\",\"marketplace\\/event\",\"marketplace\\/extension\",\"marketplace\\/installer\",\"marketplace\\/marketplace\",\"marketplace\\/modification\",\"marketplace\\/promotion\",\"marketplace\\/startup\",\"report\\/online\",\"report\\/report\",\"report\\/statistics\",\"sale\\/order\",\"sale\\/returns\",\"sale\\/subscription\",\"setting\\/setting\",\"setting\\/store\",\"tool\\/backup\",\"tool\\/log\",\"tool\\/notification\",\"tool\\/upgrade\",\"tool\\/upload\",\"user\\/api\",\"user\\/profile\",\"user\\/user\",\"user\\/user_permission\",\"extension\\/opencart\\/api\\/coupon\",\"extension\\/opencart\\/api\\/reward\",\"extension\\/opencart\\/captcha\\/basic\",\"extension\\/opencart\\/currency\\/ecb\",\"extension\\/opencart\\/currency\\/fixer\",\"extension\\/opencart\\/dashboard\\/activity\",\"extension\\/opencart\\/dashboard\\/chart\",\"extension\\/opencart\\/dashboard\\/customer\",\"extension\\/opencart\\/dashboard\\/map\",\"extension\\/opencart\\/dashboard\\/online\",\"extension\\/opencart\\/dashboard\\/order\",\"extension\\/opencart\\/dashboard\\/recent\",\"extension\\/opencart\\/dashboard\\/sale\",\"extension\\/opencart\\/fraud\\/ddos\",\"extension\\/opencart\\/fraud\\/ip\",\"extension\\/opencart\\/module\\/account\",\"extension\\/opencart\\/module\\/banner\",\"extension\\/opencart\\/module\\/bestseller\",\"extension\\/opencart\\/module\\/blog\",\"extension\\/opencart\\/module\\/category\",\"extension\\/opencart\\/module\\/featured\",\"extension\\/opencart\\/module\\/filter\",\"extension\\/opencart\\/module\\/html\",\"extension\\/opencart\\/module\\/information\",\"extension\\/opencart\\/module\\/latest\",\"extension\\/opencart\\/module\\/special\",\"extension\\/opencart\\/module\\/store\",\"extension\\/opencart\\/module\\/topic\",\"extension\\/opencart\\/payment\\/bank_transfer\",\"extension\\/opencart\\/payment\\/cheque\",\"extension\\/opencart\\/payment\\/cod\",\"extension\\/opencart\\/payment\\/free_checkout\",\"extension\\/opencart\\/report\\/customer\",\"extension\\/opencart\\/report\\/customer_activity\",\"extension\\/opencart\\/report\\/customer_order\",\"extension\\/opencart\\/report\\/customer_reward\",\"extension\\/opencart\\/report\\/customer_search\",\"extension\\/opencart\\/report\\/customer_transaction\",\"extension\\/opencart\\/report\\/marketing\",\"extension\\/opencart\\/report\\/product_purchased\",\"extension\\/opencart\\/report\\/product_viewed\",\"extension\\/opencart\\/report\\/sale_coupon\",\"extension\\/opencart\\/report\\/sale_order\",\"extension\\/opencart\\/report\\/sale_return\",\"extension\\/opencart\\/report\\/sale_shipping\",\"extension\\/opencart\\/report\\/sale_tax\",\"extension\\/opencart\\/report\\/subscription\",\"extension\\/opencart\\/shipping\\/flat\",\"extension\\/opencart\\/shipping\\/free\",\"extension\\/opencart\\/shipping\\/item\",\"extension\\/opencart\\/shipping\\/pickup\",\"extension\\/opencart\\/shipping\\/weight\",\"extension\\/opencart\\/theme\\/basic\",\"extension\\/opencart\\/total\\/coupon\",\"extension\\/opencart\\/total\\/credit\",\"extension\\/opencart\\/total\\/handling\",\"extension\\/opencart\\/total\\/low_order_fee\",\"extension\\/opencart\\/total\\/reward\",\"extension\\/opencart\\/total\\/shipping\",\"extension\\/opencart\\/total\\/sub_total\",\"extension\\/opencart\\/total\\/tax\",\"extension\\/opencart\\/total\\/total\"],\"modify\":[\"catalog\\/attribute\",\"catalog\\/attribute_group\",\"catalog\\/category\",\"catalog\\/download\",\"catalog\\/filter\",\"catalog\\/filter_group\",\"catalog\\/identifier\",\"catalog\\/information\",\"catalog\\/manufacturer\",\"catalog\\/option\",\"catalog\\/product\",\"catalog\\/review\",\"catalog\\/subscription_plan\",\"cms\\/antispam\",\"cms\\/article\",\"cms\\/comment\",\"cms\\/topic\",\"common\\/developer\",\"common\\/filemanager\",\"common\\/security\",\"customer\\/address\",\"customer\\/custom_field\",\"customer\\/customer\",\"customer\\/customer_approval\",\"customer\\/customer_group\",\"customer\\/gdpr\",\"design\\/banner\",\"design\\/homepage\",\"design\\/layout\",\"design\\/seo_url\",\"design\\/theme\",\"design\\/translation\",\"error\\/exception\",\"event\\/modification\",\"extension\\/analytics\",\"extension\\/captcha\",\"extension\\/currency\",\"extension\\/dashboard\",\"extension\\/feed\",\"extension\\/fraud\",\"extension\\/language\",\"extension\\/marketplace\",\"extension\\/module\",\"extension\\/other\",\"extension\\/payment\",\"extension\\/report\",\"extension\\/shipping\",\"extension\\/theme\",\"extension\\/total\",\"localisation\\/address_format\",\"localisation\\/country\",\"localisation\\/currency\",\"localisation\\/geo_zone\",\"localisation\\/language\",\"localisation\\/length_class\",\"localisation\\/location\",\"localisation\\/order_status\",\"localisation\\/return_action\",\"localisation\\/return_reason\",\"localisation\\/return_status\",\"localisation\\/stock_status\",\"localisation\\/subscription_status\",\"localisation\\/tax_class\",\"localisation\\/tax_rate\",\"localisation\\/weight_class\",\"localisation\\/zone\",\"mail\\/affiliate\",\"mail\\/authorize\",\"mail\\/customer\",\"mail\\/forgotten\",\"mail\\/gdpr\",\"mail\\/returns\",\"mail\\/reward\",\"mail\\/subscription\",\"mail\\/transaction\",\"marketing\\/affiliate\",\"marketing\\/contact\",\"marketing\\/coupon\",\"marketing\\/marketing\",\"marketplace\\/api\",\"marketplace\\/cron\",\"marketplace\\/event\",\"marketplace\\/extension\",\"marketplace\\/installer\",\"marketplace\\/marketplace\",\"marketplace\\/modification\",\"marketplace\\/promotion\",\"marketplace\\/startup\",\"report\\/online\",\"report\\/report\",\"report\\/statistics\",\"sale\\/order\",\"sale\\/returns\",\"sale\\/subscription\",\"setting\\/setting\",\"setting\\/store\",\"tool\\/backup\",\"tool\\/log\",\"tool\\/notification\",\"tool\\/upgrade\",\"tool\\/upload\",\"user\\/api\",\"user\\/profile\",\"user\\/user\",\"user\\/user_permission\",\"extension\\/opencart\\/api\\/coupon\",\"extension\\/opencart\\/api\\/reward\",\"extension\\/opencart\\/captcha\\/basic\",\"extension\\/opencart\\/currency\\/ecb\",\"extension\\/opencart\\/currency\\/fixer\",\"extension\\/opencart\\/dashboard\\/activity\",\"extension\\/opencart\\/dashboard\\/chart\",\"extension\\/opencart\\/dashboard\\/customer\",\"extension\\/opencart\\/dashboard\\/map\",\"extension\\/opencart\\/dashboard\\/online\",\"extension\\/opencart\\/dashboard\\/order\",\"extension\\/opencart\\/dashboard\\/recent\",\"extension\\/opencart\\/dashboard\\/sale\",\"extension\\/opencart\\/fraud\\/ddos\",\"extension\\/opencart\\/fraud\\/ip\",\"extension\\/opencart\\/module\\/account\",\"extension\\/opencart\\/module\\/banner\",\"extension\\/opencart\\/module\\/bestseller\",\"extension\\/opencart\\/module\\/blog\",\"extension\\/opencart\\/module\\/category\",\"extension\\/opencart\\/module\\/featured\",\"extension\\/opencart\\/module\\/filter\",\"extension\\/opencart\\/module\\/html\",\"extension\\/opencart\\/module\\/information\",\"extension\\/opencart\\/module\\/latest\",\"extension\\/opencart\\/module\\/special\",\"extension\\/opencart\\/module\\/store\",\"extension\\/opencart\\/module\\/topic\",\"extension\\/opencart\\/payment\\/bank_transfer\",\"extension\\/opencart\\/payment\\/cheque\",\"extension\\/opencart\\/payment\\/cod\",\"extension\\/opencart\\/payment\\/free_checkout\",\"extension\\/opencart\\/report\\/customer\",\"extension\\/opencart\\/report\\/customer_activity\",\"extension\\/opencart\\/report\\/customer_order\",\"extension\\/opencart\\/report\\/customer_reward\",\"extension\\/opencart\\/report\\/customer_search\",\"extension\\/opencart\\/report\\/customer_transaction\",\"extension\\/opencart\\/report\\/marketing\",\"extension\\/opencart\\/report\\/product_purchased\",\"extension\\/opencart\\/report\\/product_viewed\",\"extension\\/opencart\\/report\\/sale_coupon\",\"extension\\/opencart\\/report\\/sale_order\",\"extension\\/opencart\\/report\\/sale_return\",\"extension\\/opencart\\/report\\/sale_shipping\",\"extension\\/opencart\\/report\\/sale_tax\",\"extension\\/opencart\\/report\\/subscription\",\"extension\\/opencart\\/shipping\\/flat\",\"extension\\/opencart\\/shipping\\/free\",\"extension\\/opencart\\/shipping\\/item\",\"extension\\/opencart\\/shipping\\/pickup\",\"extension\\/opencart\\/shipping\\/weight\",\"extension\\/opencart\\/theme\\/basic\",\"extension\\/opencart\\/total\\/coupon\",\"extension\\/opencart\\/total\\/credit\",\"extension\\/opencart\\/total\\/handling\",\"extension\\/opencart\\/total\\/low_order_fee\",\"extension\\/opencart\\/total\\/reward\",\"extension\\/opencart\\/total\\/shipping\",\"extension\\/opencart\\/total\\/sub_total\",\"extension\\/opencart\\/total\\/tax\",\"extension\\/opencart\\/total\\/total\"]}'),
(2, 'Demonstration', ''),
(3, 'Marketing', ''),
(4, 'Product Data Entry', ''),
(5, 'Order Processing', ''),
(6, 'Accounting', ''),
(7, 'Customer Service', ''),
(8, 'Analysis', ''),
(9, 'Content WritIng', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_user_login`
--

CREATE TABLE `oc_user_login` (
  `user_login_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_user_login`
--

INSERT INTO `oc_user_login` (`user_login_id`, `user_id`, `ip`, `user_agent`, `date_added`) VALUES
(1, 1, '39.37.166.26', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-15 15:57:10'),
(2, 1, '182.185.150.5', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 19:35:03'),
(3, 1, '78.175.175.184', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-17 19:59:22'),
(4, 1, '154.80.9.18', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-18 18:37:03'),
(5, 1, '39.37.159.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-19 10:37:42'),
(6, 1, '78.191.5.187', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-20 07:40:02'),
(7, 1, '39.37.159.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-20 08:24:59'),
(8, 1, '39.37.159.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-21 12:52:59'),
(9, 1, '39.37.159.146', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-22 10:27:01'),
(10, 1, '182.185.156.108', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-25 10:08:22'),
(11, 1, '182.185.139.135', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-25 16:30:32'),
(12, 1, '182.185.139.135', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-11-26 12:53:16'),
(13, 1, '39.37.164.110', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-05 11:02:08'),
(14, 1, '39.37.138.162', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-24 10:40:44'),
(15, 1, '39.37.138.162', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-26 14:51:19'),
(16, 1, '39.49.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-29 09:13:03'),
(17, 1, '78.191.22.148', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-29 13:26:32'),
(18, 1, '39.49.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-31 11:01:28'),
(19, 1, '39.49.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-31 13:33:38'),
(20, 1, '39.49.150.50', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2025-12-31 15:00:52'),
(21, 1, '182.185.137.5', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-01 15:54:05'),
(22, 1, '182.185.137.5', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-02 13:12:44'),
(23, 1, '182.185.137.5', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-02 13:34:12'),
(24, 1, '39.37.129.156', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-03 11:38:47'),
(25, 1, '119.155.4.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-05 08:55:12'),
(26, 1, '119.155.37.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-14 14:08:58'),
(27, 1, '182.185.150.43', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2026-01-16 11:26:04');

-- --------------------------------------------------------

--
-- Table structure for table `oc_user_token`
--

CREATE TABLE `oc_user_token` (
  `user_token_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `oc_weight_class`
--

CREATE TABLE `oc_weight_class` (
  `weight_class_id` int(11) NOT NULL,
  `value` decimal(15,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_weight_class`
--

INSERT INTO `oc_weight_class` (`weight_class_id`, `value`) VALUES
(1, 1.00000000),
(2, 1000.00000000),
(3, 2.20460000),
(4, 35.27400000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_weight_class_description`
--

CREATE TABLE `oc_weight_class_description` (
  `weight_class_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `title` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_weight_class_description`
--

INSERT INTO `oc_weight_class_description` (`weight_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'Kilogram', 'kg'),
(2, 1, 'Gram', 'g'),
(3, 1, 'Pound ', 'lb'),
(4, 1, 'Ounce', 'oz');

-- --------------------------------------------------------

--
-- Table structure for table `oc_zone`
--

CREATE TABLE `oc_zone` (
  `zone_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `code` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_zone`
--

INSERT INTO `oc_zone` (`zone_id`, `country_id`, `code`, `status`) VALUES
(4660, 259, '', 1),
(4661, 259, '', 1),
(4662, 259, '', 1),
(4663, 259, '', 1),
(4664, 259, '', 1),
(4665, 259, '', 1),
(4666, 259, '', 1),
(4667, 259, '', 1),
(4668, 259, '', 1),
(4669, 259, '', 1),
(4670, 259, '', 1),
(4671, 259, '', 1),
(4672, 259, '', 1),
(4673, 259, '', 1),
(4674, 259, '', 1),
(4675, 259, '', 1),
(4676, 259, '', 1),
(4677, 259, '', 1),
(4678, 259, '', 1),
(4679, 259, '', 1),
(4680, 259, '', 1),
(4681, 259, '', 1),
(4682, 259, '', 1),
(4683, 259, '', 1),
(4684, 259, '', 1),
(4685, 259, '', 1),
(4686, 259, '', 1),
(4687, 259, '', 1),
(4688, 259, '', 1),
(4689, 259, '', 1),
(4690, 259, '', 1),
(4691, 259, '', 1),
(4692, 259, '', 1),
(4693, 259, '', 1),
(4694, 259, '', 1),
(4695, 259, '', 1),
(4696, 259, '', 1),
(4697, 259, '', 1),
(4698, 259, '', 1),
(4699, 260, '', 1),
(4700, 260, '', 1),
(4701, 260, '', 1),
(4702, 260, '', 1),
(4703, 260, '', 1),
(4704, 260, '', 1),
(4705, 260, '', 1),
(4706, 260, '', 1),
(4707, 260, '', 1),
(4708, 260, '', 1),
(4709, 260, '', 1),
(4710, 260, '', 1),
(4711, 260, '', 1),
(4712, 260, '', 1),
(4713, 260, '', 1),
(4714, 260, '', 1),
(4715, 260, '', 1),
(4716, 260, '', 1),
(4717, 260, '', 1),
(4718, 260, '', 1),
(4719, 260, '', 1),
(4720, 260, '', 1),
(4721, 260, '', 1),
(4722, 260, '', 1),
(4723, 260, '', 1),
(4724, 261, '', 1),
(4725, 261, '', 1),
(4726, 261, '', 1),
(4727, 261, '', 1),
(4728, 261, '', 1),
(4729, 261, '', 1),
(4730, 261, '', 1),
(4731, 261, '', 1),
(4732, 261, '', 1),
(4733, 261, '', 1),
(4734, 261, '', 1),
(4735, 261, '', 1),
(4736, 261, '', 1),
(4737, 261, '', 1),
(4738, 261, '', 1),
(4739, 261, '', 1),
(4740, 261, '', 1),
(4741, 261, '', 1),
(4742, 261, '', 1),
(4743, 261, '', 1),
(4744, 261, '', 1),
(4745, 261, '', 1),
(4746, 261, '', 1),
(4747, 261, '', 1),
(4748, 261, '', 1),
(4749, 261, '', 1),
(4750, 261, '', 1),
(4751, 261, '', 1),
(4752, 261, '', 1),
(4753, 261, '', 1),
(4754, 262, '', 1),
(4755, 262, '', 1),
(4756, 262, '', 1),
(4757, 262, '', 1),
(4758, 262, '', 1),
(4759, 262, '', 1),
(4760, 262, '', 1),
(4761, 262, '', 1),
(4762, 262, '', 1),
(4763, 262, '', 1),
(4764, 262, '', 1),
(4765, 262, '', 1),
(4766, 262, '', 1),
(4767, 262, '', 1),
(4768, 262, '', 1),
(4769, 262, '', 1),
(4770, 262, '', 1),
(4771, 262, '', 1),
(4772, 262, '', 1),
(4773, 263, '', 1),
(4774, 263, '', 1),
(4775, 263, '', 1),
(4776, 263, '', 1),
(4777, 263, '', 1),
(4778, 263, '', 1),
(4779, 263, '', 1),
(4780, 263, '', 1),
(4781, 263, '', 1),
(4782, 263, '', 1),
(4783, 263, '', 1),
(4784, 263, '', 1),
(4785, 263, '', 1),
(4786, 263, '', 1),
(4787, 263, '', 1),
(4788, 263, '', 1),
(4789, 263, '', 1),
(4790, 264, '', 1),
(4791, 264, '', 1),
(4792, 264, '', 1),
(4793, 264, '', 1),
(4794, 264, '', 1),
(4795, 264, '', 1),
(4796, 264, '', 1),
(4797, 264, '', 1),
(4798, 264, '', 1),
(4799, 264, '', 1),
(4800, 264, '', 1),
(4801, 264, '', 1),
(4802, 264, '', 1),
(4803, 264, '', 1),
(4804, 264, '', 1),
(4805, 265, '', 1),
(4806, 265, '', 1),
(4807, 265, '', 1),
(4808, 265, '', 1),
(4809, 265, '', 1),
(4810, 265, '', 1),
(4811, 265, '', 1),
(4812, 265, '', 1),
(4813, 265, '', 1),
(4814, 266, '', 1),
(4815, 266, '', 1),
(4816, 266, '', 1),
(4817, 266, '', 1),
(4818, 266, '', 1),
(4819, 266, '', 1),
(4820, 266, '', 1),
(4821, 266, '', 1),
(4822, 266, '', 1),
(4823, 266, '', 1),
(4824, 266, '', 1),
(4825, 266, '', 1),
(4826, 266, '', 1),
(4827, 266, '', 1),
(4828, 266, '', 1),
(4829, 266, '', 1),
(4830, 266, '', 1),
(4831, 266, '', 1),
(4832, 266, '', 1),
(4833, 266, '', 1),
(4834, 266, '', 1),
(4835, 266, '', 1),
(4836, 266, '', 1),
(4837, 266, '', 1),
(4838, 266, '', 1),
(4839, 266, '', 1),
(4840, 266, '', 1),
(4841, 266, '', 1),
(4842, 266, '', 1),
(4843, 266, '', 1),
(4844, 266, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_zone_description`
--

CREATE TABLE `oc_zone_description` (
  `zone_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_zone_description`
--

INSERT INTO `oc_zone_description` (`zone_id`, `language_id`, `name`) VALUES
(4660, 1, 'Adalar'),
(4814, 1, 'Ahırlı'),
(4815, 1, 'Akören'),
(4816, 1, 'Akşehir'),
(4754, 1, 'Akseki'),
(4755, 1, 'Aksu'),
(4699, 1, 'Akyurt'),
(4790, 1, 'Aladağ'),
(4756, 1, 'Alanya'),
(4724, 1, 'Aliağa'),
(4700, 1, 'Altındağ'),
(4817, 1, 'Altınekin'),
(4805, 1, 'Araban'),
(4661, 1, 'Arnavutköy'),
(4662, 1, 'Ataşehir'),
(4663, 1, 'Avcılar'),
(4701, 1, 'Ayaş'),
(4664, 1, 'Bağcılar'),
(4665, 1, 'Bahçelievler'),
(4666, 1, 'Bakırköy'),
(4702, 1, 'Balâ'),
(4725, 1, 'Balçova'),
(4667, 1, 'Başakşehir'),
(4726, 1, 'Bayındır'),
(4727, 1, 'Bayraklı'),
(4668, 1, 'Bayrampaşa'),
(4728, 1, 'Bergama'),
(4669, 1, 'Beşiktaş'),
(4729, 1, 'Beydağ'),
(4670, 1, 'Beykoz'),
(4671, 1, 'Beylikdüzü'),
(4672, 1, 'Beyoğlu'),
(4703, 1, 'Beypazarı'),
(4818, 1, 'Beyşehir'),
(4730, 1, 'Bornova'),
(4819, 1, 'Bozkır'),
(4731, 1, 'Buca'),
(4673, 1, 'Büyükçekmece'),
(4773, 1, 'Büyükorhan'),
(4704, 1, 'Çamlıdere'),
(4705, 1, 'Çankaya'),
(4674, 1, 'Çatalca'),
(4675, 1, 'Çekmeköy'),
(4821, 1, 'Çeltik'),
(4732, 1, 'Çeşme'),
(4791, 1, 'Ceyhan'),
(4733, 1, 'Çiğli'),
(4820, 1, 'Cihanbeyli'),
(4706, 1, 'Çubuk'),
(4792, 1, 'Çukurova'),
(4822, 1, 'Çumra'),
(4757, 1, 'Demre'),
(4823, 1, 'Derbent'),
(4824, 1, 'Derebucak'),
(4734, 1, 'Dikili'),
(4825, 1, 'Doğanhisar'),
(4758, 1, 'Döşemealtı'),
(4707, 1, 'Elmadağ'),
(4759, 1, 'Elmalı'),
(4826, 1, 'Emirgazi'),
(4827, 1, 'Ereğli'),
(4676, 1, 'Esenler'),
(4677, 1, 'Esenyurt'),
(4708, 1, 'Etimesgut'),
(4709, 1, 'Evren'),
(4678, 1, 'Eyüpsultan'),
(4679, 1, 'Fatih'),
(4793, 1, 'Feke'),
(4760, 1, 'Finike'),
(4735, 1, 'Foça'),
(4736, 1, 'Gaziemir'),
(4680, 1, 'Gaziosmanpaşa'),
(4761, 1, 'Gazipaşa'),
(4774, 1, 'Gemlik'),
(4710, 1, 'Gölbaşı'),
(4711, 1, 'Güdül'),
(4762, 1, 'Gündoğmuş'),
(4828, 1, 'Güneysınır'),
(4681, 1, 'Güngören'),
(4775, 1, 'Gürsu'),
(4737, 1, 'Güzelbahçe'),
(4829, 1, 'Hadim'),
(4830, 1, 'Halkapınar'),
(4776, 1, 'Harmancık'),
(4712, 1, 'Haymana'),
(4831, 1, 'Hüyük'),
(4763, 1, 'İbradı'),
(4832, 1, 'Ilgın'),
(4794, 1, 'İmamoğlu'),
(4777, 1, 'İnegöl'),
(4806, 1, 'İslahiye'),
(4778, 1, 'İznik'),
(4682, 1, 'Kadıköy'),
(4833, 1, 'Kadınhanı'),
(4683, 1, 'Kağıthane'),
(4713, 1, 'Kahramankazan'),
(4714, 1, 'Kalecik'),
(4738, 1, 'Karabağlar'),
(4739, 1, 'Karaburun'),
(4779, 1, 'Karacabey'),
(4795, 1, 'Karaisalı'),
(4834, 1, 'Karapınar'),
(4796, 1, 'Karataş'),
(4835, 1, 'Karatay'),
(4807, 1, 'Karkamış'),
(4740, 1, 'Karşıyaka'),
(4684, 1, 'Kartal'),
(4764, 1, 'Kaş'),
(4715, 1, 'Keçiören'),
(4780, 1, 'Keles'),
(4741, 1, 'Kemalpaşa'),
(4765, 1, 'Kemer'),
(4766, 1, 'Kepez'),
(4781, 1, 'Kestel'),
(4743, 1, 'Kiraz'),
(4742, 1, 'Kınık'),
(4716, 1, 'Kızılcahamam'),
(4744, 1, 'Konak'),
(4767, 1, 'Konyaaltı'),
(4768, 1, 'Korkuteli'),
(4797, 1, 'Kozan'),
(4685, 1, 'Küçükçekmece'),
(4836, 1, 'Kulu'),
(4769, 1, 'Kumluca'),
(4686, 1, 'Maltepe'),
(4717, 1, 'Mamak'),
(4770, 1, 'Manavgat'),
(4745, 1, 'Menderes'),
(4746, 1, 'Menemen'),
(4837, 1, 'Meram'),
(4782, 1, 'Mudanya'),
(4771, 1, 'Muratpaşa'),
(4783, 1, 'Mustafakemalpaşa'),
(4718, 1, 'Nallıhan'),
(4747, 1, 'Narlıdere'),
(4784, 1, 'Nilüfer'),
(4808, 1, 'Nizip'),
(4809, 1, 'Nurdağı'),
(4748, 1, 'Ödemiş'),
(4810, 1, 'Oğuzeli'),
(4785, 1, 'Orhaneli'),
(4786, 1, 'Orhangazi'),
(4787, 1, 'Osmangazi'),
(4687, 1, 'Pendik'),
(4719, 1, 'Polatlı'),
(4798, 1, 'Pozantı'),
(4720, 1, 'Pursaklar'),
(4811, 1, 'Şahinbey'),
(4799, 1, 'Saimbeyli'),
(4688, 1, 'Sancaktepe'),
(4838, 1, 'Sarayönü'),
(4800, 1, 'Sarıçam'),
(4689, 1, 'Sarıyer'),
(4749, 1, 'Seferihisar'),
(4812, 1, 'Şehitkamil'),
(4750, 1, 'Selçuk'),
(4839, 1, 'Selçuklu'),
(4722, 1, 'Şereflikoçhisar'),
(4772, 1, 'Serik'),
(4840, 1, 'Seydişehir'),
(4801, 1, 'Seyhan'),
(4693, 1, 'Şile'),
(4690, 1, 'Silivri'),
(4721, 1, 'Sincan'),
(4694, 1, 'Şişli'),
(4691, 1, 'Sultanbeyli'),
(4692, 1, 'Sultangazi'),
(4841, 1, 'Taşkent'),
(4751, 1, 'Tire'),
(4752, 1, 'Torbalı'),
(4802, 1, 'Tufanbeyli'),
(4695, 1, 'Tuzla'),
(4842, 1, 'Tuzlukçu'),
(4696, 1, 'Ümraniye'),
(4753, 1, 'Urla'),
(4697, 1, 'Üsküdar'),
(4843, 1, 'Yalıhüyük'),
(4813, 1, 'Yavuzeli'),
(4723, 1, 'Yenimahalle'),
(4788, 1, 'Yenişehir'),
(4789, 1, 'Yıldırım'),
(4803, 1, 'Yumurtalık'),
(4844, 1, 'Yunak'),
(4804, 1, 'Yüreğir'),
(4698, 1, 'Zeytinburnu');

-- --------------------------------------------------------

--
-- Table structure for table `oc_zone_to_geo_zone`
--

CREATE TABLE `oc_zone_to_geo_zone` (
  `zone_to_geo_zone_id` int(11) NOT NULL,
  `geo_zone_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `zone_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `oc_zone_to_geo_zone`
--

INSERT INTO `oc_zone_to_geo_zone` (`zone_to_geo_zone_id`, `geo_zone_id`, `country_id`, `zone_id`) VALUES
(1, 4, 222, 0),
(2, 3, 222, 3513),
(3, 3, 222, 3514),
(4, 3, 222, 3515),
(5, 3, 222, 3516),
(6, 3, 222, 3517),
(7, 3, 222, 3518),
(8, 3, 222, 3519),
(9, 3, 222, 3520),
(10, 3, 222, 3521),
(11, 3, 222, 3522),
(12, 3, 222, 3523),
(13, 3, 222, 3524),
(14, 3, 222, 3525),
(15, 3, 222, 3526),
(16, 3, 222, 3527),
(17, 3, 222, 3528),
(18, 3, 222, 3529),
(19, 3, 222, 3530),
(20, 3, 222, 3531),
(21, 3, 222, 3532),
(22, 3, 222, 3533),
(23, 3, 222, 3534),
(24, 3, 222, 3535),
(25, 3, 222, 3536),
(26, 3, 222, 3537),
(27, 3, 222, 3538),
(28, 3, 222, 3539),
(29, 3, 222, 3540),
(30, 3, 222, 3541),
(31, 3, 222, 3542),
(32, 3, 222, 3543),
(33, 3, 222, 3544),
(34, 3, 222, 3545),
(35, 3, 222, 3546),
(36, 3, 222, 3547),
(37, 3, 222, 3548),
(38, 3, 222, 3549),
(39, 3, 222, 3550),
(40, 3, 222, 3551),
(41, 3, 222, 3552),
(42, 3, 222, 3553),
(43, 3, 222, 3554),
(44, 3, 222, 3555),
(45, 3, 222, 3556),
(46, 3, 222, 3557),
(47, 3, 222, 3558),
(48, 3, 222, 3559),
(49, 3, 222, 3560),
(50, 3, 222, 3561),
(51, 3, 222, 3562),
(52, 3, 222, 3563),
(53, 3, 222, 3564),
(54, 3, 222, 3565),
(55, 3, 222, 3566),
(56, 3, 222, 3567),
(57, 3, 222, 3568),
(58, 3, 222, 3569),
(59, 3, 222, 3570),
(60, 3, 222, 3571),
(61, 3, 222, 3572),
(62, 3, 222, 3573),
(63, 3, 222, 3574),
(64, 3, 222, 3575),
(65, 3, 222, 3576),
(66, 3, 222, 3577),
(67, 3, 222, 3578),
(68, 3, 222, 3579),
(69, 3, 222, 3580),
(70, 3, 222, 3581),
(71, 3, 222, 3582),
(72, 3, 222, 3583),
(73, 3, 222, 3584),
(74, 3, 222, 3585),
(75, 3, 222, 3586),
(76, 3, 222, 3587),
(77, 3, 222, 3588),
(78, 3, 222, 3589),
(79, 3, 222, 3590),
(80, 3, 222, 3591),
(81, 3, 222, 3592),
(82, 3, 222, 3593),
(83, 3, 222, 3594),
(84, 3, 222, 3595),
(85, 3, 222, 3596),
(86, 3, 222, 3597),
(87, 3, 222, 3598),
(88, 3, 222, 3599),
(89, 3, 222, 3600),
(90, 3, 222, 3601),
(91, 3, 222, 3602),
(92, 3, 222, 3603),
(93, 3, 222, 3604),
(94, 3, 222, 3605),
(95, 3, 222, 3606),
(96, 3, 222, 3607),
(97, 3, 222, 3608),
(98, 3, 222, 3609),
(99, 3, 222, 3610),
(100, 3, 222, 3611),
(101, 3, 222, 3612),
(102, 3, 222, 3949),
(103, 3, 222, 3950),
(104, 3, 222, 3951),
(105, 3, 222, 3952),
(106, 3, 222, 3953),
(107, 3, 222, 3954),
(108, 3, 222, 3955);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oc_address`
--
ALTER TABLE `oc_address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `oc_address_format`
--
ALTER TABLE `oc_address_format`
  ADD PRIMARY KEY (`address_format_id`);

--
-- Indexes for table `oc_antispam`
--
ALTER TABLE `oc_antispam`
  ADD PRIMARY KEY (`antispam_id`),
  ADD KEY `keyword` (`keyword`);

--
-- Indexes for table `oc_api`
--
ALTER TABLE `oc_api`
  ADD PRIMARY KEY (`api_id`);

--
-- Indexes for table `oc_api_history`
--
ALTER TABLE `oc_api_history`
  ADD PRIMARY KEY (`api_history_id`);

--
-- Indexes for table `oc_api_ip`
--
ALTER TABLE `oc_api_ip`
  ADD PRIMARY KEY (`api_ip_id`);

--
-- Indexes for table `oc_article`
--
ALTER TABLE `oc_article`
  ADD PRIMARY KEY (`article_id`);

--
-- Indexes for table `oc_article_comment`
--
ALTER TABLE `oc_article_comment`
  ADD PRIMARY KEY (`article_comment_id`),
  ADD KEY `article_id` (`article_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `oc_article_description`
--
ALTER TABLE `oc_article_description`
  ADD PRIMARY KEY (`article_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_article_rating`
--
ALTER TABLE `oc_article_rating`
  ADD PRIMARY KEY (`article_rating_id`),
  ADD KEY `article_comment_id` (`article_comment_id`),
  ADD KEY `article_id` (`article_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `oc_article_to_layout`
--
ALTER TABLE `oc_article_to_layout`
  ADD PRIMARY KEY (`article_id`,`store_id`);

--
-- Indexes for table `oc_article_to_store`
--
ALTER TABLE `oc_article_to_store`
  ADD PRIMARY KEY (`article_id`,`store_id`);

--
-- Indexes for table `oc_attribute`
--
ALTER TABLE `oc_attribute`
  ADD PRIMARY KEY (`attribute_id`);

--
-- Indexes for table `oc_attribute_description`
--
ALTER TABLE `oc_attribute_description`
  ADD PRIMARY KEY (`attribute_id`,`language_id`);

--
-- Indexes for table `oc_attribute_group`
--
ALTER TABLE `oc_attribute_group`
  ADD PRIMARY KEY (`attribute_group_id`);

--
-- Indexes for table `oc_attribute_group_description`
--
ALTER TABLE `oc_attribute_group_description`
  ADD PRIMARY KEY (`attribute_group_id`,`language_id`);

--
-- Indexes for table `oc_banner`
--
ALTER TABLE `oc_banner`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `oc_banner_image`
--
ALTER TABLE `oc_banner_image`
  ADD PRIMARY KEY (`banner_image_id`);

--
-- Indexes for table `oc_cart`
--
ALTER TABLE `oc_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `cart_id` (`customer_id`,`session_id`,`product_id`,`subscription_plan_id`);

--
-- Indexes for table `oc_category`
--
ALTER TABLE `oc_category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `oc_category_description`
--
ALTER TABLE `oc_category_description`
  ADD PRIMARY KEY (`category_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_category_filter`
--
ALTER TABLE `oc_category_filter`
  ADD PRIMARY KEY (`category_id`,`filter_id`);

--
-- Indexes for table `oc_category_path`
--
ALTER TABLE `oc_category_path`
  ADD PRIMARY KEY (`category_id`,`path_id`);

--
-- Indexes for table `oc_category_to_layout`
--
ALTER TABLE `oc_category_to_layout`
  ADD PRIMARY KEY (`category_id`,`store_id`);

--
-- Indexes for table `oc_category_to_store`
--
ALTER TABLE `oc_category_to_store`
  ADD PRIMARY KEY (`category_id`,`store_id`);

--
-- Indexes for table `oc_country`
--
ALTER TABLE `oc_country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `oc_country_description`
--
ALTER TABLE `oc_country_description`
  ADD PRIMARY KEY (`country_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_coupon`
--
ALTER TABLE `oc_coupon`
  ADD PRIMARY KEY (`coupon_id`);

--
-- Indexes for table `oc_coupon_category`
--
ALTER TABLE `oc_coupon_category`
  ADD PRIMARY KEY (`coupon_id`,`category_id`);

--
-- Indexes for table `oc_coupon_history`
--
ALTER TABLE `oc_coupon_history`
  ADD PRIMARY KEY (`coupon_history_id`);

--
-- Indexes for table `oc_coupon_product`
--
ALTER TABLE `oc_coupon_product`
  ADD PRIMARY KEY (`coupon_product_id`);

--
-- Indexes for table `oc_cron`
--
ALTER TABLE `oc_cron`
  ADD PRIMARY KEY (`cron_id`);

--
-- Indexes for table `oc_currency`
--
ALTER TABLE `oc_currency`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `oc_customer`
--
ALTER TABLE `oc_customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `oc_customer_activity`
--
ALTER TABLE `oc_customer_activity`
  ADD PRIMARY KEY (`customer_activity_id`);

--
-- Indexes for table `oc_customer_affiliate`
--
ALTER TABLE `oc_customer_affiliate`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `oc_customer_affiliate_report`
--
ALTER TABLE `oc_customer_affiliate_report`
  ADD PRIMARY KEY (`customer_affiliate_report_id`);

--
-- Indexes for table `oc_customer_approval`
--
ALTER TABLE `oc_customer_approval`
  ADD PRIMARY KEY (`customer_approval_id`);

--
-- Indexes for table `oc_customer_authorize`
--
ALTER TABLE `oc_customer_authorize`
  ADD PRIMARY KEY (`customer_authorize_id`);

--
-- Indexes for table `oc_customer_group`
--
ALTER TABLE `oc_customer_group`
  ADD PRIMARY KEY (`customer_group_id`);

--
-- Indexes for table `oc_customer_group_description`
--
ALTER TABLE `oc_customer_group_description`
  ADD PRIMARY KEY (`customer_group_id`,`language_id`);

--
-- Indexes for table `oc_customer_history`
--
ALTER TABLE `oc_customer_history`
  ADD PRIMARY KEY (`customer_history_id`);

--
-- Indexes for table `oc_customer_ip`
--
ALTER TABLE `oc_customer_ip`
  ADD PRIMARY KEY (`customer_ip_id`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `oc_customer_login`
--
ALTER TABLE `oc_customer_login`
  ADD PRIMARY KEY (`customer_login_id`),
  ADD KEY `email` (`email`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `oc_customer_online`
--
ALTER TABLE `oc_customer_online`
  ADD PRIMARY KEY (`ip`);

--
-- Indexes for table `oc_customer_reward`
--
ALTER TABLE `oc_customer_reward`
  ADD PRIMARY KEY (`customer_reward_id`);

--
-- Indexes for table `oc_customer_search`
--
ALTER TABLE `oc_customer_search`
  ADD PRIMARY KEY (`customer_search_id`);

--
-- Indexes for table `oc_customer_token`
--
ALTER TABLE `oc_customer_token`
  ADD PRIMARY KEY (`customer_token_id`);

--
-- Indexes for table `oc_customer_transaction`
--
ALTER TABLE `oc_customer_transaction`
  ADD PRIMARY KEY (`customer_transaction_id`);

--
-- Indexes for table `oc_customer_wishlist`
--
ALTER TABLE `oc_customer_wishlist`
  ADD PRIMARY KEY (`customer_id`,`store_id`,`product_id`);

--
-- Indexes for table `oc_custom_field`
--
ALTER TABLE `oc_custom_field`
  ADD PRIMARY KEY (`custom_field_id`);

--
-- Indexes for table `oc_custom_field_customer_group`
--
ALTER TABLE `oc_custom_field_customer_group`
  ADD PRIMARY KEY (`custom_field_id`,`customer_group_id`);

--
-- Indexes for table `oc_custom_field_description`
--
ALTER TABLE `oc_custom_field_description`
  ADD PRIMARY KEY (`custom_field_id`,`language_id`);

--
-- Indexes for table `oc_custom_field_value`
--
ALTER TABLE `oc_custom_field_value`
  ADD PRIMARY KEY (`custom_field_value_id`);

--
-- Indexes for table `oc_custom_field_value_description`
--
ALTER TABLE `oc_custom_field_value_description`
  ADD PRIMARY KEY (`custom_field_value_id`,`language_id`);

--
-- Indexes for table `oc_download`
--
ALTER TABLE `oc_download`
  ADD PRIMARY KEY (`download_id`);

--
-- Indexes for table `oc_download_description`
--
ALTER TABLE `oc_download_description`
  ADD PRIMARY KEY (`download_id`,`language_id`);

--
-- Indexes for table `oc_download_report`
--
ALTER TABLE `oc_download_report`
  ADD PRIMARY KEY (`download_report_id`);

--
-- Indexes for table `oc_event`
--
ALTER TABLE `oc_event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `oc_extension`
--
ALTER TABLE `oc_extension`
  ADD PRIMARY KEY (`extension_id`);

--
-- Indexes for table `oc_extension_install`
--
ALTER TABLE `oc_extension_install`
  ADD PRIMARY KEY (`extension_install_id`);

--
-- Indexes for table `oc_extension_path`
--
ALTER TABLE `oc_extension_path`
  ADD PRIMARY KEY (`extension_path_id`),
  ADD KEY `path` (`path`);

--
-- Indexes for table `oc_filter`
--
ALTER TABLE `oc_filter`
  ADD PRIMARY KEY (`filter_id`);

--
-- Indexes for table `oc_filter_description`
--
ALTER TABLE `oc_filter_description`
  ADD PRIMARY KEY (`filter_id`,`language_id`);

--
-- Indexes for table `oc_filter_group`
--
ALTER TABLE `oc_filter_group`
  ADD PRIMARY KEY (`filter_group_id`);

--
-- Indexes for table `oc_filter_group_description`
--
ALTER TABLE `oc_filter_group_description`
  ADD PRIMARY KEY (`filter_group_id`,`language_id`);

--
-- Indexes for table `oc_gdpr`
--
ALTER TABLE `oc_gdpr`
  ADD PRIMARY KEY (`gdpr_id`);

--
-- Indexes for table `oc_geo_zone`
--
ALTER TABLE `oc_geo_zone`
  ADD PRIMARY KEY (`geo_zone_id`);

--
-- Indexes for table `oc_identifier`
--
ALTER TABLE `oc_identifier`
  ADD PRIMARY KEY (`identifier_id`);

--
-- Indexes for table `oc_information`
--
ALTER TABLE `oc_information`
  ADD PRIMARY KEY (`information_id`);

--
-- Indexes for table `oc_information_description`
--
ALTER TABLE `oc_information_description`
  ADD PRIMARY KEY (`information_id`,`language_id`);

--
-- Indexes for table `oc_information_to_layout`
--
ALTER TABLE `oc_information_to_layout`
  ADD PRIMARY KEY (`information_id`,`store_id`);

--
-- Indexes for table `oc_information_to_store`
--
ALTER TABLE `oc_information_to_store`
  ADD PRIMARY KEY (`information_id`,`store_id`);

--
-- Indexes for table `oc_language`
--
ALTER TABLE `oc_language`
  ADD PRIMARY KEY (`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_layout`
--
ALTER TABLE `oc_layout`
  ADD PRIMARY KEY (`layout_id`);

--
-- Indexes for table `oc_layout_module`
--
ALTER TABLE `oc_layout_module`
  ADD PRIMARY KEY (`layout_module_id`);

--
-- Indexes for table `oc_layout_route`
--
ALTER TABLE `oc_layout_route`
  ADD PRIMARY KEY (`layout_route_id`);

--
-- Indexes for table `oc_length_class`
--
ALTER TABLE `oc_length_class`
  ADD PRIMARY KEY (`length_class_id`);

--
-- Indexes for table `oc_length_class_description`
--
ALTER TABLE `oc_length_class_description`
  ADD PRIMARY KEY (`length_class_id`,`language_id`);

--
-- Indexes for table `oc_location`
--
ALTER TABLE `oc_location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_manufacturer`
--
ALTER TABLE `oc_manufacturer`
  ADD PRIMARY KEY (`manufacturer_id`);

--
-- Indexes for table `oc_manufacturer_to_layout`
--
ALTER TABLE `oc_manufacturer_to_layout`
  ADD PRIMARY KEY (`manufacturer_id`,`store_id`);

--
-- Indexes for table `oc_manufacturer_to_store`
--
ALTER TABLE `oc_manufacturer_to_store`
  ADD PRIMARY KEY (`manufacturer_id`,`store_id`);

--
-- Indexes for table `oc_marketing`
--
ALTER TABLE `oc_marketing`
  ADD PRIMARY KEY (`marketing_id`);

--
-- Indexes for table `oc_marketing_report`
--
ALTER TABLE `oc_marketing_report`
  ADD PRIMARY KEY (`marketing_report_id`);

--
-- Indexes for table `oc_modification`
--
ALTER TABLE `oc_modification`
  ADD PRIMARY KEY (`modification_id`);

--
-- Indexes for table `oc_module`
--
ALTER TABLE `oc_module`
  ADD PRIMARY KEY (`module_id`);

--
-- Indexes for table `oc_notification`
--
ALTER TABLE `oc_notification`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `oc_option`
--
ALTER TABLE `oc_option`
  ADD PRIMARY KEY (`option_id`);

--
-- Indexes for table `oc_option_description`
--
ALTER TABLE `oc_option_description`
  ADD PRIMARY KEY (`option_id`,`language_id`);

--
-- Indexes for table `oc_option_value`
--
ALTER TABLE `oc_option_value`
  ADD PRIMARY KEY (`option_value_id`);

--
-- Indexes for table `oc_option_value_description`
--
ALTER TABLE `oc_option_value_description`
  ADD PRIMARY KEY (`option_value_id`,`language_id`);

--
-- Indexes for table `oc_order`
--
ALTER TABLE `oc_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `oc_order_history`
--
ALTER TABLE `oc_order_history`
  ADD PRIMARY KEY (`order_history_id`);

--
-- Indexes for table `oc_order_option`
--
ALTER TABLE `oc_order_option`
  ADD PRIMARY KEY (`order_option_id`);

--
-- Indexes for table `oc_order_product`
--
ALTER TABLE `oc_order_product`
  ADD PRIMARY KEY (`order_product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_order_status`
--
ALTER TABLE `oc_order_status`
  ADD PRIMARY KEY (`order_status_id`,`language_id`);

--
-- Indexes for table `oc_order_subscription`
--
ALTER TABLE `oc_order_subscription`
  ADD PRIMARY KEY (`order_subscription_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_order_total`
--
ALTER TABLE `oc_order_total`
  ADD PRIMARY KEY (`order_total_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_product`
--
ALTER TABLE `oc_product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `oc_product_attribute`
--
ALTER TABLE `oc_product_attribute`
  ADD PRIMARY KEY (`product_id`,`attribute_id`,`language_id`);

--
-- Indexes for table `oc_product_code`
--
ALTER TABLE `oc_product_code`
  ADD PRIMARY KEY (`product_code_id`),
  ADD KEY `code` (`code`);

--
-- Indexes for table `oc_product_description`
--
ALTER TABLE `oc_product_description`
  ADD PRIMARY KEY (`product_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_product_discount`
--
ALTER TABLE `oc_product_discount`
  ADD PRIMARY KEY (`product_discount_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_product_filter`
--
ALTER TABLE `oc_product_filter`
  ADD PRIMARY KEY (`product_id`,`filter_id`);

--
-- Indexes for table `oc_product_image`
--
ALTER TABLE `oc_product_image`
  ADD PRIMARY KEY (`product_image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_product_option`
--
ALTER TABLE `oc_product_option`
  ADD PRIMARY KEY (`product_option_id`);

--
-- Indexes for table `oc_product_option_value`
--
ALTER TABLE `oc_product_option_value`
  ADD PRIMARY KEY (`product_option_value_id`);

--
-- Indexes for table `oc_product_related`
--
ALTER TABLE `oc_product_related`
  ADD PRIMARY KEY (`product_id`,`related_id`);

--
-- Indexes for table `oc_product_report`
--
ALTER TABLE `oc_product_report`
  ADD PRIMARY KEY (`product_report_id`);

--
-- Indexes for table `oc_product_reward`
--
ALTER TABLE `oc_product_reward`
  ADD PRIMARY KEY (`product_reward_id`);

--
-- Indexes for table `oc_product_subscription`
--
ALTER TABLE `oc_product_subscription`
  ADD PRIMARY KEY (`product_id`,`subscription_plan_id`,`customer_group_id`);

--
-- Indexes for table `oc_product_to_addon`
--
ALTER TABLE `oc_product_to_addon`
  ADD PRIMARY KEY (`product_id`,`addon_id`),
  ADD KEY `addon_id` (`addon_id`);

--
-- Indexes for table `oc_product_to_category`
--
ALTER TABLE `oc_product_to_category`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `oc_product_to_color`
--
ALTER TABLE `oc_product_to_color`
  ADD PRIMARY KEY (`product_id`,`color_id`),
  ADD KEY `color_id` (`color_id`);

--
-- Indexes for table `oc_product_to_country`
--
ALTER TABLE `oc_product_to_country`
  ADD PRIMARY KEY (`product_id`,`country_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `oc_product_to_download`
--
ALTER TABLE `oc_product_to_download`
  ADD PRIMARY KEY (`product_id`,`download_id`);

--
-- Indexes for table `oc_product_to_layout`
--
ALTER TABLE `oc_product_to_layout`
  ADD PRIMARY KEY (`product_id`,`store_id`);

--
-- Indexes for table `oc_product_to_store`
--
ALTER TABLE `oc_product_to_store`
  ADD PRIMARY KEY (`product_id`,`store_id`);

--
-- Indexes for table `oc_product_to_vase`
--
ALTER TABLE `oc_product_to_vase`
  ADD PRIMARY KEY (`product_id`,`vase_id`),
  ADD KEY `vase_id` (`vase_id`);

--
-- Indexes for table `oc_product_to_zone`
--
ALTER TABLE `oc_product_to_zone`
  ADD PRIMARY KEY (`product_id`,`country_id`,`zone_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `zone_id` (`zone_id`);

--
-- Indexes for table `oc_product_viewed`
--
ALTER TABLE `oc_product_viewed`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `oc_return`
--
ALTER TABLE `oc_return`
  ADD PRIMARY KEY (`return_id`);

--
-- Indexes for table `oc_return_action`
--
ALTER TABLE `oc_return_action`
  ADD PRIMARY KEY (`return_action_id`,`language_id`);

--
-- Indexes for table `oc_return_history`
--
ALTER TABLE `oc_return_history`
  ADD PRIMARY KEY (`return_history_id`);

--
-- Indexes for table `oc_return_reason`
--
ALTER TABLE `oc_return_reason`
  ADD PRIMARY KEY (`return_reason_id`,`language_id`);

--
-- Indexes for table `oc_return_status`
--
ALTER TABLE `oc_return_status`
  ADD PRIMARY KEY (`return_status_id`,`language_id`);

--
-- Indexes for table `oc_review`
--
ALTER TABLE `oc_review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_seo_url`
--
ALTER TABLE `oc_seo_url`
  ADD PRIMARY KEY (`seo_url_id`),
  ADD KEY `store` (`store_id`),
  ADD KEY `language` (`language_id`),
  ADD KEY `keyword` (`keyword`),
  ADD KEY `query` (`key`,`value`);

--
-- Indexes for table `oc_session`
--
ALTER TABLE `oc_session`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `oc_setting`
--
ALTER TABLE `oc_setting`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `oc_startup`
--
ALTER TABLE `oc_startup`
  ADD PRIMARY KEY (`startup_id`);

--
-- Indexes for table `oc_statistics`
--
ALTER TABLE `oc_statistics`
  ADD PRIMARY KEY (`statistics_id`);

--
-- Indexes for table `oc_stock_status`
--
ALTER TABLE `oc_stock_status`
  ADD PRIMARY KEY (`stock_status_id`,`language_id`);

--
-- Indexes for table `oc_store`
--
ALTER TABLE `oc_store`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `oc_subscription`
--
ALTER TABLE `oc_subscription`
  ADD PRIMARY KEY (`subscription_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `idx_paused_until` (`paused_until`),
  ADD KEY `idx_skip_next` (`skip_next_delivery`);

--
-- Indexes for table `oc_subscription_history`
--
ALTER TABLE `oc_subscription_history`
  ADD PRIMARY KEY (`subscription_history_id`),
  ADD KEY `idx_action_type` (`action_type`);

--
-- Indexes for table `oc_subscription_log`
--
ALTER TABLE `oc_subscription_log`
  ADD PRIMARY KEY (`subscription_log_id`);

--
-- Indexes for table `oc_subscription_option`
--
ALTER TABLE `oc_subscription_option`
  ADD PRIMARY KEY (`subscription_option_id`);

--
-- Indexes for table `oc_subscription_order`
--
ALTER TABLE `oc_subscription_order`
  ADD PRIMARY KEY (`subscription_order_id`),
  ADD KEY `subscription_id` (`subscription_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_subscription_plan`
--
ALTER TABLE `oc_subscription_plan`
  ADD PRIMARY KEY (`subscription_plan_id`);

--
-- Indexes for table `oc_subscription_plan_description`
--
ALTER TABLE `oc_subscription_plan_description`
  ADD PRIMARY KEY (`subscription_plan_id`,`language_id`);

--
-- Indexes for table `oc_subscription_plan_duration`
--
ALTER TABLE `oc_subscription_plan_duration`
  ADD PRIMARY KEY (`subscription_plan_duration_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`);

--
-- Indexes for table `oc_subscription_plan_frequency`
--
ALTER TABLE `oc_subscription_plan_frequency`
  ADD PRIMARY KEY (`subscription_plan_frequency_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`);

--
-- Indexes for table `oc_subscription_plan_gift`
--
ALTER TABLE `oc_subscription_plan_gift`
  ADD PRIMARY KEY (`subscription_plan_gift_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_subscription_plan_image`
--
ALTER TABLE `oc_subscription_plan_image`
  ADD PRIMARY KEY (`subscription_plan_image_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`);

--
-- Indexes for table `oc_subscription_plan_related`
--
ALTER TABLE `oc_subscription_plan_related`
  ADD PRIMARY KEY (`subscription_plan_related_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_subscription_plan_vase`
--
ALTER TABLE `oc_subscription_plan_vase`
  ADD PRIMARY KEY (`subscription_plan_vase_id`),
  ADD KEY `subscription_plan_id` (`subscription_plan_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_subscription_product`
--
ALTER TABLE `oc_subscription_product`
  ADD PRIMARY KEY (`subscription_product_id`),
  ADD KEY `subscription_id` (`subscription_id`);

--
-- Indexes for table `oc_subscription_status`
--
ALTER TABLE `oc_subscription_status`
  ADD PRIMARY KEY (`subscription_status_id`,`language_id`);

--
-- Indexes for table `oc_tax_class`
--
ALTER TABLE `oc_tax_class`
  ADD PRIMARY KEY (`tax_class_id`);

--
-- Indexes for table `oc_tax_rate`
--
ALTER TABLE `oc_tax_rate`
  ADD PRIMARY KEY (`tax_rate_id`);

--
-- Indexes for table `oc_tax_rate_to_customer_group`
--
ALTER TABLE `oc_tax_rate_to_customer_group`
  ADD PRIMARY KEY (`tax_rate_id`,`customer_group_id`);

--
-- Indexes for table `oc_tax_rule`
--
ALTER TABLE `oc_tax_rule`
  ADD PRIMARY KEY (`tax_rule_id`);

--
-- Indexes for table `oc_theme`
--
ALTER TABLE `oc_theme`
  ADD PRIMARY KEY (`theme_id`);

--
-- Indexes for table `oc_topic`
--
ALTER TABLE `oc_topic`
  ADD PRIMARY KEY (`topic_id`);

--
-- Indexes for table `oc_topic_description`
--
ALTER TABLE `oc_topic_description`
  ADD PRIMARY KEY (`topic_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_topic_to_layout`
--
ALTER TABLE `oc_topic_to_layout`
  ADD PRIMARY KEY (`topic_id`,`store_id`);

--
-- Indexes for table `oc_topic_to_store`
--
ALTER TABLE `oc_topic_to_store`
  ADD PRIMARY KEY (`topic_id`,`store_id`);

--
-- Indexes for table `oc_translation`
--
ALTER TABLE `oc_translation`
  ADD PRIMARY KEY (`translation_id`);

--
-- Indexes for table `oc_upload`
--
ALTER TABLE `oc_upload`
  ADD PRIMARY KEY (`upload_id`);

--
-- Indexes for table `oc_user`
--
ALTER TABLE `oc_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `oc_user_authorize`
--
ALTER TABLE `oc_user_authorize`
  ADD PRIMARY KEY (`user_authorize_id`);

--
-- Indexes for table `oc_user_group`
--
ALTER TABLE `oc_user_group`
  ADD PRIMARY KEY (`user_group_id`);

--
-- Indexes for table `oc_user_login`
--
ALTER TABLE `oc_user_login`
  ADD PRIMARY KEY (`user_login_id`);

--
-- Indexes for table `oc_user_token`
--
ALTER TABLE `oc_user_token`
  ADD PRIMARY KEY (`user_token_id`);

--
-- Indexes for table `oc_weight_class`
--
ALTER TABLE `oc_weight_class`
  ADD PRIMARY KEY (`weight_class_id`);

--
-- Indexes for table `oc_weight_class_description`
--
ALTER TABLE `oc_weight_class_description`
  ADD PRIMARY KEY (`weight_class_id`,`language_id`);

--
-- Indexes for table `oc_zone`
--
ALTER TABLE `oc_zone`
  ADD PRIMARY KEY (`zone_id`);

--
-- Indexes for table `oc_zone_description`
--
ALTER TABLE `oc_zone_description`
  ADD PRIMARY KEY (`zone_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_zone_to_geo_zone`
--
ALTER TABLE `oc_zone_to_geo_zone`
  ADD PRIMARY KEY (`zone_to_geo_zone_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `oc_address`
--
ALTER TABLE `oc_address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_address_format`
--
ALTER TABLE `oc_address_format`
  MODIFY `address_format_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_antispam`
--
ALTER TABLE `oc_antispam`
  MODIFY `antispam_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_api`
--
ALTER TABLE `oc_api`
  MODIFY `api_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_api_history`
--
ALTER TABLE `oc_api_history`
  MODIFY `api_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_api_ip`
--
ALTER TABLE `oc_api_ip`
  MODIFY `api_ip_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_article`
--
ALTER TABLE `oc_article`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_article_comment`
--
ALTER TABLE `oc_article_comment`
  MODIFY `article_comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_article_rating`
--
ALTER TABLE `oc_article_rating`
  MODIFY `article_rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_attribute`
--
ALTER TABLE `oc_attribute`
  MODIFY `attribute_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `oc_attribute_group`
--
ALTER TABLE `oc_attribute_group`
  MODIFY `attribute_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_banner`
--
ALTER TABLE `oc_banner`
  MODIFY `banner_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oc_banner_image`
--
ALTER TABLE `oc_banner_image`
  MODIFY `banner_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `oc_cart`
--
ALTER TABLE `oc_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oc_category`
--
ALTER TABLE `oc_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `oc_country`
--
ALTER TABLE `oc_country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT for table `oc_coupon`
--
ALTER TABLE `oc_coupon`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_coupon_history`
--
ALTER TABLE `oc_coupon_history`
  MODIFY `coupon_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_coupon_product`
--
ALTER TABLE `oc_coupon_product`
  MODIFY `coupon_product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_cron`
--
ALTER TABLE `oc_cron`
  MODIFY `cron_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_currency`
--
ALTER TABLE `oc_currency`
  MODIFY `currency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oc_customer`
--
ALTER TABLE `oc_customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_customer_activity`
--
ALTER TABLE `oc_customer_activity`
  MODIFY `customer_activity_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_affiliate_report`
--
ALTER TABLE `oc_customer_affiliate_report`
  MODIFY `customer_affiliate_report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_approval`
--
ALTER TABLE `oc_customer_approval`
  MODIFY `customer_approval_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_authorize`
--
ALTER TABLE `oc_customer_authorize`
  MODIFY `customer_authorize_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_group`
--
ALTER TABLE `oc_customer_group`
  MODIFY `customer_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_customer_history`
--
ALTER TABLE `oc_customer_history`
  MODIFY `customer_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_ip`
--
ALTER TABLE `oc_customer_ip`
  MODIFY `customer_ip_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_customer_login`
--
ALTER TABLE `oc_customer_login`
  MODIFY `customer_login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_customer_reward`
--
ALTER TABLE `oc_customer_reward`
  MODIFY `customer_reward_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_search`
--
ALTER TABLE `oc_customer_search`
  MODIFY `customer_search_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_token`
--
ALTER TABLE `oc_customer_token`
  MODIFY `customer_token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_transaction`
--
ALTER TABLE `oc_customer_transaction`
  MODIFY `customer_transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_custom_field`
--
ALTER TABLE `oc_custom_field`
  MODIFY `custom_field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `oc_custom_field_value`
--
ALTER TABLE `oc_custom_field_value`
  MODIFY `custom_field_value_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `oc_download`
--
ALTER TABLE `oc_download`
  MODIFY `download_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_download_report`
--
ALTER TABLE `oc_download_report`
  MODIFY `download_report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_event`
--
ALTER TABLE `oc_event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `oc_extension`
--
ALTER TABLE `oc_extension`
  MODIFY `extension_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `oc_extension_install`
--
ALTER TABLE `oc_extension_install`
  MODIFY `extension_install_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_extension_path`
--
ALTER TABLE `oc_extension_path`
  MODIFY `extension_path_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=396;

--
-- AUTO_INCREMENT for table `oc_filter`
--
ALTER TABLE `oc_filter`
  MODIFY `filter_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_filter_group`
--
ALTER TABLE `oc_filter_group`
  MODIFY `filter_group_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_gdpr`
--
ALTER TABLE `oc_gdpr`
  MODIFY `gdpr_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_geo_zone`
--
ALTER TABLE `oc_geo_zone`
  MODIFY `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_identifier`
--
ALTER TABLE `oc_identifier`
  MODIFY `identifier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_information`
--
ALTER TABLE `oc_information`
  MODIFY `information_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_language`
--
ALTER TABLE `oc_language`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_layout`
--
ALTER TABLE `oc_layout`
  MODIFY `layout_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `oc_layout_module`
--
ALTER TABLE `oc_layout_module`
  MODIFY `layout_module_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oc_layout_route`
--
ALTER TABLE `oc_layout_route`
  MODIFY `layout_route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `oc_length_class`
--
ALTER TABLE `oc_length_class`
  MODIFY `length_class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_location`
--
ALTER TABLE `oc_location`
  MODIFY `location_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_manufacturer`
--
ALTER TABLE `oc_manufacturer`
  MODIFY `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oc_marketing`
--
ALTER TABLE `oc_marketing`
  MODIFY `marketing_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_marketing_report`
--
ALTER TABLE `oc_marketing_report`
  MODIFY `marketing_report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_modification`
--
ALTER TABLE `oc_modification`
  MODIFY `modification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_module`
--
ALTER TABLE `oc_module`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_notification`
--
ALTER TABLE `oc_notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_option`
--
ALTER TABLE `oc_option`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `oc_option_value`
--
ALTER TABLE `oc_option_value`
  MODIFY `option_value_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `oc_order`
--
ALTER TABLE `oc_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_order_history`
--
ALTER TABLE `oc_order_history`
  MODIFY `order_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_order_option`
--
ALTER TABLE `oc_order_option`
  MODIFY `order_option_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_order_product`
--
ALTER TABLE `oc_order_product`
  MODIFY `order_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_order_status`
--
ALTER TABLE `oc_order_status`
  MODIFY `order_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `oc_order_subscription`
--
ALTER TABLE `oc_order_subscription`
  MODIFY `order_subscription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_order_total`
--
ALTER TABLE `oc_order_total`
  MODIFY `order_total_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oc_product`
--
ALTER TABLE `oc_product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `oc_product_code`
--
ALTER TABLE `oc_product_code`
  MODIFY `product_code_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_product_discount`
--
ALTER TABLE `oc_product_discount`
  MODIFY `product_discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=441;

--
-- AUTO_INCREMENT for table `oc_product_image`
--
ALTER TABLE `oc_product_image`
  MODIFY `product_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2400;

--
-- AUTO_INCREMENT for table `oc_product_option`
--
ALTER TABLE `oc_product_option`
  MODIFY `product_option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `oc_product_option_value`
--
ALTER TABLE `oc_product_option_value`
  MODIFY `product_option_value_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `oc_product_report`
--
ALTER TABLE `oc_product_report`
  MODIFY `product_report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_product_reward`
--
ALTER TABLE `oc_product_reward`
  MODIFY `product_reward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=554;

--
-- AUTO_INCREMENT for table `oc_return`
--
ALTER TABLE `oc_return`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_return_action`
--
ALTER TABLE `oc_return_action`
  MODIFY `return_action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_return_history`
--
ALTER TABLE `oc_return_history`
  MODIFY `return_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_return_reason`
--
ALTER TABLE `oc_return_reason`
  MODIFY `return_reason_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oc_return_status`
--
ALTER TABLE `oc_return_status`
  MODIFY `return_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_review`
--
ALTER TABLE `oc_review`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_seo_url`
--
ALTER TABLE `oc_seo_url`
  MODIFY `seo_url_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `oc_setting`
--
ALTER TABLE `oc_setting`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1694;

--
-- AUTO_INCREMENT for table `oc_startup`
--
ALTER TABLE `oc_startup`
  MODIFY `startup_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_statistics`
--
ALTER TABLE `oc_statistics`
  MODIFY `statistics_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `oc_stock_status`
--
ALTER TABLE `oc_stock_status`
  MODIFY `stock_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oc_store`
--
ALTER TABLE `oc_store`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_subscription`
--
ALTER TABLE `oc_subscription`
  MODIFY `subscription_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_subscription_history`
--
ALTER TABLE `oc_subscription_history`
  MODIFY `subscription_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_subscription_log`
--
ALTER TABLE `oc_subscription_log`
  MODIFY `subscription_log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_subscription_option`
--
ALTER TABLE `oc_subscription_option`
  MODIFY `subscription_option_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_subscription_order`
--
ALTER TABLE `oc_subscription_order`
  MODIFY `subscription_order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_subscription_plan`
--
ALTER TABLE `oc_subscription_plan`
  MODIFY `subscription_plan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_duration`
--
ALTER TABLE `oc_subscription_plan_duration`
  MODIFY `subscription_plan_duration_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_frequency`
--
ALTER TABLE `oc_subscription_plan_frequency`
  MODIFY `subscription_plan_frequency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_gift`
--
ALTER TABLE `oc_subscription_plan_gift`
  MODIFY `subscription_plan_gift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_image`
--
ALTER TABLE `oc_subscription_plan_image`
  MODIFY `subscription_plan_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_related`
--
ALTER TABLE `oc_subscription_plan_related`
  MODIFY `subscription_plan_related_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `oc_subscription_plan_vase`
--
ALTER TABLE `oc_subscription_plan_vase`
  MODIFY `subscription_plan_vase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oc_subscription_product`
--
ALTER TABLE `oc_subscription_product`
  MODIFY `subscription_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_subscription_status`
--
ALTER TABLE `oc_subscription_status`
  MODIFY `subscription_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `oc_tax_class`
--
ALTER TABLE `oc_tax_class`
  MODIFY `tax_class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oc_tax_rate`
--
ALTER TABLE `oc_tax_rate`
  MODIFY `tax_rate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `oc_tax_rule`
--
ALTER TABLE `oc_tax_rule`
  MODIFY `tax_rule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `oc_theme`
--
ALTER TABLE `oc_theme`
  MODIFY `theme_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_topic`
--
ALTER TABLE `oc_topic`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_translation`
--
ALTER TABLE `oc_translation`
  MODIFY `translation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_upload`
--
ALTER TABLE `oc_upload`
  MODIFY `upload_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_user`
--
ALTER TABLE `oc_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_user_authorize`
--
ALTER TABLE `oc_user_authorize`
  MODIFY `user_authorize_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_user_group`
--
ALTER TABLE `oc_user_group`
  MODIFY `user_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `oc_user_login`
--
ALTER TABLE `oc_user_login`
  MODIFY `user_login_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `oc_user_token`
--
ALTER TABLE `oc_user_token`
  MODIFY `user_token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_weight_class`
--
ALTER TABLE `oc_weight_class`
  MODIFY `weight_class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_zone`
--
ALTER TABLE `oc_zone`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4847;

--
-- AUTO_INCREMENT for table `oc_zone_to_geo_zone`
--
ALTER TABLE `oc_zone_to_geo_zone`
  MODIFY `zone_to_geo_zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `oc_product_to_addon`
--
ALTER TABLE `oc_product_to_addon`
  ADD CONSTRAINT `fk_product_to_addon_addon` FOREIGN KEY (`addon_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product_to_addon_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_product_to_color`
--
ALTER TABLE `oc_product_to_color`
  ADD CONSTRAINT `oc_product_to_color_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `oc_product_to_color_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_product_to_vase`
--
ALTER TABLE `oc_product_to_vase`
  ADD CONSTRAINT `fk_product_to_vase_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_product_to_vase_vase` FOREIGN KEY (`vase_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_order`
--
ALTER TABLE `oc_subscription_order`
  ADD CONSTRAINT `fk_subscription_order_order` FOREIGN KEY (`order_id`) REFERENCES `oc_order` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subscription_order_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `oc_subscription` (`subscription_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_duration`
--
ALTER TABLE `oc_subscription_plan_duration`
  ADD CONSTRAINT `fk_subscription_plan_duration` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_frequency`
--
ALTER TABLE `oc_subscription_plan_frequency`
  ADD CONSTRAINT `fk_subscription_plan_frequency_plan` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_gift`
--
ALTER TABLE `oc_subscription_plan_gift`
  ADD CONSTRAINT `fk_subscription_plan_gift_plan` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subscription_plan_gift_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_image`
--
ALTER TABLE `oc_subscription_plan_image`
  ADD CONSTRAINT `oc_subscription_plan_image_ibfk_1` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_related`
--
ALTER TABLE `oc_subscription_plan_related`
  ADD CONSTRAINT `fk_subscription_plan_related_plan` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subscription_plan_related_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `oc_subscription_plan_vase`
--
ALTER TABLE `oc_subscription_plan_vase`
  ADD CONSTRAINT `fk_subscription_plan_vase_plan` FOREIGN KEY (`subscription_plan_id`) REFERENCES `oc_subscription_plan` (`subscription_plan_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subscription_plan_vase_product` FOREIGN KEY (`product_id`) REFERENCES `oc_product` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
