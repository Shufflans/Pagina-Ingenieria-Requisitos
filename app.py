import oracledb

# Configura tu conexión
username = "ADMIN"
password = "87876565Vc__"
dsn = "ecommercedb_high"

# Ruta al directorio donde está la wallet
wallet_path = "./Wallet"   # ajústalo según dónde lo pongas

def test_connection():
    try:
        connection = oracledb.connect(
            user=username,
            password=password,
            dsn=dsn,
            config_dir=wallet_path,
            wallet_location=wallet_path,
            wallet_password=password  # normalmente la wallet no lleva password, pero no daña
        )
        print("🔥 Conexión exitosa a Oracle Autonomous DB")
        cursor = connection.cursor()
        cursor.execute("SELECT 'Hola desde Oracle!' FROM dual")
        print(cursor.fetchone()[0])
    except Exception as e:
        print("❌ Error al conectar:", e)

if __name__ == "__main__":
    test_connection()
