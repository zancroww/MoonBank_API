from db import open_connection, close_connection
import json


"""
updates A USER WITH A SPECIFIC id, with specific info.
"""

def update_user_account(userID, user_account_json):
    try:
        last_name = user_account_json["LastName"]
        first_name = user_account_json["FirstName"]
        DoB = user_account_json["DoB"]    
        email = user_account_json["Email"]
        phone_number = user_account_json["PhoneNumber"]
        ni_number = user_account_json["NINumber"]
        first_line = user_account_json["FirstLine"]
        postcode = user_account_json["Postcode"]

        conn = open_connection()
        with conn.cursor() as cursor:
            query = "UPDATE useraccount SET LastName = %s, FirstName = %s, DoB = %s, Email = %s, PhoneNumber = %s, NINumber = %s, FirstLine = %s, Postcode = %s WHERE UserID = %s"
            values = (last_name, first_name, DoB, email, phone_number, ni_number, first_line, postcode, userID)
            cursor.execute(query, values)
                
        conn.commit()

    except Exception as e:
        return json.dumps("Server Error"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200
