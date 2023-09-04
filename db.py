from google.cloud.sql.connector import Connector
import pymysql
import os

# initialize Connector object
connector = Connector()    
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"C:\Users\evanh\AppData\Roaming\gcloud\legacy_credentials\user108@roimoonbank.com\adc.json" 

# function to return the database connection
def open_connection() -> pymysql.connections.Connection:
    conn: pymysql.connections.Connection = connector.connect(
        "roi-team-cloud-9:europe-west2:cloud-moonbankdb",
        "pymysql",
        user="root",
        password="root",
        db="moonbankdb",
    )
    return conn

def close_connection(conn):
    conn.close()

