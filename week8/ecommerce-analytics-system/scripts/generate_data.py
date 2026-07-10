"""
generate_data.py
Generates synthetic e-commerce datasets with intentional inconsistencies.
"""

import os, random
from datetime import datetime, timedelta
import numpy as np
import pandas as pd
from faker import Faker

fake = Faker()
Faker.seed(42)
random.seed(42)
np.random.seed(42)

NUM_CUSTOMERS=500
NUM_PRODUCTS=150
NUM_ORDERS=5000
NUM_ORDER_ITEMS=12000

RAW=os.path.join("data","raw")
os.makedirs(RAW, exist_ok=True)

cats=["Electronics","Fashion","Home","Books","Sports","Beauty","Toys","Grocery"]

# Customers
customers=[]
for i in range(1,NUM_CUSTOMERS+1):
    customers.append({
        "customer_id":i,
        "name":fake.name(),
        "email":fake.email(),
        "city":fake.city(),
        "signup_date":fake.date_between(start_date="-3y", end_date="today")
    })
customers=pd.DataFrame(customers)
customers.loc[np.random.choice(customers.index,15,False),"email"]=None
customers.loc[np.random.choice(customers.index,10,False),"city"]=None
customers=pd.concat([customers,customers.sample(8,random_state=1)],ignore_index=True)

# Products
products=[]
for i in range(1,NUM_PRODUCTS+1):
    products.append({
        "product_id":i,
        "category":random.choice(cats),
        "product_name":fake.word().title(),
        "price":round(random.uniform(5,2000),2)
    })
products=pd.DataFrame(products)
products.loc[np.random.choice(products.index,5,False),"price"]*=-1
products.loc[np.random.choice(products.index,4,False),"category"]=None
products=pd.concat([products,products.sample(5,random_state=2)],ignore_index=True)

# Orders
statuses=["Delivered","Cancelled","Returned","Pending","Shipped"]
orders=[]
for i in range(1,NUM_ORDERS+1):
    cid=random.randint(1,NUM_CUSTOMERS)
    if random.random()<0.02:
        cid=NUM_CUSTOMERS+random.randint(1,50)
    dt=fake.date_between(start_date="-2y",end_date="today")
    if random.random()<0.02:
        dt=(datetime.today()+timedelta(days=random.randint(1,60))).date()
    orders.append({
        "order_id":i,
        "customer_id":cid,
        "order_date":dt,
        "status":random.choice(statuses)
    })
orders=pd.DataFrame(orders)
orders=pd.concat([orders,orders.sample(10,random_state=3)],ignore_index=True)

# Order items
items=[]
for i in range(1,NUM_ORDER_ITEMS+1):
    oid=random.randint(1,NUM_ORDERS)
    if random.random()<0.02:
        oid=NUM_ORDERS+random.randint(1,100)
    pid=random.randint(1,NUM_PRODUCTS)
    if random.random()<0.02:
        pid=NUM_PRODUCTS+random.randint(1,50)
    qty=random.randint(1,5)
    if random.random()<0.02:
        qty*=-1
    items.append({
        "item_id":i,
        "order_id":oid,
        "product_id":pid,
        "quantity":qty
    })
items=pd.DataFrame(items)
items=pd.concat([items,items.sample(20,random_state=4)],ignore_index=True)

customers.to_csv(os.path.join(RAW,"customers.csv"),index=False)
products.to_csv(os.path.join(RAW,"products.csv"),index=False)
orders.to_csv(os.path.join(RAW,"orders.csv"),index=False)
items.to_csv(os.path.join(RAW,"order_items.csv"),index=False)

print("Generation complete")
for n,df in [("Customers",customers),("Products",products),("Orders",orders),("Order Items",items)]:
    print(f"{n}: {len(df)} rows")
