#!/usr/bin/env python3
"""
Turbot Flapping Report Tool
Detects configuration flapping patterns in Turbot-managed infrastructure
"""

# Suppress urllib3 SSL warnings BEFORE any imports
import os
import warnings
os.environ['PYTHONWARNINGS'] = 'ignore::UserWarning:urllib3.*'
warnings.filterwarnings('ignore', message='.*LibreSSL.*')
warnings.filterwarnings('ignore', category=UserWarning, module='urllib3')
warnings.filterwarnings('ignore', message='.*urllib3.*')

import csv
from collections import defaultdict
from datetime import datetime, timedelta
from _turbot import Config
import json
import re
import argparse
import sys
import requests

import warnings
warnings.filterwarnings('ignore', message='.*LibreSSL.*')
warnings.filterwarnings('ignore', category=UserWarning, module='urllib3')
warnings.filterwarnings('ignore', message='.*urllib3.*')
os.environ['PYTHONWARNINGS'] = 'ignore::UserWarning:urllib3.*'

def get_config_file_path():
    """Get the path to the configuration file"""
    config_dir = os.path.expanduser('~/.turbot-flapping')
    os.makedirs(config_dir, exist_ok=True)
    return os.path.join(config_dir, 'config.json')

def load_config():
    """Load configuration from file"""
    config_file = get_config_file_path()
    if os.path.exists(config_file):
        try:
            with open(config_file, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError) as e:
            print(f"⚠️  Warning: Could not load config file: {e}")
    return {}

def save_config(config):
    """Save configuration to file"""
    config_file = get_config_file_path()
    try:
        with open(config_file, 'w') as f:
            json.dump(config, f, indent=2)
        print(f"✅ Configuration saved to {config_file}")
    except IOError as e:
        print(f"❌ Error saving config: {e}")

def parse_time_window_from_filter(filters):
    """Parse the filter to determine the appropriate time window for flapping detection"""
    for filter_str in filters:
        if filter_str.startswith('timestamp:>='):
            time_part = filter_str.replace('timestamp:>=', '')
            
            # Parse relative time expressions
            if time_part.startswith('T-'):
                # Extract the time value and unit
                time_value = time_part[2:]  # Remove 'T-'
                
                # Parse different time units
                if time_value.endswith('h'):
                    hours = int(time_value[:-1])
                    return hours * 60  # Convert to minutes
                elif time_value.endswith('d'):
                    days = int(time_value[:-1])
                    return days * 24 * 60  # Convert to minutes
                elif time_value.endswith('w'):
                    weeks = int(time_value[:-1])
                    return weeks * 7 * 24 * 60  # Convert to minutes
                elif time_value.endswith('m'):
                    minutes = int(time_value[:-1])
                    return minutes
                elif time_value.endswith('s'):
                    seconds = int(time_value[:-1])
                    return seconds / 60  # Convert to minutes
            
            # Handle keywords
            elif time_part == 'yesterday':
                return 24 * 60  # 24 hours in minutes
            elif time_part == 'now':
                return 60  # 1 hour in minutes (reasonable default)
    
    # Default to 24 hours if no timestamp filter found
    return 24 * 60

# Configuration
MIN_USER_ACTIONS = 2
MIN_TURBOT_REMEDIATIONS = 1
FLAPPING_TIME_WINDOW = 1440  # 24 hours in minutes

# GraphQL query
query = """
query GetNotifications($filter: [String!], $paging: String) {
  notifications(filter: $filter, paging: $paging) {
    items {
      turbot {
        id
        createTimestamp
        processId
      }
      notificationType
      message
      data
      actor {
        identity {
          title
        }
      }
      resource {
        turbot {
          id
          title
          path
        }
        trunk {
          title
        }
        type {
          uri
        }
        object
      }
    }
    paging {
      next
    }
  }
}
"""

# Resource types to monitor
RESOURCE_TYPES = [
    'tmod:@turbot/aws#/resource/types/aws',
    'tmod:@turbot/azure#/resource/types/azure',
    'tmod:@turbot/azure-activedirectory#/resource/types/directory'
]

