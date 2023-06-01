CREATE TABLE provider -- Поставщики
(
	supplier_id int PRIMARY KEY, -- Идентификатор поставщика
	provied_name varchar(128) NOT NULL, -- Название поставщика
	adress text NOT NULL, -- Адрес поставщика
	phone varchar(20) -- Номер телефона поставщика
);

CREATE TABLE details -- Детали
(
	part_id int PRIMARY KEY, -- Идентификатор детали
	name_detail varchar(64) NOT NULL, -- Название детали
	article varchar(12) NOT NULL -- Артикул детали
);

CREATE TABLE purchases -- Покупки
(
	purchases_id int PRIMARY KEY, -- Идентификатор покупки
	purchase_date date NOT NULL, -- Дата покупки
	quantity int NOT NULL, -- Количество приобретенных товаров
	fk_purchases_supplier int REFERENCES provider(supplier_ID), -- Идентификатор поставщика, внешний ключ
	fk_purchases_details int REFERENCES details(part_id) -- Идентификатор детали, внешний ключ
);

CREATE TABLE price_history -- История цен
(
	price_id int PRIMARY KEY, -- Идентификатор записи цены, первичный ключ
	price decimal(10, 2) NOT NULL, -- Цена детали
	change_date date NOT NULL, -- Дата изменения цены
	fk_price_history_details int REFERENCES details(part_id) NOT NULL -- Идентификатор детали, внешний ключ
)