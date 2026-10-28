import requests
import pandas as pd


def extract_transactions(state, year, quarter):
    """
    Extract transaction data from PhonePe Pulse.
    """

    url = (
        "https://raw.githubusercontent.com/PhonePe/pulse/master/"
        f"data/aggregated/transaction/country/india/state/"
        f"{state}/{year}/{quarter}.json"
    )
    try:
        response = requests.get(url, timeout=10)
    except requests.RequestException as e:
        print(f"Request failed: {e}")
        return []

    print(f"Fetching: {state} | {year} | Q{quarter}")

    if response.status_code != 200:
        print(f"Failed! Status code: {response.status_code}")
        return []

    data = response.json()

    transaction_data = data["data"]["transactionData"]

    records = []

    for transaction in transaction_data:

        transaction_type = transaction["name"]

        payment = transaction["paymentInstruments"][0]

        count = payment["count"]
        amount = payment["amount"]

        records.append({
            "state": state,
            "year": year,
            "quarter": quarter,
            "transaction_type": transaction_type,
            "transaction_count": count,
            "transaction_amount": amount
        })

    return records


# States to extract
states = [
    "andaman-&-nicobar-islands",
    "andhra-pradesh",
    "arunachal-pradesh",
    "assam",
    "bihar",
    "chandigarh",
    "chhattisgarh",
    "dadra-&-nagar-haveli-&-daman-&-diu",
    "delhi",
    "goa",
    "gujarat",
    "haryana",
    "himachal-pradesh",
    "jammu-&-kashmir",
    "jharkhand",
    "karnataka",
    "kerala",
    "ladakh",
    "lakshadweep",
    "madhya-pradesh",
    "maharashtra",
    "manipur",
    "meghalaya",
    "mizoram",
    "nagaland",
    "odisha",
    "puducherry",
    "punjab",
    "rajasthan",
    "sikkim",
    "tamil-nadu",
    "telangana",
    "tripura",
    "uttar-pradesh",
    "uttarakhand",
    "west-bengal"
]

years = [2023,2024]

quarters = [1, 2, 3, 4]

all_records = []


# Extract data
for state in states:

    for year in years:

        for quarter in quarters:

            records = extract_transactions(
                state=state,
                year=year,
                quarter=quarter
            )

            all_records.extend(records)


# Convert to DataFrame
df = pd.DataFrame(all_records)
print("\nData Validation")

print("Rows:", len(df))
print("Columns:", df.columns.tolist())

print("\nMissing values:")
print(df.isnull().sum())

print("\nDuplicate rows:")
print(df.duplicated().sum())
# Data Quality Checks

if (df["transaction_count"] < 0).any():
    print("WARNING: Negative transaction counts found")
else:
    print("Transaction count check passed")


if (df["transaction_amount"] < 0).any():
    print("WARNING: Negative transaction amounts found")
else:
    print("Transaction amount check passed")


if df.empty:
    print("ERROR: No data extracted")
else:
    print("Data quality check passed")


print("\nFinal Data:")
print(df)

print(f"\nTotal rows: {len(df)}")


# Save data
output_file = "data/processed/upi_transactions.csv"

df.to_csv(output_file, index=False)

print(f"\nData saved successfully to: {output_file}")