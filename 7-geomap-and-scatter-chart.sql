-- Задание № 1

--  Авиаперевозчикам интересно узнать распределение проданных билетов по классам обслуживания. Представьте полученные данные в виде круговой диаграммы.   


-- Загадочно: почему то много дублирующиxся записей:
SELECT
  (SELECT COUNT(*) FROM ticket_flights) AS ticket_flights_count,
  (SELECT COUNT(DISTINCT ticket_no) FROM ticket_flights) AS ticket_flights_ticket_no_count,
  (SELECT COUNT(*) FROM tickets) AS tickets_count,
  (SELECT COUNT(DISTINCT ticket_no) FROM tickets) AS tickets_ticket_no_count;
-- ticket_flights_count	ticket_flights_ticket_no_count	tickets_count	tickets_ticket_no_count
-- 1045726	341096	366733	267061


SELECT ticket_no, COUNT(*) AS tickets_count
FROM ticket_flights
GROUP BY ticket_no
HAVING COUNT(*) > 1
ORDER BY tickets_count DESC;
-- ticket_no	tickets_count
-- 0005432693006	18
-- 0005432693008	18
-- 0005432693002	18
-- 0005432693005	18
-- 0005432667449	18
-- 0005432693007	18
-- 0005432667448	18
-- 0005432693001	18
-- 0005432693003	18
-- 0005432693004	18


SELECT ticket_no, COUNT(*) AS tickets_count
FROM tickets
GROUP BY ticket_no
HAVING COUNT(*) > 1
ORDER BY tickets_count DESC;
-- ticket_no	tickets_count
-- 0005434214033	3
-- 0005434214036	3
-- 0005434214029	3
-- 0005434214032	3
-- 0005434214034	3
-- 0005434214035	3
-- 0005434214027	3
-- 0005434214028	3
-- 0005434214030	3
-- 0005434214031	3


-- по-видимому, проданные бтлеты, по которым еще не было полетов
SELECT *
FROM ticket_flights tf
LEFT JOIN tickets t
ON tf.ticket_no = t.ticket_no
WHERE t.ticket_no IS NULL;
-- ticket_no	flight_id	fare_conditions	amount	ticket_no__1	book_ref	passenger_id	passenger_name	contact_data
-- 0005433367227	24836	Economy	3300					
-- 0005435853580	22080	Economy	19300					
-- 0005435310848	20272	Business	12000					
-- 0005435310854	20272	Economy	4400					
-- 0005435310847	20272	Economy	4000					
-- 0005433434203	26185	Economy	61500					
-- 0005433434180	26185	Economy	61500					
-- 0005433233096	9829	Business	83700					
-- 0005433233112	9829	Comfort	47400					
-- 0005433180670	9829	Economy	27900					


-- А бывает и такое:
SELECT ticket_no, COUNT(DISTINCT fare_conditions) AS count
FROM ticket_flights
HAVING COUNT(DISTINCT fare_conditions) > 1
ORDER BY count DESC;
-- ticket_no	count
-- 0005432428888	3
-- 0005432533264	3
-- 0005432363430	3
-- 0005432428878	3
-- 0005432428948	3
-- 0005432428952	3
-- 0005432363383	3
-- 0005432363404	3
-- 0005432363439	3
-- 0005432400067	3

-- Или вот
SELECT *
FROM ticket_flights
NATURAL JOIN tickets
NATURAL JOIN flights
WHERE ticket_no = '0005432428888'
ORDER BY flight_id;
-- flight_id	ticket_no	fare_conditions	amount	book_ref	passenger_id	passenger_name	contact_data	flight_no	scheduled_departure	scheduled_arrival	departure_airport	arrival_airport	status	aircraft_code	actual_departure	actual_arrival
-- 7449	0005432428888	Business	32000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0505	2017-08-01T08:40:00+00:00	2017-08-01T10:10:00+00:00	SVO	KGD	Arrived	733	2017-08-01T12:20:00+00:00	2017-08-01T13:51:00+00:00
-- 7449	0005432428888	Business	32000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0505	2017-08-01T08:40:00+00:00	2017-08-01T10:10:00+00:00	SVO	KGD	Arrived	733	2017-08-01T12:20:00+00:00	2017-08-01T13:51:00+00:00
-- 7726	0005432428888	Economy	14000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0224	2017-07-22T14:05:00+00:00	2017-07-22T15:50:00+00:00	SVO	AER	Arrived	773	2017-07-22T14:06:00+00:00	2017-07-22T15:51:00+00:00
-- 29246	0005432428888	Economy	10700	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0506	2017-07-22T09:00:00+00:00	2017-07-22T10:30:00+00:00	KGD	SVO	Arrived	733	2017-07-22T09:03:00+00:00	2017-07-22T10:33:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- т.е. номера билетов - неуникальны, и на одном номере могут висеть несколько разных, а могут и несколько одинаковых полетов


