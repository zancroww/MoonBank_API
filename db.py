import pymysql

def open_connection():
    try:
        conn = pymysql.connect(
        host='localhost',
        user='root', 
        password = "root", # hide password
        db='MoonBank',
        )
    except pymysql.MySQLError as e:
        print(e)

    return conn

def close_connection(conn):
    conn.close()
