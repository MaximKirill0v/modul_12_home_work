import sqlite3
from sqlite3 import Error
import os
import json


# Задание 1.
# Создайте базу данных с одной таблицей People (имя, фамилия, страна,
# город, адрес, дата рождения).
# Добавьте возможность вставки, удаления и обновления данных через
# интерфейс приложения с помощью запросов INSERT, DELETE, UPDATE. Перед
# исполнением запроса проверяйте корректность названия таблицы.
# Добавьте к приложению возможность сохранять результаты работы
# фильтров в файл. Например, результат работы фильтра по отображению всех
# людей или результат работы фильтра по отображению людей из одного
# города.

def create_table(connection, name_table: str):
    with connection:
        cursor = connection.cursor()
        sql_request = f'''CREATE TABLE IF NOT EXISTS {name_table}
                        (
                          id INTEGER PRIMARY KEY AUTOINCREMENT,
                          name TEXT NOT NULL,
                          surname TEXT NOT NULL,
                          country TEXT NOT NULL,
                          city TEXT,
                          address TEXT,
                          date_of_birth TEXT,
                          phone TEXT UNIQUE NOT NULL
                        )'''
        cursor.execute(sql_request)
        print(f'Таблица "{name_table}" создана.')
        cursor.close()


def insert_one_people(name_db: str, connection, name_table, *args):
    with connection:
        if os.path.exists(name_db):
            cursor = connection.cursor()
            sql_request = f'''INSERT INTO {name_table} (name, surname, country, city, address, date_of_birth, phone)
                            VALUES (?, ?, ?, ?, ?, ?, ?)'''
            try:
                cursor.execute(sql_request, *args)
                print(f'Данные успешно добавлены в таблицу {name_table}.')
            except Error as e:
                print(e)
            finally:
                cursor.close()
        else:
            print(f'БД {name_db} не существует.')


def insert_many_people(name_db: str, connection, name_table, peoples_data: list[tuple]):
    with connection:
        if os.path.exists(name_db):
            cursor = connection.cursor()
            sql_request = f'''INSERT INTO {name_table} (name, surname, country, city, address, date_of_birth, phone)
                            VALUES (?, ?, ?, ?, ?, ?, ?)'''
            for data in peoples_data:
                try:
                    cursor.execute(sql_request, data)
                except Error as e:
                    print(e)
            print(f'Данные из списка успешно добавлены в таблицу {name_table}.')
            cursor.close()
        else:
            print(f'БД {name_db} не существует.')


def read_people_data_from_txt(path: str) -> list[tuple]:
    if os.path.exists(path):
        with open(path, 'r', encoding='utf8') as file:
            people_data_list = []
            for num, record in enumerate(file):
                if num % 2 != 0:
                    tuple_data = tuple(word for word in record[9:-4].split("', '"))
                    people_data_list.append(tuple_data)
        return people_data_list
    else:
        print(f'Файла по пути "{path}" не существует.')


def check_values_from_db(connection, name_db: str, name_table: str, field: str, check_values: str) -> bool:
    if check_values.isdigit():
        check_values = int(check_values)
    with connection:
        if os.path.exists(name_db):
            cursor = connection.cursor()
            cursor.execute(f"""SELECT * FROM {name_table} WHERE {field} = ?""", (check_values,))
    return cursor.fetchall() == []


def delete_data_from_db(name_db: str, connection, name_table, field_to_delete: str, values_to_delete: str):
    if values_to_delete.isdigit():
        values_to_delete = int(values_to_delete)
    with connection:
        if os.path.exists(name_db):
            cursor = connection.cursor()
            try:
                sql_request = f'''DELETE FROM {name_table}
                                  WHERE {field_to_delete} = ?
                               '''
                cursor.execute(sql_request, (values_to_delete,))
                print(f'Данные о человеке под {field_to_delete} = {values_to_delete} удалены.')
            except Error as e:
                print(e)
            finally:
                connection.commit()
                cursor.close()
        else:
            print(f'БД {name_db} не существует.')


def update_phone(name_db: str, connection, name_table, field_to_update: str, new_values: str, last_values: str):
    with connection:
        if os.path.exists(name_db):
            cursor = connection.cursor()
            try:
                sql_request = f'''UPDATE {name_table}
                                  SET {field_to_update} = ?
                                  WHERE {field_to_update} = ?
                               '''
                cursor.execute(sql_request, (new_values, last_values))
                print(f'Старые данные - "{last_values}" успешно заменены на "{new_values}".')
            except Error as e:
                print(e)
            finally:
                connection.commit()
                cursor.close()
        else:
            print(f'БД {name_db} не существует.')


