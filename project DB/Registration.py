
from PyQt5 import QtCore, QtGui, QtWidgets
import hashlib
import check
import sys

try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()

connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')
cursor = connection.cursor()

class Ui_Registration(object):

    def setupUi(self, Registration):

        self.Registration = Registration

        Registration.setObjectName("Registration")
        Registration.resize(323, 286)
        Registration.setMaximumSize(QtCore.QSize(323, 286))
        Registration.setWindowIcon(Registration.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        self.label_Password = QtWidgets.QLabel(Registration)
        self.label_Password.setGeometry(QtCore.QRect(20, 70, 51, 21))
        self.label_Password.setObjectName("label_Password")

        self.label_Confirm_Password = QtWidgets.QLabel(Registration)
        self.label_Confirm_Password.setGeometry(QtCore.QRect(20, 100, 91, 21))
        self.label_Confirm_Password.setObjectName("label_Confirm_Password")

        self.User_Confirm_Password = QtWidgets.QLineEdit(Registration)
        self.User_Confirm_Password.setGeometry(QtCore.QRect(120, 100, 191, 20))
        self.User_Confirm_Password.setEchoMode(QtWidgets.QLineEdit.Password)
        self.User_Confirm_Password.setMaxLength(16)

        self.label_Email = QtWidgets.QLabel(Registration)
        self.label_Email.setGeometry(QtCore.QRect(20, 40, 41, 21))
        self.label_Email.setObjectName("label_Email")

        self.User_Email = QtWidgets.QLineEdit(Registration)
        self.User_Email.setGeometry(QtCore.QRect(120, 40, 191, 20))
        self.User_Email.setObjectName("User_Email")
        self.User_Email.setMaxLength(255)

        self.commandLinkButton = QtWidgets.QCommandLinkButton(Registration)
        self.commandLinkButton.setGeometry(QtCore.QRect(220, 0, 91, 41))
        font = QtGui.QFont()
        font.setFamily("Segoe UI")
        font.setPointSize(10)
        self.commandLinkButton.setFont(font)
        self.commandLinkButton.setObjectName("commandLinkButton")
        self.commandLinkButton.clicked.connect(self.Login_buttonClicked)

        self.User_Password = QtWidgets.QLineEdit(Registration)
        self.User_Password.setGeometry(QtCore.QRect(120, 70, 191, 20))
        self.User_Password.setObjectName("User_Password")
        self.User_Password.setEchoMode(QtWidgets.QLineEdit.Password)
        self.User_Password.setMaxLength(16)

        self.label_Name = QtWidgets.QLabel(Registration)
        self.label_Name.setGeometry(QtCore.QRect(20, 130, 47, 21))
        self.label_Name.setObjectName("label_Name")

        self.User_Name = QtWidgets.QLineEdit(Registration)
        self.User_Name.setGeometry(QtCore.QRect(120, 130, 191, 20))
        self.User_Name.setObjectName("User_Name")
        self.User_Name.setMaxLength(50)

        self.User_Surname = QtWidgets.QLineEdit(Registration)
        self.User_Surname.setGeometry(QtCore.QRect(120, 160, 191, 20))
        self.User_Surname.setObjectName("User_Surname")

        self.label_Surname = QtWidgets.QLabel(Registration)
        self.label_Surname.setGeometry(QtCore.QRect(20, 160, 47, 21))
        self.label_Surname.setObjectName("label_Surname")
        self.User_Surname.setMaxLength(50)

        self.User_Phone = QtWidgets.QLineEdit(Registration)
        self.User_Phone.setGeometry(QtCore.QRect(120, 190, 191, 20))
        self.User_Phone.setObjectName("User_Phone")
        self.User_Phone.setMaxLength(10)

        self.label_Phone = QtWidgets.QLabel(Registration)
        self.label_Phone.setGeometry(QtCore.QRect(20, 190, 47, 21))
        self.label_Phone.setObjectName("label_Phone")

        self.radioButton_Role_Visitor = QtWidgets.QRadioButton(Registration)
        self.radioButton_Role_Visitor.setGeometry(QtCore.QRect(30, 220, 82, 17))
        self.radioButton_Role_Visitor.setObjectName("Visitor")
        self.radioButton_Role_Visitor.setChecked(True)

        self.radioButton_Role_Speaker = QtWidgets.QRadioButton(Registration)
        self.radioButton_Role_Speaker.setGeometry(QtCore.QRect(120, 220, 82, 17))
        self.radioButton_Role_Speaker.setObjectName("Speaker")

        self.radioButton_Role_Admin = QtWidgets.QRadioButton(Registration)
        self.radioButton_Role_Admin.setGeometry(QtCore.QRect(210, 220, 82, 17))
        self.radioButton_Role_Admin.setObjectName("Admin")

        self.Button_Submit = QtWidgets.QPushButton(Registration)
        self.Button_Submit.setGeometry(QtCore.QRect(230, 250, 75, 23))
        self.Button_Submit.setMaximumSize(QtCore.QSize(75, 16777215))
        self.Button_Submit.setObjectName("Button_Submit")
        self.Button_Submit.clicked.connect(self.Submit_buttonClicked)

        self.retranslateUi(Registration)
        QtCore.QMetaObject.connectSlotsByName(Registration)


    def retranslateUi(self, Registration):
        _translate = QtCore.QCoreApplication.translate
        Registration.setWindowTitle(_translate("Registration", "Registration"))
        self.label_Password.setText(_translate("Registration", "Password:"))
        self.label_Email.setText(_translate("Registration", "E-mail:"))
        self.commandLinkButton.setText(_translate("Registration", "Log in"))
        self.label_Confirm_Password.setText(_translate("Registration", "Confirm Password:"))
        self.label_Name.setText(_translate("Registration", "Name:"))
        self.label_Surname.setText(_translate("Registration", "Surname:"))
        self.label_Phone.setText(_translate("Registration", "Phone:"))
        self.Button_Submit.setText(_translate("Registration", "Submit"))
        self.radioButton_Role_Visitor.setText(_translate("Registration", "Visitor"))
        self.radioButton_Role_Speaker.setText(_translate("Registration", "Speaker"))
        self.radioButton_Role_Admin.setText(_translate("Registration", "Admin"))

    def radiobuttonChecked(self):
        if self.radioButton_Role_Visitor.isChecked() == True:
            return ("VISITOR")
        elif self.radioButton_Role_Speaker.isChecked() == True:
            return ("SPEAKER")
        else: return ("ADMIN")

    def Submit_buttonClicked(self):

        User_Role = self.radiobuttonChecked()
        h = hashlib.md5(self.User_Password.text().encode())
        Hash_Password = h.hexdigest()

        if check.check_email(self.User_Email.text()) == False:
            if self.User_Email.text() == "":
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "E-mail field is empty!",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Wrong format of e-mail!",
                                                          QtWidgets.QMessageBox.Ok)

        elif check.check_password(self.User_Password.text()) == False:
            print(self.User_Password.text())
            if self.User_Password.text() == "":
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Password field is empty!",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Wrong format of password! "
                                                                  "Right: length: 8-16 values",
                                                          QtWidgets.QMessageBox.Ok)

        elif self.User_Password.text() != self.User_Confirm_Password.text():
            buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Password is not confirmed!",
                                                          QtWidgets.QMessageBox.Ok)
            self.User_Password.clear()
            self.User_Confirm_Password.clear()

        elif check.check_Name(self.User_Name.text())==False:
            if self.User_Name.text() == "":
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Name field is empty!",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Wrong format of name! "
                                                                 "Right: with a capital letter, "
                                                                 "without spaces",
                                                          QtWidgets.QMessageBox.Ok)

        elif check.check_Surname(self.User_Surname.text()) == False:
            if self.User_Surname.text() == "":
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Surname field is empty!",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Wrong format of surname! "
                                                                 "Right: with a capital letter, "
                                                                 "without spaces",
                                                          QtWidgets.QMessageBox.Ok)
        elif check.check_Phone(self.User_Phone.text()) == False:
            if self.User_Phone.text() == "":
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Phone field is empty! ",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "Wrong format of phone! "
                                                                 "Right: length: 9-10 values",
                                                          QtWidgets.QMessageBox.Ok)
        else:
            cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
            cursor.execute(''' SELECT EMAIL
                              FROM AUTHORISATION
                              WHERE EMAIL=:email''', email = self.User_Email.text())
            c
            result = cursor.fetchall()
            if len(result) != 0:
                    buttonReply = QtWidgets.QMessageBox.warning(self.Registration, 'Error', "The e-mail is already in use! ",
                                                          QtWidgets.QMessageBox.Ok)
            else:
                Insert_Values = '''INSERT INTO AUTHORISATION
                                  VALUES (:email,:password,:uname,
                                  :surname,:phone, :role)
                                '''
                cursor.execute(Insert_Values,email = self.User_Email.text(),
                                    password = Hash_Password, uname = self.User_Name.text(),
                                    surname = self.User_Surname.text(), phone = self.User_Phone.text(),
                                    role = User_Role)
                connection.commit()
                from mainWindow import Ui_MainWindow
                self.MainWindow = QtWidgets.QMainWindow()
                self.ui = Ui_MainWindow()
                self.ui.send_log(self.send_log())
                self.ui.setupUi(self.MainWindow)
                self.MainWindow.show()
                self.Registration.close()

    def send_log(self):
        return self.User_Email.text()

    def Login_buttonClicked(self):
        self.User_Email.clear()
        self.User_Password.clear()
        self.User_Confirm_Password.clear()
        self.User_Name.clear()
        self.User_Surname.clear()
        self.User_Phone.clear()

        from Login import Ui_Login
        self.Login = QtWidgets.QMainWindow()
        self.ui = Ui_Login()
        self.ui.setupUi(self.Login)
        self.Login.show()
        self.Registration.close()

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Registration = QtWidgets.QWidget()
    ui = Ui_Registration()
    ui.setupUi(Registration)
    Registration.show()
    sys.exit(app.exec_())

