-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2025 a las 20:16:49
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
-- Base de datos: `biblioteca_nueva`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libros`
--

CREATE TABLE `libros` (
  `cod_libro` int(11) NOT NULL,
  `titulo` varchar(30) NOT NULL,
  `autor` varchar(30) NOT NULL,
  `editorial` varchar(30) NOT NULL,
  `publicacion` date NOT NULL,
  `categoria` enum('novela','drama','comedia','ciencia') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libros`
--

INSERT INTO `libros` (`cod_libro`, `titulo`, `autor`, `editorial`, `publicacion`, `categoria`) VALUES
(1, 'El Principito', 'Saint-Exupéry', 'Salamandra', '1943-04-06', 'comedia'),
(2, 'Ciencia Divertida', 'Carl Sagan', 'Planeta', '1980-03-01', 'ciencia'),
(3, 'Cuentos para niños', 'Andersen', 'Infantil SA', '1950-06-12', 'comedia'),
(4, 'Aventuras', 'J. Verne', 'Juvenil Editores', '1873-02-01', 'comedia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multa`
--

CREATE TABLE `multa` (
  `id_multa` int(11) NOT NULL,
  `monto` decimal(11,0) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `f_emision` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `multa`
--

INSERT INTO `multa` (`id_multa`, `monto`, `descripcion`, `f_emision`) VALUES
(1, 5, 'Devolución con 3 días de retraso', '2024-05-10'),
(2, 15, 'Retraso prolongado', '2024-06-01'),
(3, 0, 'Sin multa', '2024-01-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo_libro`
--

CREATE TABLE `prestamo_libro` (
  `num_socio` int(11) NOT NULL,
  `cod_libro` int(11) NOT NULL,
  `f_prestamo` date NOT NULL,
  `f_limite` date NOT NULL,
  `f_devolucion` date NOT NULL,
  `Fk_id_multa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo_libro`
--

INSERT INTO `prestamo_libro` (`num_socio`, `cod_libro`, `f_prestamo`, `f_limite`, `f_devolucion`, `Fk_id_multa`) VALUES
(1, 1, '2024-05-01', '2024-05-10', '2024-05-09', 3),
(1, 4, '2024-05-20', '2024-05-27', '2024-05-28', 1),
(2, 2, '2024-05-05', '2024-05-12', '2024-05-15', 1),
(3, 3, '2024-05-10', '2024-05-17', '0000-00-00', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socios`
--

CREATE TABLE `socios` (
  `num_socio` int(11) NOT NULL,
  `nombre_com` varchar(30) NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `correo` varchar(30) NOT NULL,
  `f_inscripcion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socios`
--

INSERT INTO `socios` (`num_socio`, `nombre_com`, `direccion`, `correo`, `f_inscripcion`) VALUES
(1, 'Juan Pérez', 'Calle 1', 'juan@mail.com', '2023-02-10'),
(2, 'Ana Gómez', 'Calle 2', 'ana@mail.com', '2024-01-15'),
(3, 'Luis Díaz', 'Calle 3', 'luis@mail.com', '2023-11-25');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `libros`
--
ALTER TABLE `libros`
  ADD PRIMARY KEY (`cod_libro`);

--
-- Indices de la tabla `multa`
--
ALTER TABLE `multa`
  ADD PRIMARY KEY (`id_multa`);

--
-- Indices de la tabla `prestamo_libro`
--
ALTER TABLE `prestamo_libro`
  ADD PRIMARY KEY (`num_socio`,`cod_libro`),
  ADD KEY `Fk_multa` (`Fk_id_multa`),
  ADD KEY `cod_libro` (`cod_libro`);

--
-- Indices de la tabla `socios`
--
ALTER TABLE `socios`
  ADD PRIMARY KEY (`num_socio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `libros`
--
ALTER TABLE `libros`
  MODIFY `cod_libro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `multa`
--
ALTER TABLE `multa`
  MODIFY `id_multa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `socios`
--
ALTER TABLE `socios`
  MODIFY `num_socio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamo_libro`
--
ALTER TABLE `prestamo_libro`
  ADD CONSTRAINT `Fk_multa` FOREIGN KEY (`Fk_id_multa`) REFERENCES `multa` (`id_multa`),
  ADD CONSTRAINT `prestamo_libro_ibfk_1` FOREIGN KEY (`cod_libro`) REFERENCES `libros` (`cod_libro`),
  ADD CONSTRAINT `prestamo_libro_ibfk_2` FOREIGN KEY (`num_socio`) REFERENCES `socios` (`num_socio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
