# AWS Account Import Lambda example

This repository contains a Python Lambda function designed to import an AWS account into Turbot Guardrails using the GraphQL API. The Lambda function (`lambda_handler`) orchestrates the import process via the Guardrails GraphQL API.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Environment Variables](#environment-variables)
- [GraphQL Queries and Mutations](#graphql-queries-and-mutations)
- [Error Handling](#error-handling)
- [Logging](#logging)

## Prerequisites

- AWS account with a predefined IAM cross account role
- Turbot Guardrails access and admin level permissions
- Python 3.7 or later
- Boto3 library for AWS SDK

## Installation

1. Clone the repository:

   ```sh
   git clone <repository-url>
   cd <repository-directory>


2. Install the required dependencies:

```sh
pip install -r requirements.txt
```

Usage

The script is designed to be executed as an AWS Lambda function. The lambda_handler function is the entry point for the Lambda.

Running Locally

To run the script locally, ensure you have set the required environment variables (see below) and then execute the script:

```sh
python3 account_create.py
```

Deploying to AWS Lambda

	1.	Zip the contents of the directory:

  ```sh
  zip -r lambda_function.zip .
  ```

  2.	Deploy the zip file to AWS Lambda using the AWS CLI:

  ```sh
  aws lambda update-function-code --function-name <your-lambda-function-name> --zip-file fileb://lambda_function.zip
  ```


## Environment Variables

The following environment variables must be set for the Lambda function to work correctly:

	•	AWS_ACCOUNT_ID: The AWS account ID to import.
	•	AWS_PARTITION: The AWS partition (e.g., aws, aws-cn, aws-us-gov).
	•	TURBOT_PARENT_ID: The parent folder ID in Turbot.
	•	TURBOT_ROLE_ARN: The IAM role ARN for Turbot.
	•	TURBOT_ROLE_EXT_ID: The external ID for the IAM role in Turbot.

These variables can be set in the AWS Lambda console or through the AWS CLI.

## GraphQL Queries and Mutations

The script uses the following GraphQL mutations to interact with the Turbot API:

	•	CreateAWSAccount: Creates an AWS account resource in Turbot.
	•	SetIamRoleArnPolicy: Sets the IAM Role ARN policy for the AWS account.
	•	SetIamRoleExternalIdPolicy: Sets the IAM Role External ID policy for the AWS account.

The mutations are defined in the get_create_account_mutation and get_account_configuration_mutation functions.

## Error Handling

The script includes basic error handling to catch and log exceptions. Custom exceptions are defined for GraphQL-related errors:

	•	GraphQlException: Raised when a GraphQL query fails.

## Logging

The script uses Python’s built-in logging module to log information and errors. Logs include:

	•	Query and variables for each GraphQL request
	•	Results of the GraphQL queries
	•	Errors encountered during execution

Logs can be viewed in the AWS CloudWatch console when running as a Lambda function.

## Example

Below is an example of how to call the import_account function directly:\

```python
import os

# Set environment variables
os.environ['AWS_ACCOUNT_ID'] = '<aws_account_id>'
os.environ['AWS_PARTITION'] = '<aws_partition>'
os.environ['TURBOT_PARENT_ID'] = '<turbot_parent_id>'
os.environ['TURBOT_ROLE_ARN'] = '<turbot_role_arn>'
os.environ['TURBOT_ROLE_EXT_ID'] = '<turbot_role_ext_id>'

# Execute the import function
import_account(
    os.environ['AWS_ACCOUNT_ID'],
    os.environ['TURBOT_ROLE_ARN'],
    os.environ['TURBOT_ROLE_EXT_ID'],
    os.environ['TURBOT_PARENT_ID'],
    '<turbot_endpoint>',
    '<turbot_access_key>',
    '<turbot_secret_key>'
)
```
Replace the placeholder values with actual values from your AWS and Turbot configurations.
