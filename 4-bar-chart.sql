-- Задание № 1

-- На этот раз вам нужно выяснить, сколько уникальных пассажиров прошли через высоконагруженные аэропорты страны за эти два месяца. Высоконагруженными считаются аэропорты, которые посетили более 10 тысяч уникальных пассажиров.

WITH unique_passengers AS (
    (SELECT
        f.arrival_airport AS airoport,
        t.passenger_id
    FROM flights f
    NATURAL JOIN boarding_passes bp
    NATURAL JOIN tickets t)
    UNION
    (SELECT
        f.departure_airport AS airoport,
        t.passenger_id
    FROM flights f
    NATURAL JOIN boarding_passes bp
    NATURAL JOIN tickets t))
SELECT airoport, COUNT(DISTINCT passenger_id) FROM unique_passengers
GROUP BY airoport
ORDER BY airoport;

-- Высоконагруженные аэропорты
WITH unique_passengers AS (
    (SELECT
        f.arrival_airport AS airoport,
        t.passenger_id
    FROM flights f
    NATURAL JOIN boarding_passes bp
    NATURAL JOIN tickets t)
    UNION
    (SELECT
        f.departure_airport AS airoport,
        t.passenger_id
    FROM flights f
    NATURAL JOIN boarding_passes bp
    NATURAL JOIN tickets t))
SELECT airoport, COUNT(DISTINCT passenger_id) FROM unique_passengers
GROUP BY airoport
HAVING COUNT(DISTINCT passenger_id) > 10000
ORDER BY airoport;
-- airoport	count
-- AER	15556
-- DME	55598
-- LED	28222
-- OVB	17615
-- SVO	62156
-- VKO	24214


-- Задание № 2

-- В Волгограде появилась новая авиакомпания. Чтобы установить конкурентные цены на авиабилеты, она хочет изучить среднюю цену билетов на рейсы из Волгограда. Код аэропорта — VOG.

-- Изучите данные и представьте их в виде столбчатой диаграммой. Отдельными столбцами выведите цены на билеты эконом- и бизнес-класса.

SELECT f.arrival_airport, tf.fare_conditions, ROUND(AVG(tf.amount), 0) AS avg_price
FROM ticket_flights tf
NATURAL JOIN flights f
WHERE departure_airport = 'VOG'
GROUP BY f.arrival_airport, tf.fare_conditions
ORDER BY f.arrival_airport, tf.fare_conditions;

-- arrival_airport	fare_conditions	avg_price
-- CEK	Business	41200
-- CEK	Economy	13783
-- ROV	Business	11300
-- ROV	Economy	3816
-- SVO	Business	27800
-- SVO	Economy	9355
-- TOF	Business	85200
-- TOF	Economy	28521
-- VKO	Business	26900
-- VKO	Economy	9050
