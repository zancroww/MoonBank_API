from db import open_connection, close_connection
import json
import os
from base64 import b64encode
from hashlib import sha512



def create_user_account(user_id, user_account_json):
    try:
        last_name = user_account_json["LastName"]
        first_name = user_account_json["FirstName"]
        DoB = user_account_json["DoB"]    
        email = user_account_json["Email"]
        phone_number = user_account_json["PhoneNumber"]
        ni_number = user_account_json["NINumber"]
        first_line = user_account_json["FirstLine"]
        postcode = user_account_json["Postcode"]
        salt = generate_salt()
        password = hash_password(user_account_json["Password"], salt)

        salt_as_string = b64encode(salt).decode('utf-8')

        conn = open_connection()
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO useraccount (UserID, LastName, FirstName, DoB, Email, PhoneNumber, NINumber, \
                        FirstLine, Postcode, Password, Salt) \
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                        (user_id, last_name, first_name, DoB, email, phone_number, ni_number, first_line, postcode, password, salt_as_string))
        conn.commit()

    except Exception as e:
            print(e)
            return json.dumps(f"Server Error {e}"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200


def generate_salt():
    salt = os.urandom(64)
    return salt


def hash_password(password, salt):
    password = bytes(password, 'utf-8')
    hashed_password = sha512(password.strip() + salt).hexdigest()
    return hashed_password
