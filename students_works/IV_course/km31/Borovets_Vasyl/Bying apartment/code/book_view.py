import cx_Oracle

if cx_Oracle.version < '3.0':
    print ("Very old version of cx_Oracle :", cx_Oracle.version)

def show_books(log):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')

    sql = """
              SELECT  title  FROM addbook
              WHERE  login = :log
              """
    cur.execute(sql, log=log)
    con.commit()
    return cur.fetchall()

def show_info(title):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
    sql = """
              SELECT   * FROM book
              WHERE  title = :title
              """
    cur.execute(sql, title=title)
    con.commit()
    return cur.fetchall()

def show_apartment(log):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
    sql = """
              SELECT  title  FROM apartment
              WHERE  login = :log
              """
    cur.execute(sql, log=log)
    con.commit()
    return cur.fetchall()