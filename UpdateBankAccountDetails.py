from db import open_connection, close_connection
import json


"""
updates A Bank WITH A SPECIFIC id, with specific info.
"""

# Check bank exists first?
def update_bank_account(accountnumber, bank_account_json):
    credit_score = bank_account_json["CreditScore"]
    sort_code = bank_account_json["SortCode"]
    balance = bank_account_json["Balance"]    
    interest_rate = bank_account_json["InterestRate"]
    interest_limit = bank_account_json["InterestLimit"]
    overdraft = bank_account_json["Overdraft"]
    overdraft_limit = bank_account_json["OverdraftLimit"]
    date_started = bank_account_json["DateStarted"]

    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            query = "UPDATE BankAccount SET CreditScore = %s, SortCode = %s, Balance = %s, InterestRate = %s, InterestLimit = %s, Overdraft = %s, OverdraftLimit = %s, DateStarted = %s WHERE AccountNumber = %s"
            values = (credit_score, sort_code, balance, interest_rate, interest_limit, overdraft, overdraft_limit, date_started, accountnumber)
            cursor.execute(query, values)
                
        conn.commit()

    except Exception as e:
        return json.dumps("Server Error"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200
