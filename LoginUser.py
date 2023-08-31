from db import open_connection, close_connection
import json
from hashlib import sha512
from base64 import b64decode

# need try catch on db connection!

def login_user(user_account_json):
    email = user_account_json["Email"]
    password = user_account_json["Password"]

    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            # Get hashed password and salt stored in the DB for the email
            query = "SELECT Password, Salt FROM UserAccount WHERE Email=%s"
            cursor.execute(query, email)
            result = cursor.fetchone()                

            if result is None:
                return json.dumps("Login failed"), 404
            
            password_from_db, salt = result
            
            # Generate hash from user supplied password and salt
            password_to_check = hash_password(password, b64decode(salt))

            if password_from_db == password_to_check:
                return json.dumps("Success"), 200
            else:
                return json.dumps("Incorrect password"), 404


    except Exception as e:
        return json.dumps(f"Server error: {e}"), 500
    
    finally:
        close_connection(conn)

    
def hash_password(password, salt):
    password = bytes(password, 'utf-8')
    hashed_password = sha512(password.strip() + salt).hexdigest()
    return hashed_password