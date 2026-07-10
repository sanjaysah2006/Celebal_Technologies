"""
report_cli.py

Command Line Reporting Tool

Usage:
python scripts/report_cli.py --report revenue
python scripts/report_cli.py --report top_products
python scripts/report_cli.py --report top_customers
python scripts/report_cli.py --report retention
python scripts/report_cli.py --report rfm
"""

import argparse
import pandas as pd
from sqlalchemy import create_engine
from tabulate import tabulate

# ===========================================
# MySQL Configuration
# ===========================================

engine = create_engine(
    "mysql+pymysql://root:3932@localhost:3306/ecommerce_analytics"
)

# ===========================================
# SQL Queries
# ===========================================

queries = {

    "revenue": """
    SELECT
        DATE_FORMAT(order_date,'%%Y-%%m') AS month,
        ROUND(SUM(oi.quantity*p.price),2) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id=oi.order_id
    JOIN products p
        ON oi.product_id=p.product_id
    GROUP BY month
    ORDER BY month;
    """,

    "top_products": """
    SELECT
        p.product_name,
        SUM(oi.quantity) total_quantity,
        ROUND(SUM(oi.quantity*p.price),2) revenue
    FROM products p
    JOIN order_items oi
        ON p.product_id=oi.product_id
    GROUP BY p.product_id,p.product_name
    ORDER BY revenue DESC
    LIMIT 10;
    """,

    "top_customers": """
    SELECT
        c.customer_id,
        c.name,
        ROUND(SUM(oi.quantity*p.price),2) total_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id=o.customer_id
    JOIN order_items oi
        ON o.order_id=oi.order_id
    JOIN products p
        ON oi.product_id=p.product_id
    GROUP BY c.customer_id,c.name
    ORDER BY total_revenue DESC
    LIMIT 10;
    """,

    "retention": """
    WITH first_purchase AS
    (
        SELECT
            customer_id,
            MIN(order_date) first_purchase
        FROM orders
        GROUP BY customer_id
    )

    SELECT
        DATE_FORMAT(first_purchase,'%%Y-%%m') cohort,
        COUNT(*) customers
    FROM first_purchase
    GROUP BY cohort
    ORDER BY cohort;
    """,

    "rfm": """
    SELECT
        c.customer_id,
        c.name,

        DATEDIFF(CURDATE(),MAX(o.order_date)) recency,

        COUNT(DISTINCT o.order_id) frequency,

        ROUND(SUM(oi.quantity*p.price),2) monetary

    FROM customers c
    JOIN orders o
        ON c.customer_id=o.customer_id
    JOIN order_items oi
        ON o.order_id=oi.order_id
    JOIN products p
        ON oi.product_id=p.product_id

    GROUP BY c.customer_id,c.name

    ORDER BY monetary DESC
    LIMIT 20;
    """
}

# ===========================================
# Argument Parser
# ===========================================

parser = argparse.ArgumentParser(
    description="E-Commerce Analytics Reporting Tool"
)

parser.add_argument(
    "--report",
    required=True,
    choices=queries.keys(),
    help="Choose report to generate"
)

args = parser.parse_args()

# ===========================================
# Execute Query
# ===========================================

try:

    df = pd.read_sql(
        queries[args.report],
        engine
    )

    if df.empty:
        print("\nNo data found.\n")

    else:

        print("\n")
        print("="*70)
        print(args.report.upper(),"REPORT")
        print("="*70)

        print(
            tabulate(
                df,
                headers="keys",
                tablefmt="grid",
                showindex=False,
                floatfmt=",.2f"
            )
        )

except Exception as e:

    print("\nDatabase Error")
    print(e)