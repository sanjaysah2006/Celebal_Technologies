# Azure Cloud Fundamentals and Data Pipeline Implementation using Azure Data Factory

## Objective
The objective of this assignment is to understand Azure cloud fundamentals and implement a complete data pipeline using Azure Storage Account and Azure Data Factory (ADF). The pipeline reads a CSV file from Azure Blob Storage, validates file metadata, and copies the data to a destination location.

---

## Technologies Used

- Microsoft Azure Portal
- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory (ADF)
- Azure IAM (Identity and Access Management)

---

## Assignment Tasks

### Task 1: Resource Group Creation

#### Steps Performed

1. Logged into Azure Portal.
2. Created a Resource Group.
3. Selected appropriate subscription and region.

#### Deliverable

- Screenshot of Resource Group creation.

---

### Task 2: Storage Setup

#### Steps Performed

1. Created Azure Storage Account.
2. Created Blob Containers: `source-data`
3. `destination-data`
4. Uploaded source file: `superstore.csv`

#### Deliverable

- Screenshot of Blob Container with uploaded CSV file.

---

### Task 3: Azure Data Factory Basics

#### Steps Performed

##### Azure Data Factory Creation

1. Created Azure Data Factory instance.
2. Launched ADF Studio.

##### Linked Service

1. Created Linked Service connecting Azure Blob Storage.

##### Datasets
Created:

- Source Dataset → `superstore.csv`
- Destination Dataset → destination container

##### Get Metadata Activity
Configured metadata validation for:

- Exists
- Size
- Last Modified

#### Deliverables

- Screenshot of Linked Service
- Screenshot of Source Dataset
- Screenshot of Destination Dataset
- Screenshot of Get Metadata Activity

---

### Task 4: Pipeline Development

#### Pipeline Name

```
SuperstorePipeline
```

#### Activities Used

##### Get Metadata
Validates source file information.

##### Copy Data
Copies data from source container to destination container.

#### Pipeline Flow

```
Get Metadata
      ↓
Copy Data
```

#### Deliverable

- Screenshot of Pipeline Design

---

### Task 5: Pipeline Execution

#### Steps Performed

1. Validated pipeline.
2. Published pipeline.
3. Executed using Debug option.
4. Monitored execution status.

#### Execution Result

```
Pipeline Status : Succeeded
```
Both activities completed successfully:

```
Get Metadata : Succeeded
Copy Data    : Succeeded
```

#### Deliverable

- Screenshot showing successful pipeline execution.

---

### Task 6: IAM Role Assignments

#### Roles Assigned

##### Reader
Assigned to user account.

##### Storage Blob Data Contributor
Assigned to Azure Data Factory Managed Identity.

##### Owner
Already assigned at Subscription Level.

> Note: Owner role provides higher privileges than Contributor and includes all Contributor permissions.

#### Deliverable

- Screenshot of IAM Role Assignments.

---

## Mini Project

### Problem Statement
Build a complete Azure Data Factory pipeline that reads a CSV file from Azure Blob Storage, validates metadata, and copies the file to a destination location.

---

## Architecture

```
superstore.csv
       │
       ▼
Azure Blob Storage
       │
       ▼
Linked Service
       │
       ▼
Source Dataset
       │
       ▼
Get Metadata
       │
       ▼
Copy Data
       │
       ▼
Destination Dataset
       │
       ▼
Destination Container
```

---

## Source Details

- Source File: `superstore.csv`
- Source Container: `source-data`
- Storage Type: Azure Blob Storage

---

## Destination Details

- Destination Container: `destination-data`
- Output File: `superstore_copy.csv`

---

## Validation Performed
Using Get Metadata activity:

- File existence validation
- File size validation
- Last modified timestamp validation

---

## Data Processing
Using Copy Data activity:

- Read data from source container
- Copied data to destination container
- Preserved source file structure

---

## Results

| Requirement | Status |
| --- | --- |
| Resource Group Created | ✅ Completed |
| Storage Account Created | ✅ Completed |
| Blob Container Created | ✅ Completed |
| CSV File Uploaded | ✅ Completed |
| Linked Service Created | ✅ Completed |
| Datasets Created | ✅ Completed |
| Metadata Validation Completed | ✅ Completed |
| Copy Data Executed | ✅ Completed |
| Pipeline Executed Successfully | ✅ Completed |
| Data Copied to Destination | ✅ Completed |
| IAM Roles Configured | ✅ Completed |

---

## Conclusion
A complete Azure Data Pipeline was successfully implemented using Azure Data Factory and Azure Blob Storage. The source CSV file (`superstore.csv`) was validated using the Get Metadata activity and copied to the destination container using the Copy Data activity. The pipeline executed successfully, demonstrating Azure cloud fundamentals, storage management, data movement, metadata validation, and IAM role configuration.
