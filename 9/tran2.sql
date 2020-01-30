USE HW7DB;

SHOW TABLES;

SELECT * FROM products;
SELECT * FROM catalogs;

CREATE VIEW sub AS (
	SELECT products.name as prod_name, catalogs.name as cat_name FROM products 
	JOIN catalogs
	ON products.catalog_id = catalogs.id
);

SELECT * FROM sub;