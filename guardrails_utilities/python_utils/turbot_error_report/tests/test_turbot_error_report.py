"""
Tests for turbot_error_report.py main script.
"""
import pytest
import sys
from unittest.mock import patch, Mock
from turbot_error_report import parse_arguments, build_filters, format_output, validate_states


class TestStateValidation:
    """Test state validation functionality."""
    
    def test_validate_states_single_valid(self):
        """Test validation with single valid state."""
        result = validate_states("error")
        assert result == "error"
    
    def test_validate_states_multiple_valid(self):
        """Test validation with multiple valid states."""
        result = validate_states("error,alarm")
        assert result == "error,alarm"
    
    def test_validate_states_all_valid(self):
        """Test validation with all valid states."""
        result = validate_states("error,alarm,ok,skipped,tbd")
        assert result == "error,alarm,ok,skipped,tbd"
    
    def test_validate_states_with_spaces(self):
        """Test validation with spaces around states."""
        result = validate_states(" error , alarm ")
        assert result == " error , alarm "
    
    def test_validate_states_invalid_uppercase(self, capsys):
        """Test validation rejects uppercase states."""
        with pytest.raises(SystemExit) as exc_info:
            validate_states("ALARM")
        assert exc_info.value.code == 1
        
        captured = capsys.readouterr()
        assert "Error: Invalid state(s): ALARM" in captured.out
        assert "Valid states are: alarm, error, ok, skipped, tbd" in captured.out
        assert "For full help: python3 turbot_error_report.py -h" in captured.out
    
    def test_validate_states_invalid_value(self, capsys):
        """Test validation rejects invalid state values."""
        with pytest.raises(SystemExit) as exc_info:
            validate_states("invalid")
        assert exc_info.value.code == 1
        
        captured = capsys.readouterr()
        assert "Error: Invalid state(s): invalid" in captured.out
        assert "Valid states are: alarm, error, ok, skipped, tbd" in captured.out
    
    def test_validate_states_mixed_valid_invalid(self, capsys):
        """Test validation with mix of valid and invalid states."""
        with pytest.raises(SystemExit) as exc_info:
            validate_states("error,INVALID,alarm")
        assert exc_info.value.code == 1
        
        captured = capsys.readouterr()
        assert "Error: Invalid state(s): INVALID" in captured.out


class TestArgumentParsing:
    """Test command line argument parsing."""
    
    def test_insecure_flag_default_false(self):
        """Test that --insecure flag defaults to False."""
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            assert args.insecure == False
    
    def test_insecure_flag_short_form(self):
        """Test that -i flag sets insecure=True."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '-i']):
            args = parse_arguments()
            assert args.insecure == True
    
    def test_insecure_flag_long_form(self):
        """Test that --insecure flag sets insecure=True."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--insecure']):
            args = parse_arguments()
            assert args.insecure == True
    
    def test_insecure_flag_with_other_options(self):
        """Test that --insecure works with other options."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--insecure', '--debug', '--limit', '5']):
            args = parse_arguments()
            assert args.insecure == True
            assert args.debug == True
            assert args.limit == 5
    
    def test_all_arguments_defaults(self):
        """Test all argument defaults."""
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            assert args.hours == 24
            assert args.states == "error,alarm"
            assert args.resource_type is None
            assert args.output == "text"
            assert args.quiet == False
            assert args.no_timestamp == False
            assert args.limit is None
            assert args.debug == False
            assert args.insecure == False
    
    def test_all_arguments_custom_values(self):
        """Test all arguments with custom values."""
        with patch.object(sys, 'argv', [
            'turbot_error_report.py',
            '--hours', '48',
            '--states', 'error',
            '--resource-type', 's3',
            '--output', 'json',
            '--quiet',
            '--no-timestamp',
            '--limit', '10',
            '--debug',
            '--insecure'
        ]):
            args = parse_arguments()
            assert args.hours == 48
            assert args.states == "error"
            assert args.resource_type == "s3"
            assert args.output == "json"
            assert args.quiet == True
            assert args.no_timestamp == True
            assert args.limit == 10
            assert args.debug == True
            assert args.insecure == True


class TestFilterBuilding:
    """Test filter building logic."""
    
    def test_build_filters_default(self):
        """Test building filters with default arguments."""
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error,alarm",
                "timestamp:>=T-24h"
            ]
            assert filters == expected
    
    def test_build_filters_custom_states(self):
        """Test building filters with custom states."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--states', 'error,ok']):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error,ok",
                "timestamp:>=T-24h"
            ]
            assert filters == expected
    
    def test_build_filters_custom_hours(self):
        """Test building filters with custom hours."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--hours', '48']):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error,alarm",
                "timestamp:>=T-48h"
            ]
            assert filters == expected
    
    def test_build_filters_no_timestamp(self):
        """Test building filters without timestamp."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--no-timestamp']):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error,alarm"
            ]
            assert filters == expected
    
    def test_build_filters_resource_type_invalid_short_form(self, capsys):
        """Test building filters rejects short form resource type."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--resource-type', 's3']):
            args = parse_arguments()
            with pytest.raises(SystemExit) as exc_info:
                build_filters(args)
            assert exc_info.value.code == 1
            
            captured = capsys.readouterr()
            assert "Error: Resource type must be a full URI starting with 'tmod:'" in captured.out
            assert "Example: tmod:@turbot/aws-s3#/resource/types/bucket" in captured.out
            assert "For full help: python3 turbot_error_report.py -h" in captured.out
    
    def test_build_filters_resource_type_full_uri(self):
        """Test building filters with full URI resource type."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--resource-type', 'tmod:@turbot/aws-s3#/resource/types/bucket']):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error,alarm",
                "timestamp:>=T-24h",
                "resourceTypeId:tmod:@turbot/aws-s3#/resource/types/bucket"
            ]
            assert filters == expected
    
    def test_build_filters_all_options(self):
        """Test building filters with all options."""
        with patch.object(sys, 'argv', [
            'turbot_error_report.py',
            '--states', 'error',
            '--hours', '12',
            '--resource-type', 'tmod:@turbot/aws-ec2#/resource/types/instance',
            '--no-timestamp'
        ]):
            args = parse_arguments()
            filters = build_filters(args)
            
            expected = [
                "state:error",
                "resourceTypeId:tmod:@turbot/aws-ec2#/resource/types/instance"
            ]
            assert filters == expected


