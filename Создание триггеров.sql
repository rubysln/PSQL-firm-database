-- Триггер на удаление записи из истории изменения цен
CREATE OR REPLACE FUNCTION prevent_row_deletion() RETURNS trigger AS $$
BEGIN
RAISE EXCEPTION 'Удаление из данной таблицы запрещено';
RETURN NULL;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER no_delete_trigger
BEFORE DELETE ON price_history
FOR EACH ROW
EXECUTE FUNCTION prevent_row_deletion();

-- Функция триггера на создание даты в таблице продаж
CREATE OR REPLACE FUNCTION prevent_row_added() RETURNS trigger AS $$
BEGIN
IF NEW.sale_date < '2006-02-25' THEN
RAISE EXCEPTION 'Неправильная дата: Оффициальная дата регистрации начала закупок в компании: 26.02.2006';
END IF;
RETURN NEW;
END
$$ LANGUAGE plpgsql;

-- Триггер
CREATE OR REPLACE TRIGGER wrong_date_trigger
BEFORE INSERT OR UPDATE ON purchases
FOR EACH ROW
EXECUTE FUNCTION prevent_row_added();

-- Функция триггера на создание даты в истории цен
CREATE OR REPLACE FUNCTION prevent_row_added_ph() RETURNS trigger AS $$
BEGIN 
IF NEW.change_date < '2006-02-01' THEN
RAISE EXCEPTION 'Неправильная дата: Оффициальная дата начала сотрудничества с поставщиками: 01.02.2006';
END IF;
RETURN NEW;
END
$$ LANGUAGE plpgsql;

-- Триггер
CREATE OR REPLACE TRIGGER wrong_date_trigger
BEFORE INSERT OR UPDATE ON price_history
FOR EACH ROW
EXECUTE FUNCTION prevent_row_added_ph();