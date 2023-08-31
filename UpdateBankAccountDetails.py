from db import open_connection, close_connection
import json


"""
updates A USER WITH A SPECIFIC id, with specific info.
"""

# Check user exists first?
def update_user_account(userID, user_account_json):
    credit_score = user_account_json["CreditScore"]
    sort_code = user_account_json["SortCode"]
    balance = user_account_json["Balance"]    
    interest_rate = user_account_json["InterestRate"]
    interest_limit = user_account_json["InterestLimit"]
    overdraft = user_account_json["Overdraft"]
    overdraft_limit = user_account_json["OverdraftLimit"]
    Date = user_account_json["Postcode"]

    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            query = "UPDATE BankAccount SET LastName = %s, FirstName = %s, DoB = %s, Email = %s, PhoneNumber = %s, NINumber = %s, FirstLine = %s, Postcode = %s WHERE UserID = %s"
            values = (last_name, first_name, DoB, email, phone_number, ni_number, first_line, postcode, userID)
            cursor.execute(query, values)
                
        conn.commit()

    except Exception as e:
        return json.dumps("Server Error"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200
