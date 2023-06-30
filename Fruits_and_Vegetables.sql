/* Задание 1
Создайте следующие запросы для базы данных с
информацией об овощах и фруктах из предыдущего домашнего задания */

/* Отображение всех овощей с калорийностью меньше,
указанной калорийности */
SELECT name, Calories
FROM Fruits_and_Vegetables
WHERE Calories < 35

/* Отображение всех фруктов с калорийностью в указанном диапазоне */
SELECT name, Calories
FROM Fruits_and_Vegetables
WHERE Calories BETWEEN 20 AND 35

/* Отображение всех овощей в названии, которых есть указанное слово. Например, слово: капуста */
SELECT *
FROM Fruits_and_Vegetables
WHERE name like '%помидор%'

/* Отображение всех овощей и фруктов в кратком описании, которых есть указанное слово. Например, слово: гемоглобин */
SELECT name, ShortDescription
FROM Fruits_and_Vegetables
WHERE ShortDescription like '%сладкий%'

/* Показать все овощи и фрукты, у которых цвет желтый или красный */
SELECT *
FROM Fruits_and_Vegetables
WHERE Color in ('жёлтый', 'красный')


/* Задание 2
Создайте следующие запросы для базы данных с
информацией об овощах и фруктах из предыдущего домашнего задания */

/* Показать количество овощей */
SELECT count(*) AS count_vegetables
FROM Fruits_and_Vegetables
WHERE Type = 'овощ'
ORDER BY Type

/* Показать количество фруктов */
SELECT count(*) AS count_vegetables
FROM Fruits_and_Vegetables
WHERE Type = 'фрукт'
ORDER BY Type

/* Показать количество овощей и фруктов заданного цвета */
SELECT count(*) AS count_color
FROM Fruits_and_Vegetables
WHERE Color = 'оранжевый'
ORDER BY Color

/* Показать количество овощей и фруктов каждого цвета */
SELECT Color, count(*) as count_color
FROM Fruits_and_Vegetables
GROUP BY Color

/* Показать цвет с минимальным количеством овощей и фруктов */
SELECT Color, count(color)
FROM Fruits_and_Vegetables
GROUP BY Color
LIMIT 1

/* Показать цвет с максимальным количеством овощей и фруктов */
SELECT Color, count(color) AS count_color
FROM Fruits_and_Vegetables
GROUP BY Color
ORDER BY count_color DESC
LIMIT 1

/* Показать минимальную калорийность овощей и фруктов */
SELECT name, min(Calories) AS Min_calories
FROM Fruits_and_Vegetables

/* Показать максимальную калорийность овощей и фруктов */
SELECT name, max(Calories) AS Max_calories
FROM Fruits_and_Vegetables

/* Показать среднюю калорийность овощей и фруктов */
SELECT avg(Calories) AS avg_calories
FROM Fruits_and_Vegetables

/* Показать фрукт с минимальной калорийностью */
SELECT name, min(Calories) AS Min_calories
FROM Fruits_and_Vegetables
WHERE Type = 'фрукт'

/* Показать фрукт с максимальной калорийностью */
SELECT name, max(Calories) AS Max_calories
FROM Fruits_and_Vegetables
WHERE Type = 'фрукт'