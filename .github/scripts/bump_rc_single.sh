#!/bin/bash
set -euo pipefail

# Simple RC bump script for a single-project repo (no --package option)
# Usage: ./bump_rc_single.sh

COG_EXEC="${COG_PATH:-$HOME/.cargo/bin/cog}"

if ! command -v git >/dev/null 2>&1; then
  echo "git not found in PATH"
  exit 1
fi

COMMIT_HASH=$(git rev-parse --short HEAD)
RC_IDENTIFIER="rc-${COMMIT_HASH}"
echo "Using RC identifier: ${RC_IDENTIFIER}"

echo "Running dry run to determine tag..."
if ! dry_run_output=$("$COG_EXEC" bump --auto --pre "$RC_IDENTIFIER" --dry-run 2>&1); then
  dry_run_exit_code=$?
else
  dry_run_exit_code=0
fi

echo "Dry run output: $dry_run_output"
echo "Dry run exit code: $dry_run_exit_code"

# If no conventional commits found, treat as success
if echo "$dry_run_output" | grep -qi "No conventional commits found"; then
  echo "No conventional commits found to bump version - this is expected and considered successful"
  exit 0
fi

if [[ $dry_run_exit_code -ne 0 ]]; then
  echo "Error: dry run failed"
  echo "$dry_run_output"
  exit 1
fi

# Extract tag like v1.2.3-rc-abc1234 or 1.2.3-rc-abc1234 or dir/v1.2.3-rc-abc1234
# Normalize to remove any directory prefix and any leading 'v' so we only return the version
raw_tag=$(echo "$dry_run_output" | grep -E "([[:alnum:]_\-]+/)*v?[0-9]+\.[0-9]+\.[0-9]+(-[A-Za-z0-9_.-]+)*-${RC_IDENTIFIER}" | tail -n 1 | tr -d '\n' )
if [[ -n "$raw_tag" ]]; then
  # remove directory prefix (anything before last '/') and leading 'v'
  expected_tag=$(echo "$raw_tag" | sed 's:.*/::' | sed 's/^v//')
else
  expected_tag=""
fi

echo "Running actual bump..."
if ! output=$("$COG_EXEC" bump --auto --pre "$RC_IDENTIFIER" 2>&1); then
  exit_code=$?
  if [[ $exit_code -eq 1 ]] && echo "$output" | grep -qi "No conventional commits found"; then
    echo "No conventional commits found to bump version - this is expected and considered successful"
    exit 0
  else
    echo "Error: failed to bump version"
    echo "$output"
    exit 1
  fi
fi

echo "Version bumped successfully"
# prefer the normalized expected_tag from dry-run, otherwise try to parse the actual output
if [[ -n "$expected_tag" ]]; then
  echo "NEW_TAG:$expected_tag"
else
  tag_from_output=$(echo "$output" | grep -E "([[:alnum:]_\-]+/)*v?[0-9]+\.[0-9]+\.[0-9]+(-[A-Za-z0-9_.-]+)*-${RC_IDENTIFIER}" | tail -n 1 | tr -d '\n') || true
  if [[ -n "$tag_from_output" ]]; then
    normalized=$(echo "$tag_from_output" | sed 's:.*/::' | sed 's/^v//')
    echo "NEW_TAG:$normalized"
  else
    echo "NEW_TAG:unknown"
  fi
fi
