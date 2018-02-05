-- Adminer 4.5.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `avaliacao1`;
CREATE DATABASE `avaliacao1` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `avaliacao1`;

DROP TABLE IF EXISTS `bairro`;
CREATE TABLE `bairro` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'chave primária',
  `nome` varchar(20) NOT NULL COMMENT 'nome do bairro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `bairro` (`id`, `nome`) VALUES
(1,	'Tijuca'),
(2,	'Barra da Tijuca'),
(3,	'Madureira'),
(4,	'Campo Grande');

DROP TABLE IF EXISTS `filial`;
CREATE TABLE `filial` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `filial` (`id`, `nome`) VALUES
(1,	'Tijuca'),
(2,	'Vargem Grande');

DROP TABLE IF EXISTS `imovel`;
CREATE TABLE `imovel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `codigo` varchar(10) NOT NULL COMMENT 'Código UNICO',
  `tipo_imovel_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Chave estrangeira da tabela `tipo_imovel`',
  `filial_id` int(11) unsigned NOT NULL DEFAULT '1' COMMENT 'Chave estrangeira da tabela `filial`',
  `logradouro_id` int(11) unsigned NOT NULL DEFAULT '1' COMMENT 'Chave estrangeira da tabela de `logradouro`',
  `numero` int(11) DEFAULT NULL COMMENT 'Nº da casa naquele logradouro',
  `tipo_negocio` enum('V','A') NOT NULL DEFAULT 'V' COMMENT 'Venda ou Aluguel',
  `valor_venda` double DEFAULT '0' COMMENT 'Valor de Venda',
  `valor_aluguel` double DEFAULT '0' COMMENT 'Valor de Aluguel',
  `dormitorios` int(11) DEFAULT NULL COMMENT 'Nº de Quartos',
  `area_terreno` double DEFAULT NULL COMMENT 'Área do Terreno',
  `banheiros` int(11) DEFAULT NULL COMMENT 'Nº de Banheiros',
  `vagas_garagem` int(11) DEFAULT NULL COMMENT 'Nº de Vagas de Garagem',
  `titulo_imovel` varchar(255) DEFAULT NULL COMMENT 'Título do imovel. ex: Casa sensacional na Tijuca',
  `descricao` text COMMENT 'Descrição do Imóvel',
  `publicado` enum('S','N') NOT NULL DEFAULT 'S' COMMENT 'Flag de Publicado do site, Sim ou Não (S/N ainda aparece na listagem)',
  `data_expiracao` datetime DEFAULT NULL,
  `ativo` enum('S','N') NOT NULL DEFAULT 'S' COMMENT 'Flag de Ativo (muda para N quando deletado, nao aparece mais na listagem)',
  PRIMARY KEY (`id`),
  KEY `FK_imovel` (`tipo_imovel_id`),
  KEY `FK_imovel_filial` (`filial_id`),
  KEY `FK_imovel_logradouro` (`logradouro_id`),
  CONSTRAINT `FK_imovel` FOREIGN KEY (`tipo_imovel_id`) REFERENCES `tipo_imovel` (`id`),
  CONSTRAINT `FK_imovel_filial` FOREIGN KEY (`filial_id`) REFERENCES `filial` (`id`),
  CONSTRAINT `FK_imovel_logradouro` FOREIGN KEY (`logradouro_id`) REFERENCES `logradouro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `imovel` (`id`, `codigo`, `tipo_imovel_id`, `filial_id`, `logradouro_id`, `numero`, `tipo_negocio`, `valor_venda`, `valor_aluguel`, `dormitorios`, `area_terreno`, `banheiros`, `vagas_garagem`, `titulo_imovel`, `descricao`, `publicado`, `data_expiracao`, `ativo`) VALUES
(1,	'ABC2',	1,	1,	1,	15,	'V',	150000,	0,	1,	67,	1,	0,	'Casa Supreendente na Tijuca',	'Casa sensacional, quartos, banheiros',	'S',	NULL,	'S'),
(2,	'CDE3',	4,	2,	3,	10,	'A',	0,	2500,	3,	150,	3,	0,	'Casa Estilo Retrô',	'Linda residência no estilo retrô, com algumas marcas de tempo.',	'S',	NULL,	'S'),
(3,	'AAAA',	2,	2,	7,	1234,	'V',	123456.78,	0,	123,	123,	123,	123,	'Título da Publicação',	'Descrição da publicação',	'S',	'2018-02-04 00:00:00',	'S'),
(4,	'AAAB',	5,	1,	5,	1245,	'A',	0,	12345.67,	0,	234,	234,	0,	'Incrível Loja na Tijuca',	'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vitae leo ut risus hendrerit vulputate. Proin id nulla elit. Phasellus in rhoncus dolor, quis ultricies libero. Sed dignissim imperdiet nunc ut dictum. Nunc ultricies volutpat risus at elementum. Morbi imperdiet dolor metus, sed dapibus dui pharetra id. Nulla neque lacus, bibendum ac sapien sed, mattis molestie eros. Suspendisse potenti. Suspendisse potenti. In et risus vitae nibh cursus auctor. Maecenas condimentum scelerisque elit eget dignissim. Cras augue est, bibendum condimentum ultrices ut, pulvinar quis risus. Sed at placerat odio, ullamcorper accumsan erat. Pellentesque vel tempus nisl. Aenean cursus in tortor vel sodales.\r\n\r\nNullam ac molestie dui. Integer est odio, faucibus sed dolor quis, lobortis ornare nunc. Quisque nec risus neque. Integer viverra vestibulum massa. In consequat, massa sed auctor commodo, velit magna pharetra lectus, ac tristique risus nunc ac nulla. Etiam et pretium metus, eget porttitor mi. Mauris lobortis, ligula vitae rutrum elementum, sem neque fringilla ex, vitae fringilla orci lectus tempor dolor. Morbi condimentum quam non justo tempus bibendum. Morbi commodo, sapien et rhoncus molestie, nisl sapien vehicula turpis, et molestie velit velit vel nunc. Nulla facilisi. Vestibulum neque justo, dictum sit amet posuere ac, efficitur at lacus. Nam eu metus quis arcu tristique tincidunt nec sed lectus. Quisque nec hendrerit turpis. Nulla gravida tristique mollis.',	'N',	NULL,	'S');

DROP TABLE IF EXISTS `imovel_imagem`;
CREATE TABLE `imovel_imagem` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'chave primaria',
  `imovel_id` int(10) unsigned NOT NULL COMMENT 'chave estrangeira da tabela imovel',
  `caminho` tinytext NOT NULL COMMENT 'caminho físico da foto',
  PRIMARY KEY (`id`),
  KEY `FK_imovel_imagem` (`imovel_id`),
  CONSTRAINT `FK_imovel_imagem` FOREIGN KEY (`imovel_id`) REFERENCES `imovel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `imovel_imagem` (`id`, `imovel_id`, `caminho`) VALUES
