from flask import Flask, request, jsonify, make_response

from GetUserAccountDetails import get_user_accounts
from CreateUserAccount import create_user_account 
from DeleteUserAccount import delete_user_account
from UpdateUserAccountDetails import update_user_account

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


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)