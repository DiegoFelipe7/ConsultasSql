CREATE DATABASE IF NOT EXISTS `store` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `store`;

CREATE TABLE IF NOT EXISTS `client` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT,
  `id_typo_docum` int(11) NOT NULL,
  `client_number` int(11) NOT NULL,
  PRIMARY KEY (`id_client`),
  KEY `FK_client_type_of_document` (`id_typo_docum`),
  CONSTRAINT `FK_client_type_of_document` FOREIGN KEY (`id_typo_docum`) REFERENCES `type_of_document` (`id_typo_docum`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO `client` (`id_client`, `id_typo_docum`, `client_number`) VALUES
	(1, 1, 1058788349),
	(3, 1, 25283449),
	(4, 2, 48655203);

CREATE TABLE IF NOT EXISTS `product` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `product_nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `product_type` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date NOT NULL,
  `delete_at` date NOT NULL,
  PRIMARY KEY (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


INSERT INTO `product` (`id_product`, `product_nombre`, `product_type`, `create_at`, `update_at`, `delete_at`) VALUES
	(1, 'Mazamorra', 'Limpieza', '2022-03-11', '2022-03-11', '2022-03-11'),
	(2, 'Mortadelas', 'Comida', '2022-03-11', '2022-03-11', '2022-03-11'),
	(3, 'Carne', 'Comida', '2022-03-11', '2022-03-11', '2022-03-11'),
	(4, 'Telefono', 'Tecnologia', '2022-03-12', '2022-03-12', '2022-03-12'),
	(5, 'Pasta', 'Comida', '2022-03-12', '2022-03-12', '2022-03-12');


CREATE TABLE IF NOT EXISTS `product_sold` (
  `id_solds` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) NOT NULL,
  `id_supplier` int(11) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id_solds`) USING BTREE,
  KEY `FK_product_sold_product` (`id_product`),
  KEY `FK_product_sold_supplier` (`id_supplier`),
  CONSTRAINT `FK_product_sold_product` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON UPDATE CASCADE,
  CONSTRAINT `FK_product_sold_supplier` FOREIGN KEY (`id_supplier`) REFERENCES `supplier` (`id_supplier`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


INSERT INTO `product_sold` (`id_solds`, `id_product`, `id_supplier`, `price`, `quantity`) VALUES
	(1, 1, 1, 4000, 4),
	(2, 2, 2, 24012, 5),
	(3, 3, 1, 2123, 4),
	(4, 3, 1, 2131, 8);


CREATE TABLE IF NOT EXISTS `sales` (
  `id_sales` int(11) NOT NULL AUTO_INCREMENT,
  `id_solds` int(11) NOT NULL,
  `id_clients` int(11) NOT NULL,
  `id_sellers` int(11) NOT NULL,
  `status_sales` int(11) NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date NOT NULL,
  `delete_at` date NOT NULL,
  PRIMARY KEY (`id_sales`) USING BTREE,
  KEY `FK_invoice_product_sold` (`id_solds`) USING BTREE,
  KEY `FK_invoice_client` (`id_clients`) USING BTREE,
  KEY `FK_invoice_seller` (`id_sellers`) USING BTREE,
  CONSTRAINT `FK_invoice_client` FOREIGN KEY (`id_clients`) REFERENCES `client` (`id_client`) ON DELETE CASCADE,
  CONSTRAINT `FK_invoice_seller` FOREIGN KEY (`id_sellers`) REFERENCES `seller` (`id_seller`) ON DELETE CASCADE,
  CONSTRAINT `FK_sales_product_sold` FOREIGN KEY (`id_solds`) REFERENCES `product_sold` (`id_solds`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO `sales` (`id_sales`, `id_solds`, `id_clients`, `id_sellers`, `status_sales`, `create_at`, `update_at`, `delete_at`) VALUES
	(1, 1, 1, 1, 1, '2022-03-10', '2022-03-11', '2022-03-11'),
	(2, 2, 1, 1, 0, '2022-03-10', '2022-03-12', '2022-03-12'),
	(3, 3, 3, 1, 1, '0000-00-00', '0000-00-00', '0000-00-00');

CREATE TABLE IF NOT EXISTS `seller` (
  `id_seller` int(11) NOT NULL AUTO_INCREMENT,
  `seller_nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_seller`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


INSERT INTO `seller` (`id_seller`, `seller_nombre`) VALUES
	(1, 'Diego');

CREATE TABLE IF NOT EXISTS `supplier` (
  `id_supplier` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `supplier_nit` int(11) NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


INSERT INTO `supplier` (`id_supplier`, `supplier_name`, `supplier_nit`) VALUES
	(1, 'Terraplaza', 1031231),
	(2, 'Campanario', 1231212);

CREATE TABLE IF NOT EXISTS `type_of_document` (
  `id_typo_docum` int(11) NOT NULL AUTO_INCREMENT,
  `document_name` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_typo_docum`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;


INSERT INTO `type_of_document` (`id_typo_docum`, `document_name`) VALUES
	(1, 'cc'),
	(2, 'ti');

-- consultas sql
UPDATE sales SET sales.status_sales =0 WHERE id_sales=1;
UPDATE sales SET sales.status_sales =0 WHERE id_sales=2;
SELECT * FROM sales;

DELETE  FROM  sales WHERE id_sales=1;
DELETE  FROM  sales WHERE id_sales=2;
SELECT * FROM sales;


UPDATE product_sold 
JOIN product ON product_sold.id_solds  = product.id_product 
JOIN supplier ON product_sold.id_supplier=supplier.id_supplier
SET product.product_nombre='Mortadelas' , supplier.supplier_name='Terraplaza'
WHERE product.id_product=1 AND supplier.id_supplier=1 AND product_sold.id_solds=1;

UPDATE product_sold 
JOIN product ON product_sold.id_solds  = product.id_product 
JOIN supplier ON product_sold.id_supplier=supplier.id_supplier
SET product.product_nombre='Mortadelas' , supplier.supplier_name='Terraplaza'
WHERE product.id_product=2 AND supplier.id_supplier=2 AND product_sold.id_solds=2;

UPDATE product_sold 
JOIN product ON product_sold.id_solds  = product.id_product 
JOIN supplier ON product_sold.id_supplier=supplier.id_supplier
SET product.product_nombre='Mortadelas' , supplier.supplier_name='Terraplaza'
WHERE product.id_product=3 AND supplier.id_supplier=1 AND product_sold.id_solds=3;





