from db import open_connection, close_connection
import json
import os
from base64 import b64encode
from hashlib import sha512



def create_bank_account(user_account_json):
    # decompose json into variables
    user_ID = ""
    last_name = ""
    first_name = ""
    DoB = ""    
    email = ""
    phone_number = ""
    ni_number = ""
    salt = generate_salt()
    password = hash_password(password, salt)

    salt_as_string = b64encode(salt).decode('utf-8')

    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            cursor.execute('INSERT INTO UserAccount (UserID, LastName, FirstName, DoB, Email, PhoneNumber, NINumber, \
                        FirstLine, Postcode, Password, Salt) \
                        VALUES (%s,%s,%s,%s,%s,%s,%s)',
                        (user_ID, last_name, first_name, DoB, email, phone_number, ni_number, password, salt_as_string))
            cursor.commit()


    except Exception as e:
        return {
            'statusCode': 404,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(e)
        }

    finally:
        close_connection(conn)


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
