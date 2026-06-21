# Apache Spark Basics Assignment

## Objective

The objective of this assignment is to learn the fundamentals of Apache Spark and perform data cleaning, transformation, and analysis using Spark DataFrames.

---

## What is Apache Spark?

Apache Spark is an open-source distributed computing framework designed for large-scale data processing. It is faster than traditional Hadoop MapReduce because it performs computations in memory instead of repeatedly reading and writing data to disk.

### Why Spark is Faster than MapReduce?

| MapReduce                  | Apache Spark                                  |
| -------------------------- | --------------------------------------------- |
| Disk-based processing      | In-memory processing                          |
| Slower for iterative tasks | Faster execution                              |
| Complex programming model  | Easy DataFrame API                            |
| Limited analytics support  | Supports SQL, ML, Streaming, Graph Processing |

---

## Technologies Used

* Python
* Apache Spark (PySpark)
* Jupyter Notebook
* Pandas

---

## Project Structure

```text
spark-assignment/
│── data/
│   └── dataset.csv
│
│── notebook/
│   └── spark_basics.ipynb
│
│── output/
│   └── results.csv
│
│── README.md
```

---

## Tasks Performed

### Step 1: Spark Session Creation

Created a SparkSession to initialize the Spark application.

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Spark Basics Assignment") \
    .getOrCreate()
```

---

### Step 2: Data Loading

Loaded the CSV dataset into a Spark DataFrame.

```python
df = spark.read.csv(
    "../data/dataset.csv",
    header=True,
    inferSchema=True
)
```

Performed:

* Displayed first few rows
* Viewed column names
* Checked schema and data types

---

### Step 3: Data Cleaning

#### Remove Duplicate Rows

```python
df = df.dropDuplicates()
```

#### Handle Missing Values

```python
df = df.na.fill({"age": 0})
```

Performed:

* Removed duplicate records
* Filled missing values

---

### Step 4: Data Filtering

Applied filters based on different conditions.

Examples:

```python
df.filter(df.age > 25).show()
df.filter(df.region == "North").show()
```

Performed:

* Filter by age
* Filter by category
* Filter by region

---

### Step 5: Data Transformation

#### Rename Columns

```python
df = df.withColumnRenamed("sales", "total_sales")
```

#### Change Data Types

```python
from pyspark.sql.functions import col

df = df.withColumn(
    "age",
    col("age").cast("integer")
)
```

Performed:

* Renamed columns
* Converted data types

---

### Step 6: Aggregation

Performed basic statistical analysis.

#### Total Rows

```python
df.count()
```

#### Average

```python
df.select(avg("sales")).show()
```

#### Minimum and Maximum

```python
df.select(
    min("sales"),
    max("sales")
).show()
```

Performed:

* Count
* Average
* Minimum
* Maximum

---

### Step 7: Grouping Data

Grouped records and applied aggregation functions.

```python
region_sales = df.groupBy("region") \
                 .sum("sales")
```

Examples:

```python
df.groupBy("region").count().show()

df.groupBy("region").avg("sales").show()
```

Performed:

* Count by region
* Average sales by region
* Total sales by region

---

### Step 8: Wide Transformations and Shuffle

#### Wide Transformation

Operations such as:

* groupBy()
* join()

require data movement across partitions.

#### Shuffle

Shuffle is the redistribution of data between partitions during wide transformations.

Effects:

* Increases network communication
* Can slow Spark jobs
* Should be minimized whenever possible

---

### Step 9: Pipeline Implementation

Created a complete Spark pipeline:

1. Load Data
2. Clean Data
3. Filter Data
4. Transform Columns
5. Perform Aggregations
6. Group Data
7. Save Results

---

### Step 10: Save Output

```python
region_sales_pd = region_sales.toPandas()

region_sales_pd.to_csv(
    "../output/results.csv",
    index=False
)
```

---

## Output

The processed results are stored in:

```text
output/results.csv
```

---

## Observations

* Spark DataFrames simplify large-scale data processing.
* Duplicate records were successfully removed.
* Missing values were handled efficiently.
* Filtering helped isolate meaningful records.
* Aggregations provided useful statistical insights.
* GroupBy operations helped analyze regional trends.
* In-memory computation makes Spark significantly faster than MapReduce.

---

## Conclusion

This assignment demonstrated the complete Spark DataFrame workflow including data loading, cleaning, filtering, transformation, aggregation, grouping, and exporting results. Apache Spark provides a fast and scalable solution for big data analytics and is widely used in modern data engineering and machine learning applications.
