# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'seller.ui'
#
# Created: Mon Dec 19 01:16:12 2016
#      by: PyQt5 UI code generator 5.0
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

from add_apartment import Ui_add_apartment
from add_bookmarks_functin import del_apart
from book_view import show_apartment
from edit_apartment import Ui_edit_apartment
from PyQt5.QtWidgets import QMessageBox

from seller_function import show_seller_book


class Ui_seller_page(object):

    def setupUi(self, seller_page):

        self.seller = seller_page
        seller_page.setObjectName("seller_page")
        seller_page.resize(400, 370)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        seller_page.setWindowIcon(icon)
        self.add_but = QtWidgets.QPushButton(seller_page)
        self.add_but.setGeometry(QtCore.QRect(290, 40, 75, 23))
        self.add_but.setObjectName("add_but")
        self.Edit_but = QtWidgets.QPushButton(seller_page)
        self.Edit_but.setGeometry(QtCore.QRect(290, 70, 75, 23))
        self.Edit_but.setObjectName("Edit_but")
        self.del_but = QtWidgets.QPushButton(seller_page)
        self.del_but.setGeometry(QtCore.QRect(290, 100, 75, 23))
        self.del_but.setObjectName("del_but")
        self.apart_list = QtWidgets.QListWidget(seller_page)
        self.apart_list.setGeometry(QtCore.QRect(10, 40, 256, 131))
        self.apart_list.setObjectName("apart_list")
        self.label = QtWidgets.QLabel(seller_page)
        self.label.setGeometry(QtCore.QRect(10, 20, 101, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.Exit_but = QtWidgets.QPushButton(seller_page)
        self.Exit_but.setGeometry(QtCore.QRect(290, 310, 75, 23))
        self.Exit_but.setObjectName("Exit_but")
        self.label_2 = QtWidgets.QLabel(seller_page)
        self.label_2.setGeometry(QtCore.QRect(10, 180, 131, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.book_list = QtWidgets.QListWidget(seller_page)
        self.book_list.setGeometry(QtCore.QRect(10, 200, 256, 161))
        self.book_list.setObjectName("book_list")



        self.retranslateUi(seller_page)
        QtCore.QMetaObject.connectSlotsByName(seller_page)

        self.add_but.clicked.connect(self.add_func)
        self.Edit_but.clicked.connect(self.edit_func)
        self.del_but.clicked.connect(self.del_func)
        self.Exit_but.clicked.connect(self.ex)


        for rez in show_seller_book(self.login):
            a = rez[0]
            a=a.ljust(40, ' ')
            self.book_list.addItem( a+ rez[1] )

        for rezult in show_apartment(self.login):
            self.apart_list.addItem(rezult[0])

    def ex(self):
        self.seller.close()

    def del_func(self):
        del_apart(self.apart_list.currentItem().text())

    def edit_func(self):
        if bool(self.apart_list.currentItem()) == True :
            self.add_apartment = QtWidgets.QDialog()
            self.ui = Ui_edit_apartment()
            self.ui.send_log(self.send_log())
            self.ui.send_title(self.send_title())
            self.ui.setupUi(self.add_apartment)
            self.add_apartment.show()
        elif bool(self.apart_list.currentItem()) == False :
            QMessageBox.information(self.seller, 'Error', "You choose not an apartment")

    def add_func(self):

        self.add_apartment = QtWidgets.QDialog()
        self.ui = Ui_add_apartment()
        self.ui.send_log(self.send_log())
        self.ui.setupUi(self.add_apartment)
        self.add_apartment.show()

    def retranslateUi(self, seller_page):
        _translate = QtCore.QCoreApplication.translate

        seller_page.setWindowTitle(_translate("seller_page", "Seller page"))
        self.add_but.setText(_translate("seller_page", "Add"))
        self.Edit_but.setText(_translate("seller_page", "Edit"))
        self.del_but.setText(_translate("seller_page", "Delete"))
        self.label.setText(_translate("seller_page", "My Apartments:"))
        self.Exit_but.setText(_translate("seller_page", "Exit"))
        self.label_2.setText(_translate("seller_page", "Popular apartments:"))


    def get_login(self, login):
        self.login = login

    def send_log(self):
        return self.login

    def send_title(self):
        return self.apart_list.currentItem().text()


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    seller_page = QtWidgets.QDialog()
    ui = Ui_seller_page()
    ui.setupUi(seller_page)
    seller_page.show()
    sys.exit(app.exec_())

