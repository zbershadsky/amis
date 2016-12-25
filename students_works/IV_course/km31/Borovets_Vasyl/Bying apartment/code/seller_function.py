import cx_Oracle

if cx_Oracle.version < '3.0':
    print ("Very old version of cx_Oracle :", cx_Oracle.version)
def search_function (city, min_price, max_price):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    if (bool(city)==True and bool(max_price)==bool(min_price)==False):
        sql = """
          SELECT title FROM apartment
          WHERE city = :city
          """
        cur.execute (sql,city = city)

        return cur.fetchall()

    elif (bool(min_price) == True and bool(max_price) == bool(city) == False):
        min_price = float(min_price)

        sql = """
          SELECT title FROM apartment
          WHERE price >= :min_price
          """
        cur.execute (sql,min_price =min_price)

        return cur.fetchall()


    elif (bool(max_price) == True and bool(city) == bool(min_price) == False):
        max_price = float(max_price)
        sql = """
          SELECT title FROM apartment
          WHERE price <= :max_price
          """
        cur.execute (sql,max_price =max_price)

        return cur.fetchall()

    elif (bool(city) == False and bool(max_price) == bool(min_price) == True):
        max_price = float(max_price)
        min_price = float(min_price)

        sql = """
          SELECT title FROM apartment
          WHERE price <= :max_price and price >= :min_price
          """
        cur.execute (sql,max_price = max_price, min_price = min_price)

        return cur.fetchall()

    elif (bool(max_price) == False and bool(city) == bool(min_price) == True):

        min_price = float(min_price)

        sql = """
          SELECT title FROM apartment
          WHERE city = :city and price >= :min_price
          """
        cur.execute (sql,city = city, min_price = min_price)

        return cur.fetchall()

    elif (bool(min_price) == False and bool(city) == bool(max_price) == True):

        max_price = float(max_price)

        sql = """
          SELECT title FROM apartment
          WHERE city = :city and price <= :max_price
          """
        cur.execute (sql,city = city, max_price = max_price)

        return cur.fetchall()


    elif (bool(min_price) == bool(city) == bool(max_price) == False):
        sql = """
                  SELECT title FROM apartment

                  """
        cur.execute(sql)

        return cur.fetchall()

    elif (bool(min_price) == bool(city) == bool(max_price) == True):

        max_price = float(max_price)
        min_price = float(min_price)
        sql = """
          SELECT title FROM apartment
          WHERE city = :city and price <= :max_price
              and price >= :min_price
          """
        cur.execute (sql,city = city, max_price = max_price, min_price = min_price)

        return cur.fetchall()

def add_apartments (title, login, cadastre_number, city, street, house, flat, price):

    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')

    sql = "insert into apartment (title, login, cadastre_number, city, street, house, flat, price) values (:t,:l,:ca,:c,:s,:h,:f,:p)"

    cur.execute (sql, t=title, l=login, ca=cadastre_number, c=city, s=street, h=house, f=flat, p=price)
    con.commit()
    cur.close()

def show_apart (login, title):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    sql = "select * from apartment where title=:t and login=:l"

    cur.execute (sql, t=title, l=login)
    con.commit()
    return cur.fetchall()
def edit_apartments (tn, title, l, cad, ci, st, hm, f, p):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    cur.execute('''SET TRANSACTION ISOLATION LEVEL serializable''')
    try:
        sql = "update  apartment set title = :ta, cadastre_number= :cad, login = :l, city = :city, street = :st, " \
              "house= :hm, flat= :f, price= :p where title = :tn"

        cur.execute (sql, ta=title, cad=cad, l=l, tn=tn, city = ci, st=st, hm=hm, f=f, p=p )

        con.commit()

    except:
        con.rollback()

    cur.close()
def show_seller_book (title):
    con = cx_Oracle.connect('borovec', 'qwerty123', 'XE')

    cur = con.cursor()
    sql = "select * from screen_seller where login=:t "

    cur.execute (sql, t=title)
    con.commit()
    return cur.fetchall()