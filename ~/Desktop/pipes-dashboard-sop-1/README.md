# Standard Operating Procedure: Accessing AWS PCI DSS v4.0 Benchmark in Turbot Pipes

## Overview
This SOP provides step-by-step instructions for accessing and viewing the AWS PCI DSS v4.0 benchmark dashboard in Turbot Pipes.

## Prerequisites
- Access to Turbot Pipes (https://pipes.turbot.com)
- Valid login credentials (GitHub or Email)
- Access to the turbot-ops organization
- Access to the rajtest workspace

## Process

### 1. Login to Turbot Pipes
1. Navigate to https://pipes.turbot.com
2. Click "Continue with GitHub" or use your preferred authentication method
3. If prompted, select the turbot-ops organization

### 2. Navigate to Workspace
1. From the organization view, select the "rajtest" workspace
2. Wait for the workspace dashboard to load
3. Click on the "Powerpipe" service

### 3. Access PCI DSS v4.0 Benchmark
1. Click on "Dashboards" in the top navigation
2. Locate and click on "AWS PCI DSS v4.0 Benchmark" in the dashboard list
3. Wait for the benchmark data to load completely

## Current Compliance Status

### Overall Metrics
- OK: 7,140 items
- Alarm: 46,953 items
- Error: 0 items
- Info: 622 items
- Skipped: 382 items

### Key Requirements Status

1. **Appendix A1: Additional PCI DSS Requirements for Multi-Tenant Service Providers**
   - Alarm: 842
   - OK: 444

2. **Appendix A3: Designated Entities Supplemental Validation (DESV)**
   - Alarm: 1,170
   - OK: 205
   - Info: 1
   - Skipped: 32

3. **Network Security Controls (Requirement 1)**
   - Alarm: 513
   - OK: 1,108

4. **System Component Configurations (Requirement 2)**
   - Alarm: 174
   - OK: 10

5. **Account Data Protection (Requirement 3)**
   - Alarm: 2,952
   - OK: 857

6. **Data Transmission Security (Requirement 4)**
   - Alarm: 166
   - OK: 60

7. **Secure Systems and Software (Requirement 6)**
   - Alarm: 1
   - OK: 0

8. **Access Restrictions (Requirement 7)**
   - Alarm: 16,353
   - OK: 2,360
   - Info: 416
   - Skipped: 16

9. **User Authentication (Requirement 8)**
   - Alarm: 16,028
   - OK: 1,260
   - Info: 205

10. **System Monitoring (Requirement 10)**
    - Alarm: 6,858
    - OK: 428
    - Skipped: 127

11. **Security Testing (Requirement 11)**
    - Alarm: 1,411
    - OK: 408
    - Skipped: 207

12. **Security Policies and Programs (Requirement 12)**
    - Alarm: 485
    - OK: 0

## Dashboard Features
- Search Path functionality for filtering requirements
- Live view option for real-time updates
- Snap feature for point-in-time captures
- Schedule option for automated runs
- Share functionality for collaboration

## Notes
- The dashboard may take a few moments to load completely
- Use the Search Path feature to filter specific requirements
- The Live view ensures you're seeing the most current data
- Use the Snap feature to capture point-in-time compliance states

## Screenshots

### AWS PCI DSS v4.0 Dashboard Overview
![AWS PCI DSS v4.0 Dashboard](images/pci-dss-dashboard.png)

Key elements in the screenshot:
1. 🔴 Navigation breadcrumb showing: Turbot Pipes > turbot-ops > rajtest > Powerpipe
2. 🔴 Dashboard controls: Search Path, View (Live/Snap), Schedule, and Share
3. 🔴 Overall compliance metrics showing:
   - OK: 7,140 items
   - Alarm: 46,953 items
   - Error: 0 items
   - Info: 622 items
   - Skipped: 382 items
4. 🔴 Detailed requirement sections with compliance status

### 2. Dashboard Features
The screenshot shows several important features:
- Search Path functionality for filtering requirements
- Live view option for real-time updates
- Snap feature for point-in-time captures
- Schedule option for automated runs
- Share functionality for team collaboration

### 3. Requirements Overview
The dashboard displays a comprehensive breakdown of PCI DSS v4.0 requirements, including:
- Appendices (A1 and A3)
- Core Requirements (1-12)
- Individual compliance metrics for each section

Note: The dashboard may take some time to load completely due to the amount of data being processed.