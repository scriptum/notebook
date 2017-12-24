from __future__ import print_function
import os
import gmpy2
from gmpy2 import mpz
from flask import Flask, jsonify


app = Flask(__name__)


@app.route("/<int:number>", methods=['GET'])
def get_fib(number):
    ''' Return Fibonacci '''
    return jsonify(str(gmpy2.fib(int(number))))


if __name__ == "__main__":
    app.run(host=os.getenv("HOST", "0.0.0.0"),
            port=int(os.getenv("PORT", 5000)))
