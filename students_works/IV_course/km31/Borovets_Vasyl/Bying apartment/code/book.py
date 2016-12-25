# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'book.ui'
#
# Created: Fri Dec 23 20:47:41 2016
#      by: PyQt5 UI code generator 5.0
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets
from book_view import show_books
class Ui_book_page(object):
    def setupUi(self, book_page):
        self.inf=book_page
        book_page.setObjectName("book_page")
        book_page.resize(400, 300)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap("hous.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        book_page.setWindowIcon(icon)
        self.label_6 = QtWidgets.QLabel(book_page)
        self.label_6.setGeometry(QtCore.QRect(110, 10, 171, 16))
        font = QtGui.QFont()
        font.setPointSize(14)
        self.label_6.setFont(font)
        self.label_6.setObjectName("label_6")
        self.listWidget = QtWidgets.QListWidget(book_page)
        self.listWidget.setGeometry(QtCore.QRect(70, 40, 256, 192))
        self.listWidget.setObjectName("listWidget")
        self.ok_but = QtWidgets.QPushButton(book_page)
        self.ok_but.setGeometry(QtCore.QRect(150, 250, 75, 23))
        self.ok_but.setObjectName("ok_but")
        self.listWidget.clear()
        for rezult in show_books(self.login):
            self.listWidget.addItem(rezult[0])
        self.retranslateUi(book_page)
        QtCore.QMetaObject.connectSlotsByName(book_page)
        self.ok_but.clicked.connect(self.button_click)

    def button_click(self):
        self.inf.close()

    def retranslateUi(self, book_page):
        _translate = QtCore.QCoreApplication.translate
        book_page.setWindowTitle(_translate("book_page", "Bookmarks page"))
        self.label_6.setText(_translate("book_page", "MY BOOKMARKS"))
        self.ok_but.setText(_translate("book_page", "OK"))

    def send_login(self, login):
        self.login = login

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    book_page = QtWidgets.QDialog()
    ui = Ui_book_page()
    ui.setupUi(book_page)
    book_page.show()
    sys.exit(app.exec_())

