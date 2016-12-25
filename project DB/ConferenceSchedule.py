import datetime
from PyQt5 import QtCore, QtGui, QtWidgets

try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()

connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')
cursor = connection.cursor()

class Ui_Schedule(object):

    def setupUi(self, Schedule):

        self.Shed = Schedule
        self.values = self.list

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(USER_ROLE)
                          FROM AUTHORISATION
                           WHERE RTRIM(EMAIL) = :email''', email = self.values[0])
        connection.commit()
        User_role = cursor.fetchall()[0][0]

        Schedule.resize(798, 535)
        Schedule.setMaximumSize(QtCore.QSize(798, 535))
        Schedule.setWindowIcon(Schedule.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        groupBox_Filter = QtWidgets.QGroupBox(Schedule)
        groupBox_Filter.setGeometry(QtCore.QRect(10, 140, 771, 51))
        groupBox_Filter.setTitle("Filter")

        self.comboBox_Filter = QtWidgets.QComboBox(groupBox_Filter)
        self.comboBox_Filter.setGeometry(QtCore.QRect(10, 20, 191, 22))
        self.comboBox_Filter.addItem("Speech Title")
        self.comboBox_Filter.addItem("Author")
        self.comboBox_Filter.addItem("Time of speech")

        Button_SearchSpeech = QtWidgets.QPushButton(groupBox_Filter)
        Button_SearchSpeech.setGeometry(QtCore.QRect(220, 20, 75, 23))
        Button_SearchSpeech.setText("Filter")
        Button_SearchSpeech.clicked.connect(self.Button_SearchSpeechClicked)

        result = self.createTable()

        self.tableView_Conferences = QtWidgets.QTableWidget(Schedule)
        self.tableView_Conferences.setGeometry(QtCore.QRect(10, 200, 771, 291))
        self.tableView_Conferences.setObjectName("tableView_Conferences")

        self.tableView_Conferences.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
        self.tableView_Conferences.setColumnCount(len(result[0]))
        self.tableView_Conferences.setRowCount(len(result))
        insert = self.insertValues(self.createTable())

        header = self.tableView_Conferences.horizontalHeader()
        header.setStretchLastSection(True)

        groupBox_Speech = QtWidgets.QGroupBox(Schedule)
        groupBox_Speech.setGeometry(QtCore.QRect(10, 80, 771, 61))
        groupBox_Speech.setTitle("Speech")

        Button_NewSpeech = QtWidgets.QPushButton(groupBox_Speech)
        Button_NewSpeech.setGeometry(QtCore.QRect(10, 20, 75, 23))
        Button_NewSpeech.setText("New")
        Button_NewSpeech.clicked.connect(self.NewSpeech_buttonClicked)

        Button_EditSpeech = QtWidgets.QPushButton(groupBox_Speech)
        Button_EditSpeech.setGeometry(QtCore.QRect(90, 20, 75, 23))
        Button_EditSpeech.setText("Edit")
        Button_EditSpeech.clicked.connect(self.EditSpeech_buttonClicked)

        self.Button_RefreshConference = QtWidgets.QPushButton(groupBox_Speech)
        self.Button_RefreshConference.setGeometry(QtCore.QRect(680, 20, 75, 23))
        self.Button_RefreshConference.setText("Refresh")
        self.Button_RefreshConference.clicked.connect(self.Button_RefreshConference_buttonClicked)

        groupBox_BuyTicket = QtWidgets.QGroupBox(Schedule)
        groupBox_BuyTicket.setGeometry(QtCore.QRect(10, 20, 771, 61))
        groupBox_BuyTicket.setTitle("Buy Ticket")

        Button_BuyTicket = QtWidgets.QPushButton(groupBox_BuyTicket)
        Button_BuyTicket.setGeometry(QtCore.QRect(10, 20, 111, 23))
        Button_BuyTicket.setText("Buy Ticket")
        Button_BuyTicket.clicked.connect(self.Button_BuyTicketClicked)

        Button_Back = QtWidgets.QPushButton(Schedule)
        Button_Back.setGeometry(QtCore.QRect(700, 500, 75, 23))
        Button_Back.setText("Back")
        Button_Back.clicked.connect(self.buttonClicked)

        if User_role != 'ADMIN':
            Button_NewSpeech.hide()
            Button_EditSpeech.hide()

        self.retranslateUi(Schedule)
        QtCore.QMetaObject.connectSlotsByName(Schedule)

    def createTable(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TIME), RTRIM(TITLE), RTRIM(AUTHOR)
                        FROM SPEECH_INFO
                        WHERE  TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place
                        ''',
                       datetime = str(self.values[1][2]), place = str(self.values[1][3]))
        result = cursor.fetchall()
        connection.commit()
        return result

    def insertValues(self, func):
        self.resultConf = func
        self.tableView_Conferences.setRowCount(len(self.resultConf))
        self.tableView_Conferences.setHorizontalHeaderLabels(["Time", "Speech Title", "Author Name"])
        for row in range(len(self.resultConf)):
            for j in range(0, len(self.resultConf[0])):
                Item = QtWidgets.QTableWidgetItem("{}".format(self.resultConf[row][j]))
                Item.setFlags(QtCore.Qt.ItemIsSelectable |  QtCore.Qt.ItemIsEnabled)
                self.tableView_Conferences.setItem(row, j, Item)

    def Button_RefreshConference_buttonClicked(self):
        self.tableView_Conferences.clearContents()
        self.insertValues(self.createTable())

    def EditSpeech_buttonClicked(self):
        if self.tableView_Conferences.currentRow() == -1:
            buttonReply = QtWidgets.QMessageBox.warning(self.Shed, 'Error', "You did not choose!",
                                                             QtWidgets.QMessageBox.Ok)
        else:
            import ViewEditSpeech
            self.items = self.resultConf[self.tableView_Conferences.currentRow()]
            self.ViewEditSpeech = ViewEditSpeech.Ui_EditSpeech(self.items)
            self.ViewEditSpeech.exec_()

    def Button_SearchSpeechClicked(self):

        if self.comboBox_Filter.currentText() == "Time of speech":
            time = self.insertValues(self.Filter_Time())

        elif self.comboBox_Filter.currentText() == "Author":
            author = self.insertValues(self.Filter_Author())

        else:
            title = self.insertValues(self.Filter_Title())

    def Filter_Time(self):
          cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
          cursor.execute('''SELECT RTRIM(TIME), RTRIM(TITLE), RTRIM(AUTHOR)
                        FROM SPEECH_INFO
                        WHERE  TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place
                        ORDER BY RTRIM(TIME)''',
                         datetime = str(self.values[1][2]), place = str(self.values[1][3]))
          result = cursor.fetchall()
          connection.commit()
          return result

    def Filter_Author(self):
         cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
         cursor.execute('''SELECT RTRIM(TIME), RTRIM(TITLE), RTRIM(AUTHOR)
                        FROM SPEECH_INFO
                        WHERE  TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place
                        ORDER BY RTRIM(AUTHOR)''',
                         datetime = str(self.values[1][2]), place = str(self.values[1][3]))
         result = cursor.fetchall()
         connection.commit()
         return result

    def Filter_Title(self):
         cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
         cursor.execute('''SELECT RTRIM(TIME), RTRIM(TITLE), RTRIM(AUTHOR)
                        FROM SPEECH_INFO
                        WHERE  TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place
                        ORDER BY RTRIM(TITLE)''',
                         datetime = str(self.values[1][2]), place = str(self.values[1][3]))
         result = cursor.fetchall()
         connection.commit()
         return result

    def NewSpeech_buttonClicked(self):
        import NewSpeech
        self.New_Speech = NewSpeech.Ui_NewSpeech(self.values)
        self.New_Speech.exec_()

    def Button_BuyTicketClicked(self):

        if self.values[1][2]< str(datetime.datetime.now()):
             buttonReply = QtWidgets.QMessageBox.warning(self.Shed, 'Error', "Conference already passed!",
                                                             QtWidgets.QMessageBox.Ok)
        else:

            from BuyTicket import Ui_BuyTicket
            self.BuyTicket = QtWidgets.QMainWindow()
            self.ui = Ui_BuyTicket()
            self.ui.send_conf_val(self.send_conf_val())
            self.ui.setupUi(self.BuyTicket)
            self.BuyTicket.show()
            self.Shed.close()

    def buttonClicked(self):
        from mainWindow import Ui_MainWindow
        self.MainWindow = QtWidgets.QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.send_log(self.send_log())
        self.ui.setupUi(self.MainWindow)
        self.MainWindow.show()
        self.Shed.close()

    def send_log(self):
        return(self.list[0])

    def retranslateUi(self, Schedule):
        _translate = QtCore.QCoreApplication.translate
        Schedule.setWindowTitle(_translate("Schedule", "Conference"))

    def send_val(self,list):
        self.list = list

    def send_conf_val(self):
        return self.values

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Schedule = QtWidgets.QWidget()
    ui = Ui_Schedule()
    ui.setupUi(Schedule)
    Schedule.show()
    sys.exit(app.exec_())

