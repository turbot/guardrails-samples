# Turbot Flapping Report

A Python tool to detect and analyze configuration flapping in Turbot-managed infrastructure. This tool helps identify resources that are experiencing repeated configuration changes, remediation cycles, or conflicts between user actions and Turbot policy enforcement.

## What is Configuration Flapping?

Configuration flapping occurs when:
- A user creates/updates a resource through Terraform without proper configuration
- Turbot detects the non-compliant state and auto-remediates it
- The user re-runs Terraform without fixing the underlying issue
- Turbot remediates again, creating a cycle

This pattern indicates configuration drift and can lead to:
- Increased operational overhead
- Compliance violations
- Resource instability
- Wasted compute resources

## Features

- **Real-time Analysis**: Analyzes Turbot activity from the past N minutes
- **Flapping Detection**: Identifies resources with repeated user actions and Turbot remediations
- **Resource Grouping**: Groups events by resource to identify problematic resources
- **CSV Export**: Export raw query results to CSV for further analysis
- **Debug Mode**: Enable verbose output for troubleshooting

## Installation

1. Clone this repository
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Configure your Turbot credentials (see Configuration section)

## Configuration

### Turbot Credentials

The tool supports multiple authentication methods:

1. **Environment Variables** (Recommended):
   ```bash
   export TURBOT_ACCESS_KEY_ID="your_access_key"
   export TURBOT_SECRET_ACCESS_KEY="your_secret_key"
   export TURBOT_WORKSPACE="https://your-workspace.turbot.com"
   ```

2. **Default Configuration File**:
   Create `~/.config/turbot/credentials.yml`:
   ```yaml
   default:
     workspace: "https://your-workspace.turbot.com"
     accessKey: "your_access_key"
     secretKey: "your_secret_key"
   
   # Additional profiles for different environments
   production:
     workspace: "https://prod-workspace.turbot.com"
     accessKey: "your_prod_access_key"
     secretKey: "your_prod_secret_key"
   
   staging:
     workspace: "https://staging-workspace.turbot.com"
     accessKey: "your_staging_access_key"
     secretKey: "your_staging_secret_key"
   ```

3. **Custom Configuration File**:
   Use the `--config` option to specify a different credentials file:
   ```bash
   python main.py --config /path/to/custom/credentials.yml
   ```

4. **Custom Profile**:
   Use the `--profile` option to specify a different profile from the credentials file:
   ```bash
   python main.py --profile production
   python main.py --profile staging --config /path/to/custom/credentials.yml
   ```

## Usage

### Basic Usage

```bash
# Default analysis (last 24 hours)
python main.py

# Custom time period (last 2 hours)
python main.py --filter "timestamp:>=T-2h"

# Export raw query results to CSV for external analysis
python main.py --csv

# Debug mode with verbose output
python main.py --debug
```

### Command Line Options

```bash
python main.py [OPTIONS]
```

