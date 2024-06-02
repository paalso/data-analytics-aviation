-- Задание № 1

-- В этом задании мы будем практиковаться строить воронкообразную диаграмму

-- Скопируйте к себе этот СSV-файл (https://drive.google.com/file/d/11IuXTKm6B61Nfp5VGI7HSbU9Gq7vEi5O/view?usp=sharing) и загрузите его в Preset.

-- Данная таблица получена из системы аналитики и содержит информацию о событиях учебного курса.

-- Учебный курс состоит из 5 модулей (module 1, module 2, …​ module 5), которые в свою очередь содержат определенное количество уроков. Студенты начинают прохождение курса с первого модуля (module 1), последовательно проходят модуль за модулем, и успешно завершают курс после окончания пятого модуля (module 5).

-- Таблица содержит следующие поля:
--     no - порядковый номер строки таблицы
--     event - признак начала и завершения урока: lesson_started и lesson_finished соответственно
--     student - уникальный идентификатор студента
--     timestamp - дата события
--     lesson_slug - название урока
--     course_element - модуль курса

-- Задание
-- С помощью запроса в sql lab подготовьте данные и постройте воронкообразную диаграмму, отражающую количество студентов на каждом этапе/модуле прохождения учебного курса.

SELECT
  course_element,
  COUNT(DISTINCT student_id)
FROM course_events
GROUP BY course_element
ORDER BY course_element;


course_element	COUNT(DISTINCT student_id)
module 1	827
module 2	299
module 3	197
module 4	190
module 5	85




SELECT
  course_element,
  COUNT(student_id)
FROM course_events
GROUP BY course_element
ORDER BY course_element;








no	event	student_id	timestamp	lesson_slug	course_element
0	lesson_finished	c2a8211670a5d40e3b2a86715e7bc26994b9a83d	2023-12-13 23:29:39.675000+03:00	interpolation	module 2
1	lesson_started	e707a77b9e71c56ca30657098ebde78a549f955c	2023-12-13 23:28:04.825000+03:00	hello-world	module 1
2	lesson_finished	e707a77b9e71c56ca30657098ebde78a549f955c	2023-12-13 23:28:04.304000+03:00	intro	module 1
3	lesson_started	e707a77b9e71c56ca30657098ebde78a549f955c	2023-12-13 23:27:52.308000+03:00	intro	module 1
4	lesson_started	de78fe3b096508f220ea51e2e495f5c1fa101738	2023-12-13 23:26:38.616000+03:00	hello-world	module 1
5	lesson_finished	de78fe3b096508f220ea51e2e495f5c1fa101738	2023-12-13 23:26:38.232000+03:00	intro	module 1
6	lesson_started	c05d97e8bc97670a0cb8794941a8062f89af9a64	2023-12-13 23:26:15.175000+03:00	symbols	module 2
7	lesson_started	9899196ec3349c997dbb512354d36a563a256b3d	2023-12-13 23:25:50.583000+03:00	slises	module 2
8	lesson_finished	9899196ec3349c997dbb512354d36a563a256b3d	2023-12-13 23:25:36.866000+03:00	symbols	module 2
9	lesson_started	1f3e6a688054d0a42300f9f40e0877e7b84e3335	2023-12-13 23:24:47.454000+03:00	methods	module 3





SELECT course_element, student_id, lesson_slug, event
FROM course_events
WHERE student_id = de78fe3b096508f220ea51e2e495f5c1fa101738
ORDER BY course_element, student_id, lesson_slug, event DESC;


SELECT student_id, DISTINCT course_element, lesson_slug
FROM course_events
WHERE event = 'lesson_finished'
ORDER BY student_idm course_element,lesson_slug;



WITH all_course_events AS (
    SELECT DISTINCT course_element, lesson_slug
    FROM course_events;
)
SELECT * FROM all_course_events;
module 1	arithmetics
module 1	hello-world
module 1	instructions
module 1	intro
module 1	linting
module 1	strings
module 1	variables
module 1	variables-expression
module 2	call-function-expression
module 2	calling-functons
module 2	data-types
module 2	immutability-of-primitive-types
module 2	interpolation
module 2	naming
module 2	signature
module 2	slises
module 2	symbols
module 3	default-parameters
module 3	deterministic
module 3	functions-arguments
module 3	functions-define
module 3	functions-return
module 3	methods
module 3	methods-chain
module 3	stdlib
module 3	type-annotations
module 4	aggregation
module 4	conditionals
module 4	conditions-inside-loops
module 4	environment
module 4	for
module 4	iteration-over-string
module 4	logical-expressions
module 4	logical-operations
module 4	logical-operators
module 4	match
module 4	named-arguments
module 4	while
module 5	debug
module 5	history
module 5	module-random
module 5	modules
module 5	modules-in-depth
module 5	packages
module 5	tuples


SELECT DISTINCT course_element, COUNT(DISTINCT lesson_slug)
FROM course_events
GROUP BY course_element
ORDER BY course_element;
course_element	COUNT(DISTINCT lesson_slug)
module 1	8
module 2	9
module 3	9
module 4	12
module 5	7

SELECT DISTINCT course_element, COUNT(DISTINCT lesson_slug)
FROM course_events
GROUP BY course_element
ORDER BY course_element;
course_element	COUNT(DISTINCT lesson_slug)
module 1	8
module 2	9
module 3	9
module 4	12
module 5	7



SELECT course_element, student_id, COUNT(lesson_slug) AS passed_lessons_count
FROM course_events
GROUP BY course_element, student_id
ORDER BY course_element, student_id;
course_element	student_id	passed_lessons_count
module 1	000008c95919237f9f9c5e59616b077811992838	1
module 1	0010ed606764938345133193e2d95fc379c94765	3
module 1	00229b9c9550066b493760e60aeb14555b36e8a0	3
module 1	00281efe230ef387b08eda74e9a14dd08a2f5589	3
module 1	00313f52f26c66be66884b15bba259635aa3bcb2	13
module 1	0035b534c127193be89d46bf01480a3b4073bfc5	7
module 1	008e9eda4eccbdc15dd9e95e7e2cb6396938fdb2	2
module 1	0110663989859b2c3885a60584f799244609d433	1
module 1	019fd0f2aea901e0fb25b66e75d7e22c49011bcd	11
module 1	021652ee02bc98bba43f01720596866d566b8e43	7


WITH tab AS (
    SELECT course_element, student_id, COUNT(lesson_slug) AS passed_lessons_count
    FROM course_events
    WHERE event = 'lesson_finished'
    GROUP BY course_element, student_id
    ORDER BY course_element, student_id
)
SELECT course_element, COUNT(student_id)
FROM tab
WHERE passed_lessons_count = 7
GROUP BY course_element
ORDER BY course_element;


SELECT student_id, COUNT(lesson_slug) AS passed_lessons_count
FROM course_events
WHERE event = 'lesson_finished' AND course_element = 'module 5'
GROUP BY student_id
ORDER BY COUNT(lesson_slug) DESC;

SELECT student_id, COUNT(lesson_slug) AS passed_lessons_count
FROM course_events

GROUP BY student_id
ORDER BY COUNT(lesson_slug) DESC;


Как посчитать количество судентов, которые прошли все уроки первого курса (course_element = 'module 5')
прошли все уроки означает, что для всех уроков есть запись с event = 'lesson_finished'

WITH module_1_lessons AS (
    SELECT DISTINCT lesson_slug
    FROM course_events
    WHERE course_element = 'module 1'
),
module_1_lessons_count AS (
    SELECT COUNT(*) AS module_1_lessons_number
    FROM module_1_lessons
),
students_completed_module_1 AS (
    SELECT student_id
    FROM course_events
    WHERE event = 'lesson_finished'
    AND course_element = 'module 1'
    GROUP BY student_id
    HAVING COUNT(DISTINCT lesson_slug) = (SELECT module_1_lessons_number FROM module_1_lessons_count)
)
SELECT COUNT(*) AS student_count
FROM students_completed_module_1;



WITH module_1_lessons AS (
    SELECT DISTINCT lesson_slug
    FROM course_events
    WHERE course_element = 'module 1'
),
module_1_lessons_count AS (
    SELECT COUNT(*) AS module_1_lessons_number
    FROM module_1_lessons
)
SELECT * FROM module_1_lessons_count;



WITH lessons_number_in_courses AS (
    SELECT DISTINCT course_element, COUNT(DISTINCT lesson_slug)
    FROM course_events
    GROUP BY course_element
    ORDER BY course_element
)
SELECT * FROM lessons_number_in_courses;







WITH
module_1_lessons_count AS (SELECT COUNT(DISTINCT lesson_slug)
FROM course_events
WHERE course_element = 'module 1')
SELECT * FROM module_1_lessons_count,
students_completed_module_1 AS (
    SELECT student_id
    FROM course_events
    WHERE event = 'lesson_finished'
    AND course_element = 'module 1'
    GROUP BY student_id
    HAVING COUNT(DISTINCT lesson_slug) = (SELECT module_1_lessons_number FROM module_1_lessons_count)
)
SELECT COUNT(*) AS student_count
FROM students_completed_module_1;