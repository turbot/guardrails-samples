"""
Unit tests for activity_ledger_export.py.

Covers pure functions and network-dependent functions via mocking.
Run with: pytest test_activity_ledger_export.py
"""
import threading
import time
from unittest.mock import MagicMock, patch, call

import pytest
import requests

import activity_ledger_export as ale


# ---------------------------------------------------------------------------
# fmt_duration
# ---------------------------------------------------------------------------

class TestFmtDuration:
    def test_seconds_only(self):
        assert ale.fmt_duration(0) == "0s"
        assert ale.fmt_duration(1) == "1s"
        assert ale.fmt_duration(59) == "59s"

    def test_minutes_and_seconds(self):
        assert ale.fmt_duration(60) == "1m 0s"
        assert ale.fmt_duration(90) == "1m 30s"
        assert ale.fmt_duration(3599) == "59m 59s"

    def test_hours_and_minutes(self):
        assert ale.fmt_duration(3600) == "1h 0m"
        assert ale.fmt_duration(3661) == "1h 1m"
        assert ale.fmt_duration(7322) == "2h 2m"


# ---------------------------------------------------------------------------
# build_date_chunks
# ---------------------------------------------------------------------------

class TestBuildDateChunks:
    def test_single_chunk_fits_range(self):
        chunks = ale.build_date_chunks("2026-01-01", "2026-01-07", 7)
        assert chunks == [("2026-01-01", "2026-01-08")]

    def test_exact_multiple_of_chunk_days(self):
        chunks = ale.build_date_chunks("2026-01-01", "2026-01-14", 7)
        assert chunks == [
            ("2026-01-01", "2026-01-08"),
            ("2026-01-08", "2026-01-15"),
        ]

    def test_partial_last_chunk(self):
        chunks = ale.build_date_chunks("2026-01-01", "2026-01-10", 7)
        assert chunks == [
            ("2026-01-01", "2026-01-08"),
            ("2026-01-08", "2026-01-11"),
        ]

    def test_single_day(self):
        chunks = ale.build_date_chunks("2026-03-15", "2026-03-15", 1)
        assert chunks == [("2026-03-15", "2026-03-16")]

    def test_chunk_larger_than_range(self):
        chunks = ale.build_date_chunks("2026-05-01", "2026-05-03", 30)
        assert chunks == [("2026-05-01", "2026-05-04")]

    def test_chunk_start_equals_end(self):
        # to_date exclusive boundary: chunk_to is end + 1 day
        chunks = ale.build_date_chunks("2026-06-01", "2026-06-01", 7)
        assert len(chunks) == 1
        assert chunks[0][0] == "2026-06-01"


# ---------------------------------------------------------------------------
# item_to_row
# ---------------------------------------------------------------------------

def _make_item(**overrides):
    base = {
        "notificationType": "action_notify",
        "message": "Resource updated",
        "turbot": {
            "id": "12345",
            "processId": "99999",
            "createTimestamp": "2026-06-01T12:00:00.000Z",
        },
        "actor": {
            "identity": {"title": "Turbot Identity"}
        },
        "resource": {
            "trunk": {"title": "Root > MyAccount"},
            "turbot": {
                "id": "67890",
                "title": "MyBucket",
                "akas": ["arn:aws:s3:::mybucket"],
            },
            "type": {
                "trunk": {"title": "AWS > S3 > Bucket"},
                "uri": "tmod:@turbot/aws-s3#/resource/types/bucket",
            },
        },
    }
    base.update(overrides)
    return base


