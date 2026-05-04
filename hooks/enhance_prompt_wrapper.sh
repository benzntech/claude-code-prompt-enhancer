#!/bin/bash
# Optimized wrapper for Claude Code prompt enhancement hook
# Ensures correct environment and execution context

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || {
    echo "Error: Project directory not found" >&2
    exit 1
}

# Read from stdin and wrap as JSON for the script
input=$(cat)
if [ -z "$input" ]; then
    exec uv run --quiet python "$SCRIPT_DIR/enhance_prompt.py" --empty
else
    echo "{\"prompt\": $(echo "$input" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')}" | uv run --quiet python "$SCRIPT_DIR/enhance_prompt.py"
fi
