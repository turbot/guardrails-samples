"""
Tests for _turbot.py Config class.
"""
import pytest
from unittest.mock import Mock, patch, mock_open
import requests
from _turbot import Config


def mock_config_with_env_vars(mock_getenv, mock_get):
    """Helper function to mock environment variables and requests."""
    # Mock environment variables for configuration
    mock_getenv.side_effect = lambda key: {
        'TURBOT_ACCESS_KEY_ID': 'test_key',
        'TURBOT_SECRET_ACCESS_KEY': 'test_secret',
        'TURBOT_WORKSPACE': 'https://test.turbot.com'
    }.get(key)
    
    # Mock successful health check
    mock_get.return_value.status_code = 200
    mock_get.return_value.text = "OK"


class TestConfigSSL:
    """Test SSL verification functionality in Config class."""
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_ssl_verification_enabled_by_default(self, mock_get, mock_getenv):
        """Test that SSL verification is enabled by default."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default")
        assert config.verify_ssl == True
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_ssl_verification_disabled_with_insecure_flag(self, mock_get, mock_getenv):
        """Test that SSL verification is disabled when insecure=True."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default", insecure=True)
        assert config.verify_ssl == False
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_health_check_uses_ssl_setting_secure(self, mock_get, mock_getenv):
        """Test that health check uses verify=True when SSL is enabled."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default", insecure=False)
        config.test_health()
        
        mock_get.assert_called_with(
            config.health_endpoint, 
            timeout=5, 
            verify=True
        )
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_health_check_uses_ssl_setting_insecure(self, mock_get, mock_getenv):
        """Test that health check uses verify=False when SSL is disabled."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default", insecure=True)
        config.test_health()
        
        mock_get.assert_called_with(
            config.health_endpoint, 
            timeout=5, 
            verify=False
        )
    
    @patch('os.getenv')
    @patch('requests.post')
    @patch('requests.get')
    def test_graphql_query_uses_ssl_setting_secure(self, mock_get, mock_post, mock_getenv):
        """Test that GraphQL query uses verify=True when SSL is enabled."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = {"data": {"test": "value"}}
        
        config = Config(None, "default", insecure=False)
        config.graphql_query("query { test }")
        
        mock_post.assert_called_with(
            config.graphql_endpoint,
            json={'query': 'query { test }'},
            headers={
                'Authorization': f'Basic {config.auth_token}',
                'Content-Type': 'application/json'
            },
            timeout=240,
            verify=True
        )
    
    @patch('os.getenv')
    @patch('requests.post')
    @patch('requests.get')
    def test_graphql_query_uses_ssl_setting_insecure(self, mock_get, mock_post, mock_getenv):
        """Test that GraphQL query uses verify=False when SSL is disabled."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = {"data": {"test": "value"}}
        
        config = Config(None, "default", insecure=True)
        config.graphql_query("query { test }")
        
        mock_post.assert_called_with(
            config.graphql_endpoint,
            json={'query': 'query { test }'},
            headers={
                'Authorization': f'Basic {config.auth_token}',
                'Content-Type': 'application/json'
            },
            timeout=240,
            verify=False
        )
    
    @patch('os.getenv')
    @patch('urllib3.disable_warnings')
    @patch('requests.get')
    def test_urllib3_warnings_disabled_when_insecure(self, mock_get, mock_disable_warnings, mock_getenv):
        """Test that urllib3 warnings are disabled when insecure=True."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        Config(None, "default", insecure=True)
        
        mock_disable_warnings.assert_called_once()
    
    @patch('os.getenv')
    @patch('urllib3.disable_warnings')
    @patch('requests.get')
    def test_urllib3_warnings_not_disabled_when_secure(self, mock_get, mock_disable_warnings, mock_getenv):
        """Test that urllib3 warnings are NOT disabled when insecure=False."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        Config(None, "default", insecure=False)
        
        mock_disable_warnings.assert_not_called()


class TestConfigInitialization:
    """Test Config class initialization with different parameters."""
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_config_with_debug_mode(self, mock_get, mock_getenv):
        """Test Config initialization with debug mode."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default", debug=True)
        assert config is not None
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_config_with_custom_credentials_file(self, mock_get, mock_getenv):
        """Test Config initialization with custom credentials file."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(None, "default", custom_credentials_file="/custom/path")
        assert config is not None
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_config_with_all_parameters(self, mock_get, mock_getenv):
        """Test Config initialization with all parameters."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        
        config = Config(
            custom_config_file=None,
            config_profile="default",
            debug=True,
            custom_credentials_file="/custom/path",
            insecure=True
        )
        assert config.verify_ssl == False


class TestConfigErrorHandling:
    """Test Config class error handling."""
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_health_check_connection_error(self, mock_get, mock_getenv):
        """Test health check with connection error."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_get.side_effect = requests.exceptions.ConnectionError("Connection failed")
        
        with pytest.raises(SystemExit):
            Config(None, "default")
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_health_check_timeout(self, mock_get, mock_getenv):
        """Test health check with timeout."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_get.side_effect = requests.exceptions.Timeout("Request timed out")
        
        with pytest.raises(SystemExit):
            Config(None, "default")
    
    @patch('os.getenv')
    @patch('requests.get')
    def test_health_check_http_error(self, mock_get, mock_getenv):
        """Test health check with HTTP error."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_get.return_value.status_code = 500
        mock_get.return_value.text = "Internal Server Error"
        
        # HTTP errors don't cause exit, just print message
        config = Config(None, "default")
        assert config is not None
    
    @patch('os.getenv')
    @patch('requests.post')
    @patch('requests.get')
    def test_graphql_query_error(self, mock_get, mock_post, mock_getenv):
        """Test GraphQL query with error response."""
        mock_config_with_env_vars(mock_getenv, mock_get)
        mock_post.return_value.status_code = 200
        mock_post.return_value.json.return_value = {
            "errors": [{"message": "GraphQL error"}]
        }
        
        config = Config(None, "default")
        
        with pytest.raises(SystemExit):
            config.graphql_query("query { test }")