from flask import Flask, request, jsonify, make_response
from firebase_admin import auth, credentials, initialize_app
import os

from GetUserAccountDetails import get_user_accounts
from CreateUserAccount import create_user_account 
from DeleteUserAccount import delete_user_account
from UpdateUserAccountDetails import update_user_account
from GetBankAccountDetails import get_bank_account
from GetSingleBankAccount import get_single_bank_account
from DeleteBankAccount import delete_bank_account
from UpdateBankAccountDetails import update_bank_account
from CreateBankAccount import create_bank_account

app = Flask(__name__)

config = {
    "apiKey": "AIzaSyBMS9kc-7-9S4plhipExzbFR2vvuKtJe5g",
    "authDomain": "roi-team-cloud-9.firebaseapp.com",
    "projectId": "roi-team-cloud-9",
    "storageBucket": "roi-team-cloud-9.appspot.com",
    "messagingSenderId": "1004071473802",
    "appId": "1:1004071473802:web:29a79a83ceeded434f9373",
    "databaseURL": "",
}

default_app = initialize_app(options=config)


def verify_token(request):
    token = request.headers["Authorization"]
    
    if not token:
        return None
    
    # remove "bearer" text from token
    token = token[7:]
    print(token)
    
    try:
        decoded_token = auth.verify_session_cookie(token)

    except auth.InvalidIdTokenError:  
        # Token is invalid, expired or revoked. Force user to login.
        return None
    
    return decoded_token['uid']


@app.route("/getuseraccount", methods=["GET"])
def getuseraccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    print(user_id)
    return make_response(get_user_accounts(user_id))


@app.route("/createuseraccount", methods=["POST"],)
def createuseraccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    json_data = request.get_json()
    print(request.headers)

    return make_response(create_user_account(user_id, json_data))


@app.route("/deleteuseraccount", methods=["DELETE"])
def deleteuseraccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    return make_response(delete_user_account(user_id))


@app.route("/updateuseraccount", methods=["PUT"])
def updateuseraccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    json_data = request.get_json()
    return make_response(update_user_account(user_id, json_data))

#---------------------------------------------------------------------------------------

# Bank Account - related methods

@app.route("/createbankaccount", methods=["POST"])
def createbankaccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    json_data = request.get_json()

    return make_response(create_bank_account(user_id, json_data))


@app.route("/getbankaccount", methods=["GET"])
def getbankaccount():
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)
        
    return make_response(get_bank_account(user_id))


@app.route("/getsinglebankaccount/<accountnumber>", methods=["GET"])
def getsinglebankaccount(accountnumber):
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)
    
    return make_response(get_single_bank_account(accountnumber))
    

@app.route("/deletebankaccount/<accountnumber>", methods=["DELETE"])
def deletebankaccount(accountnumber):
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)
    
    return make_response(delete_bank_account(accountnumber))


@app.route("/updatebankaccount/<accountnumber>", methods=["PUT"])
def updatebankaccount(accountnumber):
    user_id = verify_token(request)
    if not user_id:
        return make_response(jsonify(message="Invalid token"), 401)

    json_data = request.get_json()
    return make_response(update_bank_account(accountnumber, json_data))


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)