SELECT *
FROM ticket_flights
NATURAL JOIN tickets
NATURAL JOIN flights
WHERE ticket_no = '0005432428888'
ORDER BY actual_arrival;
-- flight_id	ticket_no	fare_conditions	amount	book_ref	passenger_id	passenger_name	contact_data	flight_no	scheduled_departure	scheduled_arrival	departure_airport	arrival_airport	status	aircraft_code	actual_departure	actual_arrival
-- 29246	0005432428888	Economy	10700	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0506	2017-07-22T09:00:00+00:00	2017-07-22T10:30:00+00:00	KGD	SVO	Arrived	733	2017-07-22T09:03:00+00:00	2017-07-22T10:33:00+00:00
-- 7726	0005432428888	Economy	14000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0224	2017-07-22T14:05:00+00:00	2017-07-22T15:50:00+00:00	SVO	AER	Arrived	773	2017-07-22T14:06:00+00:00	2017-07-22T15:51:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 30628	0005432428888	Comfort	23900	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0013	2017-07-31T15:15:00+00:00	2017-07-31T17:00:00+00:00	AER	SVO	Arrived	773	2017-07-31T15:18:00+00:00	2017-07-31T17:03:00+00:00
-- 7449	0005432428888	Business	32000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0505	2017-08-01T08:40:00+00:00	2017-08-01T10:10:00+00:00	SVO	KGD	Arrived	733	2017-08-01T12:20:00+00:00	2017-08-01T13:51:00+00:00
-- 7449	0005432428888	Business	32000	F75202	4973 058018	TATYANA SOROKINA	{'email': 'sorokina_tatyana.1965@postgrespro.ru', 'phone': '+70171550018'}	PG0505	2017-08-01T08:40:00+00:00	2017-08-01T10:10:00+00:00	SVO	KGD	Arrived	733	2017-08-01T12:20:00+00:00	2017-08-01T13:51:00+00:00

-- Можно наблюдать несколько повторяющихся записей для одного и того же номера билета (ticket_no). Такая ситуация может возникнуть по нескольким причинам:

--     Дубликаты данных: В вашей базе данных могут быть дубликаты записей. Это часто происходит, если данные вводятся вручную или если процесс загрузки данных допускает дублирование.

--     Множественные перелеты: Один и тот же билет может быть использован для нескольких перелетов. Например, пассажир может использовать один билет для пересадки на другой рейс. Однако в вашей ситуации данные не соответствуют этому сценарию, так как записи полностью дублируются.

--     Ошибки при загрузке данных: Во время импорта данных могли произойти ошибки, которые привели к дублированию записей.



-- т.е. чтобы максимально устрнить дублирование должно быть что-то вроде
WITH
grouped_by_fare_conditions_ticket_flights AS (
    SELECT fare_conditions, COUNT(DISTINCT ticket_no) AS tickets_count
    FROM ticket_flights
    GROUP BY fare_conditions
),
tickets_total_amount AS (
    SELECT SUM(tickets_count) AS total_amount
    FROM grouped_by_fare_conditions_ticket_flights
)
SELECT
    fare_conditions,
    tickets_count,
    ROUND(1.0 * tickets_count / (SELECT total_amount FROM tickets_total_amount) * 100, 1) AS tickets_percentage
FROM
    grouped_by_fare_conditions_ticket_flights
ORDER BY
    fare_conditions;
-- fare_conditions	tickets_count	tickets_percentage
-- Business	65450	16.3
-- Comfort	11249	2.8
-- Economy	323771	80.8


-- Задание № 2

-- На этот раз анонимная авиакомпания решила арендовать новые самолеты. Для этого она хочет изучить самые популярные модели.
-- Сформируйте данные о моделях самолетов и количестве проданных билетов на рейсы этих моделей. Представьте полученную информацию на круговой диаграмме.

SELECT 
ad.model, COUNT(DISTINCT tf.ticket_no)
FROM ticket_flights tf
NATURAL JOIN flights f
NATURAL JOIN aircrafts_data ad
GROUP BY ad.model 
ORDER BY ad.model;
model	count
{'en': 'Airbus A319-100', 'ru': 'Аэробус A319-100'}	24794
{'en': 'Airbus A321-200', 'ru': 'Аэробус A321-200'}	48473
{'en': 'Boeing 737-300', 'ru': 'Боинг 737-300'}	41064
{'en': 'Boeing 767-300', 'ru': 'Боинг 767-300'}	59257
{'en': 'Boeing 777-300', 'ru': 'Боинг 777-300'}	69210
{'en': 'Bombardier CRJ-200', 'ru': 'Бомбардье CRJ-200'}	59859
{'en': 'Cessna 208 Caravan', 'ru': 'Сессна 208 Караван'}	7077
{'en': 'Sukhoi Superjet-100', 'ru': 'Сухой Суперджет-100'}	128643