(1,	2,	'2af883fc18d440ebd1485e595f74f9b5.jpg'),
(2,	3,	'70de1ece19c667239d91fd2c544bb78e.jpg'),
(3,	4,	'7a9881ad8ce5ad78a89ce2bcb24956f0.jpg');

DROP TABLE IF EXISTS `logradouro`;
CREATE TABLE `logradouro` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `bairro_id` int(10) unsigned NOT NULL COMMENT 'Chave estrangeira da tabela bairro',
  `tipo` varchar(15) NOT NULL COMMENT 'Tipo do logradouro (ex: Rua, Avenida)',
  `nome` varchar(70) NOT NULL COMMENT 'Nome do logradouro (ex: Barão de Mesquita)',
  PRIMARY KEY (`id`),
  KEY `FK_logradouro_bairro` (`bairro_id`),
  CONSTRAINT `FK_logradouro_bairro` FOREIGN KEY (`bairro_id`) REFERENCES `bairro` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `logradouro` (`id`, `bairro_id`, `tipo`, `nome`) VALUES
(1,	1,	'Rua',	'Mariz e Barros'),
(2,	2,	'Alameda',	'Dalton Barreto'),
(3,	3,	'Estrada',	'do Portela'),
(4,	4,	'Avenida',	'Cesário de Melo'),
(5,	1,	'Rua',	'Itaperuna'),
(6,	1,	'Avenida',	'Maracanã'),
(7,	2,	'Rua',	'Hanibal Porto');

DROP TABLE IF EXISTS `tipo_imovel`;
CREATE TABLE `tipo_imovel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'chave primária',
  `nome` varchar(50) NOT NULL COMMENT 'Nome do tipo do imóvel',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tipo_imovel` (`id`, `nome`) VALUES
(1,	'Casa'),
(2,	'Apartamento'),
(3,	'Cobertura'),
(4,	'Kitnet'),
(5,	'Loja');

-- 2018-02-05 01:17:47