def parse_timestamp(timestamp_str):
    """Parse Turbot timestamp to datetime object (assumes UTC)"""
    if not timestamp_str:
        return datetime.utcnow()
    
    # Handle ISO format with Z suffix (UTC)
    if timestamp_str.endswith('Z'):
        return datetime.fromisoformat(timestamp_str.replace('Z', '+00:00'))
    
    # Handle ISO format without timezone (assume UTC)
    if 'T' in timestamp_str and '+' not in timestamp_str and 'Z' not in timestamp_str:
        return datetime.fromisoformat(timestamp_str + '+00:00')
    
    # Handle other formats
    return datetime.fromisoformat(timestamp_str)

def detect_flapping(events, filters=None):
    """Detect flapping configuration patterns"""
    if len(events) < 3:  # Need at least 3 events for flapping
        return False, []
    
    # Categorize events by actor type
    categories = categorize_events(events)
    
    # Check minimum requirements
    if len(categories['user']) < MIN_USER_ACTIONS:
        return False, []
    if len(categories['turbot']) < MIN_TURBOT_REMEDIATIONS:
        return False, []
    
    # Sort events by timestamp
    sorted_events = sorted(events, key=lambda x: parse_timestamp(x.get('turbot', {}).get('createTimestamp')))
    
    # Check time window
    if sorted_events:
        first_time = parse_timestamp(sorted_events[0].get('turbot', {}).get('createTimestamp'))
        last_time = parse_timestamp(sorted_events[-1].get('turbot', {}).get('createTimestamp'))
        time_span = (last_time - first_time).total_seconds() / 60
        
        # Use dynamic time window based on the filter period
        if filters:
            flapping_window = parse_time_window_from_filter(filters)
        else:
            flapping_window = 24 * 60  # Default to 24 hours
        
        if time_span > flapping_window:
            return False, []
    
    # NEW: Sophisticated flapping detection
    # Look for specific configuration conflict patterns
    
    # 1. Check for explicit configuration setting messages
    config_setting_events = []
    for event in sorted_events:
        message = event.get('message', '')
        if message is None:
            message = ''
        message = message.lower()
        
        # Look for specific configuration setting patterns
        config_patterns = [
            'set', 'enabled', 'disabled', 'enforce', 'require',
            'versioning', 'encryption', 'https', 'ssl', 'tls',
            'logging', 'compliance', 'security', 'backup', 'retention'
        ]
        
        for pattern in config_patterns:
            if pattern in message:
                config_setting_events.append(event)
                break
    
    # 2. Check for lifecycle/operational events (these are NOT flapping)
    lifecycle_events = []
    for event in sorted_events:
        message = event.get('message', '')
        if message is None:
            message = ''
        message = message.lower()
        
        # Lifecycle operations that are NOT flapping
        lifecycle_patterns = [
            'stopped', 'started', 'created', 'deleted', 'attached', 'detached',
            'snapshot', 'volume', 'cluster', 'instance', 'updated tags',
            'cannot stop', 'cannot start', 'successfully'
        ]
        
        for pattern in lifecycle_patterns:
            if pattern in message:
                lifecycle_events.append(event)
                break
    
    # 3. If we have configuration setting events, analyze them for flapping
    if config_setting_events:
        # Group by configuration property
        config_properties = {}
        for event in config_setting_events:
            message = event.get('message', '').lower()
            
            # Extract the property being configured
            property_name = None
            for pattern in ['versioning', 'encryption', 'https', 'ssl', 'tls', 'logging']:
                if pattern in message:
                    property_name = pattern
                    break
            
            if property_name:
                if property_name not in config_properties:
                    config_properties[property_name] = []
                config_properties[property_name].append(event)
        
        # Check for flapping in specific properties
        for property_name, property_events in config_properties.items():
            if len(property_events) >= 3:  # At least 3 changes to same property
                user_changes = [e for e in property_events if e.get('actor', {}).get('identity', {}).get('title', '') != 'Turbot Identity']
                turbot_changes = [e for e in property_events if e.get('actor', {}).get('identity', {}).get('title', '') == 'Turbot Identity']
                
                if len(user_changes) >= 2 and len(turbot_changes) >= 1:
                    return True, property_events
    
    # 4. Check for alternating user/Turbot patterns in non-lifecycle events
    non_lifecycle_events = [e for e in sorted_events if e not in lifecycle_events]
    
    if len(non_lifecycle_events) >= 3:
        user_events = [e for e in non_lifecycle_events if e.get('actor', {}).get('identity', {}).get('title', '') != 'Turbot Identity']
        turbot_events = [e for e in non_lifecycle_events if e.get('actor', {}).get('identity', {}).get('title', '') == 'Turbot Identity']
        
        if len(user_events) >= 2 and len(turbot_events) >= 1:
            # Check for alternating pattern
            all_events = sorted(non_lifecycle_events, key=lambda x: parse_timestamp(x.get('turbot', {}).get('createTimestamp')))
            
            alternating_count = 0
            for i in range(len(all_events) - 1):
                current_actor = all_events[i].get('actor', {}).get('identity', {}).get('title', '')
                next_actor = all_events[i + 1].get('actor', {}).get('identity', {}).get('title', '')
                
                if current_actor != next_actor:
                    alternating_count += 1
            
            if alternating_count >= 2:  # At least 2 alternations
                return True, all_events
    
    return False, []

