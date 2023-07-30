import sqlite3
from sqlite3 import Error
import re


class PeopleDB:
    __connection: sqlite3.Connection = None
    __cursor: sqlite3.Cursor = None
    __path_to_db = 'people.db'

    def create_db(self):
        self.__connection = sqlite3.connect(self.__path_to_db)

    def close_db(self):
        self.__connection.close()
        print('Выход из ДБ')

    def __del__(self):
        self.__connection.close()

    def create_cursor(self):
        self.__cursor = self.__connection.cursor()

    def close_cursor(self):
        self.__cursor.close()

    def change_file_path(self, new_path: str):
        self.__path_to_db = new_path

    @staticmethod
    def check_valid_date(date: str):
        return re.match(r'[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])', date)

    @staticmethod
    def check_valid_phone(phone: str):
        return re.match(r'(\+7)\([9]{1}[0-9]{2}\)[0-9]{3}-[0-9]{2}-[0-9]{2}', phone)

    def check_values_from_db(self, field: str, value: str) -> bool:
        if value.isdigit():
            value = int(value)
        with self.__connection:
            self.create_cursor()
            self.__cursor.execute(f"""SELECT * FROM people WHERE {field} = ?""", (value,))
        return self.__cursor.fetchall() == []

    def create_table(self, name_table: str):
        with self.__connection:
            self.create_cursor()
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
            self.__cursor.execute(sql_request)
            print(f'Таблица people создана.')
            self.close_cursor()

    def insert_one_people(self, name_table: str, people_data: tuple):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''INSERT INTO {name_table} (name, surname, country, city, address, date_of_birth, phone)
                                VALUES (?, ?, ?, ?, ?, ?, ?)'''
            try:
                self.__cursor.execute(sql_request, people_data)
                return True
            except Error:
                return False
            finally:
                self.__cursor.close()

    def delete_user_by_id(self, name_table: str, id_user: int):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''DELETE FROM {name_table} WHERE id = ?'''
            try:
                self.__cursor.execute(sql_request, (id_user,))
                return True
            except Error:
                return False
            finally:
                self.__cursor.close()

    def get_values_by_id(self, name_table: str, id_user: int):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''SELECT * FROM {name_table} WHERE id = ?'''
            try:
                self.__cursor.execute(sql_request, (id_user,))
                return self.__cursor.fetchall()
            except Error as e:
                print(e)
                return False
            finally:
                self.__cursor.close()

    def update_users_data(self, name_table: str, data: tuple):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''UPDATE {name_table}
                              SET name = ?, surname = ?, country = ?, city = ?, 
                              address = ?, date_of_birth = ?, phone = ?
                              WHERE id = ?'''
            try:
                self.__cursor.execute(sql_request, data)
                return True
            except Error as e:
                print(e)
                return False
            finally:
                self.__connection.commit()
                self.__cursor.close()

    def get_all_data(self):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''SELECT * FROM people'''
        try:
            self.__cursor.execute(sql_request)
            return self.__cursor.fetchall()
        except Error as e:
            print(e)
        finally:
            self.__cursor.close()

    def get_last_id(self):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''SELECT id FROM people
                              ORDER BY id DESC
                              LIMIT 1'''
            try:
                self.__cursor.execute(sql_request)
                return self.__cursor.fetchone()[0]
            except Error as e:
                print(e)
            finally:
                self.__cursor.close()

    def get_data_by_field_and_values(self, field: str, values: str):
        with self.__connection:
            self.create_cursor()
            sql_request = f'''SELECT * FROM people
                              WHERE {field} = ?'''
        try:
            self.__cursor.execute(sql_request, (values,))
            return self.__cursor.fetchall()
        except Error as e:
            print(e)
        finally:
            self.__cursor.close()





