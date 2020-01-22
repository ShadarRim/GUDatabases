use HW7DB;

SHOW TABLES;

SELECT * FROM catalogs;

SELECT name, 
	(SELECT name FROM catalogs WHERE id = products.catalog_id) as cat_type, 
	description, 
	price 
FROM products;