def categorize_events(events):
    """Categorize events by actor type"""
    turbot_events = []
    user_events = []
    
    for event in events:
        actor = event.get('actor', {}).get('identity', {}).get('title', '')
        message = event.get('message', '')
        
        # Handle None values
        if message is None:
            message = ''
        else:
            message = message.lower()
        
        if 'Turbot Identity' in actor or 'remediation' in message:
            turbot_events.append(event)
        else:
            user_events.append(event)
    
    return {
        'turbot': turbot_events,
        'user': user_events,
        'total': len(events)
    }

def analyze_pattern(events):
    """Analyze the pattern of events"""
    categories = categorize_events(events)
    
    if categories['turbot'] and categories['user']:
        user_count = len(categories['user'])
        turbot_count = len(categories['turbot'])
        
        if user_count >= 2 and turbot_count >= 1:
            return f"Configuration Flapping - {user_count} user changes, {turbot_count} Turbot remediations"
        else:
            return "Mixed Activity - User and Turbot actions"
    elif categories['turbot'] and not categories['user']:
        return "Turbot Only - Repeated remediation"
    elif categories['user'] and not categories['turbot']:
        return "User Only - Frequent user modifications"
    else:
        return "Unknown pattern"

def export_to_csv(notifications, filename=None):
    """Export query results to CSV file"""
    if not filename:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"turbot_events_{timestamp}.csv"
    
    headers = [
        'timestamp', 'notification_type', 'actor_title', 'message', 'data',
        'resource_id', 'resource_title', 'resource_path', 'resource_human_title', 'resource_type', 'resource_object'
    ]
    
    print(f"📊 Exporting {len(notifications)} events to {filename}...")
    
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=headers)
        writer.writeheader()
        
        for notification in notifications:
            timestamp_str = notification.get('turbot', {}).get('createTimestamp')
            try:
                timestamp = parse_timestamp(timestamp_str)
                formatted_timestamp = timestamp.strftime('%Y-%m-%d %H:%M:%S')
            except:
                formatted_timestamp = timestamp_str
            
            row = {
                'timestamp': formatted_timestamp,
                'notification_type': notification.get('notificationType', ''),
                'actor_title': notification.get('actor', {}).get('identity', {}).get('title', ''),
                'message': notification.get('message', ''),
                'data': json.dumps(notification.get('data', {})), # Export data as JSON string
                'resource_id': notification.get('resource', {}).get('turbot', {}).get('id', ''),
                'resource_title': notification.get('resource', {}).get('turbot', {}).get('title', ''),
                'resource_path': notification.get('resource', {}).get('turbot', {}).get('path', ''),
                'resource_human_title': notification.get('resource', {}).get('trunk', {}).get('title', '') if notification.get('resource', {}).get('trunk') else '',
                'resource_type': notification.get('resource', {}).get('type', {}).get('uri', ''),
                'resource_object': json.dumps(notification.get('resource', {}).get('object', {}))
            }
            
            writer.writerow(row)
    
    print(f"✅ Successfully exported {len(notifications)} events to {filename}")
    return filename

