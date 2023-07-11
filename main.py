import sqlite3
from sqlite3 import Error
from request.sql_request import *


def create_database(path: str) -> sqlite3.Connection:
    try:
        connection = sqlite3.connect(path)
    except Error as e:
        print(e)
    else:
        print(f'Соединение с базой данных {path} установлено.')
        return connection


def create_table(cursor, sql_request, name_table: str):
    cursor.execute(sql_request)
    print(f'Таблица "{name_table}" создана.')


def execute_application():
    # Задание 1.
    # Создайте базу данных «Телефонный справочник». Эта
    # база данных должна содержать одну таблицу «Люди». В
    # таблице нужно хранить: ФИО человека, дату рождения,
    # пол, телефон, город проживания, страна проживания,
    # домашний адрес. Для создания базы данных используйте запрос CREATE DATABASE. Для создания таблицы
    # используйте запрос CREATE TABLE.

    """
    name_db = 'phonebook.db'
    connection = create_database(name_db)
    cursor = connection.cursor()
    name_table = 'people'
    sql_request = create_request_people()
    try:
        create_table(cursor, sql_request, name_table)
    except Error as e:
        print(e)
    finally:
        cursor.close()
        connection.close()
        print(f'Соединение с базой данных {name_db} завершено.')
    """

    # Задание 2.
    # Создайте базу данных «Продажи». База данных должна
    # содержать информацию о продавцах, покупателях, продажах. Необходимо хранить следующую информацию:
    # ■ о продавцах: ФИО, email, контактный телефон;
    # ■ о покупателях: ФИО, email, контактный телефон;
    # ■ о продажах: покупатель, продавец, название товара,
    # цена продажи, дата сделки.
    # Для создания базы данных используйте запрос CREATE
    # DATABASE. Для создания таблицы используйте запрос
    # CREATE TABLE. Обязательно при создании таблиц задавать связи между ними.
    """
    name_db = 'sales.db'
    connection = create_database(name_db)
    cursor = connection.cursor()
    name_table_sellers = 'sellers'
    sql_request_sellers = create_request_sellers_or_buyer(name_table_sellers)
    name_table_buyer = 'buyer'
    sql_request_buyer = create_request_sellers_or_buyer(name_table_buyer)
    name_table_sales = 'sales'
    sql_request_sales = create_request_sales(name_table_sales)
    try:
        create_table(cursor, sql_request_sellers, name_table_sellers)
        create_table(cursor, sql_request_buyer, name_table_buyer)
        create_table(cursor, sql_request_sales, name_table_sales)
    except Error as e:
        print(e)
    finally:
        cursor.close()
        connection.close()
        print(f'Соединение с базой данных {name_db} завершено.')
    """

    # Задание 3.
    # Создайте базу данных «Музыкальная коллекция». База
    # данных должна содержать информацию о музыкальных
    # дисках, исполнителях, стилях. Необходимо хранить следующую информацию:
    # ■ о музыкальном диске: название диска, исполнитель,
    # дата выпуска, стиль, издатель;
    # ■ о стилях: названия стилей;
    # ■ об исполнителях: название;
    # ■ об издателях: название, страна;
    # ■ о песнях: название песни, название диска, длительность песни, музыкальный стиль песни, исполнитель.
    # Продумайте правильную структуру базы данных.
    # Для создания базы данных используйте запрос CREATE
    # DATABASE. Для создания таблицы используйте запрос
    # CREATE TABLE. Обязательно при создании таблиц задавать связи между ними.

    name_db = 'Music_collection.db'
    connection = create_database(name_db)
    cursor = connection.cursor()
    name_table_style = 'style'
    sql_request_style = create_request_style_or_singer(name_table_style)
    name_table_singer = 'singer'
    sql_request_singer = create_request_style_or_singer(name_table_singer)
    name_table_publisher = 'publisher'
    sql_request_publisher = create_request_publisher(name_table_publisher)
    name_table_music_disc = 'music_disc'
    sql_request_music_disc = create_request_music_disc(name_table_music_disc)
    name_table_song = 'song'
    sql_request_song = create_request_song(name_table_song)
    try:
        create_table(cursor, sql_request_style, name_table_style)
        create_table(cursor, sql_request_singer, name_table_singer)
        create_table(cursor, sql_request_publisher, name_table_publisher)
        create_table(cursor, sql_request_music_disc, name_table_music_disc)
        create_table(cursor, sql_request_song, name_table_song)
    except Error as e:
        print(e)
    finally:
        cursor.close()
        connection.close()
        print(f'Соединение с базой данных {name_db} завершено.')


if __name__ == '__main__':
    execute_application()

