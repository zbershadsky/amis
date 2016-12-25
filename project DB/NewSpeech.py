import sys
from PyQt5 import QtCore, QtGui, QtWidgets
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

class Ui_NewSpeech(QtWidgets.QDialog):
    
    def __init__(self, values):
        super().__init__()

        self.values = values
        self.setWindowTitle("Create New Speech")
        self.resize(381, 150)
        self.setMaximumSize(QtCore.QSize(381, 150))
        self.setWindowIcon(self.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))
        
        label_Speech_Title = QtWidgets.QLabel(self)
        label_Speech_Title.setGeometry(QtCore.QRect(20, 20, 62, 21))
        label_Speech_Title.setText("Speech Title*")
        
        self.Speech_Title = QtWidgets.QLineEdit(self)
        self.Speech_Title.setGeometry(QtCore.QRect(100, 20, 261, 20))
        self.Speech_Title.setMaxLength(200)
        self.Speech_Title.setText("")
        
        label_Author = QtWidgets.QLabel(self)
        label_Author.setGeometry(QtCore.QRect(20, 50, 71, 16))
        label_Author.setText("Author e-mail*")
        
        self.Speech_author_email = QtWidgets.QLineEdit(self)
        self.Speech_author_email.setGeometry(QtCore.QRect(100, 50, 261, 20))
        self.Speech_author_email.setMaxLength(200)
        self.Speech_author_email.setText("")
        
        label_Speech_Time = QtWidgets.QLabel(self)
        label_Speech_Time.setGeometry(QtCore.QRect(20, 80, 81, 16))
        label_Speech_Time.setText("Time of speech*")
        
        self.Speech_Time = QtWidgets.QTimeEdit(self)
        self.Speech_Time.setGeometry(QtCore.QRect(110, 80, 251, 22))

        button_Cancel = QtWidgets.QDialogButtonBox(self)
        button_Cancel.setGeometry(QtCore.QRect(290, 110, 75, 23))
        button_Cancel.setStandardButtons(QtWidgets.QDialogButtonBox.Cancel)
        button_Cancel.rejected.connect(self.reject)

        button_Ok = QtWidgets.QPushButton(self)
        button_Ok.setGeometry(QtCore.QRect(210, 110, 75, 23))
        button_Ok.setText("Ok")
        button_Ok.clicked.connect(self.button_Ok_Clicked)


    def button_Ok_Clicked(self):
         if check.check_Title(self.Speech_Title.text()) == False:
             if self.Speech_Title.text() == "":
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Title field is empty!",
                                                              QtWidgets.QMessageBox.Ok)
             else:
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Wrong format of title! "
                                                                            "Right: with a capital letter "
                                                                            "or number",
                                                              QtWidgets.QMessageBox.Ok)
         elif check.check_email(self.Speech_author_email.text()) == False:
             if self.Speech_author_email.text() == "":
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Email field is empty!",
                                                              QtWidgets.QMessageBox.Ok)
             else:
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Wrong format of email! ",
                                                              QtWidgets.QMessageBox.Ok)
         else:
             cursor.execute('''SELECT RTRIM(TIME), RTRIM(AUTHOR)
                               FROM SPEECH_ACTION
                               WHERE RTRIM(AUTHOR)=:email AND RTRIM(TIME) = :times''',
                                email = self.Speech_author_email.text(),
                                times = self.Speech_Time.text())
             result = cursor.fetchall()


             if len(result)>0 and result[0][0] == '':
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Such author does not exist in system!",
                                                              QtWidgets.QMessageBox.Ok)

             elif len(result)>0 and result[0][1] != '':
                 buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "Speech at this time existis!",
                                                              QtWidgets.QMessageBox.Ok)
             else:
                 cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
                 cursor.execute('''SELECT RTRIM(USER_ROLE)
                                    FROM AUTHORISATION
                                    WHERE RTRIM(EMAIL) = :email''', email = self.Speech_author_email.text())
                 role = cursor.fetchall()[0][0]
                 connection.commit()
                 if role != 'SPEAKER':

                     buttonReply = QtWidgets.QMessageBox.warning(self, 'Error', "User is not speaker!",
                                                              QtWidgets.QMessageBox.Ok)

                 else:
                    cursor.execute('''SET TRANSACTION ISOLATION LEVEL SERIALIZABLE''')
                    cursor.execute('''INSERT INTO SPEECH_ACTION(TIME, TITLE, DATETIME, PLACE, AUTHOR)
                                    VALUES(:time, :title, TO_DATE(:datetime, 'dd.mm.yyyy hh24:mi'),
                                    :place, :email)
                                     ''', time = self.Speech_Time.text(), title = self.Speech_Title.text(),
                                        datetime = self.values[1][2], place = self.values[1][3], email = self.values[0])
                    connection.commit()

                    self.close()



if __name__=='__main__':
    import sys
    app = QtWidgets.QApplication(sys.argv)
    ui = Ui_NewSpeech()
    ui.show()
    sys.exit(app.exec_())

