-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 12 mai 2022 à 13:30
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `strange_day`
--

-- --------------------------------------------------------

--
-- Structure de la table `accessory`
--

DROP TABLE IF EXISTS `accessory`;
CREATE TABLE IF NOT EXISTS `accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `accessory`
--

INSERT INTO `accessory` (`id`, `type`, `product_id`) VALUES
(3, 'Tote bag', 31),
(5, 'Sac', 37),
(6, 'Casquette', 48),
(7, 'Casquette', 49);

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE IF NOT EXISTS `address` (
  `user_id` int(11) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(2) NOT NULL,
  `state` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `address`
--

INSERT INTO `address` (`user_id`, `address1`, `address2`, `city`, `postal_code`, `country`, `state`) VALUES
(1, '28 rue de l\'avignou', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(36, '1455 rue Jules Régnier', '', 'Plaisir', '78370', 'FR', 'IDF'),
(37, '18 rue romain rolland', '', 'Gentilly', '94250', 'FR', 'Île de France '),
(38, '45 rue Pierre Curie', 'Bâtiment H', 'PLAISIR', '78370', 'FR', 'YVELINES'),
(39, '23 rue Arthur croquette', '', 'Charenton le pont', '94220', 'FR', 'Ile de france'),
(40, '1 Rue du Commandant Guilbaud', 'Chez Emad Saroufim', 'Boulogne-Billancourt', '92100', 'FR', 'île de france '),
(31, '4 rue des Ébisoires', '', 'Plaisir', '78370', 'FR', 'Ile de France'),
(32, '5 allée de Bavière', '', 'Elancourt', '78990', 'FR', 'Ile de France'),
(34, '315 rue Marcel Pagnol ', '', 'Plaisir', '78370', 'FR', 'Ile-de-France '),
(41, '4 impasse de la Fontenelle ', '', '27940', 'Aubevoye', 'FR', 'Normandie'),
(42, '4 Rue des Ebisoires', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(43, '2 allée de la tamise', '2', 'Elancourt', '78990', 'FR', 'Île de France'),
(44, '01 route de la gare', '', 'Malicorne', '03600', 'FR', 'Allier'),
(45, '9 rue du 71e mobiles', '', 'Limoges', '87000', 'FR', 'Haute-Vienne'),
(46, '65 avenue Gambetta', '', 'PARIS', '75020', 'FR', 'Ile de France'),
(47, '17bis boulevard de Rochechouart', '', 'Plaisir', '78370', 'FR', 'Île de France '),
(48, '9 rue vincent van gogh', '', 'Plaisir', '78370', 'FR', 'Île de france'),
(49, 'rue de liège, 52/7', '52/7', 'Verviers', '4800', 'BE', 'Liège'),
(50, 'Abel Gueyt ', '40 ', 'Plaisir ', '78370', 'FR', 'Plaisir '),
(51, '40 rue Abel Guyet', 'Deuxième étage à droite', 'Plaisir', '78370', 'FR', 'Plaisir'),
(52, '7 rue des Ebisoires', '', 'Plaisir', '78370', 'FR', 'Ile de france'),
(53, '3 rue de Folleville', '', 'Thiverval-grignon', '78850', 'FR', 'Île de France '),
(54, '9 place Marguerite yourcenar', '', 'Plaisir', '78370', 'FR', 'Île de france'),
(55, '6 rue Alexandre bontemps ', '4', 'Versailles ', '78000', 'FR', 'Yvelines'),
(56, '315 rue Marcel Pagnol', '', 'PLAISIR', '78370', 'FR', 'Ile de France'),
(57, '2ter avenue de saint mandé', '217', 'Paris', '94160', 'FR', 'Ile de france'),
(58, '5 rue Godefroy Cavaignac', '', 'PARIS ', '75011', 'FR', 'idf'),
(59, '9 rue Fernand Léger', '', 'Fontenay-sous-bois', '94120', 'FR', 'France'),
(60, '49 Avenue Alphand ', 'RDC gauche', 'Saint-Mandé', '94160', 'FR', 'Ile de France '),
(61, '68 grande rue ', '', 'Coye-La-Foret', '60580', 'FR', 'Haut-de-France'),
(62, '4 Rue Aristide Briand', '', 'Colombes', '92700', 'FR', 'IDF'),
(63, '49 Avenue Alphand', 'rdc gauche', 'Saint-Mandé', '94160', 'FR', 'île de France'),
(64, '107 ', 'rue de reuilly', '75012', 'PARIs', 'FR', 'Ile de france'),
(65, 'rue du petit bontemps', '9', 'Plaisir', '78370', 'FR', 'Yvelines'),
(66, '7 rond point du pont Mirabeau', '', 'Paris', '75015', 'FR', 'île de France '),
(67, '1333 rue Jules Regnier', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(68, '28 rue de l\'Avignou', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(69, '5 avenue Victoire ', '', 'Colombes', '92700', 'FR', 'Ile-de-France'),
(70, '67 avenue Pablo Picasso', ' appartement 105, 1er étage', 'Nanterre', '92000', 'FR', 'Ile-de-France'),
(25, '12 allée des cottages ', '', 'Le mesnil-st-dénis ', '78320', 'FR', 'Île-de-France '),
(26, 'rue de Normandie', '19', 'Plaisir', '78370', 'FR', 'Île de France'),
(23, '29 rue de la gare ', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(2, '7 rue des Ebisoires', '', 'PLAISIR', '78370', 'FR', '-'),
(14, '204 avenue du 19 mars 1962', '', 'Plaisir', '78370', 'FR', 'yaniss.mardaoui@outlook.fr'),
(35, '1455 rue Jules Régnier', '', 'Plaisir', '78370', 'FR', 'IDF'),
(33, '140 rue de suede', '', 'Plaisir', '78370', 'FR', 'Ile de France'),
(20, '16 rue du Chêne Bocquet', '', 'Taverny', '95150', 'FR', 'Île-de-France'),
(19, '6 rue albert einstein', '', 'Plaisir', '78370', 'FR', 'Yvelines'),
(21, '4 Rue Des Ebisoires ', '', 'Plaisir ', '78370', 'FR', 'Île de France '),
(27, '16 rue du Chêne Bocquet', '', 'Taverny', '95150', 'FR', 'Val d\'Oise'),
(24, '29 rue francois couperin', '29', 'Plaisir', '78370', 'FR', 'Yvelines'),
(29, '17 rue saint Guillaume ', '', 'Courbevoie ', '92400', 'FR', 'Haut de Seine '),
(30, '16 rue Dugommier', '', 'Paris', '75012', 'FR', 'Île de France'),
(28, 'impasse du carel ', '8', 'Mathieu', '14929', 'FR', 'Calvados ');

-- --------------------------------------------------------

--
-- Structure de la table `clothe`
--

DROP TABLE IF EXISTS `clothe`;
CREATE TABLE IF NOT EXISTS `clothe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) DEFAULT NULL,
  `composition` varchar(255) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `clothe`
--

INSERT INTO `clothe` (`id`, `type`, `composition`, `product_id`) VALUES
(25, NULL, '100% coton, 205gr', 30),
(30, NULL, '100% coton 180gr', 41),
(31, NULL, '100% coton 180gr', 42),
(32, NULL, '100% coton 180gr', 43),
(33, NULL, '100% coton 180gr', 44),
(34, NULL, 'blabla', 45),
(35, NULL, '100% coton. 205g', 46),
(36, NULL, '100% coton. 205g', 47),
(37, NULL, '50% Coton 50% Polyester. 270g ', 50),
(38, 'crewneck', '50% Coton 50% Polyester', 51),
(39, 'crewneck', '50% Coton 50% Polyester. 270g', 52),
(40, 'longsleeve', '90% Coton 10% Polyester. 203g', 53),
(41, 't-shirt', '100% Coton. 203g', 54),
(42, 't-shirt', '100% coton. 203g', 55),
(43, 't-shirt', '100% coton. 203g', 56),
(44, 't-shirt', '100% coton. 203g', 57),
(45, 't-shirt', '100% coton. 203g', 58),
(57, 't-shirt', 'caca', 74);

