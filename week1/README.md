# Dataset Cleaning & Analysis - Celebal Technologies Week 1

## Overview
This project is a **data cleaning and analysis assignment** that processes an e-commerce shopping dataset to prepare it for further analysis. The dataset contains product information from various categories with attributes like pricing, ratings, and customer reviews.

## Dataset Source
- **Source**: Kaggle Shopping Dataset
- **Link**: https://www.kaggle.com/datasets/anvitkumar/shopping-dataset?resource=download
- **File**: `dataset/Combined_dataset.csv`
- **Records**: 1,000 products
- **Columns**: 24 attributes

## Project Structure
```
├── cleaning_dataset.ipynb          # Main Jupyter notebook with data cleaning pipeline
├── dataset/
│   ├── Combined_dataset.csv        # Main combined dataset
│   ├── Shopping_dataset/           # Individual category CSV files
│   └── [100+ category-specific CSV files]
└── README.md                       # This file
```

## Data Cleaning Steps

### 1. **Data Exploration**
- Load dataset using pandas
- Display first and last rows
- Check dataset shape and column names
- Review data types
- Get detailed dataset information

### 2. **Missing Values Handling**
- Identified missing values in each column
- **Strategy**: 
  - Numeric columns: Fill with `0`
  - Categorical columns: Fill with `"Unknown"`

### 3. **Price Calculation**
- Discovered inconsistency in price mapping (initial_price, discount, final_price)
- **Recalculated**: `final_price = initial_price - (initial_price × discount / 100)`

### 4. **Duplicate Removal**
- Removed duplicate records from the dataset
- Ensured data uniqueness

### 5. **Feature Engineering**
- Created new column: `total_amount = final_price × ratings_count`
- Helps identify products with highest total sales impact

### 6. **Popular Products Filtering**
- Filtered products with rating > 4.0
- Selected relevant columns: product_id, title, description, rating, ratings_count, final_price, currency, category

## Key Columns in Dataset
| Column | Description |
|--------|-------------|
| `product_id` | Unique product identifier |
| `title` | Product name |
| `product_description` | Detailed product description |
| `rating` | Average product rating |
| `ratings_count` | Number of customer ratings |
| `initial_price` | Original product price |
| `discount` | Discount percentage |
| `final_price` | Price after discount (calculated) |
| `currency` | Price currency |
| `category` | Product category |
| `total_amount` | Total sales amount (calculated) |

## Technologies Used
- **Python 3.x**
- **Pandas**: Data manipulation and analysis
- **Jupyter Notebook**: Interactive data exploration

## Installation & Usage

### Prerequisites
```bash
pip install pandas
```

### Running the Notebook
```bash
# Navigate to project directory
cd "d:\celebal technologies\week1"

# Run Jupyter notebook
jupyter notebook cleaning_dataset.ipynb
```

## Output Insights
After cleaning and processing:
- ✅ Removed all missing values
- ✅ Fixed price calculation inconsistencies
- ✅ Removed duplicate records
- ✅ Identified ~X popular products (rating > 4)
- ✅ Created total sales amount metric

## Files Generated
- Cleaned and processed data in memory during notebook execution
- Analysis results and visualizations available in notebook cells

## Date
May 23, 2026

---
**Note**: The notebook executes sequentially, performing data cleaning operations on the Combined_dataset.csv file and storing results in pandas DataFrames for further analysis.