def get_query_results(filters, turbot_config, limit=100):
    """Execute GraphQL query and return notifications with pagination support"""
    all_notifications = []
    paging_token = None
    page_count = 0
    
    # Add limit to filters if specified
    query_filters = filters.copy()
    if limit != 100:  # Only add if not default
        query_filters.append(f"limit:{limit}")
    
    try:
        print("🔍 Executing GraphQL query...")
        print("⏳ This may take a moment, especially with tag filters...")
        print(f"📄 Page size: {limit} events per page")
        
        while True:
            page_count += 1
            print(f"📄 Fetching page {page_count}...")
            
            # Prepare variables for this page
            variables = {"filter": query_filters}
            if paging_token:
                variables["paging"] = paging_token
            
            # Use a shorter timeout for queries that might hang
            response = turbot_config.graphql_query(query, variables, timeout=60)
            
            # Extract notifications from this page
            page_data = response['data']['notifications']
            page_notifications = page_data['items']
            all_notifications.extend(page_notifications)
            
            print(f"📊 Page {page_count}: Found {len(page_notifications)} events")
            
            # Check if there are more pages
            paging = page_data.get('paging', {})
            paging_token = paging.get('next')
            
            if not paging_token:
                print(f"✅ Completed after {page_count} pages")
                break
        
        if not all_notifications:
            print("✅ No activity found.")
            return []
        
        print(f"📊 Total: Found {len(all_notifications)} events across {page_count} pages")
        return all_notifications
        
    except requests.exceptions.Timeout:
        print("⏰ Query timed out after 60 seconds.")
        print("💡 Try:")
        print("   - Using a more specific tag filter")
        print("   - Adding a timestamp filter to limit the search (e.g., timestamp:>=T-24h)")
        print("   - Checking if the tag exists on any resources")
        print("   - Using a broader tag pattern (e.g., tags:Test=/.*/)")
        print("   - Reducing the page size with --limit")
        return []
    except Exception as e:
        print(f"❌ Error querying Turbot: {e}")
        print("💡 This might happen when:")
        print("   - No resources match the specified filters")
        print("   - The query is taking too long to process")
        print("   - Network connectivity issues")
        return []

