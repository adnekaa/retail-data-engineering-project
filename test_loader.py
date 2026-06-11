from ingestion.loader import load_csv_to_snowflake

from pathlib import Path

raw_folder = Path("data/raw/")

for csv_file in raw_folder.glob("*.csv"):
    table_name = csv_file.stem.upper()
    load_csv_to_snowflake(
        file_path=csv_file,
        table_name=table_name
    )