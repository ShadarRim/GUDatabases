use HW7DB;

SHOW TABLES;

SELECT * FROM catalogs;

SELECT name, 
	(SELECT name FROM catalogs WHERE id = products.catalog_id) as cat_type, 
	description, 
	price 
FROM products;

-- запрос через join

SELECT products.name, catalogs.name, price, description FROM products 
JOIN catalogs
ON catalogs.id = products.catalog_id;

