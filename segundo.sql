SELECT id_sales, client.client_number , product_sold.id_product , product.product_nombre , type_of_document.document_name FROM sales
INNER JOIN product_sold ON sales.id_solds = product_sold.id_solds 
INNER JOIN product ON sales.id_solds = product.id_product
INNER JOIN client ON sales.id_clients = client.id_client
INNER JOIN type_of_document ON sales.id_clients=type_of_document.id_typo_docum
WHERE client.client_number=1058788349  AND type_of_document.document_name="cc";



SELECT product.product_nombre , supplier.supplier_name  FROM product_sold
INNER JOIN product ON product_sold.id_product = product.id_product
INNER JOIN supplier ON product_sold.id_supplier=supplier.id_supplier
WHERE product.product_nombre="Mortadela";

SELECT product.product_nombre , supplier.supplier_name , quantity FROM product_sold
INNER JOIN product ON product_sold.id_product = product.id_product
INNER JOIN supplier ON product_sold.id_supplier=supplier.id_supplier
ORDER BY quantity DESC;
