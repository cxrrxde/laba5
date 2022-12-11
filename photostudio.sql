-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 11 2022 г., 10:01
-- Версия сервера: 10.4.27-MariaDB
-- Версия PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `photostudio`
--

-- --------------------------------------------------------

--
-- Структура таблицы `bill`
--

CREATE TABLE `bill` (
  `id_bill` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date` date NOT NULL,
  `sum` float NOT NULL,
  `status` varchar(15) NOT NULL,
  `request_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `bill`
--

INSERT INTO `bill` (`id_bill`, `number`, `date`, `sum`, `status`, `request_id`) VALUES
(1, 10, '2022-12-11', 10000, 'Не оплачено', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `client`
--

CREATE TABLE `client` (
  `id_client` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `client`
--

INSERT INTO `client` (`id_client`, `full_name`, `phone`) VALUES
(1, 'Патрик Бэйтман', '89320567623');

-- --------------------------------------------------------

--
-- Структура таблицы `photographer`
--

CREATE TABLE `photographer` (
  `id_photographer` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `rent` float NOT NULL,
  `path_img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `photographer`
--

INSERT INTO `photographer` (`id_photographer`, `full_name`, `phone`, `rent`, `path_img`) VALUES
(1, 'Океанова Ксения', '89225644575', 1500, 'img/photographers/1.jpg'),
(2, 'Малинова Яна', '89324760347', 2000, 'img/photographers/2.jpg'),
(3, 'Крылова Анастасия', '89997862374', 2500, 'img/photographers/3.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `place`
--

CREATE TABLE `place` (
  `id_place` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `rent` float NOT NULL,
  `description` varchar(255) NOT NULL,
  `path_img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `place`
--

INSERT INTO `place` (`id_place`, `name`, `rent`, `description`, `path_img`) VALUES
(1, 'Зал №1', 2000, 'Данный зал предназначен для фотосессий.', 'img/places/1.jpg'),
(2, 'Зал №2', 2500, 'Данный зал предназначен для фотосессий.', 'img/places/2.jpg'),
(3, 'Зал №3', 1500, 'Данный зал предназначен для фотосессий.', 'img/places/3.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `portfolio`
--

CREATE TABLE `portfolio` (
  `id_portfolio` int(11) NOT NULL,
  `link` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `portfolio`
--

INSERT INTO `portfolio` (`id_portfolio`, `link`, `client_id`) VALUES
(1, 'какая-то ссылка', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `request`
--

CREATE TABLE `request` (
  `id_request` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `date_create` date NOT NULL,
  `datetime_pp` datetime NOT NULL,
  `datetime_py` datetime NOT NULL,
  `datetime_fp` datetime DEFAULT NULL,
  `datetime_fy` datetime DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `photographer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Дамп данных таблицы `request`
--

INSERT INTO `request` (`id_request`, `number`, `date_create`, `datetime_pp`, `datetime_py`, `datetime_fp`, `datetime_fy`, `comment`, `client_id`, `place_id`, `photographer_id`) VALUES
(1, 10, '2022-12-11', '2022-12-17 14:01:00', '2022-12-17 16:01:00', NULL, NULL, NULL, 1, 2, 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`id_bill`),
  ADD KEY `request_id` (`request_id`);

--
-- Индексы таблицы `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`);

--
-- Индексы таблицы `photographer`
--
ALTER TABLE `photographer`
  ADD PRIMARY KEY (`id_photographer`);

--
-- Индексы таблицы `place`
--
ALTER TABLE `place`
  ADD PRIMARY KEY (`id_place`);

--
-- Индексы таблицы `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id_portfolio`),
  ADD KEY `client_id` (`client_id`);

--
-- Индексы таблицы `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id_request`),
  ADD KEY `client_id` (`client_id`,`place_id`,`photographer_id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `photographer_id` (`photographer_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `bill`
--
ALTER TABLE `bill`
  MODIFY `id_bill` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `photographer`
--
ALTER TABLE `photographer`
  MODIFY `id_photographer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `place`
--
ALTER TABLE `place`
  MODIFY `id_place` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `id_portfolio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `request`
--
ALTER TABLE `request`
  MODIFY `id_request` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `request` (`id_request`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `portfolio`
--
ALTER TABLE `portfolio`
  ADD CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id_client`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `request_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id_client`) ON UPDATE CASCADE,
  ADD CONSTRAINT `request_ibfk_2` FOREIGN KEY (`place_id`) REFERENCES `place` (`id_place`) ON UPDATE CASCADE,
  ADD CONSTRAINT `request_ibfk_3` FOREIGN KEY (`photographer_id`) REFERENCES `photographer` (`id_photographer`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
