-- Задание № 1

-- В этот раз вам нужно узнать и проанализировать средние цены на билеты. Составьте запрос, который вычисляет среднюю стоимость билетов для каждого рейса и класса обслуживания. Запрос должен содержать аэропорт отправки и аэропорт прибытия. Представьте полученные данные в виде таблицы.

SELECT
    f.flight_no, f.departure_airport, f.arrival_airport,
    tf.fare_conditions, AVG(tf.amount)
FROM flights f
NATURAL JOIN ticket_flights tf
GROUP BY f.flight_no, f.departure_airport, f.arrival_airport, tf.fare_conditions
ORDER BY f.flight_no, f.departure_airport, f.arrival_airport, tf.fare_conditions;
-- flight_no	departure_airport	arrival_airport	fare_conditions	avg
-- PG0012	GDZ	VKO	Economy	12395.705521472393
-- PG0013	AER	SVO	Business	42100
-- PG0013	AER	SVO	Comfort	23900
-- PG0013	AER	SVO	Economy	14050.56460649944
-- PG0014	TJM	URJ	Business	9800
-- PG0014	TJM	URJ	Economy	3318.8870151770657
-- PG0015	SVO	VKT	Economy	18871
-- PG0016	VKT	SVO	Economy	18900.704225352114
-- PG0019	DME	UUA	Economy	9592.14795587281
-- PG0020	UUA	DME	Economy	9580.832823025106
