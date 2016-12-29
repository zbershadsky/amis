from PyQt5 import QtCore, QtGui, QtWidgets
import sys
import check


try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()

connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')
cursor = connection.cursor()

class Ui_EditProfile(QtWidgets.QDialog):


    def __init__(self, values):
        super().__init__()

        self.values = values

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL SERIALIZABLE''')
        cursor.execute('''SELECT RTRIM(UNAME), RTRIM(SURNAME), RTRIM(PHONE)
                          FROM AUTHORISATION
                          WHERE RTRIM(EMAIL) = :email''', email = self.values)
        result = cursor.fetchall()
        connection.commit()

        self.setWindowTitle("Edit Profile")
        self.resize(301, 183)
        self.setMaximumSize(QtCore.QSize(301, 183))
        self.setWindowIcon(self.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon)) 

        label_Name = QtWidgets.QLabel(self)
        label_Name.setGeometry(QtCore.QRect(20, 20, 47, 21))
        label_Name.setText("Name:")
        
        self.User_Name = QtWidgets.QLineEdit(self)
        self.User_Name.setGeometry(QtCore.QRect(90, 20, 191, 20))
        self.User_Name.setText(result[0][0])

        label_Surname = QtWidgets.QLabel(self)
        label_Surname.setGeometry(QtCore.QRect(20, 50, 47, 21))
        label_Surname.setText("Surname")
        
        self.User_Surname = QtWidgets.QLineEdit(self)
        self.User_Surname.setGeometry(QtCore.QRect(90, 50, 191, 20))
        self.User_Surname.setText(result[0][1])

        label_Phone = QtWidgets.QLabel(self)
        label_Phone.setGeometry(QtCore.QRect(20, 80, 47, 21))
        label_Phone.setText("Phone:")

        self.User_Phone = QtWidgets.QLineEdit(self)
        self.User_Phone.setGeometry(QtCore.QRect(90, 80, 191, 20))
        self.User_Phone.setText(result[0][2])

        ButtonBox = QtWidgets.QDialogButtonBox(self)
        ButtonBox.setGeometry(QtCore.QRect(130, 150, 75, 23))
        ButtonBox.setStandardButtons(QtWidgets.QDialogButtonBox.Cancel)
        ButtonBox.rejected.connect(self.reject)

        self.ButtonBox = QtWidgets.QPushButton(self)
        self.ButtonBox.setGeometry(QtCore.QRect(210, 150, 75, 23))
        self.ButtonBox.setText("Save")
        self.ButtonBox.clicked.connect(self.Clicked_buttonBox)

    def Clicked_buttonBox(self):
        sender = self.sender()

        if sender.text() == "Save":

            if check.check_Name(self.User_Name.text())==False:
                if self.User_Name.text() == "":
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Name field is empty!",
                                                              QtWidgets.QMessageBox.Ok)
                else:
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Wrong format of name! "
                                                                     "Right: with a capital letter, "
                                                                     "without spaces",
                                                              QtWidgets.QMessageBox.Ok)

            elif check.check_Surname(self.User_Surname.text()) == False:
                if self.User_Surname.text() == "":
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Surname field is empty!",
                                                              QtWidgets.QMessageBox.Ok)
                else:
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Wrong format of surname! "
                                                                     "Right: with a capital letter, "
                                                                     "without spaces",
                                                              QtWidgets.QMessageBox.Ok)
            elif check.check_Phone(self.User_Phone.text()) == False:
                if self.User_Phone.text() == "":
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Phone field is empty! ",
                                                              QtWidgets.QMessageBox.Ok)
                else:
                    buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Wrong format of phone! "
                                                                     "Right: length: 9-10 values",
                                                              QtWidgets.QMessageBox.Ok)
            else:
                cursor.execute('''SET TRANSACTION ISOLATION LEVEL SERIALIZABLE''')
                Insert_Values = '''UPDATE AUTHORISATION
                                   SET UNAME = :uname, SURNAME = :surname, PHONE = :phone
                                    WHERE RTRIM(EMAIL)=:email'''
                cursor.execute(Insert_Values, uname = self.User_Name.text(),
                                    surname = self.User_Surname.text(),
                                    phone = self.User_Phone.text(),
                                   email = self.values)
                connection.commit()
                self.close()

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    ui = Ui_EditProfile()
    ui.show()
    sys.exit(app.exec_())