-- --------------------------------------------------------

--
-- Structure de la table `color`
--

DROP TABLE IF EXISTS `color`;
CREATE TABLE IF NOT EXISTS `color` (
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `color`
--

INSERT INTO `color` (`name`, `code`) VALUES
('Rouge', '#ff0000'),
('Bleu', '#0000ff'),
('Vert', '#00ff00');

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`id`, `name`) VALUES
(60, 'BLEU.png'),
(66, 'IMG_6061.jpg'),
(67, 'IMG_6080.jpg'),
(68, 'IMG_6080.jpg'),
(69, 'IMG_6068.jpg'),
(70, 'img2.jpg'),
(71, 'img4.jpg'),
(72, 'img3.jpg'),
(73, 'img4.png'),
(74, 'img2-1.jpg'),
(75, 'Mortal Kiss Comics.PNG'),
(76, 'pull.jpg'),
(77, 'image0.jpg'),
(78, '1552764891-risi-fou.png'),
(79, 'chnce 2.png'),
(80, '1612880301-wonkie-salto.png'),
(81, '173880-full.png'),
(82, '1612848352-risitasss-bougade-bougnade-putain-putain-putain-eussou.png'),
(83, '222888-full.png'),
(84, '1612848352-risitasss-bougade-bougnade-putain-putain-putain-eusso0.png'),
(85, '222886-full.png'),
(86, 'placeholder.png'),
(87, 'fond.png'),
(88, 'fond.jpg'),
(89, 'DSC03621.jpg'),
(90, 'DSC03650.jpg'),
(91, 'DSC03447.jpg'),
(92, 'DSC03466.jpg'),
(93, 'Fond neutre zoom.jpg'),
(94, 'Tote bag fond neutre.png'),
(95, 'Tote bag fond neutre zoom.png'),
(96, 'DSC03527.jpg'),
(97, 'DSC03478.jpg'),
(98, 'DSC03270-2.jpg'),
(99, 'Fond 2.jpg'),
(100, 'DSC03519-2.jpg'),
(101, 'DSC03632.jpg'),
(102, 'DSC03616.jpg'),
(103, 'DSC03591.jpg'),
(104, 'DSC03760.jpg'),
(105, 'IMG_7032.jpg'),
(106, '18062021-DSC08919.jpg'),
(107, '18062021-DSC09483.jpg'),
(108, '18062021-DSC09992.jpg'),
(109, 'Citronnade.png'),
(110, '18062021-DSC09218.jpg'),
(111, '18062021-DSC09416.jpg'),
(112, '18062021-DSC09198.jpg'),
(113, 'Pomme.png'),
(114, 'Vert Foret.jpg.png'),
(115, '18062021-DSC09055.jpg'),
(116, '18062021-DSC09660.jpg'),
(117, 'Camel.jpg.png'),
(118, '18062021-DSC09882.jpg'),
(119, '18062021-DSC09566.jpg'),
(120, '18062021-DSC09854.jpg'),
(121, 'tote bag.png'),
(122, '18062021-DSC09487.jpg'),
(123, '18062021-DSC09205.jpg'),
(124, '18062021-DSC09405.jpg'),
(125, 'Patron_tshirt.png'),
(126, 'Sans titre-3.png'),
(127, 'DSC01570-2.jpg'),
(128, 'DSC01702.jpg'),
(129, 'DSC01626.jpg'),
(130, 'DSC02567.jpg'),
(131, 'DSC02286.jpg'),
(132, 'Tshirt Travis.png'),
(133, 'Bobby.jpg.png'),
(134, 'TWASD.jpg.png'),
(135, 'DSC04264.jpg'),
(136, 'Allons Danser.png'),
(137, 'DSC00755.jpg'),
(138, 'DSC00893.jpg'),
(139, 'DSC04039.jpg'),
(140, 'Elvis.png'),
(141, 'DSC03992.jpg'),
(142, 'DSC03898.jpg'),
(143, 'DSC03550.jpg'),
(144, 'Suzette.png'),
(145, 'DSC03268 - Copie.jpg'),
(146, 'DSC03243.jpg'),
(147, 'DSC03703.jpg'),
(148, 'Minuit.png'),
(149, 'DSC03722.jpg'),
(150, 'DSC03568.jpg'),
(151, 'DSC03192.jpg'),
(152, 'Kurt.png'),
(153, 'DSC03138.jpg'),
(154, 'DSC03085.jpg'),
(155, 'DSC04318.jpg'),
(156, 'Amélie.png'),
(157, 'DSC04448.jpg'),
(158, 'DSC04473.jpg'),
(159, 'STE.png'),
(160, 'DSC01018.jpg'),
(161, 'DSC01177.jpg'),
(162, 'DSC01685.jpg'),
(163, 'Mia.png'),
(164, 'DSC01630.jpg'),
(165, 'DSC00840.jpg'),
(166, 'DSC01201.jpg'),
(167, 'DSC01594.jpg'),
(168, 'DSC02671.jpg'),
(169, 'DSC02601.jpg'),
(170, 'DSC00983 - Copie.jpg'),
(171, 'DSC01111.jpg'),
(172, 'DSC04400.jpg'),
(173, 'archive-super8-Cover-Art.jpg'),
(174, 'Call-To-Arms-Angels.png'),
(175, 'Untitled(1).png'),
(176, 'Capture astro.PNG'),
(177, 'R-9038468-1473697820-5717.jpg'),
(178, 'figure mail maysae 2.png'),
(179, 'Capture.PNG'),
(180, 'fate-of-universe-5.png');

-- --------------------------------------------------------

