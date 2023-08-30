from db import open_connection, close_connection
import json


def get_single_bank_account(accountnumber):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            select_statement = "SELECT UserID, CreditScore, AccountNumber, SortCode, Balance, InterestRate, InterestLimit, Overdraft, OverdraftLimit, UserID2, AccountType FROM BankAccount WHERE AccountNumber=%s"
            cursor.execute(select_statement ,accountnumber)
            row_headers = [x[0] for x in cursor.description]  
            result = cursor.fetchone()

            if result is None:
                return json.dumps("Specific Bank Account not found"), 404

            json_data = dict(zip(row_headers, result))     

    except Exception as e:
        return json.dumps("Server error"), 500
    
    finally:
        close_connection(conn)

    return json.dumps(json_data), 200
