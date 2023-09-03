from flask import Flask, request, jsonify, make_response

from GetUserAccountDetails import get_user_accounts
from CreateUserAccount import create_user_account 
from DeleteUserAccount import delete_user_account
from UpdateUserAccountDetails import update_user_account
from GetBankAccountDetails import get_bank_account
from GetSingleBankAccount import get_single_bank_account
from DeleteBankAccount import delete_bank_account
from UpdateBankAccountDetails import update_bank_account

app = Flask(__name__)


@app.route("/getuseraccount/<userID>", methods=["GET"])
def getuseraccount(userID):
    if str.isdigit(userID): 
        return make_response(get_user_accounts(userID))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)


@app.route("/createuseraccount", methods=["POST"],)
def createuseraccount():
    json_data = request.get_json()

    return make_response(create_user_account(json_data))


@app.route("/deleteuseraccount/<userID>", methods=["DELETE"])
def deleteuseraccount(userID):
    if str.isdigit(userID):
        return make_response(delete_user_account(userID))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)


@app.route("/updateuseraccount/<userID>", methods=["PUT"])
def updateuseraccount(userID):
    if str.isdigit(userID):
        json_data = request.get_json()
        return make_response(update_user_account(userID, json_data))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)

#---------------------------------------------------------------------------------------

# Bank Account - related methods

@app.route("/getbankaccount/<userID>", methods=["GET"])
def getbankaccount(userID):
    if str.isdigit(userID):
        return make_response(get_bank_account(userID))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)


#UPDATE BELOW SO THAT IT USES BOTH userID and AccountNumber TO GET THE SPECIFIC BANK ACCOUNT.

@app.route("/getsinglebankaccount/<accountnumber>", methods=["GET"])
def getsinglebankaccount(accountnumber):
    if str.isdigit(accountnumber):
        return make_response(get_single_bank_account(accountnumber))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)

@app.route("/deletebankaccount/<accountnumber>", methods=["DELETE"])
def deletebankaccount(accountnumber):
    if str.isdigit(accountnumber):
        return make_response(delete_bank_account(accountnumber))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)


@app.route("/updatebankaccount/<accountnumber>", methods=["PUT"])
def updatebankaccount(accountnumber):
    if str.isdigit(accountnumber):
        json_data = request.get_json()
        return make_response(update_bank_account(accountnumber, json_data))
    
    message = jsonify(message="Invalid parameters")
    return make_response(message, 422)


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)