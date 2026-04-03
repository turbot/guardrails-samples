---
description: Run Guardrails controls in batches using run_controls_batches.py
user-invocable: true
disable-model-invocation: true
---

Help the user run the `run_controls_batches.py` utility to re-run Guardrails controls in batches.

Based on the user's description, build the correct command: $ARGUMENTS

The script is at `guardrails_utilities/python_utils/run_controls_batches/run_controls_batches.py`.

## Setup (if not already done)

```bash
cd guardrails_utilities/python_utils/run_controls_batches
python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
```

Credentials must be configured via environment variables or a YAML config file at `~/.config/turbot/credentials.yml`.

## Available options

| Flag | Description | Default |
|------|-------------|---------|
| `-f, --filter` | Control filter (e.g., `"state:tbd"`, `"state:error"`) | `"state:tbd"` |
| `-b, --batch` | Controls per batch before cooldown | `100` |
| `-d, --cooldown` | Seconds between batches (0 to disable) | `120` |
| `-s, --start-index` | Starting point in the control collection | `0` |
| `-m, --max-batch` | Max batches to run (-1 for all) | `-1` |
| `-e, --execute` | Actually re-run controls (without this, dry-run only) | off |
| `-c, --config-file` | Path to YAML config file | auto-detect |
| `-p, --profile` | Profile name from config file | `"default"` |
| `-i, --insecure` | Disable SSL verification | off |

## Common filter patterns

- TBD controls (default): `"state:tbd"`
- Error controls: `"state:error"`
- Multiple states: `"state:tbd,error,alarm"`
- Specific control type: `"controlType:'tmod:@turbot/aws#/control/types/eventHandlers'"`
- Discovery controls: `"Discovery controlCategory:'tmod:@turbot/turbot#/control/categories/cmdb'"`
- Installed controls in error: `"state:tbd,error controlType:'tmod:@turbot/turbot#/control/types/controlInstalled'"`

## Instructions

1. Ask the user what controls they want to re-run (filter, batch size, cooldown).
2. Build the command with appropriate flags.
3. **Always show the dry-run command first** (without `--execute`) so the user can see how many controls match.
4. Only add `--execute` after the user confirms they want to proceed.
5. If using a config file, include `-c` and `-p` flags.