def get_query_results_efficient(filters, turbot_config, limit=100):
    """Execute GraphQL queries efficiently for large environments"""
    print("🔍 Executing efficient two-phase query...")
    print(f"📄 Page size: {limit} events per page")
    print("⏳ Phase 1: Finding resources with action_notify events...")
    
    # Add limit to filters if specified
    query_filters = filters.copy()
    if limit != 100:  # Only add if not default
        query_filters.append(f"limit:{limit}")
    
    # Phase 1: Get action_notify events to identify relevant resources
    action_filters = [f for f in query_filters if not f.startswith('notificationType:')]
    action_filters.append("notificationType:action_notify")
    
    action_resources = set()
    paging_token = None
    page_count = 0
    
    try:
        while True:
            page_count += 1
            print(f"📄 Phase 1 - Page {page_count}...")
            
            variables = {"filter": action_filters}
            if paging_token:
                variables["paging"] = paging_token
            
            response = turbot_config.graphql_query(query, variables, timeout=60)
            page_data = response['data']['notifications']
            page_notifications = page_data['items']
            
            # Extract resource IDs from action_notify events
            for notification in page_notifications:
                resource_id = notification.get('resource', {}).get('turbot', {}).get('id')
                if resource_id:
                    action_resources.add(resource_id)
            
            print(f"📊 Phase 1 - Page {page_count}: Found {len(page_notifications)} action events")
            
            paging = page_data.get('paging', {})
            paging_token = paging.get('next')
            
            if not paging_token:
                print(f"✅ Phase 1 completed after {page_count} pages")
                break
        
        print(f"📊 Phase 1 - Total: Found {len(action_resources)} resources with action events")
        
        if not action_resources:
            print("✅ No action events found.")
            return []
        
        # Phase 2: Get resource_updated events only for relevant resources
        print("⏳ Phase 2: Fetching resource_updated events for relevant resources...")
        
        all_notifications = []
        resource_count = 0
        
        for resource_id in action_resources:
            resource_count += 1
            print(f"📄 Phase 2 - Resource {resource_count}/{len(action_resources)}: {resource_id}")
            
            # Create resource-specific filter
            resource_filters = [f for f in query_filters if not f.startswith('notificationType:')]
            resource_filters.append("notificationType:resource_updated")
            resource_filters.append(f"resourceId:{resource_id}")
            
            paging_token = None
            page_count = 0
            
            while True:
                page_count += 1
                
                variables = {"filter": resource_filters}
                if paging_token:
                    variables["paging"] = paging_token
                
                response = turbot_config.graphql_query(query, variables, timeout=60)
                page_data = response['data']['notifications']
                page_notifications = page_data['items']
                
                all_notifications.extend(page_notifications)
                
                if page_count == 1:
                    print(f"   📊 Found {len(page_notifications)} resource_updated events")
                
                paging = page_data.get('paging', {})
                paging_token = paging.get('next')
                
                if not paging_token:
                    break
        
        print(f"📊 Phase 2 - Total: Found {len(all_notifications)} resource_updated events")
        print(f"📊 Total: Found {len(all_notifications)} events across {len(action_resources)} resources")
        
        return all_notifications
        
    except requests.exceptions.Timeout:
        print("⏰ Query timed out after 60 seconds.")
        print("💡 Try:")
        print("   - Using a more specific tag filter")
        print("   - Adding a timestamp filter to limit the search (e.g., timestamp:>=T-24h)")
        print("   - Checking if the tag exists on any resources")
        print("   - Using a broader tag pattern (e.g., tags:Test=/.*/)")
        print("   - Reducing the page size with --limit")
        return []
    except Exception as e:
        print(f"❌ Error querying Turbot: {e}")
        print("💡 This might happen when:")
        print("   - No resources match the specified filters")
        print("   - The query is taking too long to process")
        print("   - Network connectivity issues")
        return []

