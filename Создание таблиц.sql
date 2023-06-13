CREATE TABLE provider -- Поставщики
(
	provider_id int PRIMARY KEY,
	provied_name varchar(128) NOT NULL, -- Название поставщика
	adress text NOT NULL, -- Адрес поставщика
	phone varchar(20) -- Номер телефона поставщика
);

CREATE TABLE details -- Детали
(
	article varchar(12) PRIMARY KEY,
	name_detail varchar(64) NOT NULL, -- Название детали
	fk_details_provider int REFERENCES provider(provider_id)
);

CREATE TABLE purchases -- Покупки
(
	sale_ID int PRIMARY KEY, -- ID продажи
	sale_date date NOT NULL -- Дата продажи
);

CREATE TABLE price_history -- История цен
(
	price_id int PRIMARY KEY, -- Идентификатор записи цены, первичный ключ
	price decimal(10, 2) NOT NULL, -- Цена детали
	change_date date NOT NULL, -- Дата изменения цены
	fk_price_history_details varchar(12) REFERENCES details(article) NOT NULL -- Идентификатор детали, внешний ключ
);

CREATE TABLE details_purchases -- Многие ко многим - детали <-> покупки
(
	fk_details_purchases_details varchar(12) REFERENCES details(article), -- Внешний ключ к деталям
	fk_details_purchases_purchases int REFERENCES purchases(sale_ID), -- Внешний ключ к покупкам
	quantity int NOT NULL -- Количество приобретенных товаров
)