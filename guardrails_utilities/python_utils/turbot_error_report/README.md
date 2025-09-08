# Turbot Error Report

A Python script to report Turbot Guardrails errors and alarms that are impacting the health of the Turbot platform.

## Overview

This script queries the Turbot Guardrails API to identify controls in ERROR or ALARM states within a specified time window. It's designed to help administrators quickly identify compliance violations and system errors that need attention.

## Features

- **Flexible Time Windows**: Report errors from the last 24 hours (default) or any custom time period
- **State Filtering**: Filter by control states (error, alarm, ok, skipped, tbd)
- **Resource Type Filtering**: Focus on specific resource types using full URIs
- **Multiple Output Formats**: Text (default), JSON, or CSV output
- **SSL Certificate Verification**: Option to disable SSL verification for self-signed certificates
- **Pagination Support**: Automatically handles large result sets
- **Command-Line Interface**: Easy to use with various options and flags
- **Comprehensive Test Suite**: Full unit test coverage with pytest

## Prerequisites

- Python 3.7 or higher
- Turbot CLI installed and configured
- Access to a Turbot Guardrails workspace

## Installation

1. **Clone or download the script files:**
   ```bash
   # Ensure you have the following files:
   # - turbot_error_report.py
   # - _turbot.py
   # - requirements.txt
   ```

2. **Create a virtual environment:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Make the script executable (optional but recommended):**
   ```bash
   chmod +x turbot_error_report.py
   ```
   **Note**: If you skip this step, you'll need to use `python3 turbot_error_report.py` instead of `./turbot_error_report.py`

5. **Verify Turbot CLI configuration:**
   ```bash
   turbot graphql --query 'query { turbot { id } }'
   ```

## Usage

### Basic Usage

```bash
# Default: Show errors and alarms from the last 24 hours
./turbot_error_report.py
# or
python3 turbot_error_report.py
```

