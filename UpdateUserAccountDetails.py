from db import open_connection, close_connection
import json


"""
updates A USER WITH A SPECIFIC id, with specific info.
"""
def update_user(lastname,firstname,datestarted,email,phonenumber,ninumber,firstline,postcode,password,salt,userid):
    conn = open_connection()
    with conn.cursor() as cursor:
        query = "UPDATE UserAccount SET LastName=%s, FirstName=%s, DoB=%s, Email=%s, PhoneNumber=%s, NINumber=%s, FirstLine=%s, Postcode=%s, Password=%s, Salt=%s WHERE UserID = %s"
        tuple1 = (lastname,firstname,datestarted,email,phonenumber,ninumber,firstline,postcode,password,salt,userid)
        cursor.execute(query, tuple1)
        print(f"User {firstname} {lastname} with id = {userid} has been updated")
            

    conn.commit()

        # add try except       

    close_connection(conn)

    return {
        'statusCode': 200,
        'headers': {'Content-Type': 'application/json'},
        
    }

"""
print(update_user("Billy","Boy", "2000-01-01","b@gmail.com","02020","PG884848A","LOXL","OPKD DID", "password123","sha256","27"))
print("\n \n \n \n ------------------------------------------------------------------------------ \n \n \n \n")
"""