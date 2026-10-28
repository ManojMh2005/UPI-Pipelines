import pandas as pd


# Load extracted data
input_file = "data/processed/upi_transactions.csv"

df = pd.read_csv(input_file)

print("Original Data:")
print(df.head())


# -----------------------------
# Data Type Conversion
# -----------------------------

df["year"] = df["year"].astype(int)
df["quarter"] = df["quarter"].astype(int)

df["transaction_count"] = df["transaction_count"].astype(int)
df["transaction_amount"] = df["transaction_amount"].astype(float)


# -----------------------------
# Create Quarter Label
# -----------------------------

df["quarter_label"] = "Q" + df["quarter"].astype(str)


# -----------------------------
# Create Period Column
# -----------------------------

df["period"] = (
    df["year"].astype(str)
    + "-"
    + df["quarter_label"]
)


# -----------------------------
# Calculate Average Transaction Value
# -----------------------------

df["average_transaction_value"] = (
    df["transaction_amount"]
    / df["transaction_count"]
)


# -----------------------------
# Display Transformed Data
# -----------------------------

print("\nTransformed Data:")
print(df.head())

print("\nColumns:")
print(df.columns.tolist())


# -----------------------------
# Save Transformed Data
# -----------------------------

output_file = "data/processed/upi_transactions_transformed.csv"

df.to_csv(output_file, index=False)

print(f"\nTransformed data saved to: {output_file}")