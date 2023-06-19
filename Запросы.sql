-- Вывод таблицы с наименованием поставщиков которые чаще всего меняли цены на свои детали

SELECT provied_name AS "Поставщики"
FROM provider
JOIN details ON details.fk_details_provider = provider.provider_id
JOIN price_history ON price_history.fk_price_history_details = details.article
GROUP BY provied_name
HAVING COUNT(price_id) = 
	(
		SELECT COUNT(price_id)
		FROM price_history
		JOIN details ON price_history.fk_price_history_details = details.article
		JOIN provider ON details.fk_details_provider = provider.provider_id
		GROUP BY provider_id
		ORDER BY COUNT(price_id) DESC
		LIMIT 1
	);
	
-- Какие датали были закуплены в 2014 году и сколько было потрачено денег 
SELECT DISTINCT name_detail AS "Название детали", SUM(details_purchases.quantity * price_history.price) AS "Общая сумма потраченных денег"
FROM details
JOIN details_purchases ON details_purchases.fk_details_purchases_details = details.article
JOIN price_history ON price_history.fk_price_history_details = details.article
JOIN purchases ON details_purchases.fk_details_purchases_purchases = purchases.sale_id
WHERE DATE_PART('year', purchases.sale_date) >= 2014 AND DATE_PART('year', purchases.sale_date) < 2015
GROUP BY name_detail

-- Какие поставщики владеют товаром "Бензонасос" и "Инжектор", вывести артикул и название поставщика
SELECT details.article, provider.provied_name
FROM details, provider
WHERE details.fk_details_provider = provider.provider_id AND details.name_detail IN ('Бензонасос', 'Инжектор')

-- Вывести артикулы и названия деталей которые как-то связаны с тормозной системой
SELECT article, name_detail
FROM details
WHERE name_detail LIKE 'Тормоз%'
