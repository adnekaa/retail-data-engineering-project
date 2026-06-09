# ingestion/extractor.py
# Rôle : lire les tables MySQL et les afficher avec pandas
# Etape 1 : on commence simple, on complique après

import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Charger les variables du fichier .env
load_dotenv()


def get_engine():
    """Crée et retourne la connexion à MySQL."""
    url = (
        f"mysql+pymysql://{os.getenv('MYSQL_USER')}:{os.getenv('MYSQL_PASSWORD')}"
        f"@{os.getenv('MYSQL_HOST')}:{os.getenv('MYSQL_PORT')}/{os.getenv('MYSQL_DATABASE')}"
    )
    return create_engine(url)


def extract_table(table_name: str) -> pd.DataFrame:
    """
    Lit une table MySQL et retourne un DataFrame pandas.

    Args:
        table_name: nom de la table à extraire

    Returns:
        DataFrame avec toutes les lignes de la table
    """
    engine = get_engine()
    print(f"📥 Extraction de la table : {table_name}")

    df = pd.read_sql(f"SELECT * FROM `{table_name}`", engine)

    print(f"✅ {len(df)} lignes extraites")
    print(f"📋 Colonnes : {list(df.columns)}")

    return df


# Test rapide — sera supprimé plus tard
if __name__ == "__main__":
    df = extract_table("clients")
    print(df.head())