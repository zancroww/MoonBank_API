from db import open_connection, close_connection
import json


def get_bank_account(userID):
    try:
        conn = open_connection()
        with conn.cursor() as cursor:
            select_statement = "SELECT UserID, CreditScore, AccountNumber, SortCode, Balance, InterestRate, InterestLimit, Overdraft, OverdraftLimit, CAST(DateStarted AS CHAR) as DateStarted, UserID2, AccountType FROM bankaccount WHERE UserID=%s"
            cursor.execute(select_statement, userID)
            row_headers = [x[0] for x in cursor.description]  
            result = cursor.fetchall()
            print(result)

            if result is None:
                return json.dumps("Bank Account not found"), 404
            
            counter = 0
            json_data = {}
            
            for columnname in row_headers:
                temporarylist = []
                for resultrow in result:
                    temporarylist.append(resultrow[counter])
                json_data[columnname] = temporarylist
                counter+=1
                    
                    
            print(json_data)

            #json_data = dict(zip(row_headers, result))  
            #print(json_data)   

    except Exception as e:
        print(e)
        return json.dumps("Server error"), 500
    
    finally:
        close_connection(conn)

    return json.dumps(json_data), 200
