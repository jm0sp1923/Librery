-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.33 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para library_db
CREATE DATABASE IF NOT EXISTS `library_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library_db`;

-- Volcando estructura para tabla library_db.book
CREATE TABLE IF NOT EXISTS `book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `isbn` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `editorial_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `FK_book_editorial` (`editorial_id`),
  KEY `FK_book_category` (`category_id`),
  CONSTRAINT `FK_book_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_book_editorial` FOREIGN KEY (`editorial_id`) REFERENCES `editorial` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla library_db.book: ~5 rows (aproximadamente)
INSERT INTO `book` (`id`, `isbn`, `title`, `author`, `editorial_id`, `category_id`) VALUES
	(1, '9780141439846', 'Pride and Prejudice', 'Jane Austen', 1, 4),
	(2, '9780743273565', 'To Kill a Mockingbird', 'Harper Lee', 2, 2),
	(3, '9780141182605', '1984', 'George Orwell', 2, 1),
	(4, '9780061120084', 'The Catcher in the Rye', 'J.D. Salinger', 3, 3),
	(5, '9780061120085', 'The Great Gatsby', 'F. Scott Fitzgerald', 4, 4);

-- Volcando estructura para tabla library_db.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla library_db.category: ~5 rows (aproximadamente)
INSERT INTO `category` (`id`, `name`, `description`) VALUES
	(1, 'Ficción', 'Libros de ficción y literatura'),
	(2, 'No ficción', 'Libros de no ficción y ensayos'),
	(3, 'Fantasía', 'Libros de fantasía y ciencia ficción'),
	(4, 'Historia', 'Libros de historia y biografías'),
	(5, 'Arte y diseño', 'Libros sobre arte y diseño gráfico');

-- Volcando estructura para tabla library_db.editorial
CREATE TABLE IF NOT EXISTS `editorial` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `address` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla library_db.editorial: ~5 rows (aproximadamente)
INSERT INTO `editorial` (`id`, `name`, `address`) VALUES
	(1, 'Editorial ABC', '123 Main Street'),
	(2, 'Librería XYZ', '456 Oak Avenue'),
	(3, 'Publicaciones 123', '789 Elm Street'),
	(4, 'Imprenta Rápida', '101 Maple Drive'),
	(5, 'Ediciones de la Montaña', '234 Pine Road');

-- Volcando estructura para tabla library_db.loan
CREATE TABLE IF NOT EXISTS `loan` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `book_id` bigint NOT NULL,
  `loan_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id_book_id` (`member_id`,`book_id`),
  KEY `FK_loan_book` (`book_id`),
  CONSTRAINT `FK_loan_book` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_loan_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla library_db.loan: ~4 rows (aproximadamente)
INSERT INTO `loan` (`id`, `member_id`, `book_id`, `loan_date`, `return_date`) VALUES
	(1, 1, 2, '2024-05-15', '2024-05-16'),
	(2, 1, 3, '2024-05-15', '2024-05-16'),
	(3, 2, 4, '2024-05-14', '2024-05-20'),
	(4, 5, 1, '2024-05-15', NULL);

-- Volcando estructura para tabla library_db.member
CREATE TABLE IF NOT EXISTS `member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `document` bigint NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(70) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document` (`document`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla library_db.member: ~5 rows (aproximadamente)
INSERT INTO `member` (`id`, `document`, `firstname`, `lastname`, `email`, `phone`) VALUES
	(1, 123456789, 'Juan', 'Pérez', 'juan@example.com', '1234567890'),
	(2, 987654321, 'María', 'Gómez', 'maria@example.com', '9876543210'),
	(3, 456789123, 'Carlos', 'Martínez', 'carlos@example.com', '4567891230'),
	(4, 789123456, 'Laura', 'Rodríguez', 'laura@example.com', '7891234560'),
	(5, 321654987, 'Ana', 'López', 'ana@example.com', '3216549870');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
