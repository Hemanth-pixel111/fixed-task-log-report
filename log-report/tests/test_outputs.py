import json
from pathlib import Path

EXPECTED_REPORT = {
    "total_requests": 6,
    "unique_ips": 3,
    "top_path": "/index.html",
}


def test_report_exists():
    """The agent produced a report file."""
    assert Path("/app/report.json").exists(), "no report.json found"


def test_report_content():
    """The report contains the expected summary values."""
    report_path = Path("/app/report.json")
    assert report_path.stat().st_size > 0, "report.json is empty"

    with report_path.open() as handle:
        report = json.load(handle)

    assert report == EXPECTED_REPORT, f"unexpected report contents: {report}"