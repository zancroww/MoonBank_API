from db import open_connection, close_connection
import json
from random import randint
from datetime import date


def create_bank_account(user_id, user_account_json):
    try:
        # extract json
        overdraft = user_account_json["Overdraft"]
        
        balance = randint(0, 10000)
        user_id2 = "empty"
        account_type = user_account_json["Accounttype"]

        # generate details
        credit_score = randint(0, 1000)
        sort_code = randint(111111, 999999)
        date_started = date.today()
        if overdraft == "1":
            overdraft_limit = randint(100,500)
        else:
            overdraft_limit = "0"
        
        

        conn = open_connection()
        account_number = generate_account_number(conn)

        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO bankaccount (userid, creditscore, accountnumber, sortcode, \
                           balance, interestrate, interestlimit, overdraft, overdraftlimit, datestarted, userid2, accounttype) \
                           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                           (user_id, credit_score, account_number, sort_code, balance, "0", "0", overdraft, overdraft_limit, date_started, 
                            user_id2, account_type))
        conn.commit()

    except Exception as e:
            return json.dumps(f"Server Error {e}"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200


def generate_account_number(conn):
    not_generated = True
    while (not_generated):
        account_number = randint(11111111, 99999999)
        with conn.cursor() as cur:
            cur.execute('SELECT * FROM bankaccount WHERE accountnumber = %s', (account_number))
            account = cur.fetchone()
        conn.commit()
        # if account number doesn't already exist
        if not account:
            return account_number