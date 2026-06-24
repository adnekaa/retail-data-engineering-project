import pytest
import pandas as pd
from unittest.mock import patch, MagicMock
from ingestion.loader import load_csv_to_snowflake

# ─────────────────────────────────────────────
# TEST 1 : fichier CSV inexistant
# ─────────────────────────────────────────────
def test_fichier_inexistant():
    """Si le fichier n'existe pas, pandas doit lever une erreur."""
    with pytest.raises(FileNotFoundError):
        load_csv_to_snowflake(
            file_path="data/raw/inexistant.csv",
            table_name="TEST_TABLE"
        )

# ─────────────────────────────────────────────
# TEST 2 : chargement normal (Snowflake mocké)
# ─────────────────────────────────────────────
def test_chargement_normal(tmp_path):
    """Un CSV valide doit être chargé sans erreur."""
    # Crée un vrai fichier CSV temporaire
    csv_file = tmp_path / "clients.csv"
    csv_file.write_text("id,nom\n1,Alice\n2,Bob\n")

    with patch("ingestion.loader.get_connection") as mock_conn, \
         patch("ingestion.loader.write_pandas") as mock_write:

        # Simule une connexion Snowflake
        mock_conn.return_value.__enter__ = MagicMock(return_value=MagicMock())
        mock_conn.return_value.__exit__ = MagicMock(return_value=False)

        load_csv_to_snowflake(
            file_path=str(csv_file),
            table_name="CLIENTS"
        )

        # write_pandas a bien été appelé une fois
        assert mock_write.call_count == 1

# ─────────────────────────────────────────────
# TEST 3 : CSV vide
# ─────────────────────────────────────────────
def test_csv_vide(tmp_path):
    """Un CSV sans lignes de données doit charger 0 lignes sans planter."""
    csv_file = tmp_path / "vide.csv"
    csv_file.write_text("id,nom\n")  # header seulement

    with patch("ingestion.loader.get_connection") as mock_conn, \
         patch("ingestion.loader.write_pandas") as mock_write:

        mock_conn.return_value.__enter__ = MagicMock(return_value=MagicMock())
        mock_conn.return_value.__exit__ = MagicMock(return_value=False)

        load_csv_to_snowflake(
            file_path=str(csv_file),
            table_name="VIDE"
        )

        # write_pandas appelé même avec 0 lignes
        assert mock_write.call_count == 1