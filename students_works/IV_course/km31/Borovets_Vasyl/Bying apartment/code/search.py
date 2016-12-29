# -*- coding: utf-8 -*-
from PyQt5 import QtCore, QtGui, QtWidgets
from info import Ui_information_page

from seller_function import search_function
from  add_bookmarks_functin import addbook
from book import Ui_book_page
from check import chek_price, chek_city
from PyQt5.QtWidgets import QMessageBox

class Ui_custom_search(object):

    def setupUi(self, custom_search):
        self.Custom = custom_search
        # print(self.login)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        custom_search.setWindowIcon(icon)
        custom_search.setObjectName("custom_search")
        custom_search.resize(400, 370)
        self.label_2 = QtWidgets.QLabel(custom_search)
        self.label_2.setGeometry(QtCore.QRect(10, 10, 31, 21))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.label_4 = QtWidgets.QLabel(custom_search)
        self.label_4.setGeometry(QtCore.QRect(210, 10, 71, 21))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_4.setFont(font)
        self.label_4.setObjectName("label_4")
        self.minPrice = QtWidgets.QLineEdit(custom_search)
        self.minPrice.setGeometry(QtCore.QRect(280, 10, 41, 20))
        self.minPrice.setObjectName("minPrice")
        self.label_5 = QtWidgets.QLabel(custom_search)
        self.label_5.setGeometry(QtCore.QRect(330, 10, 41, 21))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_5.setFont(font)
        self.label_5.setObjectName("label_5")
        self.maxPrice = QtWidgets.QLineEdit(custom_search)
        self.maxPrice.setGeometry(QtCore.QRect(350, 10, 41, 20))
        self.maxPrice.setObjectName("maxPrice")
        self.listWidget = QtWidgets.QListWidget(custom_search)
        self.listWidget.setGeometry(QtCore.QRect(130, 110, 261, 241))
        self.listWidget.setObjectName("listWidget")

        self.search_but = QtWidgets.QPushButton(custom_search)
        self.search_but.setGeometry(QtCore.QRect(320, 60, 75, 23))
        self.search_but.setObjectName("search_but")
        self.label_6 = QtWidgets.QLabel(custom_search)
        self.label_6.setGeometry(QtCore.QRect(130, 90, 71, 21))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_6.setFont(font)
        self.label_6.setObjectName("label_6")
        self.city = QtWidgets.QLineEdit(custom_search)
        self.city.setGeometry(QtCore.QRect(80, 10, 111, 20))
        self.city.setObjectName("city")
        self.add = QtWidgets.QPushButton(custom_search)
        self.add.setGeometry(QtCore.QRect(10, 150, 101, 21))
        self.add.setObjectName("add")
        self.exit_but = QtWidgets.QPushButton(custom_search)
        self.exit_but.setGeometry(QtCore.QRect(20, 330, 75, 23))
        self.exit_but.setObjectName("exit_but")
        self.pushButton = QtWidgets.QPushButton(custom_search)
        self.pushButton.setGeometry(QtCore.QRect(10, 180, 101, 23))
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(custom_search)
        self.pushButton_2.setGeometry(QtCore.QRect(10, 120, 101, 23))
        self.pushButton_2.setObjectName("pushButton_2")
        self.search_but.clicked.connect(self.add_listbox)
        self.add.clicked.connect(self.add_book)
        self.pushButton_2.clicked.connect(self.show_info)
        self.exit_but.clicked.connect(self.ex)
        self.pushButton.clicked.connect(self.open_book)
        self.retranslateUi(custom_search)
        QtCore.QMetaObject.connectSlotsByName(custom_search)

    def ex(self):
        self.Custom.close()

    def show_info(self):
        if bool(self.listWidget.currentItem()) == True:
            self.information_page = QtWidgets.QDialog()
            self.ui = Ui_information_page()
            self.ui.get_title(self.get_title())
            self.ui.setupUi(self.information_page)
            self.information_page.show()
        elif bool(self.listWidget.currentItem()) == False:
            QMessageBox.information(self.Custom, 'Error', "You choose not apartment")

    def open_book(self):

            self.book_page = QtWidgets.QDialog()
            self.ui = Ui_book_page()
            self.ui.send_login(self.send_login())
            self.ui.setupUi(self.book_page)
            self.book_page.show()

    def add_listbox(self):
        if (bool(self.city.text())==bool(self.minPrice.text())==bool(self.maxPrice.text())==False):
            self.listWidget.clear()
            for rezult in search_function(self.city.text(), self.minPrice.text(), self.maxPrice.text()):
                self.listWidget.addItem(rezult[0])

        elif (chek_city(self.city.text())==chek_price(self.minPrice.text(),self.maxPrice.text())==True):

            self.listWidget.clear()
            for rezult in  search_function(self.city.text(),self.minPrice.text(),self.maxPrice.text()):
                self.listWidget.addItem(rezult[0])
        else:
            QMessageBox.information(self.Custom, 'Error', "Input error")

    def add_book(self):
        if bool(self.listWidget.currentItem()) == True:
            addbook(self.listWidget.currentItem().text(), self.login)
        elif bool(self.listWidget.currentItem()) == False:
            QMessageBox.information(self.Custom, 'Error', "You choose not apartment")



    def retranslateUi(self, custom_search):
        _translate = QtCore.QCoreApplication.translate
        custom_search.setWindowTitle(_translate("custom_search", "Customer page"))
        self.label_2.setText(_translate("custom_search", "City:"))
        self.label_4.setText(_translate("custom_search", "Price from:"))
        self.label_5.setText(_translate("custom_search", "to"))
        self.search_but.setText(_translate("custom_search", "Search"))
        self.label_6.setText(_translate("custom_search", "Result:"))
        self.add.setText(_translate("custom_search", "Add to bookmarks"))
        self.exit_but.setText(_translate("custom_search", "Exit"))
        self.pushButton.setText(_translate("custom_search", "My bookmarks"))
        self.pushButton_2.setText(_translate("custom_search", "Show information"))
    def get_login(self, login):
        self.login = login

    def   get_title(self):
        return self.listWidget.currentItem().text()

    def send_login(self):
        return self.login

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    custom_search = QtWidgets.QDialog()
    ui = Ui_custom_search()
    ui.setupUi(custom_search)
    custom_search.show()
    sys.exit(app.exec_())