### Command-Line Options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--hours` | | Time window in hours | 24 |
| `--states` | `-s` | Control states to include (error, alarm, ok, skipped, tbd) | error,alarm |
| `--resource-type` | `-r` | Filter by resource type using full URI (e.g., tmod:@turbot/aws-s3#/resource/types/bucket) | None |
| `--output` | `-o` | Output format (text, json, csv) | text |
| `--quiet` | `-q` | Only show count, no details | False |
| `--no-timestamp` | | Don't filter by timestamp | False |
| `--limit` | `-l` | Limit number of results (for testing) | None |
| `--debug` | | Enable debug output | False |
| `--insecure` | `-i` | Disable SSL certificate verification | False |

### Examples

#### Basic Reporting
```bash
# Show all errors and alarms from last 24 hours
python3 turbot_error_report.py

# Show only count
python3 turbot_error_report.py --quiet

# Last 48 hours
python3 turbot_error_report.py --hours 48
```

#### State Filtering
```bash
# Only ERROR states
python3 turbot_error_report.py --states error

# Only ALARM states
python3 turbot_error_report.py --states alarm

# Both ERROR and ALARM states (default)
python3 turbot_error_report.py --states error,alarm

# All states (no filtering)
python3 turbot_error_report.py --states error,alarm,ok,skipped,tbd
```

#### Resource Type Filtering
```bash
# AWS S3 Bucket resources (full URI required)
python3 turbot_error_report.py --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket"

# AWS EC2 Instance resources (full URI required)
python3 turbot_error_report.py --resource-type "tmod:@turbot/aws-ec2#/resource/types/instance"

# AWS IAM Role resources (full URI required)
python3 turbot_error_report.py --resource-type "tmod:@turbot/aws-iam#/resource/types/role"

# Azure Storage Account resources (full URI - if available in your workspace)
python3 turbot_error_report.py --resource-type "tmod:@turbot/azure-storage#/resource/types/storageAccount"
```

#### Output Formats
```bash
# JSON output for programmatic use
python3 turbot_error_report.py --output json

# CSV output for spreadsheet analysis
python3 turbot_error_report.py --output csv > errors.csv

# Text output (default)
python3 turbot_error_report.py --output text
```

#### Testing and Debugging
```bash
# Limit results for testing
python3 turbot_error_report.py --limit 10

# Enable debug output
python3 turbot_error_report.py --debug

# Test with no time filter
python3 turbot_error_report.py --no-timestamp --limit 5
```

#### SSL Certificate Verification
```bash
# Disable SSL certificate verification (for self-signed certificates)
python3 turbot_error_report.py --insecure

# Use with other options
python3 turbot_error_report.py --insecure --debug --limit 5
```

#### Combined Examples
```bash
# S3 alarms from last 7 days, JSON output
python3 turbot_error_report.py --hours 168 --states alarm --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket" --output json

# Specific AWS S3 Bucket type, last 48 hours
python3 turbot_error_report.py --hours 48 --resource-type "tmod:@turbot/aws-s3#/resource/types/bucket"

# All errors (no time limit), CSV output
python3 turbot_error_report.py --states error --no-timestamp --output csv

# Quick count of recent alarms
python3 turbot_error_report.py --states alarm --quiet
```

## Output Formats

### Text Format (Default)
```
[2025-09-03T00:40:42.866Z] AWS > S3 > Bucket > Encryption at Rest | Resource: Turbot > Dunder Mifflin > Nashua > 574345774624 > us-east-1 > test-unencrypted-bucket-1756859454 (rid:363344552273846) | State: alarm | Reason: Default Encryption at Rest and Encryption at Rest Policy is not set as per policy

Total: 76
```

### JSON Format
```json
[
  {
    "state": "alarm",
    "reason": "Default Encryption at Rest and Encryption at Rest Policy is not set as per policy",
    "turbot": {
      "id": "363344552760452",
      "stateChangeTimestamp": "2025-09-03T00:40:42.866Z"
    },
    "type": {
      "trunk": {
        "title": "AWS > S3 > Bucket > Encryption at Rest"
      },
      "uri": "tmod:@turbot/aws-s3#/control/types/bucketEncryption"
    },
    "resource": {
      "trunk": {
        "title": "Turbot > Dunder Mifflin > Nashua > 574345774624 > us-east-1 > test-unencrypted-bucket-1756859454"
      },
      "turbot": {
        "id": "363344552273846"
      }
    }
  }
]
```

### CSV Format
```csv
Timestamp,Control Type,Resource,Resource ID,State,Reason
2025-09-03T00:40:42.866Z,AWS > S3 > Bucket > Encryption at Rest,Turbot > Dunder Mifflin > Nashua > 574345774624 > us-east-1 > test-unencrypted-bucket-1756859454,363344552273846,alarm,Default Encryption at Rest and Encryption at Rest Policy is not set as per policy
```

## Finding Resource Type URIs

### From Turbot Guardrails Hub
1. Visit [hub.guardrails.turbot.com](https://hub.guardrails.turbot.com)
2. Navigate to the specific resource type (e.g., AWS S3 Bucket)
3. Copy the **Resource Type URI** from the page
4. Use it with the `--resource-type` parameter

### Examples of Resource Type URIs
```bash
# AWS S3 Bucket
tmod:@turbot/aws-s3#/resource/types/bucket

# AWS EC2 Instance  
tmod:@turbot/aws-ec2#/resource/types/instance

# Azure Storage Account
tmod:@turbot/azure-storage#/resource/types/storageAccount

# GCP Compute Instance
tmod:@turbot/gcp-compute#/resource/types/instance
```

### Finding Resource Type URIs
**Note**: Available resource types depend on your workspace configuration. Use `turbot graphql --query 'query { resourceTypes { items { trunk { title } uri } } }'` to see what's available.

**Important**: Only full URIs are supported. Short forms like `s3` or `ec2` are no longer accepted.

## Understanding the Results

### Control States
- **ERROR**: System or technical errors that prevent proper evaluation
- **ALARM**: Compliance violations or policy violations detected
- **OK**: Compliant with policies
- **SKIPPED**: Policy set to skip evaluation
- **TBD**: To be determined (evaluation pending)

### Timestamp Filter
The `timestamp:>=T-24h` filter captures controls that **changed state** to ERROR or ALARM within the specified time window. This means:
- ✅ Controls that went from OK → ALARM in the last 24h
- ✅ Controls that went from SKIPPED → ERROR in the last 24h
- ❌ Controls that have been in ALARM state for weeks (unless they changed recently)

## Integration Examples

### Monitoring Script
```bash
#!/bin/bash
# Check for critical errors every hour
ERROR_COUNT=$(python3 turbot_error_report.py --states error --quiet)
if [ "$ERROR_COUNT" -gt 0 ]; then
    echo "CRITICAL: $ERROR_COUNT system errors detected"
    # Send alert, create ticket, etc.
fi
```

### Daily Report
```bash
#!/bin/bash
# Generate daily compliance report
DATE=$(date +%Y-%m-%d)
python3 turbot_error_report.py --hours 24 --output csv > "compliance-report-${DATE}.csv"
```

### API Integration
```python
import subprocess
import json

# Get errors as Python dictionary
result = subprocess.run([
    'python3', 'turbot_error_report.py', 
    '--output', 'json', '--states', 'error,alarm'
], capture_output=True, text=True)

errors = json.loads(result.stdout)
for error in errors:
    print(f"Control: {error['type']['trunk']['title']}")
    print(f"State: {error['state']}")
    print(f"Reason: {error['reason']}")
```

## Troubleshooting

### Common Issues

1. **ImportError: cannot import name 'XDG_CONFIG_HOME' from 'xdg'**
   ```bash
   pip uninstall xdg
   pip install xdg==5.1.1
   ```

2. **GraphQL errors about unknown arguments**
   - Ensure you're using the correct Turbot CLI version
   - Check that your workspace supports the GraphQL schema

3. **No results returned**
   - Try `--no-timestamp` to see if there are any matching controls
   - Check with `--debug` to see the actual filters being applied
   - Verify your Turbot CLI credentials are working

4. **Permission errors**
   - Ensure your Turbot CLI is properly configured
   - Check that you have access to the workspace

### Debug Mode
Use `--debug` to see detailed information about the query being executed:
```bash
python3 turbot_error_report.py --debug --limit 1
```

## Files

- `turbot_error_report.py` - Main script
- `_turbot.py` - Turbot CLI integration module (do not modify)
- `requirements.txt` - Python dependencies
- `tests/` - Test suite directory
  - `test_turbot.py` - Tests for _turbot.py module
  - `test_turbot_error_report.py` - Tests for main script
  - `conftest.py` - Test configuration and fixtures
- `README.md` - This documentation

## Testing

The script includes a comprehensive test suite with 36 unit tests covering all functionality:

### Running Tests

```bash
# Run all tests
pytest tests/ -v

# Run with coverage report
pytest tests/ --cov=. --cov-report=term-missing -v

# Run specific test file
pytest tests/test_turbot.py -v
```

### Test Coverage

- **Overall Coverage**: 89%
- **Core Functionality**: 97% coverage
- **SSL Verification Feature**: 100% coverage
- **Test Categories**: SSL verification, argument parsing, filter building, output formatting, error handling, integration tests

## Dependencies

### Runtime Dependencies
- `requests>=2.25.0` - HTTP requests
- `PyYAML>=5.4.0` - YAML configuration parsing
- `xdg>=5.1.1` - XDG Base Directory specification support

### Development Dependencies
- `pytest>=7.0.0` - Testing framework
- `pytest-mock>=3.10.0` - Enhanced mocking capabilities

## License

This script is provided as-is for Turbot Guardrails customers. Please ensure compliance with your organization's policies when using this tool.

## Support

For issues related to:
- **Script functionality**: Check this README and use `--debug` mode
- **Turbot CLI**: Refer to Turbot CLI documentation
- **API access**: Contact your Turbot administrator
- **Workspace configuration**: Check with your Turbot workspace administrator
