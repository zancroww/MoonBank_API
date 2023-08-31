from db import open_connection, close_connection
import json

#NOT WORKING

def delete_bank_account(accountnumber):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            query = "DELETE FROM BankAccount WHERE AccountNumber =%s"
            cursor.execute(query, accountnumber)   
            affected_rows = conn.affected_rows()

            if affected_rows == 0:
                json.dumps("No rows deleted: Incorrect ID or deleted previously"), 404

        conn.commit()

    except Exception as e:
        return json.dumps("Server Error"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200
