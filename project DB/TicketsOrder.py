from PyQt5 import QtCore, QtGui, QtWidgets
import sys

import datetime
try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()


connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')
cursor = connection.cursor()
    
class Ui_TicketsOrder(object):
    
    def setupUi(self, TicketsOrder):

        self.TickOrder = TicketsOrder

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(EMAIL), RTRIM(UNAME), RTRIM(SURNAME), RTRIM(PHONE)
                          FROM AUTHORISATION
                          WHERE RTRIM(EMAIL) = :email''', email = self.list[0])

        User = cursor.fetchall()
        connection.commit()

        TicketsOrder.setWindowTitle("Tickets Order")
        TicketsOrder.resize(400, 300)
        TicketsOrder.setMaximumSize(400, 300)
        TicketsOrder.setWindowIcon(TicketsOrder.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        label_Name = QtWidgets.QLabel(TicketsOrder)
        label_Name.setGeometry(QtCore.QRect(20, 20, 47, 21))
        label_Name.setText("Name:")
        
        self.User_Name = QtWidgets.QLineEdit(TicketsOrder)
        self.User_Name.setGeometry(QtCore.QRect(120, 20, 261, 20))
        self.User_Name.setText("{}".format(User[0][1]))
        self.User_Name.setReadOnly(True)
        self.User_Name.setAlignment(QtCore.Qt.AlignRight)

        self.User_Surname = QtWidgets.QLineEdit(TicketsOrder)
        self.User_Surname.setGeometry(QtCore.QRect(120, 60, 261, 20))
        self.User_Surname.setText("{}".format(User[0][2]))
        self.User_Surname.setReadOnly(True)
        self.User_Surname.setAlignment(QtCore.Qt.AlignRight)

        label_Surname = QtWidgets.QLabel(TicketsOrder)
        label_Surname.setGeometry(QtCore.QRect(20, 60, 47, 21))
        label_Surname.setText("Surname:")

        label_Email = QtWidgets.QLabel(TicketsOrder)
        label_Email.setGeometry(QtCore.QRect(20, 100, 47, 21))
        label_Email.setText("E-mail:")

        self.User_Email = QtWidgets.QLineEdit(TicketsOrder)
        self.User_Email.setGeometry(QtCore.QRect(120, 100, 261, 20))
        self.User_Email.setText("{}".format(User[0][0]))
        self.User_Email.setReadOnly(True)
        self.User_Email.setAlignment(QtCore.Qt.AlignRight)

        self.User_Phone = QtWidgets.QLineEdit(TicketsOrder)
        self.User_Phone.setGeometry(QtCore.QRect(120, 140, 261, 20))
        self.User_Phone.setText("{}".format(User[0][3]))
        self.User_Phone.setReadOnly(True)
        self.User_Phone.setAlignment(QtCore.Qt.AlignRight)

        label_Phone = QtWidgets.QLabel(TicketsOrder)
        label_Phone.setGeometry(QtCore.QRect(20, 140, 47, 16))
        label_Phone.setText("Phone:")

        self.User_TicketsQuantity = QtWidgets.QLineEdit(TicketsOrder)
        self.User_TicketsQuantity.setGeometry(QtCore.QRect(120, 180, 261, 20))
        self.User_TicketsQuantity.setText("{}".format(self.list[2]))
        self.User_TicketsQuantity.setReadOnly(True)
        self.User_TicketsQuantity.setAlignment(QtCore.Qt.AlignRight)

        label_TicketsQuantity = QtWidgets.QLabel(TicketsOrder)
        label_TicketsQuantity.setGeometry(QtCore.QRect(20, 180, 90, 16))
        label_TicketsQuantity.setText("Tickets Quantity:")

        label_FinalPrice = QtWidgets.QLabel(TicketsOrder)
        label_FinalPrice.setGeometry(QtCore.QRect(220, 215, 71, 21))
        label_FinalPrice.setText("Final price:")

        Readable_Money_label = QtWidgets.QLabel(TicketsOrder)
        Readable_Money_label.setGeometry(QtCore.QRect(300, 220, 47, 13))
        Readable_Money_label.setText("{}".format(int(self.list[1][4])*self.list[2]))

        Button_Cancel = QtWidgets.QPushButton(TicketsOrder)
        Button_Cancel.setGeometry(QtCore.QRect(310, 260, 75, 23))
        Button_Cancel.setText("Cancel")
        Button_Cancel.clicked.connect(self.Cancel_buttonClicked)

        Button_Buy = QtWidgets.QPushButton(TicketsOrder)
        Button_Buy.setGeometry(QtCore.QRect(230, 260, 75, 23))
        Button_Buy.setText("Buy")
        Button_Buy.clicked.connect(self.Button_Buy_buttonClicked)

        Button_Back = QtWidgets.QPushButton(TicketsOrder)
        Button_Back.setGeometry(QtCore.QRect(150, 260, 75, 23))
        Button_Back.setText("Back")
        Button_Back.clicked.connect(self.Back_buttonClicked)

    def Cancel_buttonClicked(self):
        from ConferenceSchedule import Ui_Schedule
        self.Schedule = QtWidgets.QMainWindow()
        self.ui = Ui_Schedule()
        self.ui.send_val(self.send_val())
        self.ui.setupUi(self.Schedule)
        self.Schedule.show()
        self.TickOrder.close()

    def Back_buttonClicked(self):
        from BuyTicket import Ui_BuyTicket
        self.BuyTicket = QtWidgets.QMainWindow()
        self.ui = Ui_BuyTicket()
        self.ui.send_conf_val(self.send_val())
        self.ui.setupUi(self.BuyTicket)
        self.BuyTicket.show()
        self.TickOrder.close()

    def Button_Buy_buttonClicked(self):
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT MAX(order_num)
                          FROM Orders_action''')
        order_value = cursor.fetchall()[0][0]
        connection.commit()

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL SERIALIZABLE''')
        cursor.execute('''INSERT INTO Orders_action(order_num, current_date, email)
                          VALUES (:order_num, :datetime, :email)''',
                            order_num=order_value+1, datetime = datetime.datetime.now(),email = self.list[0])
        connection.commit()

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT MAX(SEAT)
                         FROM TICKETS_ACTION
                         WHERE TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place''',
                         datetime = str(self.list[1][2]), place = str(self.list[1][3]))
        seat = cursor.fetchall()[0][0]
        connection.commit()

        cursor.execute('''SET TRANSACTION ISOLATION LEVEL SERIALIZABLE''')
        Insert = '''INSERT INTO Tickets_Action(SEAT, ORDER_NUM, PRICE, DATETIME, PLACE)
                                    VALUES (:seat,:order_num,:price, TO_DATE(:datetime, 'dd.mm.yyyy hh24:mi'), :place)'''

        cursor.execute(Insert,
                          seat = seat + 1,
                          order_num=order_value+1,
                          price = float(self.list[1][4]),
                          datetime = self.list[1][2],
                          place = self.list[1][3])
        connection.commit()

        from mainWindow import Ui_MainWindow
        self.MainWindow = QtWidgets.QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.send_log(self.send_val()[0])
        self.ui.setupUi(self.MainWindow)
        self.MainWindow.show()
        self.TickOrder.close()

    def send_val(self):
        return[self.list[0], self.list[1]]

    def send_tick_ord(self, list):
        self.list = list

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    TicketsOrder = QtWidgets.QWidget()
    ui = Ui_TicketsOrder()
    ui.setupUi(TicketsOrder)
    TicketsOrder.show()
    sys.exit(app.exec_())


