from flask import Flask, request

from GetUserAccountDetails import get_user_accounts
from CreateUserAccount import create_user_account 

app = Flask(__name__)


@app.route("/getuseraccount", methods=["GET"])
def getuseraccount():
    userID = request.args.get("userID")

    return get_user_accounts(userID)


@app.route("/createuseraccount", methods=["POST"])
def createuseraccount():
    json_data = request.get_json()

    return create_user_account(json_data)



@app.route("/deleteuseraccount", methods=["POST"])
def deleteuseraccount():
    pass


@app.route("/updateuseraccount", methods=["POST"])
def updateuseraccount():
    pass



if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)