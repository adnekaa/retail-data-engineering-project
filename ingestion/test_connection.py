print("Test connexion MySQL...")

from dotenv import load_dotenv
import os
from sqlalchemy import create_engine, text

load_dotenv()

engine = create_engine(
    f"mysql+pymysql://{os.getenv('MYSQL_USER')}:{os.getenv('MYSQL_PASSWORD')}"
    f"@{os.getenv('MYSQL_HOST')}:{os.getenv('MYSQL_PORT')}/{os.getenv('MYSQL_DATABASE')}"
)

try:
    with engine.connect() as conn:
        result = conn.execute(text("SHOW TABLES"))
        tables = [row[0] for row in result]
        print(f"✅ Connexion réussie !")
        print(f"📦 {len(tables)} tables trouvées :")
        for t in tables:
            print(f"   - {t}")
except Exception as e:
    print(f"❌ Erreur : {e}")