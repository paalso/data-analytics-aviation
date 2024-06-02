-- Задание № 1

-- Представьте, что руководство аэропорта Домодедово просит вас проанализировать ежедневную загрузку аэропорта за два месяца.

-- Составьте запрос к базе данных, с помощью которого можно получить количество прибывших пассажиров за два месяца с группировкой по дням. Провизуализируйте полученные данные с помощью линейного графика.

-- В задании вам потребуется код аэропорта Домодедово — DME.


WITH tab AS (
    SELECT
    DATE(actual_arrival) AS arrival_date,
    flight_id,
    departure_airport,
    arrival_airport,
    status,
    bp.ticket_no
    FROM flights f
    NATURAL JOIN boarding_passes bp
    WHERE arrival_airport = 'DME' AND status= 'Arrived'
    ORDER BY DATE(actual_arrival)
)
SELECT arrival_date, COUNT(ticket_no)
FROM tab
GROUP BY arrival_date
ORDER BY arrival_date;

-- arrival_date	count
-- 2017-07-16	1890
-- 2017-07-17	2253
-- 2017-07-18	1342
-- 2017-07-19	1309
-- 2017-07-20	1352
-- 2017-07-21	1388
-- 2017-07-22	1578
-- 2017-07-23	1649
-- 2017-07-24	1199
-- 2017-07-29	884
-- .....



-- Задание № 2

-- Восхитившись вашими результатами, вас попросили получить аналогичные данные для Шереметьево и Внуково. Представьте полученную информацию на одном линейном графике.

-- В задании вам понадобятся коды аэропортов:
--     Шереметьево — SVO
--     Внуково — VKO

WITH tab AS (
    SELECT
    DATE(actual_arrival) AS arrival_date,
    flight_id,
    departure_airport,
    arrival_airport,
    status,
    bp.ticket_no
    FROM flights f
    NATURAL JOIN boarding_passes bp
    WHERE arrival_airport IN ('VKO', 'SVO') AND status= 'Arrived'
    ORDER BY DATE(actual_arrival)
)
SELECT arrival_date, arrival_airport, COUNT(ticket_no)
FROM tab
GROUP BY arrival_date, arrival_airport
ORDER BY arrival_date, arrival_airport;

-- arrival_date	arrival_airport	count
-- 2017-07-16	SVO	1662
-- 2017-07-16	VKO	520
-- 2017-07-17	SVO	1660
-- 2017-07-17	VKO	531
-- 2017-07-18	SVO	973
-- 2017-07-18	VKO	294
-- 2017-07-19	SVO	994
-- 2017-07-19	VKO	299
-- 2017-07-20	SVO	1022
-- 2017-07-20	VKO	307
-- .....
