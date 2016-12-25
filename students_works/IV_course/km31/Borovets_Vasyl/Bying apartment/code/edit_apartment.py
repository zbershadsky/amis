# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'add_apartment.ui'
#
# Created: Sat Dec 24 02:01:02 2016
#      by: PyQt5 UI code generator 5.0
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QMessageBox

from add_bookmarks_functin import street_only, title_only
from seller_function import show_apart, edit_apartments
from check import *

class Ui_edit_apartment(object):
    def setupUi(self, add_apartment):
        self.win = add_apartment
        show_apartment = show_apart(self.login, self.title)
        self.edit_apart = add_apartment
        add_apartment.setObjectName("add_apartment")
        add_apartment.resize(400, 300)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        add_apartment.setWindowIcon(icon)
        self.city_ed = QtWidgets.QLineEdit(add_apartment)
        self.city_ed.setGeometry(QtCore.QRect(130, 90, 113, 20))
        self.city_ed.setObjectName("city_ed")
        self.street_ed = QtWidgets.QLineEdit(add_apartment)
        self.street_ed.setGeometry(QtCore.QRect(130, 120, 113, 20))
        self.street_ed.setObjectName("street_ed")
        self.flat_ed = QtWidgets.QLineEdit(add_apartment)
        self.flat_ed.setGeometry(QtCore.QRect(130, 180, 113, 20))
        self.flat_ed.setObjectName("flat_ed")
        self.home_ed = QtWidgets.QLineEdit(add_apartment)
        self.home_ed.setGeometry(QtCore.QRect(130, 150, 113, 20))
        self.home_ed.setObjectName("home_ed")
        self.label = QtWidgets.QLabel(add_apartment)
        self.label.setGeometry(QtCore.QRect(70, 90, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(add_apartment)
        self.label_2.setGeometry(QtCore.QRect(70, 120, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.label_3 = QtWidgets.QLabel(add_apartment)
        self.label_3.setGeometry(QtCore.QRect(70, 150, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_3.setFont(font)
        self.label_3.setObjectName("label_3")
        self.label_4 = QtWidgets.QLabel(add_apartment)
        self.label_4.setGeometry(QtCore.QRect(70, 210, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_4.setFont(font)
        self.label_4.setObjectName("label_4")
        self.label_5 = QtWidgets.QLabel(add_apartment)
        self.label_5.setGeometry(QtCore.QRect(70, 180, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_5.setFont(font)
        self.label_5.setObjectName("label_5")
        self.price_ed = QtWidgets.QLineEdit(add_apartment)
        self.price_ed.setGeometry(QtCore.QRect(130, 210, 113, 20))
        self.price_ed.setObjectName("price_ed")
        self.ok_but = QtWidgets.QPushButton(add_apartment)
        self.ok_but.setGeometry(QtCore.QRect(100, 250, 75, 23))
        self.ok_but.setObjectName("ok_but")
        self.cantl_but = QtWidgets.QPushButton(add_apartment)
        self.cantl_but.setGeometry(QtCore.QRect(200, 250, 75, 23))
        self.cantl_but.setObjectName("cantl_but")
        self.label_6 = QtWidgets.QLabel(add_apartment)
        self.label_6.setGeometry(QtCore.QRect(110, 10, 171, 16))
        font = QtGui.QFont()
        font.setPointSize(14)
        self.label_6.setFont(font)
        self.label_6.setObjectName("label_6")
        self.label_7 = QtWidgets.QLabel(add_apartment)
        self.label_7.setGeometry(QtCore.QRect(70, 30, 46, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_7.setFont(font)
        self.label_7.setObjectName("label_7")
        self.title_ed = QtWidgets.QLineEdit(add_apartment)
        self.title_ed.setGeometry(QtCore.QRect(130, 30, 113, 20))
        self.title_ed.setObjectName("title_ed")
        self.title_ed_2 = QtWidgets.QLineEdit(add_apartment)
        self.title_ed_2.setGeometry(QtCore.QRect(130, 60, 113, 20))
        self.title_ed_2.setText("")
        self.title_ed_2.setObjectName("title_ed_2")
        self.label_8 = QtWidgets.QLabel(add_apartment)
        self.label_8.setGeometry(QtCore.QRect(20, 60, 111, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_8.setFont(font)
        self.label_8.setObjectName("label_8")
        self.label_9 = QtWidgets.QLabel(add_apartment)
        self.label_9.setGeometry(QtCore.QRect(250, 60, 111, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_9.setFont(font)
        self.label_9.setObjectName("label_9")

        self.title_ed.insert(show_apartment[0][0])
        self.title_ed_2.insert(show_apartment[0][2])
        self.city_ed.insert(show_apartment[0][3])
        self.street_ed.insert(show_apartment[0][4])
        self.home_ed.insert(show_apartment[0][5])
        self.flat_ed.insert(show_apartment[0][6])
        self.price_ed.insert(str(show_apartment[0][7]))

        self.ok_but.clicked.connect(self.update)
        self.cantl_but.clicked.connect(self.ex)
        self.retranslateUi(add_apartment)

    def ex(self):
        self.win.close()

    def update(self):
        if (check_title(self.title_ed.text()) == False):

            QMessageBox.information(self.win, 'Error', "Title input error")

        elif check_cadastr(self.title_ed_2.text()) == False:

            QMessageBox.information(self.win, 'Error', "Cadastre number input error")

        elif chek_city(self.city_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "City input error")

        elif chek_street(self.street_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "Street input error")

        elif check_home(self.home_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "Home input error")

        elif check_flat(self.flat_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "Flat input error")

        elif chek_input_price(self.price_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "Price input error")
        elif street_only(self.city_ed.text(), self.street_ed.text(), self.home_ed.text(), self.flat_ed.text()) == False:
            QMessageBox.information(self.win, 'Error', "You can not use this adress")

        elif title_only(self.title_ed.text()) == False:

            QMessageBox.information(self.win, 'Error', "Title error")

        else:
            try:
                edit_apartments(self.title, self.title_ed.text(),self.login,self.title_ed_2.text(),self.city_ed.text(),
                            self.street_ed.text(), self.home_ed.text(), self.flat_ed.text(), self.price_ed.text())
                QMessageBox.information(self.edit_apart, 'Success', "Apartment updated")
                self.edit_apart.close()

            except:
                QMessageBox.information(self.edit_apart, 'Error', "DataBase error")

    def send_log(self, login):
        self.login = login

    def send_title(self, title):
        self.title = title
 

    def retranslateUi(self, add_apartment):
        _translate = QtCore.QCoreApplication.translate
        add_apartment.setWindowTitle(_translate("add_apartment", "ADD APARTMENT"))
        self.label.setText(_translate("add_apartment", "City:"))
        self.label_2.setText(_translate("add_apartment", "Street:"))
        self.label_3.setText(_translate("add_apartment", "Home:"))
        self.label_4.setText(_translate("add_apartment", "Price:"))
        self.label_5.setText(_translate("add_apartment", "Flat:"))
        self.ok_but.setText(_translate("add_apartment", "OK"))
        self.cantl_but.setText(_translate("add_apartment", "CANCEL"))
        self.label_6.setText(_translate("add_apartment", "EDIT APARTMENT"))
        self.label_7.setText(_translate("add_apartment", "Title:"))
        self.label_8.setText(_translate("add_apartment", "Cadastre number"))
        self.label_9.setText(_translate("add_apartment", "XXXXXX:XX:XXX:XXXX"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    add_apartment = QtWidgets.QDialog()
    ui = Ui_edit_apartment()
    ui.setupUi(add_apartment)
    add_apartment.show()
    sys.exit(app.exec_())