class TestItemToRow:
    WS = "https://example.turbot.com"

    def test_full_item(self):
        row = ale.item_to_row(_make_item(), self.WS)
        assert row["notification_id"] == "12345"
        assert row["notification_type"] == "action_notify"
        assert row["timestamp"] == "2026-06-01T12:00:00.000Z"
        assert row["actor"] == "Turbot Identity"
        assert row["message"] == "Resource updated"
        assert row["resource_aka"] == "arn:aws:s3:::mybucket"
        assert row["resource_title"] == "MyBucket"
        assert row["resource_type"] == "AWS > S3 > Bucket"
        assert row["resource_trunk"] == "Root > MyAccount"
        assert row["detail_link"] == (
            "https://example.turbot.com/apollo/processes/99999/notifications/12345"
        )

    def test_detail_link_absent_when_no_process_id(self):
        item = _make_item()
        item["turbot"]["processId"] = ""
        row = ale.item_to_row(item, self.WS)
        assert row["detail_link"] == ""

    def test_empty_akas_uses_empty_string(self):
        item = _make_item()
        item["resource"]["turbot"]["akas"] = []
        row = ale.item_to_row(item, self.WS)
        assert row["resource_aka"] == ""

    def test_null_resource(self):
        item = _make_item()
        item["resource"] = None
        row = ale.item_to_row(item, self.WS)
        assert row["resource_aka"] == ""
        assert row["resource_title"] == ""
        assert row["resource_type"] == ""
        assert row["resource_trunk"] == ""

    def test_null_actor(self):
        item = _make_item()
        item["actor"] = None
        row = ale.item_to_row(item, self.WS)
        assert row["actor"] == ""

    def test_workspace_url_trailing_slash_not_normalized(self):
        # item_to_row does not rstrip workspace_url — the CLI caller handles that.
        # A trailing slash produces a double-slash in the detail_link.
        item = _make_item()
        row = ale.item_to_row(item, "https://example.turbot.com/")
        assert row["detail_link"].startswith("https://example.turbot.com//apollo/")

    def test_notification_id_coerced_to_string(self):
        item = _make_item()
        item["turbot"]["id"] = 12345  # int, not string
        row = ale.item_to_row(item, self.WS)
        assert row["notification_id"] == "12345"
        assert isinstance(row["notification_id"], str)

    def test_null_turbot_field_does_not_crash(self):
        # regression: bare item['turbot']['createTimestamp'] would raise TypeError
        item = _make_item()
        item["turbot"] = None
        row = ale.item_to_row(item, self.WS)
        assert row["notification_id"] == ""
        assert row["timestamp"] == ""
        assert row["detail_link"] == ""


# ---------------------------------------------------------------------------
# run_query — retry and success paths
# ---------------------------------------------------------------------------

def _mock_response(status_code, json_body=None):
    resp = MagicMock()
    resp.status_code = status_code
    resp.json.return_value = json_body or {}
    return resp


class TestRunQuery:
    ENDPOINT = "https://example.turbot.com/api/latest/graphql"
    HEADERS = {"Authorization": "Basic abc123"}
    QUERY = "query { __typename }"
    VARS = {}

    def test_success_on_first_attempt(self):
        payload = {"data": {"notifications": {}}}
        with patch("requests.post", return_value=_mock_response(200, payload)) as mock_post:
            result = ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS)
        assert result == payload
        mock_post.assert_called_once()

    def test_retries_on_429_then_succeeds(self):
        payload = {"data": {}}
        responses = [_mock_response(429), _mock_response(200, payload)]
        with patch("requests.post", side_effect=responses):
            with patch("time.sleep"):
                result = ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS,
                                       max_retries=3)
        assert result == payload

    def test_retries_on_503(self):
        payload = {"data": {}}
        responses = [_mock_response(503), _mock_response(503), _mock_response(200, payload)]
        with patch("requests.post", side_effect=responses):
            with patch("time.sleep"):
                result = ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS,
                                       max_retries=5)
        assert result == payload

    def test_raises_on_non_retriable_http_error(self):
        with patch("requests.post", return_value=_mock_response(400)):
            with pytest.raises(Exception, match="HTTP 400"):
                ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS, max_retries=3)

    def test_raises_after_exhausting_retries(self):
        with patch("requests.post", return_value=_mock_response(503)):
            with patch("time.sleep"):
                with pytest.raises(Exception, match="after 3 retries"):
                    ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS, max_retries=3)

    def test_retries_on_timeout_exception(self):
        payload = {"data": {}}
        side_effects = [
            requests.exceptions.Timeout("timed out"),
            _mock_response(200, payload),
        ]
        with patch("requests.post", side_effect=side_effects):
            with patch("time.sleep"):
                result = ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS,
                                       max_retries=3)
        assert result == payload

    def test_raises_after_exhausting_timeout_retries(self):
        with patch("requests.post", side_effect=requests.exceptions.Timeout("timed out")):
            with patch("time.sleep"):
                with pytest.raises(Exception, match="after 2 retries"):
                    ale.run_query(self.ENDPOINT, self.HEADERS, self.QUERY, self.VARS, max_retries=2)


