-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-05-2025 a las 22:49:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion`
--

CREATE TABLE `devolucion` (
  `id_devolucion` int(11) NOT NULL,
  `f_real` date NOT NULL,
  `fk_id_prestamo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `devolucion`
--

INSERT INTO `devolucion` (`id_devolucion`, `f_real`, `fk_id_prestamo`) VALUES
(1, '2025-05-14', 1),
(2, '2025-05-05', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incluye`
--

CREATE TABLE `incluye` (
  `fk_id_prestamo` int(11) NOT NULL,
  `fk_cod_libro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `incluye`
--

INSERT INTO `incluye` (`fk_id_prestamo`, `fk_cod_libro`) VALUES
(1, 1),
(3, 2),
(1, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `cod_libro` int(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `editorial` varchar(50) NOT NULL,
  `publicacion` int(11) NOT NULL,
  `categoria` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`cod_libro`, `titulo`, `autor`, `editorial`, `publicacion`, `categoria`) VALUES
(1, 'El Principito', 'Antoine de Saint-Exupéry', 'Reynal & Hitchcock', 1943, 'Infantil'),
(2, 'Cuentos para pensar', 'Jorge Bucay', 'RBA', 2003, 'Infantil'),
(3, '1984', 'George Orwell', 'Secker & Warburg', 1949, 'Novela'),
(4, 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 'Técnica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multa`
--

CREATE TABLE `multa` (
  `id_multa` int(11) NOT NULL,
  `monto` decimal(6,2) NOT NULL,
  `descripcion` text NOT NULL,
  `f_emision` date NOT NULL,
  `fk_id_devolucion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `multa`
--

INSERT INTO `multa` (`id_multa`, `monto`, `descripcion`, `f_emision`, `fk_id_devolucion`) VALUES
(1, 5.00, 'Retraso de un día', '2025-05-06', 2),
(2, 12.00, 'Retraso adicional', '2025-05-07', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `id_prestamo` int(11) NOT NULL,
  `f_prestamo` date NOT NULL,
  `f_limite` date NOT NULL,
  `fk_num_socio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`id_prestamo`, `f_prestamo`, `f_limite`, `fk_num_socio`) VALUES
(1, '2025-05-01', '2025-05-15', 1),
(2, '2025-04-20', '2025-05-04', 2),
(3, '2025-05-10', '2025-05-24', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `num_socio` int(11) NOT NULL,
  `nombre_com` varchar(50) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `f_inscripcion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`num_socio`, `nombre_com`, `direccion`, `correo`, `f_inscripcion`) VALUES
(1, 'Ana Pérez', 'Calle Sol 23', 'ana@gmail.com', '2023-03-15'),
(2, 'Luis Gómez', 'Avenida Luna 10', 'luis@gmail.com', '2022-11-10'),
(3, 'Marta Ruiz', 'Plaza Mayor 5', 'marta@gmail.com', '2023-07-01');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD UNIQUE KEY `id_prestamo` (`fk_id_prestamo`);

--
-- Indices de la tabla `incluye`
--
ALTER TABLE `incluye`
  ADD KEY `fk_id_prestamo + fk_cod_libro` (`fk_cod_libro`,`fk_id_prestamo`),
  ADD KEY `fk_id_prestamo` (`fk_id_prestamo`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`cod_libro`);

--
-- Indices de la tabla `multa`
--
ALTER TABLE `multa`
  ADD PRIMARY KEY (`id_multa`),
  ADD KEY `Fk_id_devoluciones` (`fk_id_devolucion`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `Fk_Prestamo` (`fk_num_socio`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`num_socio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `multa`
--
ALTER TABLE `multa`
  MODIFY `id_multa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `socio`
--
ALTER TABLE `socio`
  MODIFY `num_socio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`fk_id_prestamo`) REFERENCES `prestamo` (`id_prestamo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `incluye`
--
ALTER TABLE `incluye`
  ADD CONSTRAINT `incluye_ibfk_1` FOREIGN KEY (`fk_id_prestamo`) REFERENCES `prestamo` (`id_prestamo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `incluye_ibfk_2` FOREIGN KEY (`fk_cod_libro`) REFERENCES `libro` (`cod_libro`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `multa`
--
ALTER TABLE `multa`
  ADD CONSTRAINT `Fk_id_devoluciones` FOREIGN KEY (`fk_id_devolucion`) REFERENCES `devolucion` (`id_devolucion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `Fk_Prestamo` FOREIGN KEY (`fk_num_socio`) REFERENCES `socio` (`num_socio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
