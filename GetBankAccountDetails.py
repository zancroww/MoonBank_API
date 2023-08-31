from db import open_connection, close_connection
import json


def get_bank_account(userID):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            select_statement = "SELECT UserID, CreditScore, AccountNumber, SortCode, Balance, InterestRate, InterestLimit, Overdraft, OverdraftLimit, CAST(DateStarted AS CHAR) as DateStarted, UserID2, AccountType FROM BankAccount WHERE UserID=%s"
            cursor.execute(select_statement, userID)
            row_headers = [x[0] for x in cursor.description]  
            result = cursor.fetchone()

            if result is None:
                return json.dumps("Bank Account not found"), 404

            json_data = dict(zip(row_headers, result))     

    except Exception as e:
        return json.dumps("Server error"), 500
    
    finally:
        close_connection(conn)

    return json.dumps(json_data), 200
