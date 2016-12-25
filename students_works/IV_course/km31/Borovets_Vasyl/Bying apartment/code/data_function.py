import cx_Oracle
import hashlib
if cx_Oracle.version < '3.0':
    print ("Very old version of cx_Oracle :", cx_Oracle.version)

con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')


def autorization_seller (seller,password):

    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    h = hashlib.md5(password.encode())
    h1 =h.hexdigest()
    cur = con.cursor()
    cur.execute('''
                  select login, password
                      from seller
                                    ''' )
    rez = False
    for r in cur.fetchall():
        if r[0]==seller :
            rez = True
            if h1==r[1]:
                return True
                break
            else:
                return False
                break
    if rez==False :
        return False
    cur.close()

def autorization_customer (seller,password):

    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    h = hashlib.md5(password.encode())
    h1 =h.hexdigest()
    cur = con.cursor()
    cur.execute('''
                    select login, password
                            from customer
                             ''' )
    rez = False
    for r in cur.fetchall():
        if r[0]==seller :
            rez = True
            if h1==r[1]:
                return True
                break
            else:
                return False
                break
    if rez==False :
        return False
    cur.close()

def seller_registration (log, nam,em ,pas):
    h = hashlib.md5(pas.encode())
    pas = h.hexdigest()
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')
    sql = "insert into seller (login, name_s, email, password) values (:login, :name, :email, :password)"

    cur.execute (sql,login=log, name=nam, email=em, password =pas)
    con.commit()
    cur.close()

def customer_registration (log, nam,em ,pas):
    h = hashlib.md5(pas.encode())
    pas = h.hexdigest()
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')
    sql = "insert into customer (login, name_c, email, password) values (:login, :name, :email, :password)"

    cur.execute (sql,login=log, name=nam, email=em, password =pas)
    con.commit()
    cur.close()




con.commit ()

con.close()
