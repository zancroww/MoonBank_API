from db import open_connection, close_connection
import json
import os
from base64 import b64encode
from hashlib import sha512



def create_user_account(user_account_json):
    user = json.loads(user_account_json)

    last_name = user["LastName"]
    first_name = user["FirstName"]
    DoB = user["DoB"]    
    first_line = user["FirstLine"]
    postcode = user["Postcode"]
    email = user["Email"]
    phone_number = user["Phone"]
    ni_number = user["NINumber"]
    salt = generate_salt()
    password = hash_password(user["Password"], salt)

    salt_as_string = b64encode(salt).decode('utf-8')


    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO UserAccount (UserID, LastName, FirstName, DoB, Email, PhoneNumber, NINumber, \
                        FirstLine, Postcode, Password, Salt) \
                        VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
                        (last_name, first_name, DoB, email, phone_number, ni_number, first_line, postcode, password, salt_as_string))
            cursor.commit()

    except Exception as e:
        return {
            'statusCode': 404,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(f"Failed: {str(e)}")
        }

   # finally:
        # close_connection(conn)


    return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps("Success")
        }


def generate_salt():
    salt = os.urandom(64)
    return salt


def hash_password(password, salt):
    password = bytes(password, 'utf-8')
    hashed_password = sha512(password.strip() + salt).hexdigest()
    return hashed_password


print(create_user_account(json.dumps({"LastName": "Smith", "FirstName": "Roger", "DoB": "1999-09-22", "Email": "RogerSmith@demomail.com", "Phone": "01100011012", \
                  "NINumber": "CC000000A", "FirstLine": "3 Red Street", "Postcode": "BB0 0AA", "Password": "Apple1"})))


