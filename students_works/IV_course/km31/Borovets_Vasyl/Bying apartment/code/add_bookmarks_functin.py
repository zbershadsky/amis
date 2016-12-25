import cx_Oracle

if cx_Oracle.version < '3.0':
    print ("Very old version of cx_Oracle :", cx_Oracle.version)

def addbook(title, log):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')
    try:
        sql = """
          SELECT  cadastre_number  FROM apartment
          WHERE title = :title
          """
        cur.execute(sql, title=title)
        con.commit()
    except:
        cur.rollback()


    i = cur.fetchall()
    ii=i[0][0]
    cur.close()
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')
    try:
        sql="insert into bookmark (numb, login, cadastre_number) values (book_sequence.nextval, :login, :cadastre_number)"

        cur.execute (sql, login=log, cadastre_number=ii)
        con.commit()

    except:
        cur.rollback()
    cur.close()

def del_apart(title):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')
    try:
        sql = """
         DELETE FROM apartment
          WHERE  title = :title
          """
        cur.execute(sql, title=title)
        con.commit()

    except:
        con.rollback()
    cur.close()
def street_only(city,street,home, flat):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')

    sql = """
         select * FROM apartment
          WHERE  city = :a0 and street = :a1 and house = :a2 and flat = :a3
          """
    cur.execute(sql, a0 = city, a1 = street, a2 = home, a3 = flat)
    con.commit()

    if (cur.fetchone() != None):
            return False
    elif (cur.fetchone() == None):
        return True
    cur.close()
def title_only(title):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')
    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL READ COMMITTED''')

    sql = """
         select title FROM apartment
          WHERE  title = :t
          """
    cur.execute(sql, t = title)
    con.commit()

    if (cur.fetchone() != None):
            return False
    elif (cur.fetchone() == None):
        return True
    cur.close()
