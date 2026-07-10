"""
load_database.py

Purpose:
--------
1. Connect to MySQL
2. Create tables using schema.sql
3. Load cleaned CSV files into MySQL
4. Verify row counts
"""

import os
import pandas as pd
from sqlalchemy import create_engine, text

# ====================================================
# MySQL Configuration
# ====================================================

MYSQL_USER = "root"
MYSQL_PASSWORD = "3932"
MYSQL_HOST = "localhost"
MYSQL_PORT = "3306"
MYSQL_DATABASE = "ecommerce_analytics"

# ====================================================
# Paths
# ====================================================

SCHEMA = os.path.join("sql", "schema.sql")
DATA = os.path.join("data", "cleaned")

# ====================================================
# Create SQLAlchemy Engine
# ====================================================

print("Connecting to MySQL...")

engine = create_engine(
    f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"
)

# ====================================================
# Execute schema.sql
# ====================================================

print("Creating tables...")

with engine.begin() as connection:
    with open(SCHEMA, "r", encoding="utf-8") as file:
        sql_script = file.read()

    # Execute each statement separately
    for statement in sql_script.split(";"):
        statement = statement.strip()
        if statement:
            connection.execute(text(statement))

print("Tables created successfully.")

# ====================================================
# Load CSV Files
# ====================================================

print("Loading cleaned CSV files...")

customers = pd.read_csv(os.path.join(DATA, "customers_clean.csv"))
products = pd.read_csv(os.path.join(DATA, "products_clean.csv"))
orders = pd.read_csv(os.path.join(DATA, "orders_clean.csv"))
order_items = pd.read_csv(os.path.join(DATA, "order_items_clean.csv"))

# ====================================================
# Insert Data
# ====================================================

print("Loading Customers...")
customers.to_sql(
    "customers",
    con=engine,
    if_exists="append",
    index=False
)

print("Loading Products...")
products.to_sql(
    "products",
    con=engine,
    if_exists="append",
    index=False
)

print("Loading Orders...")
orders.to_sql(
    "orders",
    con=engine,
    if_exists="append",
    index=False
)

print("Loading Order Items...")
order_items.to_sql(
    "order_items",
    con=engine,
    if_exists="append",
    index=False
)

print("\nAll data loaded successfully.")

# ====================================================
# Verify Row Counts
# ====================================================

print("\nDatabase Summary")
print("-" * 40)

tables = [
    "customers",
    "products",
    "orders",
    "order_items"
]

with engine.connect() as connection:
    for table in tables:
        result = connection.execute(
            text(f"SELECT COUNT(*) FROM {table}")
        )

        count = result.scalar()

        print(f"{table:<15} {count}")

print("\nDatabase Created Successfully!")