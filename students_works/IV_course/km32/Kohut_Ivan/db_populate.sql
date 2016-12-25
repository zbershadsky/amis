-----------------------------
-- Populate Cusomer table
-----------------------------
INSERT INTO Customer (cust_name, cust_pass, cust_email, cust_phone) VALUES ('kpis', '$2a$11$87RaxDbpV8EDMAX87gBnZOtDWfDspoWS8OLxEjvIQYWlDhWl63dVC', 'kogut.iwan@gmail.com', '+380979835405');
INSERT INTO Customer (cust_name, cust_pass, cust_email, cust_phone) VALUES ('user', '$2a$11$SrHcUcBmp.0PnR820gXb6OXV8iIcxq476hkML1CGlWk7a2ow0kwca', 'olka@gmail.com', '+380979835405'); 

-----------------------------
-- Populate Supermarket table
-----------------------------
INSERT INTO Supermarket (supermarket_name, supermarket_image) VALUES ('Мегамаркет', loadBlobFromFile ('supermarket_mega.jpg'));
INSERT INTO Supermarket (supermarket_name, supermarket_image) VALUES ('Сільпо', loadBlobFromFile ('supermarket_silpo.jpg'));
INSERT INTO Supermarket (supermarket_name, supermarket_image) VALUES ('Велика кишеня', loadBlobFromFile ('supermarket_big_pocket.jpg'));
INSERT INTO Supermarket (supermarket_name, supermarket_image) VALUES ('АТБ', loadBlobFromFile ('supermarket_atb.jpg'));

---------------------------------
-- Populate SectionProducts table
---------------------------------
INSERT INTO SectionProducts (section_name, section_image) VALUES ('Молочні продукти', loadBlobFromFile ('section_milk.jpg'));
INSERT INTO SectionProducts (section_name, section_image) VALUES ('Крупи', loadBlobFromFile ('section_buckwheat.jpg'));
INSERT INTO SectionProducts (section_name, section_image) VALUES ('Гарячі напої', loadBlobFromFile ('section_hotdrinks.jpg'));
INSERT INTO SectionProducts (section_name, section_image) VALUES ('Фрукти', loadBlobFromFile ('section_fruits.jpg'));
INSERT INTO SectionProducts (section_name, section_image) VALUES ('Овочі', loadBlobFromFile ('section_vegetables.jpg'));