# ---------------------------------------------------------------------------
# get_turbot_identity_id
# ---------------------------------------------------------------------------

class TestGetTurbotIdentityId:
    ENDPOINT = "https://example.turbot.com/api/latest/graphql"
    HEADERS = {}

    def test_returns_id_when_found(self):
        payload = {"data": {"resources": {"items": [{"turbot": {"id": 777, "title": "turbot"}}]}}}
        with patch.object(ale, "run_query", return_value=payload):
            result = ale.get_turbot_identity_id(self.ENDPOINT, self.HEADERS)
        assert result == "777"

    def test_returns_none_when_no_items(self):
        payload = {"data": {"resources": {"items": []}}}
        with patch.object(ale, "run_query", return_value=payload):
            result = ale.get_turbot_identity_id(self.ENDPOINT, self.HEADERS)
        assert result is None

    def test_returns_none_on_graphql_errors(self):
        payload = {"errors": [{"message": "Unauthorized"}]}
        with patch.object(ale, "run_query", return_value=payload):
            result = ale.get_turbot_identity_id(self.ENDPOINT, self.HEADERS)
        assert result is None


# ---------------------------------------------------------------------------
# _paginate — streaming and accumulating modes
# ---------------------------------------------------------------------------

def _make_progress(key="types_done"):
    total_key = "total_" + key.replace("_done", "")
    return {
        "lock": threading.Lock(),
        key: 0,
        "items_fetched": 0,
        total_key: 1,
        "start_time": time.time(),
    }


def _make_notification_payload(items, next_cursor=None):
    return {
        "data": {
            "notifications": {
                "metadata": {"stats": {"total": len(items)}},
                "paging": {"next": next_cursor},
                "items": items,
            }
        }
    }


class TestPaginate:
    ENDPOINT = "https://example.turbot.com/api/latest/graphql"
    HEADERS = {}
    FILTER = ["notificationType:action_notify"]

    def test_single_page_accumulate(self):
        items = [_make_item(), _make_item()]
        payload = _make_notification_payload(items, next_cursor=None)
        progress = _make_progress()

        with patch.object(ale, "run_query", return_value=payload):
            result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                   "test", 500, progress, "types_done")

        assert len(result) == 2

    def test_multi_page_accumulate(self):
        items_p1 = [_make_item()]
        items_p2 = [_make_item(), _make_item()]
        payloads = [
            _make_notification_payload(items_p1, next_cursor="cursor-abc"),
            _make_notification_payload(items_p2, next_cursor=None),
        ]
        progress = _make_progress()

        with patch.object(ale, "run_query", side_effect=payloads):
            result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                   "test", 500, progress, "types_done")

        assert len(result) == 3

    def test_streaming_write_fn_called_per_page(self):
        items_p1 = [_make_item()]
        items_p2 = [_make_item()]
        payloads = [
            _make_notification_payload(items_p1, next_cursor="cursor-abc"),
            _make_notification_payload(items_p2, next_cursor=None),
        ]
        progress = _make_progress()
        collected = []

        with patch.object(ale, "run_query", side_effect=payloads):
            result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                   "test", 500, progress, "types_done",
                                   write_fn=lambda page: collected.extend(page))

        assert result == []  # write_fn mode returns empty list
        assert len(collected) == 2

    def test_query_error_stops_pagination(self):
        payload = {"errors": [{"message": "server error"}]}
        progress = _make_progress()

        with patch.object(ale, "run_query", return_value=payload):
            result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                   "test", 500, progress, "types_done")

        assert result == []

    def test_query_error_on_page2_returns_partial_and_reports_count(self):
        # regression: error on page 2 should report items fetched so far, not silently return 0
        items_p1 = [_make_item(), _make_item()]
        payloads = [
            _make_notification_payload(items_p1, next_cursor="cursor-abc"),
            {"errors": [{"message": "timeout"}]},
        ]
        progress = _make_progress()

        with patch.object(ale, "run_query", side_effect=payloads):
            with patch("activity_ledger_export.tprint") as mock_tprint:
                result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                       "test", 500, progress, "types_done")

        assert len(result) == 2  # partial results from page 1 returned
        error_messages = " ".join(str(c) for c in mock_tprint.call_args_list)
        assert "2" in error_messages  # item count mentioned in the stop message

    def test_exception_stops_pagination(self):
        progress = _make_progress()

        with patch.object(ale, "run_query", side_effect=Exception("network error")):
            result = ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                                   "test", 500, progress, "types_done")

        assert result == []

    def test_progress_counter_incremented(self):
        items = [_make_item()]
        payload = _make_notification_payload(items)
        progress = _make_progress()

        with patch.object(ale, "run_query", return_value=payload):
            ale._paginate(self.ENDPOINT, self.HEADERS, self.FILTER,
                          "test", 500, progress, "types_done")

        assert progress["types_done"] == 1
        assert progress["items_fetched"] == 1


