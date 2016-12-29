from PyQt5 import QtCore, QtGui, QtWidgets
import sys

import ViewEditSpeech

try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()

connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')

class Ui_MainWindow(object):

    def setupUi(self, MainWindow):

        self.Email = self.text
        self.Main = MainWindow

        self.result = self.User_Profile()

        self.Role = self.result[0][4]

        MainWindow.resize(798, 535)
        MainWindow.setWindowIcon(MainWindow.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))
        MainWindow.setWindowIcon(MainWindow.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        MainWindow.setMinimumSize(QtCore.QSize(798, 535))
        MainWindow.setMaximumSize(QtCore.QSize(798, 535))

        self.TabWidget = QtWidgets.QTabWidget(MainWindow)
        self.TabWidget.setGeometry(QtCore.QRect(0, 0, 801, 531))

        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Fixed, QtWidgets.QSizePolicy.Fixed)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.TabWidget.sizePolicy().hasHeightForWidth())

        self.TabWidget.setContextMenuPolicy(QtCore.Qt.DefaultContextMenu)
        self.TabWidget.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.TabWidget.setTabShape(QtWidgets.QTabWidget.Rounded)

        self.Conferences = QtWidgets.QWidget()
        self.Conferences.setObjectName("tab")

        resultTable = self.createTable()

        self.tableView_Conferences = QtWidgets.QTableWidget(self.Conferences)
        self.tableView_Conferences.setGeometry(QtCore.QRect(10, 150, 771, 341))
        self.tableView_Conferences.setObjectName("tableView_Conferences")

        self.tableView_Conferences.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
        self.tableView_Conferences.setColumnCount(len(resultTable[0]))
        self.tableView_Conferences.setRowCount(len(resultTable))
        insert = self.insertValues(self.createTable())

        header = self.tableView_Conferences.horizontalHeader()
        header.setStretchLastSection(True)


        self.groupBox_Filter = QtWidgets.QGroupBox(self.Conferences)
        self.groupBox_Filter.setGeometry(QtCore.QRect(10, 80, 771, 61))
        self.groupBox_Filter.setObjectName("Filter")

        self.comboBox_FilterConference = QtWidgets.QComboBox(self.groupBox_Filter)
        self.comboBox_FilterConference.setGeometry(QtCore.QRect(10, 20, 191, 22))
        self.comboBox_FilterConference.setObjectName("comboBox_FilterConference")
        self.comboBox_FilterConference.addItem("Title")
        self.comboBox_FilterConference.addItem("Theme")
        self.comboBox_FilterConference.addItem("Date")
        self.comboBox_FilterConference.addItem("Place")

        self.Button_SearchConference = QtWidgets.QPushButton(self.groupBox_Filter)
        self.Button_SearchConference.setGeometry(QtCore.QRect(210, 20, 75, 23))
        self.Button_SearchConference.setText("Filter")
        self.Button_SearchConference.clicked.connect(self.Button_SearchConference_buttonClicked)

        self.Button_RefreshConference = QtWidgets.QPushButton(self.groupBox_Filter)
        self.Button_RefreshConference.setGeometry(QtCore.QRect(680, 20, 75, 23))
        self.Button_RefreshConference.setText("Refresh")
        self.Button_RefreshConference.clicked.connect(self.Button_RefreshConference_buttonClicked)

        self.groupBox_Conference = QtWidgets.QGroupBox(self.Conferences)
        self.groupBox_Conference.setGeometry(QtCore.QRect(10, 10, 771, 61))
        self.groupBox_Conference.setObjectName("groupBox")

        self.Button_NewConference = QtWidgets.QPushButton(self.groupBox_Conference)
        self.Button_NewConference.setGeometry(QtCore.QRect(120, 20, 75, 23))
        self.Button_NewConference.setObjectName("Button_NewConference")
        self.Button_NewConference.clicked.connect(self.Button_NewConferenceClicked)

        self.Button_EditConference = QtWidgets.QPushButton(self.groupBox_Conference)
        self.Button_EditConference.setGeometry(QtCore.QRect(200, 20, 75, 23))
        self.Button_EditConference.setObjectName("Button_EditConference")
        self.Button_EditConference.clicked.connect(self.Button_EditConferenceClicked)

        self.Button_View = QtWidgets.QPushButton(self.groupBox_Conference)
        self.Button_View.setGeometry(QtCore.QRect(10, 20, 75, 23))
        self.Button_View.setObjectName("Button_View")
        self.Button_View.clicked.connect(self.Button_ViewClicked)

        line = QtWidgets.QFrame(self.groupBox_Conference)
        line.setGeometry(QtCore.QRect(90, 10, 20, 41))
        line.setFrameShape(QtWidgets.QFrame.VLine)
        line.setFrameShadow(QtWidgets.QFrame.Sunken)

        self.TabWidget.addTab(self.Conferences, "Conferences")

        self.Tickets = QtWidgets.QWidget()
        self.Tickets.setObjectName("tab_2")
        self.groupBox_Filter_Tickets = QtWidgets.QGroupBox(self.Tickets)
        self.groupBox_Filter_Tickets.setGeometry(QtCore.QRect(10, 10, 771, 61))
        self.groupBox_Filter_Tickets.setObjectName("groupBox_3")

        self.comboBox_FilterTickets = QtWidgets.QComboBox(self.groupBox_Filter_Tickets)
        self.comboBox_FilterTickets.setGeometry(QtCore.QRect(10, 20, 191, 21))
        self.comboBox_FilterTickets.setObjectName("comboBox_FilterTickets")
        self.comboBox_FilterTickets.addItem("Seat")
        self.comboBox_FilterTickets.addItem("Price")
        self.comboBox_FilterTickets.addItem("Date, Time")
        self.comboBox_FilterTickets.addItem("Place")

        self.Button_RefreshTickets = QtWidgets.QPushButton(self.groupBox_Filter_Tickets)
        self.Button_RefreshTickets.setGeometry(QtCore.QRect(680, 20, 75, 23))
        self.Button_RefreshTickets.setText("Refresh")
        self.Button_RefreshTickets.clicked.connect(self.Button_RefreshTicketsClicked)

        self.Button_Search_Tickets = QtWidgets.QPushButton(self.groupBox_Filter_Tickets)
        self.Button_Search_Tickets.setGeometry(QtCore.QRect(220, 20, 75, 23))
        self.Button_Search_Tickets.setObjectName("Filter")
        self.Button_Search_Tickets.clicked.connect(self.Button_Search_TicketsClicked)

        self.tableView_Tickets = QtWidgets.QTableWidget(self.Tickets)
        self.tableView_Tickets.setGeometry(QtCore.QRect(10, 80, 771, 411))

        resultTable = self.create_TicketsTable()

        if len(resultTable) >0:
            self.tableView_Tickets.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
            self.tableView_Tickets.setColumnCount(len(resultTable[0]))
            self.tableView_Tickets.setRowCount(len(resultTable))
            insert = self.insertValues_TicketsTable(self.create_TicketsTable())

        header = self.tableView_Tickets.horizontalHeader()
        header.setStretchLastSection(True)

        self.TabWidget.addTab(self.Tickets, "Tickets")

        self.Profile = QtWidgets.QWidget()
        self.Profile.setObjectName("tab_3")
        self.groupBox_Profile = QtWidgets.QGroupBox(self.Profile)
        self.groupBox_Profile.setGeometry(QtCore.QRect(10, 10, 771, 71))
        self.groupBox_Profile.setTitle("Profile")

        self.Button_Edit_Profile = QtWidgets.QPushButton(self.groupBox_Profile)
        self.Button_Edit_Profile.setGeometry(QtCore.QRect(10, 30, 75, 23))
        self.Button_Edit_Profile.setObjectName("pushButton_2")
        self.Button_Edit_Profile.clicked.connect(self.Button_Edit_ProfileClicked)

        self.Button_Sign_Out = QtWidgets.QPushButton(self.groupBox_Profile)
        self.Button_Sign_Out.setGeometry(QtCore.QRect(100, 30, 75, 23))
        self.Button_Sign_Out.setObjectName("pushButton_3")
        self.Button_Sign_Out.clicked.connect(self.Button_Sign_OutClicked)

        self.Button_RefreshProfile = QtWidgets.QPushButton(self.groupBox_Profile)
        self.Button_RefreshProfile.setGeometry(QtCore.QRect(680, 30, 75, 23))
        self.Button_RefreshProfile.setText("Refresh")
        self.Button_RefreshProfile.clicked.connect(self.Button_ProfileRefreshClicked)

        self.groupBox_Profile_Information = QtWidgets.QGroupBox(self.Profile)
        self.groupBox_Profile_Information.setGeometry(QtCore.QRect(10, 90, 771, 401))
        self.groupBox_Profile_Information.setObjectName("groupBox_6")

        self.label_Email = QtWidgets.QLabel(self.groupBox_Profile_Information)
        self.label_Email.setGeometry(QtCore.QRect(240, 80, 41, 21))
        self.label_Email.setObjectName("label_3")

        self.User_Email = QtWidgets.QLineEdit(self.groupBox_Profile_Information)
        self.User_Email.setGeometry(QtCore.QRect(310, 80, 191, 20))
        self.User_Email.setText("{}".format(self.result[0][0]))
        self.User_Email.setReadOnly(True)
        self.User_Email.setAlignment(QtCore.Qt.AlignRight)

        self.label_Name = QtWidgets.QLabel(self.groupBox_Profile_Information)
        self.label_Name.setGeometry(QtCore.QRect(240, 110, 47, 21))
        self.label_Name.setObjectName("label_3")

        self.User_Name = QtWidgets.QLineEdit(self.groupBox_Profile_Information)
        self.User_Name.setGeometry(QtCore.QRect(310, 110, 191, 20))
        self.User_Name.setReadOnly(True)
        self.User_Name.setText("{}".format(self.result[0][1]))
        self.User_Name.setAlignment(QtCore.Qt.AlignRight)

        self.label_Surname = QtWidgets.QLabel(self.groupBox_Profile_Information)
        self.label_Surname.setGeometry(QtCore.QRect(240, 140, 47, 21))
        self.label_Surname.setObjectName("Surname4")

        self.User_Surname = QtWidgets.QLineEdit(self.groupBox_Profile_Information)
        self.User_Surname.setGeometry(QtCore.QRect(310, 140, 191, 20))
        self.User_Surname.setReadOnly(True)
        self.User_Surname.setText("{}".format(self.result[0][2]))
        self.User_Surname.setAlignment(QtCore.Qt.AlignRight)

        self.label_Phone = QtWidgets.QLabel(self.groupBox_Profile_Information)
        self.label_Phone.setGeometry(QtCore.QRect(240, 170, 47, 21))
        self.label_Phone.setObjectName("label_5")

        self.User_Phone = QtWidgets.QLineEdit(self.groupBox_Profile_Information)
        self.User_Phone.setGeometry(QtCore.QRect(310, 170, 191, 20))
        self.User_Phone.setText("{}".format(self.result[0][3]))
        self.User_Phone.setReadOnly(True)
        self.User_Phone.setAlignment(QtCore.Qt.AlignRight)

        self.label_Role = QtWidgets.QLabel(self.groupBox_Profile_Information)
        self.label_Role.setGeometry(QtCore.QRect(240, 200, 46, 21))
        self.label_Role.setText("Role:")

        self.User_Role = QtWidgets.QLineEdit(self.groupBox_Profile_Information)
        self.User_Role.setGeometry(QtCore.QRect(310, 200, 191, 20))
        self.User_Role.setText("{}".format(self.result[0][4]))
        self.User_Role.setReadOnly(True)
        self.User_Role.setAlignment(QtCore.Qt.AlignRight)

        self.TabWidget.addTab(self.Profile, "")

        self.retranslateUi(MainWindow)
        self.TabWidget.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

        if self.Role == 'VISITOR':
            self.Button_NewConference.hide()
            self.Button_EditConference.hide()

        elif self.Role == 'SPEAKER':

            self.Button_NewConference.hide()
            self.Button_EditConference.hide()

            self.User_Conferences = QtWidgets.QWidget()
            self.User_Conferences.setObjectName("tab_4")

            self.tableView_Author_Conferences = QtWidgets.QTableWidget(self.User_Conferences)
            self.tableView_Author_Conferences.setGeometry(QtCore.QRect(10, 80, 771, 411))

            resultTable = self.create_Conferences()

            if len(resultTable) >0:
                self.tableView_Author_Conferences.setSelectionBehavior(QtWidgets.QAbstractItemView.SelectRows)
                self.tableView_Author_Conferences.setColumnCount(len(resultTable[0]))
                self.tableView_Author_Conferences.setRowCount(len(resultTable))
                insert = self.insertValues_Conferences(self.create_Conferences())

            header = self.tableView_Author_Conferences.horizontalHeader()
            header.setStretchLastSection(True)

            self.groupBox_Filter_Author_Conferences = QtWidgets.QGroupBox(self.User_Conferences)
            self.groupBox_Filter_Author_Conferences.setGeometry(QtCore.QRect(10, 10, 771, 61))
            self.groupBox_Filter_Author_Conferences.setObjectName("groupBox_8")
            self.groupBox_Filter_Author_Conferences.setTitle("Filter")

            self.Button_RefreshUserConferences = QtWidgets.QPushButton(self.groupBox_Filter_Author_Conferences)
            self.Button_RefreshUserConferences.setGeometry(QtCore.QRect(680, 20, 75, 23))
            self.Button_RefreshUserConferences.setText("Refresh")
            self.Button_RefreshUserConferences.clicked.connect(self.Button_RefreshConferences)

            self.comboBox_Filter_Author_Conferences = QtWidgets.QComboBox(self.groupBox_Filter_Author_Conferences)
            self.comboBox_Filter_Author_Conferences.setGeometry(QtCore.QRect(10, 20, 191, 21))
            self.comboBox_Filter_Author_Conferences.setObjectName("comboBox_Filter_Author_Conferences")
            self.comboBox_Filter_Author_Conferences.addItem("Title")
            self.comboBox_Filter_Author_Conferences.addItem("Theme")
            self.comboBox_Filter_Author_Conferences.addItem("Place")
            self.comboBox_Filter_Author_Conferences.addItem("Date, Time")

            self.Button_Search_Author_Conferences = QtWidgets.QPushButton(self.groupBox_Filter_Author_Conferences)
            self.Button_Search_Author_Conferences.setGeometry(QtCore.QRect(220, 20, 75, 23))
            self.Button_Search_Author_Conferences.setObjectName("Button_SearchConference_3")
            self.Button_Search_Author_Conferences.setText("Filter")
            self.Button_Search_Author_Conferences.clicked.connect(self.Button_Search_Author_ConferencesClicked)
            self.Button_SearchConference.setText("Filter")

            self.TabWidget.addTab(self.User_Conferences, "My Conferences")

        else:
             self.line = QtWidgets.QFrame(self.groupBox_Conference)
             self.line.setGeometry(QtCore.QRect(90, 10, 20, 41))
             self.line.setFrameShape(QtWidgets.QFrame.VLine)
             self.line.setFrameShadow(QtWidgets.QFrame.Sunken)
             self.line.setObjectName("line")


    def send_log(self,text):
        self.text= text

    def send_val(self):
        return [self.result[0][0],self.resultConf[self.tableView_Conferences.currentRow()]]

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Organization of conference"))
        self.groupBox_Filter.setTitle(_translate("MainWindow", "Filter"))
        self.Button_SearchConference.setText(_translate("MainWindow", "Filter"))
        self.groupBox_Conference.setTitle(_translate("MainWindow", "Conference"))
        self.Button_NewConference.setText(_translate("MainWindow", "New"))
        self.Button_EditConference.setText(_translate("MainWindow", "View/Edit"))
        self.Button_View.setText(_translate("MainWindow", "Speech List"))
        self.TabWidget.setTabText(self.TabWidget.indexOf(self.Conferences), _translate("MainWindow", "Conferences"))
        self.groupBox_Filter.setTitle(_translate("MainWindow", "Filter"))
        self.Button_Search_Tickets.setText(_translate("MainWindow", "Filter"))
        self.TabWidget.setTabText(self.TabWidget.indexOf(self.Tickets), _translate("MainWindow", "Tickets"))
        self.groupBox_Profile.setTitle(_translate("MainWindow", "Profile"))
        self.Button_Edit_Profile.setText(_translate("MainWindow", "Edit"))
        self.Button_Sign_Out.setText(_translate("MainWindow", "Sign Out"))
        self.groupBox_Profile_Information.setTitle(_translate("MainWindow", "Profile Information"))
        self.label_Name.setText(_translate("MainWindow", "Name:"))
        self.label_Email.setText(_translate("MainWindow", "E-mail:"))
        self.label_Surname.setText(_translate("MainWindow", "Surname:"))
        self.label_Phone.setText(_translate("MainWindow", "Phone:"))
        self.label_Role.setText(_translate("MainWindow", "Role:"))
        self.TabWidget.setTabText(self.TabWidget.indexOf(self.Profile), _translate("MainWindow", "Profile"))

    def createTable(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE), RTRIM(PRICE), RTRIM(QUANTITY)
                        FROM CONFERENCE_ACTION''')
        connection.commit()
        resultTable = cursor.fetchall()
        return resultTable

    def insertValues(self, func):
        self.resultConf = func
        self.tableView_Conferences.setRowCount(len(self.resultConf))
        self.tableView_Conferences.setHorizontalHeaderLabels(["Title", "Theme", "Date, Time", "Place", "Price", "Quantity of seats"])
        for row in range(len(self.resultConf)):
            for j in range(0, len(self.resultConf[0])):
                Item = QtWidgets.QTableWidgetItem("{}".format(self.resultConf[row][j]))
                Item.setFlags(QtCore.Qt.ItemIsSelectable |  QtCore.Qt.ItemIsEnabled)
                self.tableView_Conferences.setItem(row, j, Item)

    def create_TicketsTable(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(SEAT), RTRIM(PRICE),
                       RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM tickets_present
                        WHERE rtrim(EMAIL) =:email''', email = self.Email)
        connection.commit()
        resultTickets = cursor.fetchall()
        return resultTickets

    def insertValues_TicketsTable(self, func):
        self.resultTickets = func
        self.tableView_Tickets.setRowCount(len(self.resultTickets))
        self.tableView_Tickets.setHorizontalHeaderLabels(["Seat №", "Price", "Conference Date", "Place"])
        for row in range(len(self.resultTickets)):
            for j in range(0, len(self.resultTickets[0])):
                Item = QtWidgets.QTableWidgetItem("{}".format(self.resultTickets[row][j]))
                Item.setFlags(QtCore.Qt.ItemIsSelectable |  QtCore.Qt.ItemIsEnabled)
                self.tableView_Tickets.setItem(row, j, Item)

    def create_Conferences(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM USER_CONFERENCES_PRESENT
                        WHERE rtrim(EMAIL) =:email''', email = self.Email)
        connection.commit()
        resultTickets = cursor.fetchall()
        return resultTickets

    def insertValues_Conferences(self, func):
        self.resultTickets = func
        self.tableView_Author_Conferences.setRowCount(len(self.resultTickets))
        self.tableView_Author_Conferences.setHorizontalHeaderLabels(["Title", "Theme", "Date", "Place"])
        for row in range(len(self.resultTickets)):
            for j in range(0, len(self.resultTickets[0])):
                Item = QtWidgets.QTableWidgetItem("{}".format(self.resultTickets[row][j]))
                Item.setFlags(QtCore.Qt.ItemIsSelectable |  QtCore.Qt.ItemIsEnabled)
                self.tableView_Author_Conferences.setItem(row, j, Item)

    def Button_RefreshConference_buttonClicked(self):
        self.tableView_Conferences.clearContents()
        self.insertValues(self.createTable())

    def Button_SearchConference_buttonClicked(self):

        if self.comboBox_FilterConference.currentText() == "Title":
            time = self.insertValues(self.Filter_Title())

        elif self.comboBox_FilterConference.currentText() == "Theme":
            author = self.insertValues(self.Filter_Theme())

        elif self.comboBox_FilterConference.currentText() == "Date":
            date = self.insertValues(self.Filter_Date())

        else:
            place = self.insertValues(self.Filter_Place())

    def Filter_Title(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(TITLE)''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_Theme(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(THEME)''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_Date(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_Place(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME),RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(PLACE)''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Button_NewConferenceClicked(self):
        import NewConference

        self.New_Conference = NewConference.Ui_CreateConference()
        self.New_Conference.exec_()

    def Button_EditConferenceClicked(self):
        if self.tableView_Conferences.currentRow() == -1:
            buttonReply = QtWidgets.QMessageBox.warning(self.Main, 'Error', "You did not choose!",
                                                             QtWidgets.QMessageBox.Ok)
        else:
            import EditConference
            self.Edit_Conference = EditConference.Ui_Edit_Conference(self.send_val())
            self.Edit_Conference.exec_()

    def Button_ViewClicked(self):

        if self.tableView_Conferences.currentRow() == -1:
            buttonReply = QtWidgets.QMessageBox.warning(self.Main, 'Error', "You did not choose!",
                                                             QtWidgets.QMessageBox.Ok)
        else:
            from ConferenceSchedule import Ui_Schedule
            self.Schedule = QtWidgets.QMainWindow()
            self.ui = Ui_Schedule()
            self.ui.send_val(self.send_val())
            self.ui.setupUi(self.Schedule)
            self.Schedule.show()
            self.Main.close()

    def Button_RefreshTicketsClicked(self):
        self.tableView_Tickets.clearContents()
        self.insertValues_TicketsTable(self.create_TicketsTable())

    def Button_Search_TicketsClicked(self):

        if self.comboBox_FilterTickets.currentText() == "title":
            title = self.insertValues_Conferences(self.Filter_Author_Title())

        elif self.comboBox_FilterConference.currentText() == "Price":
            author = self.insertValues_Conferences(self.Filter_Price())

        elif self.comboBox_FilterConference.currentText() == "Date":
            date = self.insertValues_Conferences(self.Filter_DateTickets())

        else:
            place = self.insertValues_Conferences(self.Filter_PlaceTickets())

    def Filter_Author_Title(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(SEAT), RTRIM(PRICE),RTRIM(PLACE), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))
                        FROM TICKETS_PRESENT
                        WHERE RTRIM(EMAIL) = :email
                        ORDER BY RTRIM(SEAT)''', email = self.Email)
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_Price(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(SEAT), RTRIM(PRICE),RTRIM(PLACE), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))
                        FROM TICKETS_PRESENT
                        WHERE RTRIM(EMAIL) = :email
                        ORDER BY RTRIM(PRICE)''', email = self.Email)
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_DateTickets(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(SEAT), RTRIM(PRICE),RTRIM(PLACE), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))
                        FROM TICKETS_PRESENT
                        WHERE RTRIM(EMAIL) = :email
                        ORDER BY RTRIM(DATETIME)''', email = self.Email)
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_PlaceTickets(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(SEAT), RTRIM(PRICE),RTRIM(PLACE), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))
                        FROM TICKETS_PRESENT
                        WHERE RTRIM(EMAIL) = :email
                        ORDER BY RTRIM(PLACE)''', email = self.Email)
        result = cursor.fetchall()
        connection.commit()
        return result

    def Button_RefreshConferences(self):
        self.tableView_Author_Conferences.clearContents()
        self.insertValues_Conferences(self.create_Conferences())

    def User_Profile(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(EMAIL), RTRIM(UNAME), RTRIM(SURNAME), RTRIM(PHONE), RTRIM(USER_ROLE)
                          FROM AUTHORISATION
                          WHERE RTRIM(EMAIL) = :email''', email = self.Email)
        connection.commit()
        result = cursor.fetchall()
        return result

    def Button_ProfileRefreshClicked(self):
        result = self.User_Profile()

        self.User_Name.clear()
        self.User_Name.setText(result[0][1])

        self.User_Surname.clear()
        self.User_Surname.setText(result[0][2])

        self.User_Phone.clear()
        self.User_Phone.setText(result[0][3])

    def Button_Search_Author_ConferencesClicked(self):

        if self.comboBox_Filter_Author_Conferences.currentText() == "Title":
            time = self.insertValues(self.Filter_AuthorTitle())

        elif self.comboBox_Filter_Author_Conferences.currentText() == "Theme":
            author = self.insertValues(self.Filter_AuthorTheme())

        elif self.comboBox_Filter_Author_Conferences.currentText() == "Date":
            date = self.insertValues(self.Filter_AuthorDate())

        else:
            place = self.insertValues(self.Filter_AuthorPlace())

    def Filter_AuthorTitle(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(TITLE)''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_AuthorTheme(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(THEME)''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_AuthorDate(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME), RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi'))''')
        result = cursor.fetchall()
        connection.commit()
        return result

    def Filter_AuthorPlace(self):
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(TITLE), RTRIM(THEME),RTRIM(TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')), RTRIM(PLACE)
                        FROM CONFERENCE_ACTION
                        ORDER BY RTRIM(PLACE)''')
        result = cursor.fetchall()
        connection.commit()
        return result


    def Button_Edit_ProfileClicked(self):
        import EditProfile
        Edit_Profile = EditProfile.Ui_EditProfile(self.Email)
        Edit_Profile.exec_()



    def Button_Sign_OutClicked(self):
        from Login import Ui_Login
        self.Login = QtWidgets.QMainWindow()
        self.ui = Ui_Login()
        self.ui.setupUi(self.Login)
        self.Login.show()
        self.Main.close()

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)

    ViewEdit_Speech = ViewEditSpeech.Ui_EditSpeech()
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())