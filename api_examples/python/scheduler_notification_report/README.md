# Project Setup

## Prerequisites
- Python 3.x
- `virtualenv` package

## Setup Instructions

### 1. Create and Activate Virtual Environment
```bash
# Navigate to your project directory
cd /path/to/scheduler_report

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
# On macOS/Linux
source venv/bin/activate
# On Windows
venv\Scripts\activate
```

### 2. Install Dependencies
```bash
# Ensure you are in the virtual environment
pip install -r requirements.txt
```

### 3. Update Configuration
Edit the `config.yaml` file to include your workspace url and access keys:
```yaml
workspace-url: "https://turbot-demo.cloud.turbot.com"  
api-access-key: "YOUR_ACCESS_KEY"
api-secret-key: "YOUR_SECRET_KEY"
```

### 4. Run the Script
```bash
# Ensure the virtual environment is activated
python scheduler_notification_report.py
```

## Expected Outputs
- Outputs a csv file with the matching event activity