# ---------------------------------------------------------------------------
# run_chunk — empty resource_type_ids (single unfiltered worker)
# ---------------------------------------------------------------------------

class TestRunChunkNoResourceTypes:
    ENDPOINT = "https://example.turbot.com/api/latest/graphql"
    HEADERS = {}

    def test_empty_resource_type_ids_uses_single_worker(self):
        items = [_make_item(), _make_item()]
        payload = _make_notification_payload(items)

        with patch.object(ale, "run_query", return_value=payload):
            result = ale.run_chunk(
                self.ENDPOINT, self.HEADERS,
                ["notificationType:action_notify"],
                [],  # no resource_type_ids
                "2026-06-01", "2026-06-08",
                500, 7,
                "2026-06-01 → 2026-06-08", 1, 1,
                all_notifications=False,
            )

        assert len(result) == 2

    def test_empty_resource_type_ids_filter_has_no_resourceTypeId(self):
        captured = []

        def capture_call(endpoint, headers, query, variables, **kwargs):
            captured.append(variables["filter"])
            return _make_notification_payload([])

        with patch.object(ale, "run_query", side_effect=capture_call):
            ale.run_chunk(
                self.ENDPOINT, self.HEADERS,
                ["notificationType:action_notify"],
                [],
                "2026-06-01", "2026-06-08",
                500, 7,
                "label", 1, 1,
                all_notifications=False,
            )

        assert captured, "run_query was not called"
        filter_sent = captured[0]
        assert not any("resourceTypeId" in f for f in filter_sent)


# ---------------------------------------------------------------------------
# --resume guard: output exists but no checkpoint
# ---------------------------------------------------------------------------

class TestResumeGuard:
    def test_resume_rejected_when_output_exists_but_no_checkpoint(self, tmp_path):
        from click.testing import CliRunner
        output_file = tmp_path / "out.csv"
        output_file.write_text("notification_id\n")  # simulate existing output

        runner = CliRunner()
        result = runner.invoke(ale.activity_ledger_export, [
            "--from-date", "2026-06-01",
            "--to-date", "2026-06-07",
            "--resume",
            "--output", str(output_file),
        ])

        assert result.exit_code != 0
        assert "checkpoint" in result.output.lower()

    def test_resume_rejected_when_neither_file_exists(self, tmp_path):
        from click.testing import CliRunner
        output_file = tmp_path / "nonexistent.csv"

        runner = CliRunner()
        result = runner.invoke(ale.activity_ledger_export, [
            "--from-date", "2026-06-01",
            "--to-date", "2026-06-07",
            "--resume",
            "--output", str(output_file),
        ])

        assert result.exit_code != 0
        assert "checkpoint" in result.output.lower() or "no checkpoint" in result.output.lower()
