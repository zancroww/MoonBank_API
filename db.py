import pymysql

# "from mysql import connector" instead??

def open_connection():
    try:
        conn = pymysql.connect(
        host='localhost',
        user='root', 
        password = "root", # edit to import from google secrets!
        db='moonbankdb',
        )
    except pymysql.MySQLError as e:
        return e # What to do with error?

    return conn

def close_connection(conn):
    conn.close()