def save_to_json_file(path: str):
    def decorator(func):
        def wrapper(*args, **kwargs):
            fields = func(*args, **kwargs)
            with open(path, 'a') as file:
                print(fields)
                for field in fields:
                    json.dump(field, file)
            return fields

        return wrapper

    return decorator


@save_to_json_file('./people_data/data_people.json')
def filter_by_city(name_db: str, connection, name_table, fields: str, values: str):
    if os.path.exists(name_db):
        cursor = connection.cursor()
        try:
            sql_request = f'''SELECT * FROM {name_table}
                              WHERE {fields} = ? 
                           '''
            cursor.execute(sql_request, (values,))
            fields = cursor.fetchall()
            return fields
        except Error as e:
            print(e)
        finally:
            cursor.close()
    else:
        print(f'БД {name_db} не существует.')


def interface_app():
    print('Введите число для работы с приложением: \n=> 1 - добавить данные пользователя в БД'
          '\n=> 2 - изменение данных в БД\n=> 3 - выборка данных пользователей по фильтру\n'
          '=> 4 - удаление данных пользователя из таблицы\n=> 5 - выход из программы')


def execute_application():
    name_db = 'People.db'
    connection = sqlite3.connect(name_db)
    name_table = 'People'
    create_table(connection, name_table)

    # добавление в таблицу данных одного человека
    # people_data = ('Maxim', 'Kirillov', 'Russia', 'Yaroslavl', 'Lenina', '1989-02-14', '+671-0795-532-256')
    # insert_one_people(name_db, connection, name_table, people_data)

    # считывание данных из txt файла и преобразование данных к списку кортежей
    # path_to_txt_people_data = './people_data/data_people.txt'
    # people_list_tuple = read_people_data_from_txt(path_to_txt_people_data)

    # добавление в таблицу данных многих людей
    # insert_many_people(name_db, connection, name_table, people_list_tuple)

    # удаление данных из таблицы по введённому полю и его значению
    # fields_for_delete = 'phone'
    # values_to_delete = '+350-3833-535-675'
    #
    # if not check_values_from_db(connection, name_db, name_table, fields_for_delete, values_to_delete):
    #     delete_data_from_db(name_db, connection, name_table, fields_for_delete, values_to_delete)
    # else:
    #     print(f'Человек с полем {fields_for_delete} = {values_to_delete} '
    #           f'отсутствует в таблице. Удаление данных не возможно.')

    # изменение данных в БД
    # last_values = '+65-2061-655-061'
    #     # new_values = '+43-9021-344-097'
    #     # fields_for_update = 'phone'
    # if not check_values_from_db(connection, name_db, name_table, fields_for_update, last_values):
    #     update_phone(name_db, connection, name_table, fields_for_update, new_values, last_values)
    # else:
    #     print(f'Человек с полем {fields_for_update} = {last_values} '
    #           f'отсутствует в таблице. Обновление данных не возможно.')

    # выборка из БД
    # field = 'country'
    # values = 'Nigeria'
    #
    # fields = filter_by_city(name_db, connection, name_table, field, values)
    # if fields:
    #     for field in fields:
    #         print(field)
    # else:
    #     print(f"Данные с полем '{field}' = '{values}' в БД не найдены.")

    while True:
        interface_app()
        number_input = input('=> ')
        numbers_app = ('1', '2', '3', '4', '5')
        if number_input == '1':
            print('Введите имя, фамилию, страну, город, улицу, дату рождения, телефон через запятую и пробел:\n'
                  '# Степанов, Степан, Россия, Саратов, ул. Ленина, 1999-12-28, +671-0795-532-200')
            people_data = tuple(input().split(', '))
            try:
                insert_one_people(name_db, connection, name_table, people_data)
                print('Пользователь успешно добавлен в БД.')
            except Error as e:
                print(e)
            else:
                print('Не корректные данные, повторите ввод.')

        if number_input == '2':
            
            fields_for_update = 'name', 'surname', 'country', 'city', 'address', 'date_of_birth', 'phone'

            field_for_update = input('Введите название поля, значение которого хотите изменить'
                                     '(name, surname, country, city, address, date_of_birth, phone): ')
            if field_for_update in fields_for_update:


        if number_input not in numbers_app:
            print('Введено не корректное число, повторите попытку.')
        if number_input == '5':
            break

    connection.close()
    print(f'Соединение с БД "{name_db}" завершено.')


if __name__ == '__main__':
    execute_application()