def generate_flapping_report_from_notifications(notifications, filters=None, output_file=None):
    """Generate flapping report from notifications"""
    if not notifications:
        print("✅ No activity found.")
        return
    
    # Determine output format
    is_html = output_file and output_file.lower().endswith('.html')
    
    # Capture output for file
    report_lines = []
    in_list = False  # Track if we're inside a list
    
    def add_line(line="", html_class=None):
        """Add a line to both console and report"""
        nonlocal in_list
        print(line)
        if output_file:
            if is_html:
                # Convert markdown to HTML
                html_line = convert_markdown_to_html(line)
                
                # Handle list structure
                if html_line.startswith('<li>'):
                    if not in_list:
                        report_lines.append('<ul>')
                        in_list = True
                    report_lines.append(html_line)
                elif in_list and not html_line.startswith('<li>'):
                    report_lines.append('</ul>')
                    in_list = False
                    if html_class:
                        report_lines.append(f'<div class="{html_class}">{html_line}</div>')
                    else:
                        report_lines.append(html_line)
                else:
                    if html_class:
                        report_lines.append(f'<div class="{html_class}">{html_line}</div>')
                    else:
                        report_lines.append(html_line)
            else:
                report_lines.append(line)
    
    def convert_markdown_to_html(markdown_text):
        """Convert markdown syntax to HTML"""
        if not markdown_text:
            return ""
        
        # Convert headers
        if markdown_text.startswith('# '):
            return f'<h1>{markdown_text[2:]}</h1>'
        elif markdown_text.startswith('## '):
            return f'<h2>{markdown_text[3:]}</h2>'
        elif markdown_text.startswith('### '):
            return f'<h3>{markdown_text[4:]}</h3>'
        
        # Convert bold text (handle nested replacements properly)
        html_text = markdown_text
        # Replace **text** with <strong>text</strong>
        import re
        html_text = re.sub(r'\*\*(.*?)\*\*', r'<strong>\1</strong>', html_text)
        
        # Convert inline code
        html_text = re.sub(r'`([^`]+)`', r'<code>\1</code>', html_text)
        
        # Convert emojis to HTML entities or keep as is
        emoji_map = {
            '📦': '📦',
            '🚨': '🚨',
            '✅': '✅',
            '❌': '❌',
            '🔸': '🔸',
            '📋': '📋'
        }
        for emoji, replacement in emoji_map.items():
            html_text = html_text.replace(emoji, replacement)
        
        # Convert list items (including indented ones)
        if html_text.strip().startswith('- '):
            # Remove leading spaces and convert to list item
            clean_text = html_text.strip()
            return f'<li>{clean_text[2:]}</li>'
        
        # Convert empty lines to breaks
        if html_text.strip() == '':
            return '<br>'
        
        return html_text
    
    # Group by resource
    grouped_by_resource = defaultdict(list)
    for notification in notifications:
        resource_id = notification["resource"]["turbot"]["id"]
        grouped_by_resource[resource_id].append(notification)
    
    # Analyze for flapping
    flapping_resources = []
    
    if is_html:
        report_lines.extend([
            '<!DOCTYPE html>',
            '<html lang="en">',
            '<head>',
            '<meta charset="UTF-8">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            '<title>Turbot Flapping Report</title>',
            '<style>',
            'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 40px; background: #f5f5f5; }',
            '.container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }',
            'h1 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }',
            'h2 { color: #34495e; margin-top: 30px; }',
            'h3 { color: #7f8c8d; }',
            '.summary { background: #ecf0f1; padding: 20px; border-radius: 5px; margin: 20px 0; }',
            '.resource { border: 1px solid #bdc3c7; margin: 20px 0; padding: 20px; border-radius: 5px; }',
            '.flapping { border-left: 5px solid #e74c3c; background: #fdf2f2; }',
            '.no-flapping { border-left: 5px solid #27ae60; background: #f0f9f0; }',
            '.event { margin: 5px 0; padding: 5px; background: #f8f9fa; border-radius: 3px; }',
            '.timestamp { font-family: monospace; color: #7f8c8d; }',
            '.actor { font-weight: bold; color: #2c3e50; }',
            '.message { color: #34495e; }',
            '.recommendations { background: #e8f4fd; padding: 20px; border-radius: 5px; margin: 20px 0; }',
            '.error { color: #e74c3c; }',
            '.success { color: #27ae60; }',
            'ul { margin: 10px 0; padding-left: 20px; }',
            'li { margin: 5px 0; }',
            'code { background: #f8f9fa; padding: 2px 4px; border-radius: 3px; font-family: monospace; }',
            '</style>',
            '</head>',
            '<body>',
            '<div class="container">'
        ])
    
    add_line(f"# Turbot Flapping Report")
    add_line(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    add_line(f"Filters: {filters}")
    add_line()
    
    add_line(f"## Analysis Summary", 'summary')
    add_line(f"- **Total Resources**: {len(grouped_by_resource)}")
    add_line(f"- **Analysis Period**: {filters[0] if filters else 'Default'}")
    add_line()
    
    add_line(f"## Resource Analysis")
    
    flapping_resources = []
    
    for resource_id, events in grouped_by_resource.items():
        first_event = events[0]
        resource_title = first_event.get('resource', {}).get('turbot', {}).get('title', 'Unknown')
        
        # Show event details for debugging
        categories = categorize_events(events)
        
        # Show recent events
        sorted_events = sorted(events, key=lambda x: parse_timestamp(x.get('turbot', {}).get('createTimestamp')))
        
        is_flapping, flapping_events = detect_flapping(events, filters)
        
        if is_flapping:
            add_line(f"### 📦 {resource_title}")
            add_line(f"- **Total Events**: {len(events)}")
            add_line(f"- **User Events**: {len(categories['user'])}")
            add_line(f"- **Turbot Events**: {len(categories['turbot'])}")
            
            add_line(f"- **Recent Events**:")
            for event in sorted_events[-5:]:  # Last 5 events
                timestamp = parse_timestamp(event.get('turbot', {}).get('createTimestamp'))
                actor = event.get('actor', {}).get('identity', {}).get('title', 'Unknown')
                message = event.get('message', 'No message')
                notification_type = event.get('notificationType', 'Unknown')
                data = event.get('data', {})
                
                # Show data if message is null/empty
                if not message or message == 'None':
                    if data:
                        message = f"Data: {json.dumps(data, indent=2)}"
                    else:
                        message = "No message or data available"
                
                add_line(f"  - `{timestamp.strftime('%Y-%m-%d %H:%M:%S')}` **{actor}** ({notification_type}): {message}")
            
            # Add blank line after events
            add_line()
            
            add_line(f"🚨 **FLAPPING DETECTED!**")
            resource_info = {
                'title': resource_title,
                'path': first_event.get('resource', {}).get('turbot', {}).get('path', 'Unknown'),
                'type': first_event.get('resource', {}).get('type', {}).get('uri', 'Unknown'),
                'total_events': len(events),
                'flapping_events': flapping_events,
                'pattern': analyze_pattern(flapping_events)
            }
            flapping_resources.append(resource_info)
            add_line()
    
    # Only add a line break if we found flapping resources
    if not flapping_resources:
        add_line()
    
    # Generate report
    add_line(f"## Flapping Report Summary")
    add_line(f"- **Total Resources**: {len(grouped_by_resource)}")
    add_line(f"- **Resources with Flapping**: {len(flapping_resources)}")
    add_line()
    
    if flapping_resources:
        add_line(f"## 🚨 Resources with Configuration Flapping")
        add_line()
        
        for resource in flapping_resources:
            add_line(f"### 🔸 {resource['title']}")
            add_line(f"- **Path**: `{resource['path']}`")
            add_line(f"- **Type**: `{resource['type']}`")
            add_line(f"- **Pattern**: {resource['pattern']}")
            add_line(f"- **Total Events**: {resource['total_events']}")
            add_line(f"- **Flapping Events**: {len(resource['flapping_events'])}")
            
            add_line(f"- **Recent Activity**:")
            for event in resource['flapping_events'][-5:]:  # Last 5 events
                timestamp = parse_timestamp(event.get('turbot', {}).get('createTimestamp'))
                actor = event.get('actor', {}).get('identity', {}).get('title', 'Unknown')
                message = event.get('message', 'No message')
                
                # Show data if message is null/empty
                if not message or message == 'None':
                    data = event.get('data', {})
                    if data:
                        message = f"Data: {json.dumps(data)}"
                
                add_line(f"  - `{timestamp.strftime('%Y-%m-%d %H:%M:%S')}` **{actor}**: {message}")
            add_line()
    else:
        add_line(f"## ✅ No Configuration Flapping Detected")
        add_line()
    
    add_line(f"## 📋 Recommendations")
    add_line()
    if flapping_resources:
        add_line("- Contact resource owners to fix configuration issues")
        add_line("- Review Terraform configurations for flapping resources")
        add_line("- Consider implementing better CI/CD practices")
    else:
        add_line("- Continue monitoring for any new patterns")
    
    # Close any open list
    if is_html and in_list:
        report_lines.append('</ul>')
    
    if is_html:
        report_lines.extend([
            '</div>',
            '</body>',
            '</html>'
        ])
    
    # Save to file if requested
    if output_file:
        try:
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write('\n'.join(report_lines))
            print(f"✅ Report saved to {output_file}")
        except IOError as e:
            print(f"❌ Error saving report: {e}")
    
    return flapping_resources

def main():
    parser = argparse.ArgumentParser(description='Generate Turbot flapping report.')
    parser.add_argument('--filter', default='timestamp:>=T-24h', 
                       help='Filters (e.g., timestamp:>=T-24h, tags:Environment=Production). Default: timestamp:>=T-24h')
    parser.add_argument('--two-phase', action='store_true',
                       help='Use two-phase query for large environments (Phase 1: find action events, Phase 2: get resource events)')
    parser.add_argument('--csv', action='store_true', 
                       help='Export query results to CSV file')
    parser.add_argument('--debug', action='store_true', 
                       help='Enable debug output')
    parser.add_argument('--limit', type=int, default=500,
                       help='GraphQL query result page size (default: 500)')
    parser.add_argument('--save-config', action='store_true',
                       help='Save current arguments to configuration file')
    parser.add_argument('--load-config', action='store_true',
                       help='Load arguments from configuration file')
    parser.add_argument('--output', type=str,
                       help='Save report to file (only .md and .html supported, e.g., report.md or report.html)')
    parser.add_argument('--config', type=str,
                       help='Path to Turbot credentials file (default: ~/.config/turbot/credentials.yml)')
    parser.add_argument('--profile', type=str, default='default',
                       help='Profile name to use from credentials file (default: default)')
    
    args = parser.parse_args()
    
    # Load configuration if requested
    if args.load_config:
        config = load_config()
        if config:
            print("📋 Loading configuration from file...")
            # Update args with loaded config
            for key, value in config.items():
                if hasattr(args, key):
                    setattr(args, key, value)
            print("✅ Configuration loaded successfully")
        else:
            print("⚠️  No configuration file found. Use --save-config to create one.")
            return
    else:
        # Load config as defaults (but don't override explicit args)
        config = load_config()
        if config:
            # Set defaults from config, but don't override explicit args
            for key, value in config.items():
                if hasattr(args, key) and getattr(args, key) == parser.get_default(key):
                    setattr(args, key, value)
    
    # Save configuration if requested
    if args.save_config:
        config_to_save = {
            'filter': args.filter,
            'two_phase': args.two_phase,
            'csv': args.csv,
            'debug': args.debug,
            'limit': args.limit,
            'config': args.config,
            'profile': args.profile
        }
        save_config(config_to_save)
        print("💡 Configuration saved! Use --load-config to load these settings next time.")
        return
    
    # Suppress urllib3 warnings
    warnings.filterwarnings('ignore', message='.*LibreSSL.*')
    warnings.filterwarnings('ignore', category=UserWarning, module='urllib3')
    warnings.filterwarnings('ignore', message='.*urllib3.*')
    os.environ['PYTHONWARNINGS'] = 'ignore::UserWarning:urllib3.*'
    
    # Load Turbot configuration
    try:
        config = Config(None, args.profile, debug=args.debug, custom_credentials_file=args.config)
    except Exception as e:
        print(f"❌ Configuration error: {e}")
        return
    
    # Test connection (test_health will exit on failure)
    config.test_health(debug=args.debug)
    
    print(f"🔍 Querying Turbot activity with filters: {args.filter}...")
    
    # Build query filters
    filters = [
        "notificationType:action_notify,resource_updated"
    ]
    
    # Add user-specified filters
    if args.filter:
        # Split by comma and add each filter
        user_filters = [f.strip() for f in args.filter.split(',')]
        filters.extend(user_filters)
        
        # Check if we have tag filters without timestamp filters
        has_tag_filter = any(f.startswith('tags:') for f in user_filters)
        has_timestamp_filter = any(f.startswith('timestamp:') for f in user_filters)
        
        if has_tag_filter and not has_timestamp_filter:
            print("⚠️  Warning: Tag-only filters may cause timeouts.")
            print("💡 Consider adding a timestamp filter (e.g., timestamp:>=T-24h)")
            print()
    
    print(f"📋 Query filters: {filters}")
    print(f"📋 Resource types: {RESOURCE_TYPES}")
    
    # Choose query method based on --two-phase flag
    if args.two_phase:
        print("🚀 Using two-phase query method")
        notifications = get_query_results_efficient(filters, config, args.limit)
    else:
        print("📊 Using single query method")
        notifications = get_query_results(filters, config, args.limit)
    
    if args.csv:
        export_to_csv(notifications)
        # Don't return here if --output is also specified
    
    # Generate flapping report (if --output is specified or no --csv)
    if args.output or not args.csv:
        generate_flapping_report_from_notifications(notifications, filters, args.output)

if __name__ == "__main__":
    main()