--
-- Structure de la table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE IF NOT EXISTS `newsletter` (
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `newsletter`
--

INSERT INTO `newsletter` (`email`) VALUES
('antoine.madrelle@laposte.net'),
('antoinemXmarceau@gmail.com'),
('arouxel.trash@outlook.fr'),
('arouxel@outlook.fr'),
('baptistepouyaud31@gmail.com'),
('boutrinmarianne@gmail.com'),
('colombe@heurdier.com'),
('ds.laura2@gmail.com'),
('helovarde@gmail.com'),
('jdaniel1304@gmail.com '),
('kassimbourhan@yahoo.fr'),
('kimkim.jules@gmail.com'),
('lekien.thomas@gmail.com'),
('mardochee78@gmail.com '),
('mariashenoda@outlook.com'),
('matthias_antivax@raoult.fr'),
('maureen.bck@gmail.com'),
('maxime.murer04@gmail.com'),
('naomakawaii@gmail.com'),
('noemie.poujol@gmail.com'),
('perrine@heurdier.com'),
('simon.petit2019@outlook.com'),
('toulouse.carla@gmail.com'),
('yaonnlife@gmail.com '),
('yaonnlife@hotmail.fr'),
('Zalo.Timothe@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `total_cost` decimal(15,2) DEFAULT NULL,
  `subtotal_cost` decimal(15,2) DEFAULT NULL,
  `shipping_cost` decimal(15,2) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `shipping_method` varchar(20) DEFAULT NULL,
  `state` varchar(20) NOT NULL DEFAULT 'waiting',
  `tracking_number` varchar(255) DEFAULT NULL,
  `voucher` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `user_id`, `date`, `total_cost`, `subtotal_cost`, `shipping_cost`, `billing_address`, `shipping_address`, `payment_method`, `shipping_method`, `state`, `tracking_number`, `voucher`) VALUES
(18, 21, '2021-04-02', '12.00', '12.00', '0.00', '4 Rue Des Ebisoires   78370 Plaisir  Île de France  FR ', '4 Rue Des Ebisoires   78370 Plaisir  Île de France  FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(19, 25, '2021-04-02', '19.95', '15.00', '4.95', '12 allée des cottages   78320 Le mesnil-st-dénis  Île-de-France  FR ', '12 allée des cottages   78320 Le mesnil-st-dénis  Île-de-France  FR', 'carte bancaire', 'colissimo', 'shipped', '8J00696733039', NULL),
(20, 14, '2021-04-02', '15.00', '15.00', '0.00', '204 avenue du 19 mars 1962  78370 Plaisir yaniss.mardaoui@outlook.fr FR ', '204 avenue du 19 mars 1962  78370 Plaisir yaniss.mardaoui@outlook.fr FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(21, 19, '2021-04-02', '15.00', '15.00', '0.00', '6 rue albert einstein  78370 Plaisir Yvelines FR ', '6 rue albert einstein  78370 Plaisir Yvelines FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(22, 27, '2021-04-02', '19.95', '15.00', '4.95', '16 rue du Chêne Bocquet  95150 Taverny Val d\'Oise FR ', '16 rue du Chêne Bocquet  95150 Taverny Val d\'Oise FR', 'carte bancaire', 'colissimo', 'shipped', '8J00696315266', NULL),
(23, 26, '2021-04-02', '15.00', '15.00', '0.00', 'rue de Normandie 19 78370 Plaisir Île de France FR ', 'rue de Normandie 19 78370 Plaisir Île de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(24, 28, '2021-04-02', '19.95', '15.00', '4.95', 'impasse du carel  8 14929 Mathieu Calvados  FR ', 'impasse du carel  8 14929 Mathieu Calvados  FR', 'carte bancaire', 'colissimo', 'shipped', '8J00696732995', NULL),
(25, 29, '2021-04-03', '16.95', '12.00', '4.95', '17 rue saint Guillaume   92400 Courbevoie  Haut de Seine  FR ', '17 rue saint Guillaume   92400 Courbevoie  Haut de Seine  FR', 'carte bancaire', 'colissimo', 'shipped', '8J00696733008', NULL),
(26, 30, '2021-04-03', '34.95', '30.00', '4.95', '16 rue Dugommier  75012 Paris Île de France FR ', '16 rue Dugommier  75012 Paris Île de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(27, 31, '2021-04-03', '15.00', '15.00', '0.00', '4 rue des Ébisoires  78370 Plaisir Ile de France FR ', '4 rue des Ébisoires  78370 Plaisir Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(28, 32, '2021-04-05', '15.00', '15.00', '0.00', '5 allée de Bavière  78990 Elancourt Ile de France FR ', '5 allée de Bavière  78990 Elancourt Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(29, 34, '2021-04-05', '27.00', '27.00', '0.00', '315 rue Marcel Pagnol   78370 Plaisir Ile-de-France  FR ', '315 rue Marcel Pagnol   78370 Plaisir Ile-de-France  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(30, 33, '2021-04-05', '12.00', '12.00', '0.00', '140 rue de suede  78370 Plaisir Ile de France FR ', '140 rue de suede  78370 Plaisir Ile de France FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(31, 36, '2021-04-06', '27.00', '27.00', '0.00', '1455 rue Jules Régnier  78370 Plaisir IDF FR ', '1 rue Albert Roussel  78370 Plaisir IDF FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(32, 37, '2021-04-06', '19.95', '15.00', '4.95', '18 rue romain rolland  94250 Gentilly Île de France  FR ', '18 rue romain rolland  94250 Gentilly Île de France  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(33, 38, '2021-04-07', '42.00', '42.00', '0.00', '9 rue de la ferronnerie  78370 PLAISIR YVELINES FR ', '9 rue de la ferronnerie  78370 PLAISIR YVELINES FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(34, 39, '2021-04-07', '16.95', '12.00', '4.95', '23 rue Arthur croquette  94220 Charenton le pont Ile de france FR ', '23 rue Arthur croquette  94220 Charenton le pont Ile de france FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(35, 40, '2021-04-09', '19.95', '15.00', '4.95', '1 Rue du Commandant Guilbaud Chez Emad Saroufim 92100 Boulogne-Billancourt île de france  FR ', '1 Rue du Commandant Guilbaud Chez Emad Saroufim 92100 Boulogne-Billancourt île de france  FR', 'carte bancaire', 'colissimo', 'shipped', '8J00696733015', NULL),
(36, 41, '2021-04-21', '19.95', '15.00', '4.95', '4 impasse de la Fontenelle   Aubevoye 27940 Normandie FR ', '4 impasse de la Fontenelle   Aubevoye 27940 Normandie FR', 'carte bancaire', 'colissimo', 'shipped', '8J00697645591', NULL),
(37, 42, '2021-07-02', '18.00', '18.00', '0.00', '4 Rue des Ebisoires  78370 Plaisir Yvelines FR ', '4 Rue des Ebisoires  78370 Plaisir Yvelines FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(38, 43, '2021-07-02', '18.00', '18.00', '0.00', '2 allée de la tamise 2 78990 Elancourt Île de France FR ', '2 allée de la tamise 2 78990 Elancourt Île de France FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(39, 44, '2021-07-02', '22.95', '18.00', '4.95', '01 route de la gare  03600 Malicorne Allier FR ', '01 route de la gare  03600 Malicorne Allier FR', 'carte bancaire', 'colissimo', 'shipped', '8J00718562845', NULL),
(40, 45, '2021-07-02', '22.95', '18.00', '4.95', '9 rue du 71e mobiles  87000 Limoges Haute-Vienne FR ', '9 rue du 71e mobiles  87000 Limoges Haute-Vienne FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(41, 46, '2021-07-03', '40.95', '36.00', '4.95', '65 avenue Gammbetta  75020 PARIS Ile de France FR ', '65 avenue Gammbetta  75020 PARIS Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', '8J00718562852', NULL),
(42, 46, '2021-04-02', '19.95', '15.00', '4.95', '65-67 Avenue Gambetta  75020 Paris Ile de France FR', '65-67 Avenue Gambetta  75020 Paris Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', NULL, NULL),
(43, 14, '2021-07-06', '18.00', '18.00', '0.00', '204 avenue du 19 mars 1962  78370 Plaisir yaniss.mardaoui@outlook.fr FR ', '204 avenue du 19 mars 1962  78370 Plaisir yaniss.mardaoui@outlook.fr FR', 'carte bancaire', 'colissimo', 'shipped', 'tu es ?', NULL),
(44, 47, '2021-07-15', '18.00', '18.00', '0.00', '17bis boulevard de Rochechouart  78370 Plaisir Île de France  FR ', '17bis boulevard de Rochechouart  78370 Plaisir Île de France  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(45, 48, '2021-07-16', '18.00', '18.00', '0.00', '9 rue vincent van gogh  78370 Plaisir Île de france FR ', '9 rue vincent van gogh  78370 Plaisir Île de france FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(47, 1, '2021-11-05', '27.00', '27.00', '0.00', '28 rue de l\'avignou  78370 Plaisir Yvelines FR ', '28 rue de l\'avignou  78370 Plaisir Yvelines FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(48, 51, '2021-11-05', '178.00', '178.00', '0.00', '40 rue Abel Guyet Deuxième étage à droite 78370 Plaisir Plaisir FR ', '40 rue Abel Guyet Deuxième étage à droite 78370 Plaisir Plaisir FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(49, 51, '2021-11-05', '57.00', '57.00', '0.00', '40 rue Abel Guyet Deuxième étage à droite 78370 Plaisir Plaisir FR ', '40 rue Abel Guyet Deuxième étage à droite 78370 Plaisir Plaisir FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(50, 52, '2021-11-06', '38.00', '38.00', '0.00', '7 rue des Ebisoires  78370 Plaisir Ile de france FR ', '7 rue des Ebisoires  78370 Plaisir Ile de france FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(51, 53, '2021-11-06', '44.45', '38.00', '6.45', '3 rue de Folleville  78850 Thiverval-grignon Île de France  FR ', '3 rue de Folleville  78850 Thiverval-grignon Île de France  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(52, 55, '2021-11-07', '40.00', '38.00', '6.45', '6 rue Alexandre bontemps  4 78000 Versailles  Yvelines FR ', '6 rue Alexandre bontemps  4 78000 Versailles  Yvelines FR', 'carte bancaire', 'colissimo', 'shipped', '', 'JORISLOVE'),
(53, 56, '2021-11-09', '38.00', '38.00', '0.00', '315 rue Marcel Pagnol  78370 PLAISIR Ile de France FR ', '315 rue Marcel Pagnol  78370 PLAISIR Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(54, 38, '2021-11-11', '38.00', '38.00', '0.00', '45 rue Pierre Curie Bâtiment H 78370 PLAISIR YVELINES FR ', '45 rue Pierre Curie Bâtiment H 78370 PLAISIR YVELINES FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(55, 26, '2021-11-11', '38.00', '38.00', '0.00', 'rue de Normandie 19 78370 Plaisir Île de France FR ', 'rue de Normandie 19 78370 Plaisir Île de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(56, 58, '2021-11-11', '31.95', '27.00', '4.95', '5 rue Godefroy Cavaignac  75011 PARIS  idf FR ', '5 rue Godefroy Cavaignac  75011 PARIS  idf FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(57, 46, '2021-11-11', '71.45', '65.00', '6.45', '65 avenue Gammbetta  75020 PARIS Ile de France FR ', '65 avenue Gammbetta  75020 PARIS Ile de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(58, 31, '2021-11-12', '38.00', '38.00', '0.00', '4 rue des Ébisoires  78370 Plaisir Ile de France FR ', '4 rue des Ébisoires  78370 Plaisir Ile de France FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(59, 57, '2021-11-13', '67.00', '68.00', '6.45', '2ter avenue de saint mandé 217 94160 Paris Ile de france FR ', '2ter avenue de saint mandé 217 94160 Paris Ile de france FR', 'carte bancaire', 'colissimo', 'shipped', '', 'ENCORETOICHEF'),
(60, 59, '2021-11-19', '44.45', '38.00', '6.45', '9 rue Fernand Léger  94120 Fontenay-sous-bois France FR ', '9 rue Fernand Léger  94120 Fontenay-sous-bois France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(61, 61, '2021-11-25', '31.95', '27.00', '4.95', '68 grande rue   60580 Coye-La-Foret Haut-de-France FR ', '68 grande rue   60580 Coye-La-Foret Haut-de-France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(62, 63, '2021-11-29', '31.95', '27.00', '4.95', '49 Avenue Alphand rdc gauche 94160 Saint-Mandé île de France FR ', '49 Avenue Alphand rdc gauche 94160 Saint-Mandé île de France FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(63, 21, '2021-12-01', '38.00', '38.00', '0.00', '4 Rue Des Ebisoires   78370 Plaisir  Île de France  FR ', '4 Rue Des Ebisoires   78370 Plaisir  Île de France  FR', 'paypal', 'colissimo', 'shipped', '', NULL),
(65, 62, '2021-12-02', '44.45', '38.00', '6.45', '4 Rue Aristide Briand  92700 Colombes IDF FR ', '4 Rue Aristide Briand  92700 Colombes IDF FR', 'carte bancaire', 'colissimo', 'shipped', 'C\'est dans ton casier au BDE bg', ''),
(66, 29, '2021-12-03', '83.35', '76.00', '7.35', '17 rue saint Guillaume   92400 Courbevoie  Haut de Seine  FR ', '17 rue saint Guillaume   92400 Courbevoie  Haut de Seine  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(67, 64, '2021-12-03', '31.95', '27.00', '4.95', '107  rue de reuilly PARIs 75012 Ile de france FR ', '107  rue de reuilly PARIs 75012 Ile de france FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(68, 65, '2021-12-06', '27.00', '27.00', '0.00', 'rue du petit bontemps 9 78370 Plaisir Yvelines FR ', 'rue du petit bontemps 9 78370 Plaisir Yvelines FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(69, 66, '2021-12-09', '44.45', '38.00', '6.45', '7 rond point du pont Mirabeau  75015 Paris île de France  FR ', '7 rond point du pont Mirabeau  75015 Paris île de France  FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(70, 67, '2021-12-09', '27.00', '27.00', '0.00', '1333 rue Jules Regnier  78370 Plaisir Yvelines FR ', '1333 rue Jules Regnier  78370 Plaisir Yvelines FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(71, 68, '2021-12-09', '85.00', '85.00', '0.00', '28 rue de l\'Avignou  78370 Plaisir Yvelines FR ', '28 rue de l\'Avignou  78370 Plaisir Yvelines FR', 'carte bancaire', 'colissimo', 'shipped', '', NULL),
(72, 69, '2021-12-10', '113.72', '119.00', '7.35', '5 avenue Victoire   92700 Colombes Ile-de-France FR ', '5 avenue Victoire   92700 Colombes Ile-de-France FR', 'carte bancaire', 'colissimo', 'shipped', '', 'ENCORETOICHEF'),
(73, 70, '2021-12-15', '99.35', '92.00', '7.35', '67 avenue Pablo Picasso  appartement 105, 1er étage 92000 Nanterre Ile-de-France FR ', '67 avenue Pablo Picasso  appartement 105, 1er étage 92000 Nanterre Ile-de-France FR', 'carte bancaire', 'colissimo', 'shipped', '8J00752319757', NULL),
(74, 19, '2021-12-31', '27.00', '27.00', '0.00', '6 rue albert einstein  78370 Plaisir Yvelines FR ', '6 rue albert einstein  78370 Plaisir Yvelines FR', 'paypal', 'colissimo', 'shipped', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `order_content`
--

DROP TABLE IF EXISTS `order_content`;
CREATE TABLE IF NOT EXISTS `order_content` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `nb` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`order_id`,`product_id`,`size`,`color`) USING BTREE,
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `order_content`
--

INSERT INTO `order_content` (`order_id`, `product_id`, `size`, `color`, `nb`, `name`, `price`) VALUES
(17, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(18, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(19, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(20, 30, 'S', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(21, 30, 'S', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(22, 30, 'L', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(23, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(24, 30, 'L', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(25, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(26, 30, 'L', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(26, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(27, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(28, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(29, 30, 'L', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(29, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(30, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(31, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(31, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(32, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(33, 30, 'M', '', 2, 'T-SHIRT PHOTOMATON', '15.00'),
(33, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(34, 31, '', '', 1, 'TOTE BAG PHOTOMATON', '12.00'),
(35, 30, 'L', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(36, 30, 'S', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(37, 42, 'XL', '', 1, 'T-SHIRT VAN VERT FORÊT ', '18.00'),
(38, 44, 'L', '', 1, 'T-SHIRT VAN POMME', '18.00'),
(39, 42, 'S', '', 1, 'T-SHIRT VAN VERT FORÊT ', '18.00'),
(40, 44, 'M', '', 1, 'T-SHIRT VAN POMME', '18.00'),
(41, 42, 'M', '', 1, 'T-SHIRT VAN VERT FORÊT ', '18.00'),
(41, 44, 'M', '', 1, 'T-SHIRT VAN POMME', '18.00'),
(42, 30, 'M', '', 1, 'T-SHIRT PHOTOMATON', '15.00'),
(43, 44, 'S', '', 1, 'T-SHIRT VAN POMME', '18.00'),
(44, 44, 'M', '', 1, 'T-SHIRT VAN POMME', '18.00'),
(45, 41, 'L', '', 1, 'T-SHIRT VAN CAMEL', '18.00'),
(47, 57, 'M', '', 1, 'T-shirt Antoine', '27.00'),
(48, 48, '', '', 1, 'La casquette Bobby', '30.00'),
(48, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(48, 53, 'L', '', 1, 'Longsleeve Minuit', '29.00'),
(48, 55, 'L', '', 1, 'T-shirt Montmartre', '27.00'),
(48, 58, 'XL', '', 2, 'T-shirt Mia', '27.00'),
(49, 49, '', '', 1, 'La Casquette Pigalle', '30.00'),
(49, 57, 'L', '', 1, 'T-shirt Antoine', '27.00'),
(50, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(51, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(52, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(53, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(54, 51, 'M', '', 1, 'Crewneck Elvis', '38.00'),
(55, 52, 'L', '', 1, 'Crewneck Suzette', '38.00'),
(56, 54, 'L', '', 1, 'T-shirt Kurt', '27.00'),
(57, 52, 'L', '', 1, 'Crewneck Suzette', '38.00'),
(57, 57, 'M', '', 1, 'T-shirt Antoine', '27.00'),
(58, 51, 'XL', '', 1, 'Crewneck Elvis', '38.00'),
(59, 48, '', '', 1, 'La casquette Bobby', '30.00'),
(59, 51, 'XL', '', 1, 'Crewneck Elvis', '38.00'),
(60, 52, 'L', '', 1, 'Crewneck Suzette', '38.00'),
(61, 55, 'S', '', 1, 'T-shirt Montmartre', '27.00'),
(62, 54, 'L', '', 1, 'T-shirt Kurt', '27.00'),
(63, 52, 'XXL', '', 1, 'Crewneck Suzette', '38.00'),
(65, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(66, 51, 'XL', '', 1, 'Crewneck Elvis', '38.00'),
(66, 52, 'M', '', 1, 'Crewneck Suzette', '38.00'),
(67, 58, 'L', '', 1, 'T-shirt Mia', '27.00'),
(68, 58, 'L', '', 1, 'T-shirt Mia', '27.00'),
(69, 50, 'S', '', 1, 'Crewneck Dernier Métro', '38.00'),
(70, 57, 'M', '', 1, 'T-shirt Antoine', '27.00'),
(71, 53, 'M', '', 2, 'Longsleeve Minuit', '29.00'),
(71, 56, 'M', '', 1, 'T-shirt Travis', '27.00'),
(72, 51, 'L', '', 1, 'Crewneck Elvis', '38.00'),
(72, 55, 'XL', '', 1, 'T-shirt Montmartre', '27.00'),
(72, 57, 'L', '', 1, 'T-shirt Antoine', '27.00'),
(72, 58, 'M', '', 1, 'T-shirt Mia', '27.00'),
(73, 52, 'L', '', 1, 'Crewneck Suzette', '38.00'),
(73, 56, 'L', '', 1, 'T-shirt Travis', '27.00'),
(73, 58, 'L', '', 1, 'T-shirt Mia', '27.00'),
(74, 55, 'S', '', 1, 'T-shirt Montmartre', '27.00');

-- --------------------------------------------------------

--
-- Structure de la table `print`
--

DROP TABLE IF EXISTS `print`;
CREATE TABLE IF NOT EXISTS `print` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `print_size` varchar(255) DEFAULT NULL,
  `printing` varchar(255) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `available` tinyint(1) DEFAULT '1',
  `type` varchar(20) DEFAULT NULL,
  `cover_image` varchar(255) NOT NULL,
  `default_color` varchar(255) NOT NULL DEFAULT '',
  `collection` varchar(255) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `available`, `type`, `cover_image`, `default_color`, `collection`, `weight`, `visible`) VALUES
(30, 'T-SHIRT PHOTOMATON', 'T-shirt sérigraphié en France. Coupe standard.\n\nJoana porte un t-shirt de taille S et mesure 1m54.\nMacky porte un t-shirt de taille M et mesure 1m74\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '18.00', 0, 'clothe', 'fond.png', '', 'Capsule Photomaton', 0, 0),
(31, 'SAC PHOTOMATON', 'Tote bag sérigraphié en France.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '12.00', 0, 'accessory', 'Tote bag fond neutre.png', '', 'Capsule Photomaton', 0, 0),
(37, 'SAC SUMMER ROADTRIP', 'Tote bag sérigraphié en France.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '12.00', 0, 'accessory', 'tote bag.png', '', 'Capsule Summer Roadtrip', 0, 0),
(41, 'T-SHIRT VAN CAMEL', 'T-shirt sérigraphié en France. Coupe standard.\n\nLoic porte un t-shirt de taille L et mesure 1m83.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '18.00', 0, 'clothe', 'Camel.jpg.png', '', 'Capsule Summer Roadtrip', 0, 0),
(42, 'T-SHIRT VAN VERT FORÊT ', 'T-shirt sérigraphié en France. Coupe standard.\n\nColin porte un t-shirt de taille L et mesure 1m83.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '18.00', 0, 'clothe', 'Vert Foret.jpg.png', '', 'Capsule Summer Roadtrip', 0, 0),
(43, 'T-SHIRT VAN CITRONNADE ', 'T-shirt sérigraphié en France. Coupe standard.\n\nHeloïse porte un t-shirt de taille L et mesure 1m65.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '18.00', 1, 'clothe', 'Citronnade.png', '', 'Capsule Summer Roadtrip', 200, 0),
(44, 'T-SHIRT VAN POMME', 'T-shirt sérigraphié en France. Coupe standard.\n\nCarla porte un t-shirt de taille M et mesure 1m60.\n\nLe laver à l\'envers à 30°C. Ne pas le passer au sèche-linge\n\nCe produit est imprimé à la demande. Compter 2 à 3 semaines avant réception.', '18.00', 1, 'clothe', 'Pomme.png', '', 'Capsule Summer Roadtrip', 200, 0),
(45, 'Test', 'blabla description', '1.00', 1, 'clothe', 'Patron_tshirt.png', '', 'Capsule Summer Roadtrip', 150, 0),
(46, 'Le T-shirt Mia', 'Laver à l\'envers\nréception sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Sans titre-3.png', '', 'Capsule Summer Roadtrip', 150, 0),
(47, 'Le T-shirt Travis', 'Laver à l\'envers\nréception sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Tshirt Travis.png', '', 'Capsule Summer Roadtrip', 150, 0),
(48, 'La casquette Bobby', 'Casquette ajustable\nRéception sous 2 à 3 semaines', '30.00', 0, 'accessory', 'Bobby.jpg.png', 'Défaut', 'Capsule Insomnie', 190, 1),
(49, 'La Casquette Pigalle', 'Casquette ajustable\nLivraison sous 2 à 3 semaines', '30.00', 1, 'accessory', 'TWASD.jpg.png', 'Défaut', 'Capsule Insomnie', 190, 1),
(50, 'Crewneck Dernier Métro', 'Laver à l\'envers\nYaël porte un crewneck de taille XL et mesure 1m67\nSi vous souhaitez un effet oversize, nous vous conseillons de prendre une taille au dessus de votre taille habituelle.\nLivraison sous 2 à 3 semaines', '38.00', 0, 'clothe', 'Allons Danser.png', '', 'Capsule Insomnie', 400, 0),
(51, 'Crewneck Elvis', 'Laver à l\'envers\nIlan porte un crewneck de taille L et mesure 1m78\nSi vous souhaitez un effet oversize, nous vous conseillons de prendre une taille au dessus de votre taille habituelle\nLivraison sous 2 à 3 semaines', '38.00', 1, 'clothe', 'Elvis.png', 'Défaut', 'Capsule Insomnie', 270, 1),
(52, 'Crewneck Suzette', 'Laver à l\'envers\nCamille porte un crewneck de taille L et mesure 1m70\nSi vous souhaitez un effet oversize, nous vous conseillons de prendre une taille au dessus de votre taille habituelle\nLivraison sous 2 à 3 semaines', '38.00', 1, 'clothe', 'Suzette.png', 'Défaut', 'Capsule Insomnie', 270, 1),
(53, 'Longsleeve Minuit', 'Laver à l\'envers\nTom porte un longsleeve de taille L et mesure 1m76\nLivraison sous 2 à 3 semaines', '29.00', 1, 'clothe', 'Minuit.png', '', 'Capsule Insomnie', 180, 1),
(54, 'T-shirt Kurt', 'Laver à l\'envers\nJulie porte un t-shirt de taille L et mesure 1m70\nLivraison sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Kurt.png', 'Défaut', 'Capsule Insomnie', 150, 1),
(55, 'T-shirt Montmartre', 'Laver à l\'envers\nYoann porte un t-shirt de taille L et mesure 1m83\nLivraison sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Amélie.png', 'Défaut', 'Capsule Insomnie', 150, 1),
(56, 'T-shirt Travis', 'Laver à l\'envers\nAlix porte un t-shirt de taille L et mesure 1m72\nLivraison sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Tshirt Travis.png', 'Défaut', 'Capsule Insomnie', 150, 1),
(57, 'T-shirt Antoine', 'Laver à l\'envers\nBaptiste porte un t-shirt de taille L et mesure 1m80\nLivraison sous 2 à 3 semaines', '27.00', 1, 'clothe', 'STE.png', 'Défaut', 'Capsule Insomnie', 150, 1),
(58, 'T-shirt Mia', 'Laver à l\'envers\nEmma porte un t-shirt de taille L et mesure 1m57\nLivraison sous 2 à 3 semaines', '27.00', 1, 'clothe', 'Mia.png', 'Défaut', 'Capsule Insomnie', 150, 1),
(74, 'Test couleurs', 'blabla', '12.36', 1, 'clothe', 'archive-super8-Cover-Art.jpg', 'Rouge', 'Aucune', 236, 1);

-- --------------------------------------------------------

--
-- Structure de la table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
CREATE TABLE IF NOT EXISTS `product_image` (
  `product_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `color` varchar(255) NOT NULL,
  `position` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`image_id`,`color`) USING BTREE,
  KEY `image_id` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `product_image`
--

INSERT INTO `product_image` (`product_id`, `image_id`, `color`, `position`) VALUES
(30, 87, '', 0),
(30, 90, '', 1),
(30, 91, '', 3),
(30, 100, '', 2),
(31, 94, '', 0),
(31, 103, '', 2),
(31, 104, '', 1),
(37, 121, '', 0),
(41, 117, '', 0),
(41, 118, '', 2),
(41, 120, '', 1),
(41, 122, '', 3),
(42, 114, '', 0),
(42, 115, '', 1),
(42, 116, '', 2),
(43, 109, '', 0),
(43, 110, '', 1),
(43, 123, '', 3),
(43, 124, '', 2),
(44, 106, '', 1),
(44, 107, '', 3),
(44, 108, '', 2),
(44, 113, '', 0),
(45, 125, '', 0),
(46, 126, '', 0),
(46, 127, '', 1),
(46, 128, '', 2),
(46, 129, '', 3),
(47, 130, '', 1),
(47, 131, '', 2),
(47, 132, '', 0),
(48, 133, '', 0),
(48, 166, '', 1),
(49, 134, '', 0),
(49, 135, '', 1),
(50, 136, '', 0),
(50, 137, '', 1),
(50, 138, '', 2),
(50, 165, '', 3),
(51, 139, '', 3),
(51, 140, '', 0),
(51, 141, '', 1),
(51, 142, '', 2),
(52, 143, '', 1),
(52, 144, '', 0),
(52, 145, '', 2),
(52, 146, '', 3),
(54, 151, '', 3),
(54, 152, '', 0),
(54, 153, '', 1),
(54, 154, '', 2),
(55, 155, '', 2),
(55, 156, '', 0),
(55, 157, '', 1),
(55, 172, '', 3),
(56, 130, '', 1),
(56, 132, '', 0),
(56, 168, '', 2),
(56, 169, '', 3),
(57, 159, '', 0),
(57, 161, '', 1),
(57, 170, '', 2),
(57, 171, '', 3),
(58, 163, '', 0),
(74, 173, 'Rouge', 0),
(74, 174, 'Rouge', 1),
(74, 176, 'Vert', 0),
(74, 177, 'Rouge', 2),
(74, 180, 'Vert', 1);

-- --------------------------------------------------------

--
-- Structure de la table `product_option`
--

DROP TABLE IF EXISTS `product_option`;
CREATE TABLE IF NOT EXISTS `product_option` (
  `product_id` int(11) NOT NULL,
  `color` varchar(255) NOT NULL,
  `size` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`product_id`,`color`,`size`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `product_option`
--

INSERT INTO `product_option` (`product_id`, `color`, `size`, `stock`) VALUES
(54, '', 'L', -1),
(57, '', 'L', -1),
(57, '', 'S', -1),
(56, '', 'L', -1),
(55, '', 'XXL', -1),
(55, '', 'M', -1),
(54, '', 'XXL', -1),
(54, '', 'M', -1),
(54, '', 'S', -1),
(51, '', 'L', -1),
(74, 'Vert', 'Taille 2', 3),
(52, '', 'L', -1),
(52, '', 'M', -1),
(52, '', 'S', -1),
(51, '', 'XXL', -1),
(51, '', 'M', -1),
(51, '', 'S', -1),
(50, '', 'S', -1),
(50, '', 'M', -1),
(50, '', 'L', -1),
(50, '', 'XXL', -1),
(49, '', '', 3),
(48, '', '', 5),
(47, '', 'S', -1),
(47, '', 'M', -1),
(47, '', 'L', -1),
(47, '', 'XL', -1),
(47, '', 'XXL', -1),
(46, '', 'S', -1),
(46, '', 'M', -1),
(46, '', 'L', -1),
(46, '', 'XL', -1),
(46, '', 'XXL', -1),
(45, '', 'S', -1),
(45, '', 'M', -1),
(45, '', 'L', -1),
(44, '', 'S', -1),
(44, '', 'M', -1),
(44, '', 'L', -1),
(44, '', 'XL', -1),
(44, '', 'XXL', -1),
(43, '', 'S', -1),
(43, '', 'M', -1),
(43, '', 'XL', -1),
(43, '', 'XXL', -1),
(42, '', 'S', -1),
(42, '', 'M', -1),
(42, '', 'L', -1),
(42, '', 'XL', -1),
(42, '', 'XXL', -1),
(41, '', 'S', -1),
(41, '', 'L', -1),
(41, '', 'XL', -1),
(41, '', 'XXL', -1),
(37, '', '', -1),
(31, '', '', -1),
(30, '', 'S', -1),
(30, '', 'M', -1),
(30, '', 'L', -1),
(30, '', 'XL', -1),
(30, '', 'XXL', -1),
(57, '', 'XXL', -1),
(57, '', 'XL', -1),
(56, '', 'M', -1),
(56, '', 'S', -1),
(55, '', 'L', -1),
(55, '', 'S', -1),
(74, 'Rouge', 'Taille 1', -1),
(57, '', 'M', -1),
(55, '', 'XL', -1),
(74, 'Rouge', 'Taille 2', -1),
(58, '', 'XXL', -1),
(58, '', 'S', -1),
(58, '', 'XL', -1),
(58, '', 'M', -1),
(58, '', 'L', -1),
(74, 'Rouge', 'Taille 3', -1),
(74, 'Vert', 'Taille 1', 4),
(51, '', 'XL', -1),
(52, '', 'XXL', -1),
(52, '', 'XL', -1),
(54, '', 'XL', -1),
(56, '', 'XXL', -1),
(56, '', 'XL', -1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `name`, `password`, `email`, `tel`) VALUES
(1, 'Armel Rouxel', '$2a$10$d6.SsrBY.d0Sa0WnBI1zPe6EzMM7GgIeJ00WrqHNdV9vgvwA.OSU.', 'arouxel@outlook.fr', '0680067781'),
(2, 'Yoann Dogbe', '$2a$10$Uxk/B.7KI9h41fr3cfpQ0OY5usuUWz3D4VJUHF3Xp4AgsUOUlQsuG', 'yoann.dogbe@gmail.com', '0641979733'),
(14, 'Mardaoui Yaniss', '$2a$10$sYufHI7.dO0UgYEHXLrrieYxCsekZr6BuMu8FBrtoByjEFuVPeBlm', 'yaniss.mardaoui@outlook.fr', '0623700245'),
(19, 'matthias troude', '$2a$10$XdDPU8dfUdgvs7euzt7vxut2YbvUZUllhoBJUVs0Kz4WF2z5nBtim', 'matthias.troude@gmail.com', '0750529169'),
(20, 'DEBLADIS Yvon', '$2a$10$h8quFAHOCK3WMTfFLMIoRe8Z8jX3whomwkxnfvqb15Xw.g6GXQ8z.', 'ydebladis@gmail.com ', '0674667324'),
(21, 'Colombe Heurdier ', '$2a$10$/gCIAoG46d.ujo970NvKxeZx5JDFvSe1kh.DYDjnWOU6OHVqyGncO', 'colombe@heurdier.com', '0782661348'),
(23, 'Kezia Varde', '$2a$10$022NoyUP7Ev2uMIYizueP.NyhZvxh620QFFsP1oinYpGoRHmEoUBe', 'Kezia.v@hotmail.fr ', '0675506253'),
(24, 'Sappey louis', '$2a$10$p2u0Td0EqDEJwXs2nHQ9SuP7BtR7fdhSLAgh9eVrVgrqlhToz2ArG', 'louis.sappey@hotmail.com', '0652172578'),
(25, 'Varlet chloë', '$2a$10$FotOLn6SWDiXv92PviQviO/QX9OWX/1ZdFqCHZfXTdt9M.JhOSj7a', 'Chloevarletjoubert@gmail.com', '0601427740'),
(26, 'Heloise Varde', '$2a$10$Yk9uUkloBxyZbaLcQLAwwe/d1JiySe0or.kxujS39TtsXXycsA9MO', 'helovarde@gmail.com', '0782780795'),
(27, 'Yvon DEBLADIS', '$2a$10$8mDUko0MRWBZ5nBXm8sroORAr3pCPpev/3c3IBAtph8yKEbpTYBfm', 'ydebladis@gmail.com', '0674667324'),
(28, 'Agathe Ban', '$2a$10$02EwqUQpo/7R/xJGKWHfVOaWIT6UXNTPe4FMRZ6DwU1OGYhR0nHMK', 'agatheban@yahoo.com', '0633818170'),
(29, 'Le Goff Yaël', '$2a$10$Wyv/tE5pd44sfZBqq4Bo0.ey35qTYyeTUeksfVmX7Z5l5ilijipY2', 'legoffyael@gmail.com', '0666419830'),
(30, 'Chloé Campfort', '$2a$10$hUQX6nDyURcr8IxNKoMfxOh7JBXXys0ifY7WXSas9k5THIVGEFdrK', 'chloe.campfort@laposte.net', '0643902516'),
(31, 'Perrine Heurdier', '$2a$10$Cjts3Ji5aySGz2A35H5MhOzC2ghHh9NHTqnnif9vivHlhyInpeOG.', 'perrine@heurdier.com', '0782903924'),
(32, 'Laura Dos Santos', '$2a$10$59lNQLPIOCDUtERY50Qh4ue0wWLIqPjSfis.wDUSObEi1Oynw0dvO', 'ds.laura2@gmail.com', '0675084834'),
(33, 'Elyakim Mirande-Ney', '$2a$10$RQGZjxS0KWX/OPwWnqGyeOfTQRO1aOOGr6dxiAqa/4gKjNIMb7H6G', 'kimkim.jules@gmail.com', '0767865264'),
(34, 'Ribeiro manuela', '$2a$10$Xq5O.P/QVUEvEZU/yEAC1.MqYmyi9hJAjSQ/842tJvXJYsuI2je1.', 'ana.joa@hotmail.fr', '0678083566'),
(35, 'Eva Farcot', '$2a$10$cmTTGsDU79oBremdxAssmuKbvjQPVi21Tm7m6Ff3u2b0FG7VPA9QS', 'evalovelavie@gmail.com', '0607746577'),
(36, 'Antoine Alciati', '$2a$10$IxVeBaXnBs/o1jO/7fccB.7hyCwKMaZOG5Zb7iqkWCHfZhfEakcCy', 'eva.farcot@gmail.com', '0607746577'),
(37, 'Nouis Judith', '$2a$10$j/wHixwPgpFp5kHepyFe3uc3gE6VxqKR1gOjLlm4heVaB3SRG3zi2', 'Judith.nouis013@gmail.com', '0678706444'),
(38, 'BUCKET Maureen', '$2a$10$C3C4SIwIiUUcIqY7sGLrKeq/imbfdeaSU.QI44YssX/uMe1J7gNBm', 'maureen.bck@gmail.com', '0770384220'),
(39, 'Ricbourg Johanna', '$2a$10$vyngrqMFMe86GGGck4vbp.HR1dYWYXMZi5FemxwxIpxf7ytWmACna', 'Johanna.ricbourg@orange.fr', '0632830334'),
(40, 'Maria Shenoda', '$2a$10$r/8BvfmO/3H4MjhdGrOToO0KcJ2nGM7vRrtigT2EDaDoIbqU1x8dm', 'mariashenoda@outlook.com', '0766869694'),
(41, 'Samyntha Cornuejols', '$2a$10$1zi.x6a49zXiFtcHcaVQNuTvBfbUGKuxNlLK9bGi38UQP5lZwMy/2', 'samynthou@gmail.com', '0767232853'),
(42, 'Caroline Heurdier', '$2a$10$6Xr2Mwtcbt2rwvW0N8CLtOGmaaKbzpDEzYh2/uBTK0wr0.LRCC.UK', 'caroline@heurdier.com', '0781368946'),
(43, 'Antoine Pimenta', '$2a$10$zXpQPqLtTmhK98SWizGuWepcifXeCRDLv7oxm7AEpqdV2zBGwzOFW', 'ajcp.pro@gmail.com', '0760850249'),
(44, 'Tom MARTIN VOLCOVICI', '$2a$10$8pWLhOimk0Iql3u1ILbY7uBIWHR3PWUYIq4BVxMgnoW8jvSzJ/Zbi', 'toomy2324@gmail.com', '0762883490'),
(45, 'Léa Balmy', '$2a$10$1fl6/wfojJT8l54NwFre4.sL2bowHswSAv6Of2SGykEJ1gwZoY1SK', 'lea.balmy@orange.fr', '0648581730'),
(46, 'Noémie Poujol', '$2a$10$Gfj6c6XEZEBVGgKZnwCRNe26UiP10OArwqfY/W4H/hNevFje/ipJu', 'noemie.poujol@gmail.com', '0695710570'),
(47, 'Vérot ', '$2a$10$jQSdYIsGR91N9pEl4rwkReJO1OuOy90NtZ6GvjcTeURgR7v6PgrvO', 'alice.verot@sfr.fr', '0651986391'),
(48, 'Pauline Tartary', '$2a$10$s1/clE3gDDwrJVcFUtDSSeS7zsjKGJSvI1FkIGslGHOGALY3jLbRW', 'Pauline.tartary@hotmail.fr', '0695270709'),
(49, 'Simon Petit', '$2a$10$tkTGhWr5qmlnqy/b6bgMQ.7kLd5wwB/pYJgIwlHztxARvjOwTD09q', 'simon.petit2019@outlook.com', '0493152812'),
(50, 'Mardochée  Masaki', '$2a$10$pFFTQa4MNY5zsKi1KLzDgeCWWGWqBOejtWtPMpSBDC0KTbHW2MtLm', 'mardochee78@gmail.com ', '0767818790'),
(51, 'Mardochée Masaki Ndongala', '$2a$10$TBI4r9WgkQWmBC.pc0BlgeRmcylrp4cDshsLxncQl/AAp3SBh2pVy', 'mardochee.masaki@gmail.com', '0767818790'),
(52, 'Benoît Beguier', '$2a$10$uwpSU4i3AIySO.6ohVt9zekBwHxT6eMhcm/DzoLcjubOYdwPljPbm', 'benoit.beguier@centrale-marseille.fr', '0787359132'),
(53, 'Vachette Mathilde', '$2a$10$LaviP/z3PlhMFwvUvebnGOTRwBSbphwki8DPqaQvfKMGREDgk7n.O', 'math.vachette@gmail.com', '0666864688'),
(54, 'Eileen CONSTANT', '$2a$10$3aU67q9gEZQKw11eBm6p/u9F92i/Kisl3Ot0hdDY17MEQNfrsDLba', 'eileenconstant74@gmail.com ', '0783069804'),
(55, 'Hillion  joris', '$2a$10$3jrjThuaa6ZZAYpVikCU6uC0yAdkkDLriTKZiwEcXHJ7GkRA.2Nty', 'hillion.joris00@gmail.com', '0674131586'),
(56, 'RIBEIRO Joana', '$2a$10$K7.lUBx2TpuDcvL6RH0Duu13Wwy2lB1K2aFJohdey5SusyL0TKqrC', 'joana.ribeiro2401@gmail.com', '0648903939'),
(57, 'Baptiste Dintilhac', '$2a$10$oCJ4MtpZBDKQJjvuaS4KJePG2FCIQ42YhXognwWefM8p/dqDVEplq', 'baptiste.dintilhac@gmail.com', '0768572968'),
(58, 'Adele', '$2a$10$uX2MRQFzpkBrfv0IFHIMKexSHbmbxTNDjjX/AFegoJE./gH81U7rW', 'adele.r.mouf@gmail.com', '0768529968'),
(59, 'VIGANEGO Clara', '$2a$10$btznDHZIsvZoCJpp8R/PQuI9piyiCleAAIrjzYGZoFrwQFuo43bY2', 'claraviganegotollari@gmail.com', '0619026221'),
(60, 'Zandona Cyrille', '$2a$10$bwfdAaebglbtrPgo3lVjqu0ZWlA3fSc8kI8IKLTUeZWqMTCJDFhzG', 'cyrille.zandona12@gmail.com ', '0783034738'),
(61, 'Charline Gac', '$2a$10$24yxrJG8cSGyV1w36PzQpOWaWCIZkcQjojd40RdbIQ0ulMLP7bCjK', 'charline.gac@gmail.com', '0688436194'),
(62, 'Filip Assimon', '$2a$10$MC10M2wYFd3Ca6FrXsJ0kuaqVBJS/iR8m/I94n600gcag9RM.Y4/u', 'filip.assimon@gmail.com', '0788608048'),
(63, 'Zandona Cyrille', '$2a$10$8R2bjcCRUa2gtyQ0ZPL2xOxlM0t8EpKI0VpSPfo8OZpw5/3JnYIpO', 'cyrille.zandona@gmail.com', '0783034738'),
(64, 'Maïa pernet', '$2a$10$OCCN63y/gyLUIKNhzbF3sOGel/SDOr.EsLbtEtLJDeMKH5s4hKH.q', 'pernetmaia@gmail.com', '0637557805'),
(65, 'Mahé Antoine', '$2a$10$CD7ULbyXNmvrPt3fjO9dTO7g50c2t7JkD.J0Nv3hDrXzZ/i37zCEu', 'antoine.1648@gmail.com', '0646275665'),
(66, 'Pierre Guignot', '$2a$10$SdIqR/4tG9qBlg3u8a4jZu/OtSf5oLbgQtyeMECtSMMAdW6pGQ50y', 'pierre.guignot@paris-valdeseine.archi.fr', '0788103334'),
(67, 'Clotilde Salvador', '$2a$10$B5g3ufS6Zy1vtROlCMkKIu/ZuH1cz794z02m7Qz1pWlOeeQZsT/4y', 'clo.salvador@gmail.com', '0665513336'),
(68, 'Rouxel Maïka', '$2a$10$BKAV5ek3aZEA9vv7jgaRh./WliUSLeQ6HEk3eOSGBy4inO1EPjcCq', 'maika.rouxel@hotmail.fr', '0631570846'),
(69, 'Shenouda Alexandrine', '$2a$10$C/a9wdKHGEBofU20lJqpM.K/LPkj10pnDyCJZzXurzLN8QJgDOaoO', 'alexandrine.shenouda@gmail.com', '0651383026'),
(70, 'Camille EURY', '$2a$10$8BYKe0HO3g00rd.xVFu6yeDzQpYjbqGX6yrhqhCrylVvc4o5hduvi', 'camilleeury17@gmail.com', '0652910693');

-- --------------------------------------------------------

--
-- Structure de la table `user_voucher`
--

DROP TABLE IF EXISTS `user_voucher`;
CREATE TABLE IF NOT EXISTS `user_voucher` (
  `user_id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  PRIMARY KEY (`code`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `user_voucher`
--

INSERT INTO `user_voucher` (`user_id`, `code`) VALUES
(57, 'ENCORETOICHEF'),
(62, 'ENCORETOICHEF'),
(69, 'ENCORETOICHEF'),
(55, 'JORISLOVE');

-- --------------------------------------------------------

--
-- Structure de la table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
CREATE TABLE IF NOT EXISTS `voucher` (
  `code` varchar(20) NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  `nb` int(11) DEFAULT '-1',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `voucher`
--

INSERT INTO `voucher` (`code`, `value`, `nb`) VALUES
('BDE10', 10, 3),
('ENCORETOICHEF', 10, -1),
('kfet10', 10, -1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `accessory`
--
ALTER TABLE `accessory`
  ADD CONSTRAINT `accessory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `clothe`
--
ALTER TABLE `clothe`
  ADD CONSTRAINT `clothe_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `print`
--
ALTER TABLE `print`
  ADD CONSTRAINT `print_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