class TestOutputFormatting:
    """Test output formatting functionality."""
    
    def test_format_output_quiet_mode(self, sample_controls_data):
        """Test output formatting in quiet mode."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--quiet']):
            args = parse_arguments()
            result = format_output(sample_controls_data, args)
            assert result == "Total: 2"
    
    def test_format_output_text_mode(self, sample_controls_data):
        """Test output formatting in text mode."""
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            result = format_output(sample_controls_data, args)
            
            assert "Total: 2" in result
            assert "AWS S3 Bucket Encryption" in result
            assert "my-test-bucket" in result
            assert "error" in result
            assert "alarm" in result
    
    def test_format_output_json_mode(self, sample_controls_data):
        """Test output formatting in JSON mode."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--output', 'json']):
            args = parse_arguments()
            result = format_output(sample_controls_data, args)
            
            import json
            parsed = json.loads(result)
            assert len(parsed) == 2
            assert parsed[0]["state"] == "error"
            assert parsed[1]["state"] == "alarm"
    
    def test_format_output_csv_mode(self, sample_controls_data):
        """Test output formatting in CSV mode."""
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--output', 'csv']):
            args = parse_arguments()
            result = format_output(sample_controls_data, args)
            
            lines = result.strip().split('\n')
            assert len(lines) == 3  # Header + 2 data rows
            assert "Timestamp,Control Type,Resource,Resource ID,State,Reason" in lines[0]
            assert "error" in lines[1]
            assert "alarm" in lines[2]
    
    def test_format_output_empty_data(self):
        """Test output formatting with empty data."""
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            result = format_output([], args)
            assert result == "\nTotal: 0"
    
    def test_format_output_missing_reason(self):
        """Test output formatting with missing reason field."""
        data_without_reason = [
            {
                "state": "error",
                "turbot": {
                    "id": "12345",
                    "stateChangeTimestamp": "2024-01-01T00:00:00Z"
                },
                "type": {
                    "trunk": {"title": "Test Control"}
                },
                "resource": {
                    "trunk": {"title": "Test Resource"},
                    "turbot": {"id": "67890"}
                }
            }
        ]
        
        with patch.object(sys, 'argv', ['turbot_error_report.py']):
            args = parse_arguments()
            result = format_output(data_without_reason, args)
            
            assert "Test Control" in result
            assert "Test Resource" in result
            assert "error" in result


class TestIntegration:
    """Integration tests for the main script."""
    
    @patch('turbot_error_report.Config')
    def test_main_function_basic_flow(self, mock_config_class, sample_controls_data):
        """Test main function with basic flow."""
        # Mock Config class
        mock_config = Mock()
        mock_config.graphql_query.return_value = {
            "data": {
                "controls": {
                    "items": sample_controls_data,
                    "paging": {"next": None}
                }
            }
        }
        mock_config_class.return_value = mock_config
        
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--limit', '1']):
            with patch('turbot_error_report.print') as mock_print:
                from turbot_error_report import main
                main()
                
                # Verify Config was initialized with correct parameters
                mock_config_class.assert_called_once_with(None, "default", debug=False, insecure=False)
                
                # Verify GraphQL query was called
                mock_config.graphql_query.assert_called_once()
                
                # Verify output was printed
                mock_print.assert_called_once()
    
    @patch('turbot_error_report.Config')
    def test_main_function_with_insecure_flag(self, mock_config_class, sample_controls_data):
        """Test main function with insecure flag."""
        # Mock Config class
        mock_config = Mock()
        mock_config.graphql_query.return_value = {
            "data": {
                "controls": {
                    "items": sample_controls_data,
                    "paging": {"next": None}
                }
            }
        }
        mock_config_class.return_value = mock_config
        
        with patch.object(sys, 'argv', ['turbot_error_report.py', '--insecure', '--debug']):
            with patch('turbot_error_report.print') as mock_print:
                from turbot_error_report import main
                main()
                
                # Verify Config was initialized with insecure=True
                mock_config_class.assert_called_once_with(None, "default", debug=True, insecure=True)
