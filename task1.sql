-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- catalogs и products в таблицу logs помещается время и дата создания записи, название 
USE shop;

drop table logs;
CREATE TABLE IF NOT EXISTS logs (
  id BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  data_created DATETIME COMMENT 'Название таблицы',
  table_name VARCHAR(255) COMMENT 'Название таблицы',
  id_primary BIGINT(20) COMMENT 'id первичного ключа',
  name VARCHAR(255) COMMENT 'поле name'
) COMMENT = 'logs таблиц catalogs, products ' ENGINE=Archive;

insert INTO catalogs (name) values ('блоки питания');


-- тригер таблицы catalogs
CREATE DEFINER=`root`@`localhost` TRIGGER `catalogs_AFTER_INSERT` AFTER INSERT ON `catalogs` FOR EACH ROW BEGIN
INSERT INTO logs (data_created,table_name,id_primary,name) VALUES(now(),'catalog', NEW.id,NEW.name);
END
-- тригер таблицы products
CREATE DEFINER=`root`@`localhost` TRIGGER `products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW BEGIN
INSERT INTO logs (data_created,table_name,id_primary,name) VALUES(now(),'products', NEW.id,NEW.name);
END
-- тригер таблицы users
CREATE DEFINER=`root`@`localhost` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
INSERT INTO logs (data_created,table_name,id_primary,name) VALUES(now(),'users', NEW.id,NEW.name);
END
