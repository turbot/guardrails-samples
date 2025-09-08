"""
Test configuration and fixtures for turbot_error_report tests.
"""
import pytest
import sys
import os
from unittest.mock import Mock

# Add the parent directory to the path so we can import our modules
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

@pytest.fixture
def mock_config_data():
    """Mock configuration data for testing."""
    return {
        'default': {
            'accessKey': 'test_access_key',
            'secretKey': 'test_secret_key',
            'workspace': 'https://test.turbot.com'
        }
    }

@pytest.fixture
def mock_health_response():
    """Mock health check response."""
    response = Mock()
    response.status_code = 200
    response.text = "OK"
    return response

@pytest.fixture
def mock_graphql_response():
    """Mock GraphQL response."""
    response = Mock()
    response.status_code = 200
    response.json.return_value = {
        "data": {
            "controls": {
                "items": [
                    {
                        "state": "error",
                        "reason": "Test error",
                        "turbot": {
                            "id": "12345",
                            "stateChangeTimestamp": "2024-01-01T00:00:00Z"
                        },
                        "type": {
                            "trunk": {"title": "Test Control"},
                            "uri": "tmod:@turbot/test#/control/types/test"
                        },
                        "resource": {
                            "trunk": {"title": "Test Resource"},
                            "turbot": {"id": "67890"}
                        }
                    }
                ],
                "paging": {"next": None}
            }
        }
    }
    return response

@pytest.fixture
def sample_controls_data():
    """Sample controls data for testing output formatting."""
    return [
        {
            "state": "error",
            "reason": "Test error reason",
            "turbot": {
                "id": "12345",
                "stateChangeTimestamp": "2024-01-01T00:00:00Z"
            },
            "type": {
                "trunk": {"title": "AWS S3 Bucket Encryption"},
                "uri": "tmod:@turbot/aws-s3#/control/types/bucketEncryption"
            },
            "resource": {
                "trunk": {"title": "my-test-bucket"},
                "turbot": {"id": "67890"}
            }
        },
        {
            "state": "alarm",
            "reason": "Test alarm reason",
            "turbot": {
                "id": "54321",
                "stateChangeTimestamp": "2024-01-01T01:00:00Z"
            },
            "type": {
                "trunk": {"title": "AWS EC2 Instance Public Access"},
                "uri": "tmod:@turbot/aws-ec2#/control/types/instancePublicAccess"
            },
            "resource": {
                "trunk": {"title": "i-1234567890abcdef0"},
                "turbot": {"id": "09876"}
            }
        }
    ]
