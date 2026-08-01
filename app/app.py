from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

def obtener_conexion():
    return sqlite3.connect("database.db")

@app.route("/buscar", methods=["GET"])
def buscar():
    termino = request.args.get("q", "")
    
    # Consulta parametrizada segura
    with obtener_conexion() as conexion:
        cursor = conexion.cursor()
        cursor.execute("SELECT * FROM productos WHERE nombre = ?", (termino,))
        resultados = cursor.fetchall()
        
    return jsonify({"resultados": resultados})

@app.route("/evaluar", methods=["GET"])
def evaluar():
    return jsonify({"mensaje": "Operación no permitida por políticas de seguridad"}), 400

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
