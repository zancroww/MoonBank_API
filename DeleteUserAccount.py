from db import open_connection, close_connection
import json


def delete_user_account(userid):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            query = "DELETE FROM UserAccount WHERE UserID =%s"
            cursor.execute(query, userid)   
            affected_rows = conn.affected_rows()

            if affected_rows == 0:
                json.dumps("No rows deleted: Incorrect ID or deleted previously"), 404

        conn.commit()

    except Exception as e:
        return json.dumps("Server Error"), 500

    finally:
        close_connection(conn)

    return json.dumps("Success"), 200