### Filtering
- `--filter FILTERS` - Filters (default: timestamp:>=T-24h). See [Turbot Filter Rules](https://turbot.com/guardrails/docs/guides/using-guardrails/notifications/filter-rules) for detailed syntax.
- `--two-phase` - Use two-phase query for large environments
- `--limit N` - GraphQL query result page size (default: 500)

### Configuration
- `--config PATH` - Path to Turbot credentials file (default: ~/.config/turbot/credentials.yml)
- `--profile NAME` - Profile name to use from credentials file (default: default)
- `--save-config` - Save current arguments to configuration file
- `--load-config` - Load arguments from configuration file

### Output Options
- `--csv` - Export query results to CSV file
- `--output FILENAME` - Save report to file (only .md and .html supported, e.g., report.md or report.html)
- `--debug` - Enable debug output

### Examples

```bash
# Default analysis (24 hours)
python main.py

# Analyze last 2 hours
python main.py --filter "timestamp:>=T-2h"

# Analyze last week
python main.py --filter "timestamp:>=T-7d"

# Analyze yesterday
python main.py --filter "timestamp:>=yesterday"

# Analyze specific date range
python main.py --filter "timestamp:>=2025-07-27"

# Filter by tags
python main.py --filter "tags:Environment=Production"

# Filter by multiple tags
python main.py --filter "tags:Environment=Production,tags:Owner=Scott"

# Combine time and tag filters
python main.py --filter "timestamp:>=T-7d,tags:Environment=Production"

# Export to CSV with filters
python main.py --csv --filter "timestamp:>=T-24h,tags:Owner=Scott"

# Debug mode with filters
python main.py --debug --filter "timestamp:>=T-2h,tags:Environment=Development"

# Efficient mode for large environments
python main.py --two-phase --filter "timestamp:>=T-24h"

# Efficient mode with tag filters
python main.py --two-phase --filter "timestamp:>=T-7d,tags:Environment=Production"

# Custom page size (useful for large datasets)
python main.py --limit 50 --filter "timestamp:>=T-7d"

# Debug mode with custom page size
python main.py --debug --limit 25 --filter "timestamp:>=T-2h"

# Two-phase mode with custom page size
python main.py --two-phase --limit 75 --filter "timestamp:>=T-24h"

# Save current settings to config file
python main.py --filter "timestamp:>=T-7d" --two-phase --limit 250 --save-config

# Load settings from config file
python main.py --load-config

# Load config and override specific settings
python main.py --load-config --filter "timestamp:>=T-2h"

# Save report to markdown file
python main.py --output report.md --filter "timestamp:>=T-7d"

# Save report with custom settings
python main.py --output weekly_report.md --filter "timestamp:>=T-7d" --two-phase --limit 250

# Use custom credentials file
python main.py --config /path/to/custom/credentials.yml

# Use custom credentials with filters
python main.py --config /path/to/custom/credentials.yml --filter "timestamp:>=T-7d"

# Use custom credentials with all options
python main.py --config /path/to/custom/credentials.yml --filter "timestamp:>=T-24h" --two-phase --csv --debug

# Use different profile from default credentials file
python main.py --profile production

# Use different profile with custom credentials file
python main.py --profile staging --config /path/to/custom/credentials.yml

# Use different profile with filters
python main.py --profile production --filter "timestamp:>=T-7d"

# Use different profile with all options
python main.py --profile staging --config /path/to/custom/credentials.yml --filter "timestamp:>=T-24h" --two-phase --csv --debug
```

## Flapping Detection Logic

The tool uses a sophisticated algorithm to detect **actual configuration conflicts** rather than just any user/Turbot interaction. It distinguishes between:

### **Real Configuration Flapping:**
- User repeatedly changes the same configuration setting
- Turbot repeatedly fixes the same setting
- Examples: S3 HTTPS, encryption, versioning, logging settings

### **Normal Operations (NOT Flapping):**
- Volume lifecycle operations (create, attach, detach, delete)
- Instance start/stop operations
- Tag updates and metadata changes
- Resource creation/deletion

### **Detection Criteria:**

The tool detects flapping when a resource has:
- **Minimum 2 user actions** within the analysis period
- **Minimum 1 Turbot remediation** within the analysis period
- **All events within the filter period** (dynamic time window based on your `--filter` parameter)
- **Configuration-specific patterns** rather than just any user/Turbot interaction

### **Algorithm Steps:**

1. **Configuration Setting Detection**: Identifies events with specific configuration keywords:
   - `set`, `enabled`, `disabled`, `enforce`, `require`
   - `versioning`, `encryption`, `https`, `ssl`, `tls`, `logging`
   - `compliance`, `security`, `backup`, `retention`

2. **Lifecycle Operation Filtering**: Excludes normal operational events:
   - `stopped`, `started`, `created`, `deleted`, `attached`, `detached`
   - `snapshot`, `volume`, `cluster`, `instance`, `updated tags`
   - `cannot stop`, `cannot start`, `successfully`

3. **Property-Specific Analysis**: Groups events by the specific configuration property being changed (e.g., "versioning", "encryption")

4. **Alternating Pattern Detection**: Looks for user → Turbot → user patterns in non-lifecycle events

### **Dynamic Time Window:**

The flapping time window is **automatically determined** by your filter period:

**Examples:**
- `--filter "timestamp:>=T-24h"` → 24-hour flapping window
- `--filter "timestamp:>=T-7d"` → 7-day flapping window  
- `--filter "timestamp:>=T-3w"` → 3-week flapping window
- `--filter "timestamp:>=yesterday"` → 24-hour flapping window

### **Real-World Scenario:**

This matches the actual flapping behavior where:
1. User makes a change (e.g., disables S3 HTTPS)
2. Turbot detects and remediates (enables HTTPS) in seconds/minutes
3. User doesn't notice the remediation
4. Hours/days later, user reverts the change
5. Turbot remediates again

**✅ Valid Flapping (7-day window with `--filter "timestamp:>=T-7d"`):**
```
Day 1, 2:00 PM - User disables S3 HTTPS
Day 1, 2:05 PM - Turbot enables S3 HTTPS  
Day 3, 8:00 PM - User disables S3 HTTPS again
Day 3, 8:05 PM - Turbot enables S3 HTTPS again
```
*Total time span: 2 days (within 7-day window)*

**❌ Not Flapping (spread over 10 days with `--filter "timestamp:>=T-7d"`):**
```
Day 1, 2:00 PM - User disables S3 HTTPS
Day 1, 2:05 PM - Turbot enables S3 HTTPS
Day 10, 2:00 PM - User disables S3 HTTPS again  
Day 10, 2:05 PM - Turbot enables S3 HTTPS again
```
*Total time span: 9 days (exceeds 7-day window)*

**❌ Not Flapping (normal lifecycle operations):**
```
Day 1, 2:00 PM - User creates volume
Day 1, 2:05 PM - Turbot attaches volume
Day 3, 8:00 PM - User detaches volume
Day 3, 8:05 PM - Turbot deletes volume
```
*These are normal lifecycle operations, not configuration conflicts*

## Query Performance Modes

The tool supports two query modes optimized for different environment sizes:

### **Standard Mode (Default)**
- **Single Query**: Fetches all `action_notify` and `resource_updated` events in one query
- **Best For**: Small to medium environments (< 10K resources)
- **Pros**: Simple, fast for small datasets
- **Cons**: Can be slow for large environments with many events

### **Efficient Mode (`--two-phase`)**
- **Two-Phase Query**: 
  1. Phase 1: Find resources with `action_notify` events
  2. Phase 2: Fetch `resource_updated` events only for those resources
- **Best For**: Large environments (10K+ resources, 100K+ events)
- **Pros**: Much faster for large datasets, targeted queries
- **Cons**: More complex, multiple API calls

### **When to Use Two-Phase Mode:**
```bash
# Use two-phase mode for large environments
python main.py --two-phase --filter "timestamp:>=T-24h"

# Use two-phase mode with tag filters
python main.py --two-phase --filter "timestamp:>=T-7d,tags:Environment=Production"

# Use standard mode for small environments
python main.py --filter "timestamp:>=T-24h"
```

### **Performance Comparison:**
- **Small Environment** (1K resources): Standard mode is faster
- **Medium Environment** (10K resources): Either mode works well
- **Large Environment** (100K+ resources): Two-phase mode is significantly faster

## Tag Filtering

The tool supports filtering by tags to focus analysis on specific resources. Tag filters use Turbot's native tag filtering syntax and can be combined with timestamp filters. See [Turbot Tag Filtering Documentation](https://turbot.com/guardrails/docs/reference/filter#tag-filters) for detailed syntax and examples.

### Filter Examples:

```bash
# Filter by single tag
python main.py --filter "tags:Environment=Production"

# Filter by tag with regex (case insensitive)
python main.py --filter "tags:Environment=/production/i"

# Filter by tag with exact regex match
python main.py --filter "tags:Owner=/^Scott$/"

# Filter by tag with any value
python main.py --filter "tags:Environment=/.*/"

# Filter by tag with empty value
python main.py --filter "tags:Description=''"

# Filter by multiple tags (AND logic)
python main.py --filter "tags:Environment=Production,tags:Owner=Scott"

# Combine with time filter
python main.py --filter "timestamp:>=T-7d,tags:Environment=Production"

# Complex filter combination
python main.py --filter "timestamp:>=T-24h,tags:Environment=Production,tags:Owner=Scott"
```

### Supported Filter Formats:

**Timestamp Filters:**
- **Relative time**: `timestamp:>=T-24h`, `timestamp:>=T-7d`
- **Keywords**: `timestamp:>=yesterday`, `timestamp:>=now`
- **ISO dates**: `timestamp:>=2025-07-27`

**Tag Filters:**
- **Exact match**: `tags:key=value`
- **Regex match**: `tags:key=/pattern/`
- **Case insensitive**: `tags:key=/pattern/i`
- **Any value**: `tags:key=/.*/`
- **Empty value**: `tags:key=''`
- **Multiple tags**: `tags:key1=value1,tags:key2=value2`

## Configuration File

The tool supports saving and loading command-line arguments to/from a configuration file for convenience.

### **Configuration File Location:**
- **Path**: `~/.turbot-flapping/config.json`
- **Format**: JSON
- **Permissions**: User-readable/writable

### **Usage:**

**Save Current Settings:**
```bash
# Save your preferred settings
python main.py --filter "timestamp:>=T-7d" --two-phase --limit 250 --save-config
```

**Load Saved Settings:**
```bash
# Load all saved settings
python main.py --load-config

# Load config but override specific settings
python main.py --load-config --filter "timestamp:>=T-2h"

# Load config but override multiple settings
python main.py --load-config --filter "timestamp:>=T-7d" --limit 500 --debug

# Load config but use different output
python main.py --load-config --output custom_report.md

# Load config but disable CSV export
python main.py --load-config --csv

# Load config but use standard mode instead of two-phase
python main.py --load-config --two-phase

# Load config but use different credentials file
python main.py --load-config --config /path/to/different/credentials.yml

# Load config but use different profile
python main.py --load-config --profile production

# Load config but use different profile and credentials file
python main.py --load-config --profile staging --config /path/to/different/credentials.yml
```

**Priority Order:**
1. **Command-line arguments** (highest priority) - Override loaded config
2. **Loaded configuration** (medium priority) - Used as defaults
3. **Default values** (lowest priority) - Fallback when neither config nor args provided

**Automatic Loading:**
The tool automatically loads saved configuration as defaults when no explicit arguments are provided.

### **Configuration File Example:**
```json
{
  "filter": "timestamp:>=T-7d",
  "two_phase": true,
  "csv": false,
  "debug": false,
  "limit": 250,
  "config": "/path/to/custom/credentials.yml",
  "profile": "production"
}
```

## Output Options

The tool supports multiple output formats for different use cases:

### **Console Output (Default)**
Rich, formatted output with emojis and clear sections.

### **CSV Export (`--csv`)**
Export raw query results to CSV for further analysis in spreadsheets.

### **Markdown Report (`--output filename.md`)**
Save a formatted markdown report for documentation and sharing.

**Note:** The file extension determines the output format:
- `.md` files generate markdown format
- `.html` files generate styled HTML format

**Best for:**
- 📝 **Documentation** - Perfect for README files, wikis
- 🔄 **Version control** - Easy to track changes over time
- 📧 **Email sharing** - Works in most email clients
- 💬 **Chat platforms** - Slack, Teams, Discord
- 👥 **Technical teams** - Developers, DevOps, SRE

### **HTML Report (`--output filename.html`)**
Save a styled HTML report that opens in any web browser.

**Best for:**
- 🎨 **Professional presentations** - Executive reports, meetings
- 🖨️ **Printing** - Clean, formatted output
- 📊 **Non-technical audiences** - Managers, stakeholders
- 🎯 **Branded reports** - Company colors, logos
- 📱 **Mobile viewing** - Responsive design

### **Output Format Examples:**

```bash
# Generate a markdown report (recommended for most users)
python main.py --output weekly_report.md --filter "timestamp:>=T-7d"

# Generate an HTML report (for presentations/executives)
python main.py --output production_report.html --filter "timestamp:>=T-24h"

# HTML report with custom settings
python main.py --output detailed_report.html --filter "timestamp:>=T-30d" --two-phase --limit 250

# Save to specific directory
python main.py --output /path/to/reports/flapping_analysis.md --filter "timestamp:>=T-7d"

# Export both CSV and report (both files will be created)
python main.py --csv --output analysis_report.md --filter "timestamp:>=T-7d"
```

### **Recommendation:**
- **Use `.md` files for most cases** - Universal compatibility, version control friendly
- **Use `.html` files for special cases** - Executive reports, presentations, non-technical audiences

## CSV Export

The tool can export raw query results to CSV format for further analysis.

### CSV Columns:

- `timestamp` - Event timestamp (YYYY-MM-DD HH:MM:SS)
- `notification_type` - Type of notification (action_notify, resource_updated)
- `actor_title` - Who performed the action
- `message` - Description of the action
- `data` - Additional data (JSON format)
- `resource_id` - Unique resource identifier
- `resource_title` - Human-readable resource name
- `resource_path` - Resource path in Turbot
- `resource_human_title` - Human-readable resource path
- `resource_type` - Type of resource
- `resource_object` - Full resource object (JSON format)

## Troubleshooting

### Connection Issues
- Verify your Turbot workspace URL is correct
- Check that your access keys are valid
- Ensure network connectivity to your Turbot instance
- Use `--debug` to see detailed connection information

### No Results
- Increase the time period in `--filter` to look further back (e.g., `--filter "timestamp:>=T-7d"`)
- Check that the resource types you're monitoring have recent activity
- Use `--csv` to export raw data and inspect manually

### Debug Mode
Use `--debug` to see:
- Detailed connection information
- Query filters being applied
- Resource-by-resource analysis
- Reasons why flapping was not detected

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.