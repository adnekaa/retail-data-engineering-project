import os
from pathlib import Path
import snowflake.connector
from dotenv import load_dotenv
import pandas as pd
from snowflake.connector.pandas_tools import write_pandas
load_dotenv()  # ✅ Parfait

def get_connection():  # ✅ Bonne idée de séparer la connexion
    return snowflake.connector.connect(
        user=os.getenv("SNOWFLAKE_USER"),          # ✅
        password=os.getenv("SNOWFLAKE_PASSWORD"),  # ✅
        account=os.getenv("SNOWFLAKE_ACCOUNT"),    # ✅
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),# ✅
        database=os.getenv("SNOWFLAKE_DATABASE"),  # ✅
        schema=os.getenv("SNOWFLAKE_SCHEMA"),  
        role=os.getenv("SNOWFLAKE_ROLE")          # ✅
    )
def load_csv_to_snowflake(
    file_path,
    table_name,
    catalog="POS_RETAIL",
    schema="SOURCE",
    separator=",",
    mode="overwrite"):
    print(f"Chargement de {file_path} vers {catalog}.{schema}.{table_name}...")
    df = pd.read_csv(file_path, sep=separator)
    with get_connection() as conn:
        cursor = conn.cursor()
        if mode == "overwrite":
            cursor.execute(f"DROP TABLE IF EXISTS {catalog}.{schema}.{table_name}")
        write_pandas(conn,df,database=catalog, table_name=table_name, schema=schema,auto_create_table=True)    
        print(f"✅ {len(df)} lignes chargées dans {catalog}.{schema}.{table_name} terminé.")
        cursor.close()
