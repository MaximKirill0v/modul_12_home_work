from PyQt6 import QtWidgets
from PyQt6.QtWidgets import QApplication, QMainWindow, QMessageBox, QTableWidgetItem, QAbstractItemView
from Designer_windows.new_main_window import Ui_MainWindow
from Designer_windows.insert import UiInsertDialog
from Designer_windows.delete import UiDeleteDialog
from Designer_windows.update import UiUpdateDialog
from Designer_windows.filter import UiFilterDialog
from Designer_windows.save_filter_window import UiSaveFilterDialog
import json
from people_db import PeopleDB
import sys


class InsertDialog(QMainWindow):
    def __init__(self):
        super().__init__()
        self.name_table = 'people'
        self.insert_window = QtWidgets.QDialog()
        self.ui_window = UiInsertDialog()
        self.ui_window.setupUi(self.insert_window)

        self.ui_window.pushButton.clicked.connect(self.insert_data_people_to_db)

    def change_name_table(self, new_name_table: str):
        self.name_table = new_name_table

    def show_window(self):
        self.insert_window.show()

    def close_window(self):
        self.insert_window.close()

    def insert_data_people_to_db(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        name = self.ui_window.name.text()
        surname = self.ui_window.surname.text()
        country = self.ui_window.country.text()
        city = self.ui_window.city.text()
        address = self.ui_window.address.text()
        date_of_birth = self.ui_window.date_of_birth.text()
        phone = self.ui_window.phone.text()

        if name == '' or surname == '' or country == '' or city == '' or address == '':
            dlg.setText(f'Заполните пустые поля!')
            dlg.exec()
        elif not people_data_base.check_valid_date(date_of_birth):
            dlg.setText(f'Не корректный формат записи даты рождения!')
            dlg.exec()
        elif not people_data_base.check_values_from_db('phone', phone):
            dlg.setText(f'Данный номер телефона уже есть в БД!')
            dlg.exec()
        elif not people_data_base.check_valid_phone(phone):
            dlg.setText(f'Не корректный формат записи телефона!')
            dlg.exec()
        else:
            if people_data_base.insert_one_people(self.name_table, (name, surname, country, city, address,
                                                                    date_of_birth, phone)):

                row = main_window.table_widget.rowCount()
                main_window.table_widget.insertRow(row)

                main_window.table_widget.setItem(row, 0, QTableWidgetItem(str(people_data_base.get_last_id())))
                main_window.table_widget.setItem(row, 1, QTableWidgetItem(name))
                main_window.table_widget.setItem(row, 2, QTableWidgetItem(surname))
                main_window.table_widget.setItem(row, 3, QTableWidgetItem(country))
                main_window.table_widget.setItem(row, 4, QTableWidgetItem(city))
                main_window.table_widget.setItem(row, 5, QTableWidgetItem(address))
                main_window.table_widget.setItem(row, 6, QTableWidgetItem(date_of_birth))
                main_window.table_widget.setItem(row, 7, QTableWidgetItem(phone))

                dlg = QMessageBox(self)
                dlg.setWindowTitle("Good news!")
                dlg.setText(f'Данные успешно добавлены в таблицу.')
                dlg.exec()
            else:
                dlg = QMessageBox(self)
                dlg.setWindowTitle("Bad news!")
                dlg.setText(f'Данные не добавлены в таблицу! Не корректные значения!')
                dlg.exec()
            self.close_window()


class DeleteDialog(QMainWindow):
    def __init__(self):
        super().__init__()
        self.name_table = 'people'
        self.delete_window = QtWidgets.QDialog()
        self.ui_window = UiDeleteDialog()
        self.ui_window.setupUi(self.delete_window)

        self.ui_window.btn_del.clicked.connect(self.delete_user_by_id)

    def change_name_table(self, new_name_table: str):
        self.name_table = new_name_table

    def show_window(self):
        self.delete_window.show()

    def close_window(self):
        self.delete_window.close()

    def delete_user_by_id(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        id_user = self.ui_window.lineEdit_id.text()
        if people_data_base.check_values_from_db('id', id_user):
            dlg.setText(f'Пользователя под введённым id нет в БД!')
            dlg.exec()
        else:
            if people_data_base.delete_user_by_id(self.name_table, id_user):
                main_window.table_widget.clear()
                main_window.set_table_widget()
                dlg.setText(f'Пользователь успешно удалён!')
                dlg.exec()
            self.close_window()


class UpdateDialog(QMainWindow):
    def __init__(self):
        super().__init__()
        self.name_table = 'people'

        self.update_window = QtWidgets.QDialog()
        self.ui_window = UiUpdateDialog()
        self.ui_window.setupUi(self.update_window)

        self.ui_window.btn_id.clicked.connect(self.confirm_id)

    def change_name_table(self, new_name_table: str):
        self.name_table = new_name_table

    def show_window(self):
        self.update_window.show()

    def close_window(self):
        self.update_window.close()

    def confirm_id(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        id_user = self.ui_window.lineEdit.text()
        if people_data_base.check_values_from_db('id', id_user):
            dlg.setText(f'Пользователя под введённым id нет в БД!')
            dlg.exec()
        else:
            user_data = people_data_base.get_values_by_id(self.name_table, id_user)[0][1:]
            place_holder_text = (self.ui_window.name, self.ui_window.surname, self.ui_window.country,
                                 self.ui_window.city, self.ui_window.address, self.ui_window.date_of_birth,
                                 self.ui_window.phone)

            for num, user_value in enumerate(user_data):
                place_holder_text[num].setText(user_data[num])
            self.ui_window.btn_update.clicked.connect(self.update_data_user)

    def update_data_user(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        id_user = self.ui_window.lineEdit.text()
        name = self.ui_window.name.text()
        surname = self.ui_window.surname.text()
        country = self.ui_window.country.text()
        city = self.ui_window.city.text()
        address = self.ui_window.address.text()
        date_of_birth = self.ui_window.date_of_birth.text()
        phone = self.ui_window.phone.text()
        if name == '' or surname == '' or country == '' or city == '' or address == '':
            dlg.setText(f'Заполните пустые поля!')
            dlg.exec()
        elif not people_data_base.check_valid_date(date_of_birth):
            dlg.setText(f'Не корректный формат записи даты рождения!')
            dlg.exec()
        elif not people_data_base.check_valid_phone(phone):
            dlg.setText(f'Не корректный формат записи телефона!')
            dlg.exec()
        else:
            if people_data_base.update_users_data(self.name_table, (name, surname, country, city, address,
                                                                    date_of_birth, phone, id_user)):
                dlg = QMessageBox(self)
                main_window.table_widget.clear()
                main_window.set_table_widget()
                dlg.setWindowTitle("Good news!")
                dlg.setText(f'Данные обновлены.')
                dlg.exec()
            else:
                dlg = QMessageBox(self)
                dlg.setWindowTitle("Bad news!")
                dlg.setText(f'Данные не обновлены! Такой номер телефона уже есть в БД!')
                dlg.exec()
            self.close_window()


class FilterDialog(QMainWindow):

    def __init__(self):
        super(FilterDialog, self).__init__()
        self.name_table = 'people'

        self.filter_window = QtWidgets.QDialog()
        self.ui_window = UiFilterDialog()
        self.ui_window.setupUi(self.filter_window)

        self.data_by_field_and_values = []

        self.ui_window.pushButton.clicked.connect(self.show_filter)

    def show_filter(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        field = self.ui_window.comboBox.currentText()
        if field == 'Имя':
            field = 'name'
        elif field == 'Фамилия':
            field = 'surname'
        elif field == 'Страна':
            field = 'country'
        elif field == 'Город':
            field = 'city'
        elif field == 'Адрес':
            field = 'address'
        elif field == 'Дата рождения':
            field = 'date_of_birth'
        else:
            field = 'phone'
        field_value = self.ui_window.name.text()
        if people_data_base.check_values_from_db(field, field_value):
            dlg.setText(f'По введённым данным ничего не нашлось!')
            dlg.exec()
        else:
            data_by_field_and_values = people_data_base.get_data_by_field_and_values(field, field_value)
            self.data_by_field_and_values = [data for data in data_by_field_and_values]
            main_window.table_widget.setRowCount(len(data_by_field_and_values))
            row = 0
            for value in data_by_field_and_values:
                main_window.table_widget.setItem(row, 0, QTableWidgetItem(str(value[0])))
                main_window.table_widget.setItem(row, 1, QTableWidgetItem(value[1]))
                main_window.table_widget.setItem(row, 2, QTableWidgetItem(value[2]))
                main_window.table_widget.setItem(row, 3, QTableWidgetItem(value[3]))
                main_window.table_widget.setItem(row, 4, QTableWidgetItem(value[4]))
                main_window.table_widget.setItem(row, 5, QTableWidgetItem(value[5]))
                main_window.table_widget.setItem(row, 6, QTableWidgetItem(value[6]))
                main_window.table_widget.setItem(row, 7, QTableWidgetItem(value[7]))
                row += 1
            main_window.ui.btn_save_filter.setDisabled(False)
            self.close_window()

    def get_data_by_field_and_values(self):
        return self.data_by_field_and_values

    def change_name_table(self, new_name_table: str):
        self.name_table = new_name_table

    def show_window(self):
        self.filter_window.show()

    def close_window(self):
        self.filter_window.close()


class SaveFilterDialog(QMainWindow):
    def __init__(self):
        super(SaveFilterDialog, self).__init__()

        self.save_filter_window = QtWidgets.QDialog()
        self.ui_window = UiSaveFilterDialog()
        self.ui_window.setupUi(self.save_filter_window)

        self.ui_window.pushButton.clicked.connect(self.save_data)

    def save_data(self):
        dlg = QMessageBox(self)
        dlg.setWindowTitle("Информация")
        path = self.ui_window.lineEdit.text()
        form = self.ui_window.comboBox.currentText()
        if form == 'txt':
            self.save_data_to_txt(path, main_window.filter_window.get_data_by_field_and_values())
            dlg.setText(f'Данные сохранились в файл {path}.txt')
            dlg.exec()
        else:
            self.save_data_to_json(path, main_window.filter_window.get_data_by_field_and_values())
            dlg.setText(f'Данные сохранились в файл {path}.json')
            dlg.exec()
        self.close_window()

    @staticmethod
    def save_data_to_txt(path: str, data: list[tuple]):
        with open((path + '.txt'), 'a', encoding='utf-8') as f:
            for line in data:
                f.write(', '.join(str(s) for s in line) + '\n')

    @staticmethod
    def save_data_to_json(path: str, data: list[tuple]):
        with open((path + '.json'), 'w') as f:
            json.dump(data, f)

    def show_window(self):
        self.save_filter_window.show()

    def close_window(self):
        self.save_filter_window.close()


class MainWindow(QMainWindow):

    def __init__(self):
        super().__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.table_widget = self.set_table_widget()
        self.insert_window = None
        self.delete_window = None
        self.update_window = None
        self.filter_window = None
        self.save_filter_window = None

        self.ui.btn_insert.clicked.connect(self.open_insert_window)
        self.ui.btn_delete.clicked.connect(self.open_delete_window)
        self.ui.btn_update.clicked.connect(self.open_update_window)
        self.ui.btn_filter.clicked.connect(self.open_filter_dialog)
        self.ui.btn_show_all_db.clicked.connect(self.set_table_widget)
        self.ui.btn_exit.clicked.connect(self.close_app)
        self.ui.btn_save_filter.clicked.connect(self.open_save_filter_window)
        self.ui.btn_save_filter.setDisabled(True)

    def open_insert_window(self):
        self.ui.btn_save_filter.setDisabled(True)
        self.insert_window = InsertDialog()
        self.insert_window.show_window()

    def open_delete_window(self):
        self.ui.btn_save_filter.setDisabled(True)
        self.delete_window = DeleteDialog()
        self.delete_window.show_window()

    def open_update_window(self):
        self.ui.btn_save_filter.setDisabled(True)
        self.update_window = UpdateDialog()
        self.update_window.show_window()

    def open_filter_dialog(self):
        self.filter_window = FilterDialog()
        self.filter_window.show_window()

    def open_save_filter_window(self):
        self.save_filter_window = SaveFilterDialog()
        self.save_filter_window.show_window()

    def set_table_widget(self):
        self.ui.btn_save_filter.setDisabled(True)
        self.table_widget = self.ui.tableWidget
        self.table_widget.setColumnCount(8)
        self.table_widget.setColumnWidth(0, 50)
        self.table_widget.setColumnWidth(5, 200)
        self.table_widget.setShowGrid(False)
        self.table_widget.setSortingEnabled(False)
        self.table_widget.verticalHeader().setVisible(False)
        self.table_widget.verticalScrollBar().setVisible(True)
        self.table_widget.horizontalHeader().setStretchLastSection(True)
        self.table_widget.setHorizontalHeaderLabels(['ID', 'Имя', 'Фамилия', 'Страна', 'Город', 'Адрес',
                                                     'Дата рождения', 'Телефон'])
        all_db = people_data_base.get_all_data()
        self.table_widget.setRowCount(len(all_db))
        row = 0
        for num, value in enumerate(all_db):
            self.table_widget.setItem(row, 0, QTableWidgetItem(str(value[0])))
            self.table_widget.setItem(row, 1, QTableWidgetItem(value[1]))
            self.table_widget.setItem(row, 2, QTableWidgetItem(value[2]))
            self.table_widget.setItem(row, 3, QTableWidgetItem(value[3]))
            self.table_widget.setItem(row, 4, QTableWidgetItem(value[4]))
            self.table_widget.setItem(row, 5, QTableWidgetItem(value[5]))
            self.table_widget.setItem(row, 6, QTableWidgetItem(value[6]))
            self.table_widget.setItem(row, 7, QTableWidgetItem(value[7]))
            row += 1

        return self.table_widget

    @staticmethod
    def close_app():
        people_data_base.close_db()
        sys.exit(app.exec())


if __name__ == '__main__':
    app = QApplication(sys.argv)

    people_data_base = PeopleDB()
    people_data_base.create_db()
    people_data_base.create_table('people')

    main_window = MainWindow()

    main_window.show()
    sys.exit(app.exec())
