import oracledb
from flask import Flask, request, render_template

app = Flask(__name__)

# Ruta de wallet en la VM
WALLET_PATH = "/var/www/tu-proyecto/wallet"

# Activar modo Thick Client
oracledb.init_oracle_client(config_dir=r"C:\Users\camil\OneDrive\Desktop\Estudio\Workspace\BuscaPreciosChile\Pagina-Ingenieria-Requisitos")

# Conexión
def get_connection():
    return oracledb.connect(
        user="TU_USUARIO",
        password="TU_CONTRASEÑA",
        dsn="tu_dsn_de_tnsnames"
    )


@app.route("/registrar", methods=["POST"])
def registrar_usuario():
    nombre = request.form["nombre"]
    correo = request.form["correo"]
    direccion = request.form["direccion"]
    contraseña = request.form["contraseña"]

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        INSERT INTO usuario (id_usuario, correo_usuario, contraseña_hash, pnombre_usuario, papellido_usuario)
        VALUES (usuario_seq.nextval, :correo, :password, :nombre, 'Apellido')
        """,
        correo=correo,
        password=contraseña,
        nombre=nombre
    )
    conn.commit()
    cursor.close()
    conn.close()

    return "Registro exitoso"
