#!/usr/bin/env bash
# Concise test runner: full output goes to log files, the terminal gets one line per test
# plus a short excerpt for each failure. Open the log only when the excerpt is not enough.
#
# Usage (from anywhere):
#   tests/run.sh                     all Lua and Python specs in tests/
#   tests/run.sh bleeding camera     selected specs (name, name_spec, or path; .lua or .py)
#   tests/run.sh --balance           balance tooling tests (docs/balance/tests)
#   tests/run.sh --syntax FILE...    syntax-only check of standard-Lua files
#
# Environment: PYTHON (default python3), SUMMARY_LINES (default 8), SPEC_TIMEOUT seconds (default 120).

set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit 2

LOG_DIR="outputs/test-logs"
PYTHON="${PYTHON:-python3}"
SUMMARY_LINES="${SUMMARY_LINES:-8}"
SPEC_TIMEOUT="${SPEC_TIMEOUT:-120}"
ERROR_PATTERN='error|Error|FAIL|assert|Traceback|expected|attempt to'

mkdir -p "$LOG_DIR"

passed=0
failed=0
failures=()

timeoutPrefix=()
if command -v timeout >/dev/null 2>&1; then
	timeoutPrefix=(timeout "$SPEC_TIMEOUT")
fi

# Print the most informative lines of a failed log: error-looking lines first, else the tail.
summarize() {
	local log="$1"
	local excerpt
	if grep -q "^stack traceback:" "$log"; then
		# Lua: the message precedes the traceback; keep it plus the first non-C frames.
		excerpt="$(awk -v max="$SUMMARY_LINES" '
			/^stack traceback:/ { inTrace = 1; frames = 0; next }
			!inTrace { message[++count] = $0; next }
			inTrace && !/^\t\[C\]/ && frames < max - 3 { trace[++frames] = $0 }
			END {
				for (i = (count > 3 ? count - 2 : 1); i <= count; i++) print message[i]
				for (i = 1; i <= frames; i++) print trace[i]
			}' "$log")"
	else
		excerpt="$(grep -E -m "$SUMMARY_LINES" "$ERROR_PATTERN" "$log")"
	fi
	if [[ -z "$excerpt" ]]; then
		excerpt="$(tail -n "$SUMMARY_LINES" "$log")"
	fi

	sed 's/^/    /' <<< "$excerpt"
	echo "    log: $log"
}

# Fingerprint of tracked-file changes, so a test that rewrites repository files is caught.
treeState() {
	git diff --no-ext-diff HEAD 2>/dev/null | cksum
}

# runOne LABEL COMMAND...
runOne() {
	local label="$1"
	shift
	local log="$LOG_DIR/$label.log"
	local status
	local before
	before="$(treeState)"

	"${timeoutPrefix[@]}" "$@" > "$log" 2>&1
	status=$?

	if [[ "$(treeState)" != "$before" ]]; then
		failed=$((failed + 1))
		failures+=("$label")
		echo "FAIL $label (modified tracked files; review with git diff, nothing was restored)"
		git diff --stat HEAD | sed 's/^/    /'
		echo "    log: $log"
		return
	fi

	if [[ $status -eq 0 ]]; then
		passed=$((passed + 1))
		echo "PASS $label"
		return
	fi

	failed=$((failed + 1))
	failures+=("$label")
	if [[ $status -eq 124 ]]; then
		echo "FAIL $label (timed out after ${SPEC_TIMEOUT}s)"
	else
		echo "FAIL $label (exit $status)"
	fi
	summarize "$log"
}

# Resolve "bleeding", "bleeding_spec", "tests/bleeding_spec.lua" or "x_spec.py" to a spec path.
resolveSpec() {
	if [[ -f "$1" && "$1" == *_spec.* ]]; then
		echo "$1"
		return 0
	fi

	local name="${1#tests/}"
	local candidate
	name="${name%.lua}"
	name="${name%.py}"
	name="${name%_spec}"

	for candidate in "tests/${name}_spec.lua" "tests/${name}_spec.py"; do
		if [[ -f "$candidate" ]]; then
			echo "$candidate"
			return 0
		fi
	done

	return 1
}

runSpec() {
	local path="$1"
	local label
	# Keep the extension: some specs exist as both .lua and .py.
	label="$(basename "$path")"

	case "$path" in
		*.lua) runOne "$label" luatex --luaonly "$path" ;;
		*.py) runOne "$label" "$PYTHON" "$path" ;;
	esac
}

runBalance() {
	runOne "balance" "$PYTHON" -m unittest discover -s docs/balance/tests
}

# Syntax check only. Legacy files using GMod-only operators (!=, &&, //, continue) fail here
# even though Garry's Mod accepts them.
runSyntax() {
	local file
	for file in "$@"; do
		local label="syntax_$(basename "${file%.*}")"
		runOne "$label" luatex --luaonly tests/support/syntax_check.lua "$file"
	done
}

case "${1:-}" in
	--balance)
		runBalance
		;;
	--syntax)
		shift
		if [[ $# -eq 0 ]]; then
			echo "usage: tests/run.sh --syntax FILE..." >&2
			exit 2
		fi
		runSyntax "$@"
		;;
	-h|--help)
		sed -n '2,12p' "${BASH_SOURCE[0]}"
		exit 0
		;;
	"")
		for spec in tests/*_spec.lua tests/*_spec.py; do
			runSpec "$spec"
		done
		;;
	*)
		for name in "$@"; do
			if ! spec="$(resolveSpec "$name")"; then
				failed=$((failed + 1))
				failures+=("$name")
				echo "FAIL $name (no matching spec in tests/)"
				continue
			fi
			runSpec "$spec"
		done
		;;
esac

echo
echo "$passed passed, $failed failed"
if [[ $failed -gt 0 ]]; then
	echo "failed: ${failures[*]}"
	exit 1
fi
