from db import open_connection, close_connection
import json


def get_user_accounts(userID):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            select_statement = "SELECT UserID, LastName, FirstName, CAST(DoB AS CHAR) as DoB, Email, PhoneNumber, NINumber, FirstLine, Postcode, Password FROM UserAccount WHERE UserID=%s"
            cursor.execute(select_statement, userID)
            row_headers = [x[0] for x in cursor.description]  
            result = cursor.fetchone()

            json_data = dict(zip(row_headers, result))     

            conn.commit()

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
        'body': json.dumps(json_data)
    }

get_user_accounts("1")