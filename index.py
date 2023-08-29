from flask import Flask, request
from GetUserAccountDetails import get_user_accounts

app = Flask(__name__)


@app.route("/getuseraccount", methods=["GET"])
def getuseraccount():
    userID = request.args.get("userID")

    return get_user_accounts(userID)


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)