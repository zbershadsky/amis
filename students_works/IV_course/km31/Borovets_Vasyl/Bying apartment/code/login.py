# -*- coding: utf-8 -*-

import sys
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QMessageBox

from search import Ui_custom_search
from seller import Ui_seller_page
from registration import Ui_Dialog
from check import chek_login, chek_password
from data_function import autorization_seller, autorization_customer

class Ui_Login_input(object):
    def setupUi(self, Login_input):
        self.login_input = Login_input
        Login_input.setObjectName("Login_input")
        Login_input.resize(400, 371)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Login_input.setWindowIcon(icon)
        self.login = QtWidgets.QLineEdit(Login_input)
        self.login.setGeometry(QtCore.QRect(110, 90, 151, 20))
        self.login.setObjectName("login")

        self.password_edit = QtWidgets.QLineEdit(Login_input)
        self.password_edit.setGeometry(QtCore.QRect(110, 130, 151, 20))
        self.password_edit.setEchoMode(QtWidgets.QLineEdit.Password)
        self.password_edit.setObjectName("password_edit")
        self.label = QtWidgets.QLabel(Login_input)
        self.label.setGeometry(QtCore.QRect(110, 70, 71, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(Login_input)
        self.label_2.setGeometry(QtCore.QRect(110, 110, 71, 16))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.Seller = QtWidgets.QRadioButton(Login_input)
        self.Seller.setGeometry(QtCore.QRect(110, 160, 82, 17))
        self.Seller.setObjectName("Seller")
        self.Customer = QtWidgets.QRadioButton(Login_input)
        self.Customer.setGeometry(QtCore.QRect(160, 160, 82, 17))
        self.Customer.setObjectName("Customer")
        self.pushButton = QtWidgets.QPushButton(Login_input)
        self.pushButton.setGeometry(QtCore.QRect(190, 190, 75, 23))
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(Login_input)
        self.pushButton_2.setGeometry(QtCore.QRect(110, 190, 75, 23))
        self.pushButton_2.setObjectName("pushButton_2")
        self.pushButton_2.clicked.connect(self.button_click)
        self.pushButton.clicked.connect(self.button_click_registration)

        self.retranslateUi(Login_input)
        QtCore.QMetaObject.connectSlotsByName(Login_input)

    def button_click(self):

        if (chek_login( self.login.text())==False):
            QMessageBox.information(self.login_input, 'Error', "Login input error")

        elif (chek_password(self.password_edit.text())==False):
            QMessageBox.information(self.login_input, 'Error', "Password input error")

        elif self.Seller.isChecked()== self.Customer.isChecked()==False :
            QMessageBox.information(self.login_input, 'Error', "You do not choose the role")

        if ((self.Seller.isChecked()==True)
                 and (autorization_seller(self.login.text(),self.password_edit.text())) == True):

            self.seller_page = QtWidgets.QDialog()
            self.ui = Ui_seller_page()
            self.ui.get_login(self.get_login())
            self.ui.setupUi(self.seller_page)
            self.login_input.close()
            self.seller_page.show()

        elif((self.Seller.isChecked()==True)
                 and (autorization_seller(self.login.text(),self.password_edit.text())) != True):
            QMessageBox.information(self.login_input, 'Error', "User not found")

        if (self.Customer.isChecked() == True
                and (autorization_customer(self.login.text(),self.password_edit.text())) == True) :
            self.custom_search = QtWidgets.QDialog()
            self.ui = Ui_custom_search()
            self.ui.get_login(self.get_login())
            self.ui.setupUi(self.custom_search)
            self.login_input.close()
            self.custom_search.show()
        elif(self.Customer.isChecked() == True
                and (autorization_customer(self.login.text(),self.password_edit.text())) != True) :
            QMessageBox.information(self.login_input, 'Error', "User not found")

    def get_login(self):
        return self.login.text()


    def button_click_registration(self):

        # self.reg = QtWidgets.QApplication()

        self.Dialog = QtWidgets.QDialog()
        self.ui = Ui_Dialog()
        self.ui.setupUi(self.Dialog)
        self.login_input.close()
        self.Dialog.show()
        self.Dialog.exec()
        self.login_input.show()


    def retranslateUi(self, Login_input):
        _translate = QtCore.QCoreApplication.translate
        Login_input.setWindowTitle(_translate("Login_input", "Login page"))
        self.label.setText(_translate("Login_input", "Login:"))
        self.label_2.setText(_translate("Login_input", "Password:"))
        self.Seller.setText(_translate("Login_input", "Seller"))
        self.Customer.setText(_translate("Login_input", "Customer"))
        self.pushButton.setText(_translate("Login_input", "Sing Up"))
        self.pushButton_2.setText(_translate("Login_input", "Login"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Login_input = QtWidgets.QDialog()
    ui = Ui_Login_input()
    ui.setupUi(Login_input)
    Login_input.show()
    sys.exit(app.exec_())

