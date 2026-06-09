# ingestion/extractor.py
# Rôle : extraire toutes les tables MySQL vers des fichiers CSV
# Ces CSV seront ensuite chargés dans Databricks

import os
import pandas as pd
from sqlalchemy import create_engine, inspect
from dotenv import load_dotenv
from datetime import datetime

load_dotenv()

# Dossier où on va sauvegarder les CSV extraits
OUTPUT_DIR = "data/raw"


def get_engine():
    """Crée et retourne la connexion à MySQL."""
    url = (
        f"mysql+pymysql://{os.getenv('MYSQL_USER')}:{os.getenv('MYSQL_PASSWORD')}"
        f"@{os.getenv('MYSQL_HOST')}:{os.getenv('MYSQL_PORT')}/{os.getenv('MYSQL_DATABASE')}"
    )
    return create_engine(url)


def get_all_tables(engine) -> list:
    """Retourne la liste de toutes les tables de la base."""
    inspector = inspect(engine)
    return inspector.get_table_names()


def extract_table(engine, table_name: str) -> pd.DataFrame:
    """Lit une table MySQL et retourne un DataFrame pandas."""
    print(f"  📥 Extraction : {table_name}")
    df = pd.read_sql(f"SELECT * FROM `{table_name}`", engine)
    print(f"  ✅ {len(df)} lignes | {len(df.columns)} colonnes")
    return df


def save_to_csv(df: pd.DataFrame, table_name: str):
    """Sauvegarde un DataFrame en CSV dans data/raw/."""
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    path = os.path.join(OUTPUT_DIR, f"{table_name}.csv")
    df.to_csv(path, index=False, encoding="utf-8")
    print(f"  💾 Sauvegardé : {path}")


def extract_all():
    """Extrait toutes les tables et les sauvegarde en CSV."""
    print("=" * 50)
    print("🚀 Démarrage de l'extraction complète")
    print(f"⏰ {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 50)

    engine  = get_engine()
    tables  = get_all_tables(engine)
    success = []
    failed  = []

    print(f"\n📦 {len(tables)} tables trouvées dans la base\n")

    for table in tables:
        try:
            df = extract_table(engine, table)
            save_to_csv(df, table)
            success.append(table)
        except Exception as e:
            print(f"  ❌ Erreur sur {table} : {e}")
            failed.append(table)

    print("\n" + "=" * 50)
    print(f"✅ Succès  : {len(success)} tables")
    print(f"❌ Échecs  : {len(failed)} tables")
    if failed:
        print(f"   {failed}")
    print("=" * 50)


if __name__ == "__main__":
    extract_all()