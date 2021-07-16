-- Adminer 4.8.0 MySQL 5.7.34 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `genres`;
CREATE TABLE `genres` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

INSERT INTO `genres` (`id`, `genre_name`, `created_at`, `updated_at`) VALUES
(1,	'Drama',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(2,	'Crime',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(3,	'Action',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(4,	'Comic Book',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(5,	'Sci-Fi',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(6,	'Mystery',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(7,	'Adventure',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(8,	'Comedy',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(9,	'Romance',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `genre_name` = VALUES(`genre_name`), `created_at` = VALUES(`created_at`), `updated_at` = VALUES(`updated_at`);

DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `title` varchar(24) DEFAULT NULL,
  `description` varchar(85) DEFAULT NULL,
  `year` smallint(6) DEFAULT NULL,
  `release_date` datetime DEFAULT NULL,
  `runtime` smallint(6) DEFAULT NULL,
  `rating` tinyint(4) DEFAULT NULL,
  `mpaa_rating` varchar(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

INSERT INTO `movies` (`id`, `title`, `description`, `year`, `release_date`, `runtime`, `rating`, `mpaa_rating`, `created_at`, `updated_at`) VALUES
(1,	'The Shawshank Redemption',	'Two imprisoned men bond over a number of years',	1994,	'1994-10-14 00:00:00',	142,	5,	'R',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(2,	'The Godfather',	'The aging patriarch of an organized crime dynasty transfers control to his son',	1972,	'1972-03-24 00:00:00',	175,	5,	'R',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(3,	'The Dark Knight',	'The menace known as the Joker wreaks havoc on Gotham City',	2008,	'2008-07-18 00:00:00',	152,	5,	'PG13',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00'),
(4,	'American Psycho',	' A wealthy New York investment banking executive hides his alternate psychopathic ego',	2000,	'2000-04-14 00:00:00',	102,	4,	'R',	'2021-05-17 00:00:00',	'2021-05-17 00:00:00')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `title` = VALUES(`title`), `description` = VALUES(`description`), `year` = VALUES(`year`), `release_date` = VALUES(`release_date`), `runtime` = VALUES(`runtime`), `rating` = VALUES(`rating`), `mpaa_rating` = VALUES(`mpaa_rating`), `created_at` = VALUES(`created_at`), `updated_at` = VALUES(`updated_at`);

DROP TABLE IF EXISTS `movies_genres`;
CREATE TABLE `movies_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

INSERT INTO `movies_genres` (`id`, `movie_id`, `genre_id`, `created_at`, `updated_at`) VALUES
(1,	1,	1,	'2021-07-13 19:30:07',	'2021-07-13 19:30:07'),
(2,	1,	2,	'2021-07-13 19:30:07',	'2021-07-13 19:30:07')
ON DUPLICATE KEY UPDATE `id` = VALUES(`id`), `movie_id` = VALUES(`movie_id`), `genre_id` = VALUES(`genre_id`), `created_at` = VALUES(`created_at`), `updated_at` = VALUES(`updated_at`);

-- 2021-07-16 15:55:30
