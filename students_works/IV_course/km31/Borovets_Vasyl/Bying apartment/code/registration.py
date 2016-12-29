# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'registration.ui'
#
# Created: Mon Dec 12 13:33:25 2016
#      by: PyQt5 UI code generator 5.0
#
# WARNING! All changes made in this file will be lost!
from check import chek_password, chek_login, chek_name, chek_email
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QMessageBox
from data_function import seller_registration, customer_registration
# from PyQt5.QtWidgets import QWidget, QMessageBox, QApplication

class Ui_Dialog(object):
    def setupUi(self, Dialog):
        self.ui_dialog=Dialog
        Dialog.setObjectName("Dialog")
        Dialog.resize(400, 370)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        Dialog.setWindowIcon(icon)
        self.log = QtWidgets.QLineEdit(Dialog)
        self.log.setGeometry(QtCore.QRect(100, 60, 161, 20))
        self.log.setObjectName("log")
        self.email = QtWidgets.QLineEdit(Dialog)
        self.email.setGeometry(QtCore.QRect(100, 140, 161, 20))
        self.email.setObjectName("email")
        self.pass1 = QtWidgets.QLineEdit(Dialog)
        self.pass1.setGeometry(QtCore.QRect(100, 180, 161, 20))
        self.pass1.setEchoMode(QtWidgets.QLineEdit.Password)
        self.pass1.setObjectName("pass1")
        self.name = QtWidgets.QLineEdit(Dialog)
        self.name.setGeometry(QtCore.QRect(100, 100, 161, 20))
        self.name.setObjectName("name")
        self.pass2 = QtWidgets.QLineEdit(Dialog)
        self.pass2.setGeometry(QtCore.QRect(100, 220, 161, 20))
        self.pass2.setEchoMode(QtWidgets.QLineEdit.Password)
        self.pass2.setObjectName("pass2")
        self.label = QtWidgets.QLabel(Dialog)
        self.label.setGeometry(QtCore.QRect(100, 40, 101, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label.setFont(font)
        self.label.setObjectName("label")
        self.label_2 = QtWidgets.QLabel(Dialog)
        self.label_2.setGeometry(QtCore.QRect(100, 80, 120, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_2.setFont(font)
        self.label_2.setObjectName("label_2")
        self.label_3 = QtWidgets.QLabel(Dialog)
        self.label_3.setGeometry(QtCore.QRect(100, 120, 101, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_3.setFont(font)
        self.label_3.setObjectName("label_3")
        self.label_4 = QtWidgets.QLabel(Dialog)
        self.label_4.setGeometry(QtCore.QRect(100, 160, 101, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_4.setFont(font)
        self.label_4.setObjectName("label_4")
        self.label_5 = QtWidgets.QLabel(Dialog)
        self.label_5.setGeometry(QtCore.QRect(100, 200, 111, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_5.setFont(font)
        self.label_5.setObjectName("label_5")
        self.label_6 = QtWidgets.QLabel(Dialog)
        self.label_6.setGeometry(QtCore.QRect(100, 240, 101, 20))
        font = QtGui.QFont()
        font.setPointSize(10)
        self.label_6.setFont(font)
        self.label_6.setObjectName("label_6")
        self.radioButton = QtWidgets.QRadioButton(Dialog)
        self.radioButton.setGeometry(QtCore.QRect(100, 260, 82, 17))
        self.radioButton.setObjectName("radioButton")
        self.radioButton_2 = QtWidgets.QRadioButton(Dialog)
        self.radioButton_2.setGeometry(QtCore.QRect(150, 260, 82, 17))
        self.radioButton_2.setObjectName("radioButton_2")
        self.pushButton = QtWidgets.QPushButton(Dialog)
        self.pushButton.setGeometry(QtCore.QRect(100, 280, 75, 23))
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(Dialog)
        self.pushButton_2.setGeometry(QtCore.QRect(180, 280, 75, 23))
        self.pushButton_2.setObjectName("pushButton_2")
        self.label_7 = QtWidgets.QLabel(Dialog)
        self.label_7.setGeometry(QtCore.QRect(120, 0, 121, 31))
        font = QtGui.QFont()
        font.setPointSize(14)
        self.label_7.setFont(font)
        self.label_7.setObjectName("label_7")
        self.pushButton.clicked.connect(self.reg_click)
        self.pushButton_2.clicked.connect(self.exit_click)
        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)
    def reg_click(self):
        # shost is a QString object

        if (chek_login(self.log.text())==False):
            QMessageBox.information(self.ui_dialog, 'Error', "Login input error")

        elif (chek_name(self.name.text())==False):
            QMessageBox.information(self.ui_dialog, 'Error', "Surname and name input error")

        elif (chek_email(self.email.text()) == False):
            QMessageBox.information(self.ui_dialog, 'Error', "Email input error")

        elif (chek_password(self.pass1.text())==True and self.pass1.text()==self.pass2.text()):
            QMessageBox.information(self.ui_dialog, 'Error', "Password input error")
        elif (self.radioButton.isChecked()==False and self.radioButton_2.isChecked()==False):
            QMessageBox.information(self.ui_dialog, 'Error', "Role input error")
        else:
            if  self.radioButton.isChecked() == True :
                try:
                    seller_registration(self.log.text(),self.name.text(), self.email.text(),self.pass1.text())
                    QMessageBox.information(self.ui_dialog, 'Error', "Seller created")
                    self.ui_dialog.close()
                except:
                    QMessageBox.information(self.ui_dialog, 'Error', "DataBase error")
            if  self.radioButton_2.isChecked() == True :
                try:
                    customer_registration(self.log.text(),self.name.text(), self.email.text(),self.pass1.text())
                    QMessageBox.information(self.ui_dialog, 'Error', "Customer created")
                    self.ui_dialog.close()

                except:
                    QMessageBox.information(self.ui_dialog, 'Error', "DataBase error")

    def exit_click (self):
        self.ui_dialog.close()

    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Registration"))
        self.label.setText(_translate("Dialog", "Login:"))
        self.label_2.setText(_translate("Dialog", "Surname and name:"))
        self.label_3.setText(_translate("Dialog", "E-mail:"))
        self.label_4.setText(_translate("Dialog", "Password:"))
        self.label_5.setText(_translate("Dialog", "Repeat password:"))
        self.label_6.setText(_translate("Dialog", "You are:"))
        self.radioButton.setText(_translate("Dialog", "Seller"))
        self.radioButton_2.setText(_translate("Dialog", "Customer"))
        self.pushButton.setText(_translate("Dialog", "Ok"))
        self.pushButton_2.setText(_translate("Dialog", "Cancel"))
        self.label_7.setText(_translate("Dialog", "Registration"))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Dialog = QtWidgets.QDialog()
    ui = Ui_Dialog()
    ui.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())

