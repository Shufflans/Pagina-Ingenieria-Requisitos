from flask import Flask, request, render_template
import oracledb

app = Flask(__name__)

# --- Configuración Oracle ---
wallet_location = r"C:\Users\camil\OneDrive\Desktop\Estudio\Workspace\BuscaPreciosChile\Pagina-Ingenieria-Requisitos\Wallet"
user = "ADMIN"
password = "Angelnigga1234*"
dsn = "dbpruebarequisitos_high"

# --- Ruta principal ---
@app.route('/')
def index():
    return render_template('index.html')

# --- Ruta de registro ---
@app.route('/registrar', methods=['POST'])
def registrar():
    pnombre = request.form.get('pnombre_usuario')
    snombre = request.form.get('snombre_usuario')
    papellido = request.form.get('papellido_usuario')
    sapellido = request.form.get('sapellido_usuario')
    correo = request.form.get('correo_usuario')
    telefono = request.form.get('nrotelefono_usuario')
    contrasena = request.form.get('contraseña_hash')

    try:
        connection = oracledb.connect(
            user=user,
            password=password,
            dsn=dsn,
            config_dir=wallet_location,
            wallet_location=wallet_location,
            wallet_password='123angel'
        )

        cur = connection.cursor()
        cur.execute("""
            INSERT INTO usuario (
                id_usuario, correo_usuario, contraseña_hash,
                pnombre_usuario, snombre_usuario, papellido_usuario, sapellido_usuario,
                nrotelefono_usuario, rol_usuario
            ) VALUES (
                SEQ_USUARIO.NEXTVAL, :correo, :contrasena,
                :pnombre, :snombre, :papellido, :sapellido,
                :telefono, 'Cliente'
            )
        """, correo=correo, contrasena=contrasena,
             pnombre=pnombre, snombre=snombre,
             papellido=papellido, sapellido=sapellido,
             telefono=telefono)

        connection.commit()
        cur.close()
        connection.close()

        return "Registro exitoso ✅"

    except Exception as e:
        print("❌ Error al insertar:", e)
        return "❌ Error al registrar usuario"

if __name__ == "__main__":
    app.run(debug=True)
