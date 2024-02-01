-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

SELECT customers.company_name as customer, CONCAT(first_name, ' ', last_name) as employee
FROM (customers INNER JOIN (orders INNER JOIN employees ON orders.employee_id = employees.employee_id) ON customers.customer_id = orders.customer_id) 
	  INNER JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE (((employees.city) in ('London')) AND ((customers.city) in ('London')) AND ((shippers.company_name) in ('United Package')));


-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT product_name, units_in_stock, suppliers.contact_name, suppliers.phone
FROM products
INNER JOIN suppliers USING(supplier_id)
INNER JOIN categories USING(category_id)
WHERE discontinued = 0 and units_in_stock < 25 and category_name in ('Dairy Products', 'Condiments')
ORDER BY units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT customers.company_name
FROM customers 
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE (((orders.customer_id) Is Null));

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT(product_name) FROM products
WHERE EXISTS (SELECT * FROM order_details WHERE products.product_id=order_details.product_id and order_details.quantity=10);