-------------------------
-- Populate Product table
-------------------------
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Гречка', 'Сільпо', 'Крупи', '40', 'Гречана крупа за 1 кг.', loadBlobFromFile ('product_buckwheat.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Рис', 'Сільпо', 'Крупи', '47,64', 'Рис Жменька за 1 кг.', loadBlobFromFile ('product_rice.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Чай ліптон', 'Сільпо', 'Гарячі напої', '17,45', 'Коробка чаю ліптон.', loadBlobFromFile ('product_tea.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Чай батік', 'Сільпо', 'Гарячі напої', '22,49', 'Коробка чаю Батік', loadBlobFromFile ('product_tea_batik.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Йогурт', 'Мегамаркет', 'Молочні продукти', '11,35', 'Йогурт Живинка', loadBlobFromFile ('product_yogurt.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Банан', 'Мегамаркет', 'Фрукти', '29,75', 'Банани за 1 кг.', loadBlobFromFile ('product_banana.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сир', 'Мегамаркет', 'Молочні продукти', '19,99', 'Сир Галичина', loadBlobFromFile ('product_milk_cheese.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Груша', 'Мегамаркет', 'Фрукти', '8,45', 'Груши за 1 кг.', loadBlobFromFile ('product_grusha.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Яблуко', 'Мегамаркет', 'Фрукти', '5,50', 'Яблука за 1 кг.', loadBlobFromFile ('product_apple.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Кефір', 'Сільпо', 'Молочні продукти', '9,65', 'Кефір Волошкове', loadBlobFromFile ('product_kefir.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сирок', 'Сільпо', 'Молочні продукти', '10,91', 'Сирок Картошка', loadBlobFromFile ('product_syrok.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сметана', 'Сільпо', 'Молочні продукти', '16,99', 'Сметана 18 % жирності', loadBlobFromFile ('product_smetana.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Цибуля', 'Мегамаркет', 'Овочі', '2,00', 'Цибуля за 1 кг.', loadBlobFromFile ('product_onion.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Картопля', 'Мегамаркет', 'Овочі', '7,49', 'Картопля за 1 кг.', loadBlobFromFile ('product_potato.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сир', 'Велика кишеня', 'Молочні продукти', '18,96', 'Сир Галичина', loadBlobFromFile ('product_milk_cheese.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сметана', 'Велика кишеня', 'Молочні продукти', '15,99', 'Сметана 18 % жирності', loadBlobFromFile ('product_smetana.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Кефір', 'Велика кишеня', 'Молочні продукти', '9,65', 'Кефір Волошкове', loadBlobFromFile ('product_kefir.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Рис', 'Велика кишеня', 'Крупи', '47,84', 'Рис Жменька за 1 кг.', loadBlobFromFile ('product_rice.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Гречка', 'Велика кишеня', 'Крупи', '35,65', 'Гречана крупа за 1 кг.', loadBlobFromFile ('product_buckwheat.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Пшоно', 'Велика кишеня', 'Крупи', '22,58', 'Пшонова крупа за 1 кг.', loadBlobFromFile ('product_pshono.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Кава галка', 'Велика кишеня', 'Гарячі напої', '34,45', 'Пакет кави Галки', loadBlobFromFile ('product_coffee.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Зелений чай бесіда', 'Велика кишеня', 'Гарячі напої', '18,40', 'Коробка зеленого чаю Бесіда', loadBlobFromFile ('product_tea_besida.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Чорний чай високогірний', 'Велика кишеня', 'Гарячі напої', '18,84', 'Коробка чорного чаю Високогірний', loadBlobFromFile ('product_tea_vysokogyr.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Апельсин', 'Велика кишеня', 'Фрукти', '30,00', 'Апельсини за 1 кг.', loadBlobFromFile ('product_orange.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Ананас', 'Велика кишеня', 'Фрукти', '68,15', 'Ананаси за 1 кг.', loadBlobFromFile ('product_ananas.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Яблуко', 'Велика кишеня', 'Фрукти', '6', 'Яблука за 1 кг.', loadBlobFromFile ('product_apple.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Йогурт Активіа', 'АТБ', 'Молочні продукти', '14,30', 'Йогурт Активіа', loadBlobFromFile ('product_aktyvia.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Сирок', 'АТБ', 'Молочні продукти', '9,92', 'Сирок Картошка', loadBlobFromFile ('product_syrok.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Ряжанка від Простоквашино', 'АТБ', 'Молочні продукти', '22,37', 'Ряжанка Простоквашино 4 % жирності', loadBlobFromFile ('product_ryachenka.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Чай батік', 'АТБ', 'Гарячі напої', '24,50', 'Коробка чаю Батік', loadBlobFromFile ('product_tea_batik.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Чай Майский', 'АТБ', 'Гарячі напої', '19,82', 'Коробка чаю Майский', loadBlobFromFile ('product_tea_mayskyy.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Зелений чай бесіда', 'АТБ', 'Гарячі напої', '18,40', 'Коробка зеленого чаю Бесіда', loadBlobFromFile ('product_tea_besida.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Мандарин', 'АТБ', 'Фрукти', '12', 'Мандарини за 1 кг.', loadBlobFromFile ('product_mandarin.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Груша', 'АТБ', 'Фрукти', '8', 'Груши за 1 кг.', loadBlobFromFile ('product_grusha.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Полуниця', 'АТБ', 'Фрукти', '2,2', 'Полуниця за 1 кг.', loadBlobFromFile ('product_strawberry.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Морква', 'АТБ', 'Овочі', '2,30', 'Морква за 1 кг.', loadBlobFromFile ('product_morkva.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Цибуля', 'АТБ', 'Овочі', '2,50', 'Цибуля за 1 кг.', loadBlobFromFile ('product_onion.jpg'));
INSERT INTO Product (prod_name, supermarket_name, section_name, prod_price, prod_desc, prod_image) VALUES ('Буряк', 'АТБ', 'Овочі', '2,90', 'Буряк за 1 кг.', loadBlobFromFile ('product_beet.jpg'));

---------------------------
-- Populate OrderItem table
---------------------------
INSERT INTO OrderItem (cust_name, order_date, order_item, supermarket_name, prod_name, quantity) VALUES ('kpis', to_date('Нд. 18.12.2016 16:31:38','Dy dd.mm.yyyy hh24:mi:ss'), '1', 'Мегамаркет', 'Йогурт', '1');
INSERT INTO OrderItem (cust_name, order_date, order_item, supermarket_name, prod_name, quantity) VALUES ('kpis', to_date('Нд. 18.12.2016 16:33:43','Dy dd.mm.yyyy hh24:mi:ss'), '1', 'Мегамаркет', 'Банан', '2');
INSERT INTO OrderItem (cust_name, order_date, order_item, supermarket_name, prod_name, quantity) VALUES ('kpis', to_date('Нд. 18.12.2016 16:33:43','Dy dd.mm.yyyy hh24:mi:ss'), '2', 'Мегамаркет', 'Картопля', '1');
INSERT INTO OrderItem (cust_name, order_date, order_item, supermarket_name, prod_name, quantity) VALUES ('kpis', to_date('Нд. 18.12.2016 16:33:43','Dy dd.mm.yyyy hh24:mi:ss'), '3', 'Сільпо', 'Чай ліптон', '3');
INSERT INTO OrderItem (cust_name, order_date, order_item, supermarket_name, prod_name, quantity) VALUES ('user', to_date('Пн. 19.12.2016 13:24:40','Dy dd.mm.yyyy hh24:mi:ss'), '1', 'Сільпо', 'Чай ліптон', '2');