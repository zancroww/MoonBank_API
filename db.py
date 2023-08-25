#db.py
import os
import pymysql
from flask import jsonify

db_user = os.environ.get('root@localhost')
db_password = os.environ.get('root')
db_name = os.environ.get('MoonBaseDB')
db_connection_name = os.environ.get('127.0.0.0')


def open_connection():
    unix_socket = '/cloudsql/{}'.format(db_connection_name)
    try:
        if os.environ.get('GAE_ENV') == 'standard':
            conn = pymysql.connect(user=db_user, password=db_password,
                                unix_socket=unix_socket, db=db_name,
                                cursorclass=pymysql.cursors.DictCursor
                                )
    except pymysql.MySQLError as e:
        print(e)

    return conn



def get_bank_accounts(userrequest):
    conn = open_connection()
    with conn.cursor() as cursor:
        result = cursor.execute('SELECT * FROM bank_accounts WHERE userid_fk = (userid); VALUES(%s)', (userrequest["userid"]))
        bank_accounts = cursor.fetchall()
        if result > 0:
            got_bank_accounts = jsonify(bank_accounts)
        else:
            got_bank_accounts = 'No Bank Accounts in DB'
    conn.close()
    return got_bank_accounts