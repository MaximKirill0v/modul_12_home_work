# Form implementation generated from reading ui file 'main_window.ui'
#
# Created by: PyQt6 UI code generator 6.4.2
#
# WARNING: Any manual changes made to this file will be lost when pyuic6 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt6 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(580, 640)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Policy.Maximum, QtWidgets.QSizePolicy.Policy.Maximum)
        sizePolicy.setHorizontalStretch(52)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(MainWindow.sizePolicy().hasHeightForWidth())
        MainWindow.setSizePolicy(sizePolicy)
        MainWindow.setMinimumSize(QtCore.QSize(580, 639))
        MainWindow.setMaximumSize(QtCore.QSize(580, 640))
        MainWindow.setCursor(QtGui.QCursor(QtCore.Qt.CursorShape.ArrowCursor))
        MainWindow.setMouseTracking(False)
        MainWindow.setFocusPolicy(QtCore.Qt.FocusPolicy.NoFocus)
        MainWindow.setStyleSheet(
            "background-color:qlineargradient(spread:pad, x1:0.134423, y1:0.187, x2:0.935323, y2:0.909, stop:0 rgba(74, 0, 255, 255), stop:1 rgba(229, 30, 204, 255))")
        self.centralwidget = QtWidgets.QWidget(parent=MainWindow)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Policy.Preferred, QtWidgets.QSizePolicy.Policy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.centralwidget.sizePolicy().hasHeightForWidth())
        self.centralwidget.setSizePolicy(sizePolicy)
        self.centralwidget.setObjectName("centralwidget")
        self.frame = QtWidgets.QFrame(parent=self.centralwidget)
        self.frame.setGeometry(QtCore.QRect(90, 30, 391, 581))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Policy.Maximum, QtWidgets.QSizePolicy.Policy.Maximum)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.frame.sizePolicy().hasHeightForWidth())
        self.frame.setSizePolicy(sizePolicy)
        self.frame.setStyleSheet("background-color: none;")
        self.frame.setObjectName("frame")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.frame)
        self.verticalLayout.setSizeConstraint(QtWidgets.QLayout.SizeConstraint.SetMaximumSize)
        self.verticalLayout.setObjectName("verticalLayout")
        self.btn_insert = QtWidgets.QPushButton(parent=self.frame)
        self.btn_insert.setStyleSheet("QPushButton{\n"
                                      "color:white;\n"
                                      "background-color: rgba(255,255,255,30);\n"
                                      "border:1px solid rgba(255,255,255,40);\n"
                                      "border-radius: 7px;\n"
                                      "width:400px;\n"
                                      "height:90px;\n"
                                      "font: 12pt \"Berlin Sans FB\";\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:hover{\n"
                                      "background-color:rgba(255,255,255,40);\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:pressed{\n"
                                      "background-color:rgba(255,255,255,70);\n"
                                      "}")
        self.btn_insert.setObjectName("btn_insert")
        self.verticalLayout.addWidget(self.btn_insert)
        self.btn_delete = QtWidgets.QPushButton(parent=self.frame)
        self.btn_delete.setStyleSheet("QPushButton{\n"
                                      "color:white;\n"
                                      "background-color: rgba(255,255,255,30);\n"
                                      "border:1px solid rgba(255,255,255,40);\n"
                                      "border-radius: 7px;\n"
                                      "width:400px;\n"
                                      "height:90px;\n"
                                      "font: 12pt \"Berlin Sans FB\";\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:hover{\n"
                                      "background-color:rgba(255,255,255,40);\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:pressed{\n"
                                      "background-color:rgba(255,255,255,70);\n"
                                      "}")
        self.btn_delete.setObjectName("btn_delete")
        self.verticalLayout.addWidget(self.btn_delete)
        self.btn_update = QtWidgets.QPushButton(parent=self.frame)
        self.btn_update.setStyleSheet("QPushButton{\n"
                                      "color:white;\n"
                                      "background-color: rgba(255,255,255,30);\n"
                                      "border:1px solid rgba(255,255,255,40);\n"
                                      "border-radius: 7px;\n"
                                      "width:400px;\n"
                                      "height:90px;\n"
                                      "font: 12pt \"Berlin Sans FB\";\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:hover{\n"
                                      "background-color:rgba(255,255,255,40);\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:pressed{\n"
                                      "background-color:rgba(255,255,255,70);\n"
                                      "}")
        self.btn_update.setObjectName("btn_update")
        self.verticalLayout.addWidget(self.btn_update)
        self.btn_filter = QtWidgets.QPushButton(parent=self.frame)
        self.btn_filter.setStyleSheet("QPushButton{\n"
                                      "color:white;\n"
                                      "background-color: rgba(255,255,255,30);\n"
                                      "border:1px solid rgba(255,255,255,40);\n"
                                      "border-radius: 7px;\n"
                                      "width:400px;\n"
                                      "height:90px;\n"
                                      "font: 12pt \"Berlin Sans FB\";\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:hover{\n"
                                      "background-color:rgba(255,255,255,40);\n"
                                      "}\n"
                                      "\n"
                                      "QPushButton:pressed{\n"
                                      "background-color:rgba(255,255,255,70);\n"
                                      "}")
        self.btn_filter.setObjectName("btn_filter")
        self.verticalLayout.addWidget(self.btn_filter)
        self.btn_show_all_db = QtWidgets.QPushButton(parent=self.frame)
        self.btn_show_all_db.setStyleSheet("QPushButton{\n"
                                           "color:white;\n"
                                           "background-color: rgba(255,255,255,30);\n"
                                           "border:1px solid rgba(255,255,255,40);\n"
                                           "border-radius: 7px;\n"
                                           "width:400px;\n"
                                           "height:90px;\n"
                                           "font: 12pt \"Berlin Sans FB\";\n"
                                           "}\n"
                                           "\n"
                                           "QPushButton:hover{\n"
                                           "background-color:rgba(255,255,255,40);\n"
                                           "}\n"
                                           "\n"
                                           "QPushButton:pressed{\n"
                                           "background-color:rgba(255,255,255,70);\n"
                                           "}")
        self.btn_show_all_db.setObjectName("btn_show_all_db")
        self.verticalLayout.addWidget(self.btn_show_all_db)
        self.btn_exit = QtWidgets.QPushButton(parent=self.frame)
        self.btn_exit.setEnabled(True)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.btn_exit.sizePolicy().hasHeightForWidth())
        self.btn_exit.setSizePolicy(sizePolicy)
        self.btn_exit.setStyleSheet("QPushButton{\n"
                                    "color:white;\n"
                                    "background-color: rgba(255,255,255,30);\n"
                                    "border:1px solid rgba(255,255,255,40);\n"
                                    "border-radius: 7px;\n"
                                    "width:400px;\n"
                                    "height:90px;\n"
                                    "font: 12pt \"Berlin Sans FB\";\n"
                                    "}\n"
                                    "\n"
                                    "QPushButton:hover{\n"
                                    "background-color:rgba(255,255,255,40);\n"
                                    "}\n"
                                    "\n"
                                    "QPushButton:pressed{\n"
                                    "background-color:rgba(255,255,255,70);\n"
                                    "}")
        self.btn_exit.setObjectName("btn_exit")
        self.verticalLayout.addWidget(self.btn_exit)
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        MainWindow.setTabOrder(self.btn_update, self.btn_delete)
        MainWindow.setTabOrder(self.btn_delete, self.btn_filter)
        MainWindow.setTabOrder(self.btn_filter, self.btn_show_all_db)
        MainWindow.setTabOrder(self.btn_show_all_db, self.btn_exit)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "People Data Base"))
        self.btn_insert.setText(_translate("MainWindow", "Добавить пользователя в БД"))
        self.btn_delete.setText(_translate("MainWindow", "Удалить пользователя из БД"))
        self.btn_update.setText(_translate("MainWindow", "Обновить данные пользователя"))
        self.btn_filter.setText(_translate("MainWindow", "Выборка по фильтрам из БД"))
        self.btn_show_all_db.setText(_translate("MainWindow", "Вывод всей БД"))
        self.btn_exit.setText(_translate("MainWindow", "Выход"))

