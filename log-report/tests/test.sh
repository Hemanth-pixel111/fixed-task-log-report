#!/bin/bash
set -euo pipefail

# pytest is baked into the environment image (environment/Dockerfile).
test_status=0
pytest /tests/test_outputs.py -rA --tb=short || test_status=$?

if [ "$test_status" -eq 0 ]; then
  echo 1 > /app/reward.txt
  python3 - <<'PY'
import json
from pathlib import Path

Path('/app/ctrf.json').write_text(json.dumps({
    'results': {
        'tool': {'name': 'pytest'},
        'summary': {'passed': 2, 'failed': 0, 'error': 0, 'skipped': 0, 'total': 2},
        'tests': [
            {'name': 'test_report_exists', 'status': 'passed'},
            {'name': 'test_report_content', 'status': 'passed'},
        ],
    }
}, indent=2))
PY
else
  echo 0 > /app/reward.txt
  python3 - <<'PY'
import json
from pathlib import Path

Path('/app/ctrf.json').write_text(json.dumps({
    'results': {
        'tool': {'name': 'pytest'},
        'summary': {'passed': 0, 'failed': 2, 'error': 0, 'skipped': 0, 'total': 2},
        'tests': [
            {'name': 'test_report_exists', 'status': 'failed'},
            {'name': 'test_report_content', 'status': 'failed'},
        ],
    }
}, indent=2))
PY
fi
