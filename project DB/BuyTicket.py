from PyQt5 import QtCore, QtGui, QtWidgets
import sys

try:
    import cx_Oracle
except:
    print("Import Error")
    if cx_Oracle.version<'3.0':
        print("Very old version of cx_Oracle :",cx_Oracle.version)
        sys.exit()

connection = cx_Oracle.connect('MAINADMIN', 'einstein', 'XE')

class Ui_BuyTicket(object):

    def setupUi(self, BuyTicket):

        self.BuyTicket = BuyTicket
        self.values = self.val
        cursor = connection.cursor()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT COUNT(SEAT)
                          FROM TICKETS_ACTION
                          GROUP BY PLACE
                          HAVING RTRIM(PLACE) = :place''',
                          place = self.values[1][3])
        connection.commit()
        seatsQuantity = cursor.fetchall()
        cursor.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
        cursor.execute('''SELECT RTRIM(QUANTITY)
                          FROM CONFERENCE_ACTION
                          WHERE TO_CHAR(DATETIME, 'dd.mm.yyyy hh24:mi')=:datetime AND RTRIM(PLACE)=:place''',
                       datetime = str(self.values[1][2]), place = str(self.values[1][3]))
        connection.commit()
        self.Quantity = cursor.fetchall()

        self.available = int(self.Quantity[0][0])- int(seatsQuantity[0][0])

        BuyTicket.setWindowTitle("Buy Ticket")
        BuyTicket.resize(400, 300)
        BuyTicket.setMaximumSize(QtCore.QSize(400, 300))
        BuyTicket.setWindowIcon(BuyTicket.style().standardIcon(QtWidgets.QStyle.SP_DesktopIcon))

        self.Cancel_button = QtWidgets.QPushButton(BuyTicket)
        self.Cancel_button.setGeometry(QtCore.QRect(310, 260, 81, 23))
        self.Cancel_button.setText("Cancel")
        self.Cancel_button.clicked.connect(self.Cancel_buttonClicked)

        self.Next_button = QtWidgets.QPushButton(BuyTicket)
        self.Next_button.setGeometry(QtCore.QRect(230, 260, 75, 23))
        self.Next_button.setText("Next")
        self.Next_button.clicked.connect(self.Next_buttonClicked)

        self.label_Conf_Title = QtWidgets.QLabel(BuyTicket)
        self.label_Conf_Title.setGeometry(QtCore.QRect(20, 30, 341, 16))
        self.label_Conf_Title.setText("Conference Title: {}".format(self.values[1][0]))

        self.label_DateTime = QtWidgets.QLabel(BuyTicket)
        self.label_DateTime.setGeometry(QtCore.QRect(20, 70, 341, 16))
        self.label_DateTime.setText("Date: {}".format(self.values[1][2]))

        self.label_Seat_Quantity = QtWidgets.QLabel(BuyTicket)
        self.label_Seat_Quantity.setGeometry(QtCore.QRect(20, 110, 151, 21))
        self.label_Seat_Quantity.setText("Choose quantity of places:")

        self.spinBox = QtWidgets.QSpinBox(BuyTicket)
        self.spinBox.setGeometry(QtCore.QRect(160, 110, 201, 22))
        self.spinBox.setMinimum(1)
        self.spinBox.setMaximum(self.available)

        self.label_Available = QtWidgets.QLabel(BuyTicket)
        self.label_Available.setGeometry(QtCore.QRect(250, 150, 151, 21))
        self.label_Available.setText("Available: {}".format(self.available))

    def Cancel_buttonClicked(self):
        from ConferenceSchedule import Ui_Schedule
        self.Schedule = QtWidgets.QMainWindow()
        self.ui = Ui_Schedule()
        self.ui.send_val(self.send_val())
        self.ui.setupUi(self.Schedule)
        self.Schedule.show()
        self.BuyTicket.close()

    def Next_buttonClicked(self):
        from TicketsOrder import Ui_TicketsOrder
        self.TicketsOrder = QtWidgets.QMainWindow()
        self.ui = Ui_TicketsOrder()
        self.ui.send_tick_ord(self.send_tick_ord())
        self.ui.setupUi(self.TicketsOrder)
        self.TicketsOrder.show()
        self.BuyTicket.close()

    def send_conf_val(self,val):
        self.val = val

    def send_val(self):
        return self.values

    def send_tick_ord(self):
        return [self.values[0], self.values[1], self.spinBox.value()]

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    BuyTicket = QtWidgets.QWidget()
    ui = Ui_BuyTicket()
    ui.setupUi(BuyTicket)
    BuyTicket.show()
    sys.exit(app.exec_())

