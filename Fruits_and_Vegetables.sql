/* Задание 1.
Создайте следующие запросы для таблицы с информацией об овощах и
фруктах из предыдущего задания */

/* Отображение всей информации из таблицы с овощами и фруктами;*/
SELECT *
FROM Fruits_and_Vegetables

/* Отображение всех овощей; */
SELECT *
FROM Fruits_and_Vegetables
WHERE Type = "овощ"

/* Отображение всех фруктов */
SELECT *
FROM Fruits_and_Vegetables
WHERE Type = "фрукт"

/* Отображение всех названий овощей и фруктов */
SELECT Name
FROM Fruits_and_Vegetables

/* Отображение всех цветов. Цвета должны быть уникальными */
SELECT DISTINCT Color FROM Fruits_and_Vegetables

/* Отображение фруктов конкретного цвета */
SELECT *
FROM Fruits_and_Vegetables
WHERE color = "оранжевый"

/* Отображение овощей конкретного цвета */
SELECT *
FROM Fruits_and_Vegetables
WHERE Type = "овощ" AND color = "красный"