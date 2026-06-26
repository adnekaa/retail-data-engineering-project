import great_expectations as gx
import pandas as pd

context = gx.get_context()

def validate_file(file_path, expectations):
    df = pd.read_csv(file_path)
    ds = context.sources.add_or_update_pandas(name="retail_source")
    da = ds.add_dataframe_asset(name=file_path)
    batch = da.build_batch_request(dataframe=df)

    suite_name = file_path.replace("/", "_").replace(".", "_")
    suite = context.add_or_update_expectation_suite(suite_name)
    validator = context.get_validator(batch_request=batch, expectation_suite=suite)

    for exp in expectations:
        getattr(validator, exp["type"])(**exp["kwargs"])

    validator.save_expectation_suite()
    results = validator.validate()
    return results

receiptdetails_expectations = [
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "ReceiptID"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "Barcode"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "Itemcount"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "ReceiptDate"}},
]

be_expectations = [
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "id"}},
    {"type": "expect_column_values_to_be_unique", "kwargs": {"column": "id"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "idsupplier"}},
]

bedetails_expectations = [
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "id"}},
    {"type": "expect_column_values_to_be_unique", "kwargs": {"column": "id"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "beid"}},
    {"type": "expect_column_values_to_not_be_null", "kwargs": {"column": "itemid"}},
]

if __name__ == "__main__":
    checks = [
        ("data/raw/receiptdetails.csv", receiptdetails_expectations),
        ("data/raw/be.csv", be_expectations),
        ("data/raw/bedetails.csv", bedetails_expectations),
    ]

    all_passed = True
    for file_path, expectations in checks:
        print(f"\n🔍 Validation de {file_path}...")
        results = validate_file(file_path, expectations)
        success = results["success"]
        print(f"{'✅ PASS' if success else '❌ FAIL'} — {file_path}")
        if not success:
            all_passed = False

    if not all_passed:
        raise SystemExit("❌ Data quality checks échoués — pipeline arrêté.")
    print("\n✅ Tous les checks qualité sont passés.")
