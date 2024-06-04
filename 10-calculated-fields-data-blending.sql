-- Задание № 1

-- Авиакомпаниям интересно узнать, из каких городов пассажиры предпочитают летать бизнес и комфорт классом. Составьте запрос, который сформирует таблицу содержащую записи о классе обслуживания, а также аэропортах вылета и прилета пассажиров. Полученные данные сохраните в виде таблицы.

SELECT
    DISTINCT tf.fare_conditions, f.departure_airport, f.arrival_airport
FROM flights f
NATURAL JOIN ticket_flights tf
ORDER BY tf.fare_conditions;

-- с учетом частоты
SELECT
    tf.fare_conditions, f.departure_airport, f.arrival_airport
FROM flights f
NATURAL JOIN ticket_flights tf
ORDER BY tf.fare_conditions, f.departure_airport, f.arrival_airport;


-- Задание № 2

-- В предыдущем задании мы получили общую информацию в целом по стране. Теперь нам нужно узнать, из каких городов России чаще всего летают бизнес или комфорт классом в Москву. Воспользуйтесь функциональностью вычисляемых полей и добавьте необходимые вычисления при условии, что:
--     arrival_airport: SVO, VKO, 
--     fare_conditions: Business, Comfort

-- см. dashboart Аэропорты, chart "Из каких городов чаще всего летают бизнес или комфорт классом в Москву"
