from google.cloud.sql.connector import Connector
import pymysql
import os

# initialize Connector object
connector = Connector()  

# function to return the database connection
def open_connection() -> pymysql.connections.Connection:
    conn: pymysql.connections.Connection = connector.connect(
        os.environ["DB_INSTANCE_NAME"],
        "pymysql",
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        db=os.environ["DB_NAME"],
    )
    return conn

def close_connection(conn):
    conn.close()

