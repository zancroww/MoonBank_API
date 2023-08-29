from db import open_connection, close_connection
import json
import os
from base64 import b64encode
from hashlib import sha512



def create_user_account(user_account_json):
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

    # Check if user already exists?
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            cursor.execute("INSERT INTO UserAccount (LastName, FirstName, DoB, Email, PhoneNumber, NINumber, \
                        FirstLine, Postcode, Password, Salt) \
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                        (last_name, first_name, DoB, email, phone_number, ni_number, first_line, postcode, password, salt_as_string))
            conn.commit()

    except Exception as e:
            return json.dumps("Server Error"), 500

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
