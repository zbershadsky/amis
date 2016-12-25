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
class Ui_Login(object):

    def setupUi(self, Login):
        self.log= Login
        
        Login.setObjectName("Login")
        Login.resize(301, 140)
        Login.setMaximumSize(QtCore.QSize(301, 140))
        Login.setWindowIcon(Login.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        self.label_Email = QtWidgets.QLabel(Login)
        self.label_Email.setGeometry(QtCore.QRect(20, 40, 41, 21))
        self.label_Email.setObjectName("label_Email")

        self.line_email = QtWidgets.QLineEdit(Login)
        self.line_email.setGeometry(QtCore.QRect(90, 40, 191, 20))
        self.line_email.setObjectName("line_email")
        self.line_email.setText('')

        self.label_Password = QtWidgets.QLabel(Login)
        self.label_Password.setGeometry(QtCore.QRect(20, 70, 51, 21))
        self.label_Password.setObjectName("label_2")

        self.User_Password = QtWidgets.QLineEdit(Login)
        self.User_Password.setGeometry(QtCore.QRect(90, 70, 191, 20))
        self.User_Password.setObjectName("User_Password")
        self.User_Password.setEchoMode(QtWidgets.QLineEdit.Password)
        self.User_Password.setText('')

        self.commandLinkButton = QtWidgets.QCommandLinkButton(Login)
        self.commandLinkButton.setGeometry(QtCore.QRect(200, 0, 91, 41))
        font = QtGui.QFont()
        font.setFamily("Segoe UI")
        font.setPointSize(10)
        self.commandLinkButton.setFont(font)
        self.commandLinkButton.setObjectName("commandLinkButton")
        self.commandLinkButton.clicked.connect(self.Sign_buttonClicked)

        self.Button_Submit = QtWidgets.QPushButton(Login)
        self.Button_Submit.setGeometry(QtCore.QRect(210, 100, 75, 23))
        self.Button_Submit.setMaximumSize(QtCore.QSize(75, 16777215))
        self.Button_Submit.setObjectName("Button_Submit")
        self.Button_Submit.clicked.connect(self.buttonClicked)

        self.retranslateUi(Login)
        QtCore.QMetaObject.connectSlotsByName(Login)

    def retranslateUi(self, Login):
        _translate = QtCore.QCoreApplication.translate
        Login.setWindowTitle(_translate("Login", "Login"))
        self.label_Email.setText(_translate("Login", "E-mail:"))
        self.label_Password.setText(_translate("Login", "Password:"))
        self.commandLinkButton.setText(_translate("Login", "Sign up"))
        self.Button_Submit.setText(_translate("Login", "Submit"))

    def Sign_buttonClicked(self):
        from Registration import Ui_Registration
        Registration = QtWidgets.QWidget()
        self.ui = Ui_Registration()
        self.ui.setupUi(Registration)
        Registration.show()

        self.line_email.clear()
        self.User_Password.clear()

        self.log.close()

    def buttonClicked(self):

        h = hashlib.md5(self.User_Password.text().encode())
        Hash_Password = h.hexdigest()

        if check.check_email(self.line_email.text()) == False and self.line_email.text() == "":
            buttonReply = QtWidgets.QMessageBox.warning(self.log, 'Error', "E-mail field is empty!",
                                                             QtWidgets.QMessageBox.Ok)

        elif check.check_password(self.User_Password.text()) == False and self.User_Password.text() == "":
            buttonReply = QtWidgets.QMessageBox.warning(self.log, 'Error', "Password field is empty!",
                                                             QtWidgets.QMessageBox.Ok)


        elif check.check_email(self.line_email.text()) == False:
            buttonReply = QtWidgets.QMessageBox.warning(self.log, 'Error', "Wrong format of e-mail!",
                                                         QtWidgets.QMessageBox.Ok)

        elif check.check_password(self.User_Password.text()) == False:
            buttonReply = QtWidgets.QMessageBox.warning(self.log, 'Error', "Wrong format of password!"
                                                                       "Right: length: 8-16 values",
                                                         QtWidgets.QMessageBox.Ok)

        else:
            cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
            cursor.execute('''SELECT RTRIM(EMAIL), RTRIM(PASSWORD), RTRIM(USER_ROLE)
                              FROM AUTHORISATION
                              WHERE RTRIM(EMAIL) = :email
                              AND RTRIM(PASSWORD) = :password''',email = self.line_email.text(), password = Hash_Password)
            result = cursor.fetchall()
            connection.commit()

            if len(result)==0:
                buttonReply = QtWidgets.QMessageBox.warning(self.log, 'Error', "Wrong e-mail or password!",
                                                             QtWidgets.QMessageBox.Ok)
            else:

                from mainWindow import Ui_MainWindow
                self.MainWindow = QtWidgets.QMainWindow()
                self.ui = Ui_MainWindow()
                self.ui.send_log(self.send_log())
                self.ui.setupUi(self.MainWindow)
                self.MainWindow.show()
                self.line_email.clear()
                self.User_Password.clear()
                self.log.close()

    def send_log(self):
        return self.line_email.text()

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Login = QtWidgets.QWidget()
    ui = Ui_Login()
    ui.setupUi(Login)
    Login.show()
    sys.exit(app.exec_())

