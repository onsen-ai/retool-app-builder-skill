#!/usr/bin/env bash
# bundle-apps.sh — Bundle Retool app directories into single .toolscript-bundle
# files for LLM context consumption.
#
# Usage:
#   bash bundle-apps.sh <app-dir> [output-file]          # Bundle single app
#   bash bundle-apps.sh --all [source-dir] [output-dir]   # Bundle all apps
#   bash bundle-apps.sh --help
#
# Options:
#   --all           Bundle all app directories in source-dir
#   --validate      Run validate_app.py on each app before bundling
#   --help          Show usage

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage:
  bash $0 <app-dir> [output-file]          Bundle single app
  bash $0 --all [source-dir] [output-dir]  Bundle all apps in directory
  bash $0 --help

Options:
  --all           Bundle all app directories in source-dir
  --validate      Run validate_app.py on each app before bundling
  --help          Show this help

Defaults:
  output-file:  <app-name>.toolscript-bundle (next to app dir)
  source-dir:   assets/examples/ (relative to script)
  output-dir:   same as source-dir
EOF
    exit 0
}

# ---------------------------------------------------------------------------
# Parse flags
# ---------------------------------------------------------------------------
ALL_MODE=false
VALIDATE=false
POSITIONAL=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help|-h)
            usage
            ;;
        --all)
            ALL_MODE=true
            shift
            ;;
        --validate)
            VALIDATE=true
            shift
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done

# ---------------------------------------------------------------------------
# Check for valid app dir (must contain main.rsx)
# ---------------------------------------------------------------------------
is_valid_app() {
    [ -f "$1/main.rsx" ]
}

# ---------------------------------------------------------------------------
# Excluded patterns — matches zip_app.sh
# ---------------------------------------------------------------------------
should_exclude() {
    local relpath="$1"
    case "$relpath" in
        .DS_Store|*/.DS_Store) return 0 ;;
        __pycache__/*|*/__pycache__/*) return 0 ;;
        *.pyc) return 0 ;;
        *.toolscript-bundle) return 0 ;;
    esac
    return 1
}

# ---------------------------------------------------------------------------
# Run validation if --validate is set
# ---------------------------------------------------------------------------
run_validate() {
    local app_dir="$1"
    if [ "$VALIDATE" = true ]; then
        if [ -f "$SCRIPT_DIR/validate_app.py" ]; then
            echo "  Validating $(basename "$app_dir")..."
            if ! python3 "$SCRIPT_DIR/validate_app.py" "$app_dir"; then
                echo "Error: Validation failed for $(basename "$app_dir"). Aborting."
                return 1
            fi
        else
            echo "Warning: validate_app.py not found, skipping validation."
        fi
    fi
    return 0
}

# ---------------------------------------------------------------------------
# Bundle a single app directory into an output file
# ---------------------------------------------------------------------------
bundle_app() {
    local app_dir="$1"
    local outfile="$2"
    local app_name
    app_name=$(basename "$app_dir")

    # Validate if requested
    if ! run_validate "$app_dir"; then
        return 1
    fi

    # Ensure output directory exists
    mkdir -p "$(dirname "$outfile")"

    # Header
    cat > "$outfile" <<HEADER
# =============================================
# RETOOL APP BUNDLE: $app_name
# Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)
# =============================================

HEADER

    # Collect files, excluding junk
    local files=()
    while IFS= read -r -d '' filepath; do
        local relpath="${filepath#$app_dir/}"
        if ! should_exclude "$relpath"; then
            files+=("$filepath")
        fi
    done < <(find "$app_dir" -type f -print0 | sort -z)

    # Folder structure
    echo "# FOLDER STRUCTURE" >> "$outfile"
    echo "# ----------------" >> "$outfile"
    for filepath in "${files[@]}"; do
        echo "${filepath#$app_dir/}" >> "$outfile"
    done
    echo "" >> "$outfile"
    echo "# =============================================" >> "$outfile"
    echo "# FILE CONTENTS" >> "$outfile"
    echo "# =============================================" >> "$outfile"
    echo "" >> "$outfile"

    # Concatenate all files with path headers
    for filepath in "${files[@]}"; do
        local relpath="${filepath#$app_dir/}"
        echo "# ──────────────────────────────────────────────" >> "$outfile"
        echo "# FILE: $relpath" >> "$outfile"
        echo "# ──────────────────────────────────────────────" >> "$outfile"
        cat "$filepath" >> "$outfile"
        echo "" >> "$outfile"
        echo "" >> "$outfile"
    done

    echo "  -> ${#files[@]} files bundled into $(basename "$outfile")"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

if [ "$ALL_MODE" = true ]; then
    # --all mode: bundle all apps in a directory
    BASE="${POSITIONAL[0]:-$SCRIPT_DIR/../assets/examples}"
    OUT="${POSITIONAL[1]:-}"

    # Resolve source to absolute path
    if [ ! -d "$BASE" ]; then
        echo "Error: Source directory does not exist: $BASE"
        exit 1
    fi
    BASE="$(cd "$BASE" && pwd)"

    # Output defaults to same as source
    if [ -z "$OUT" ]; then
        OUT="$BASE"
    fi
    mkdir -p "$OUT"
    OUT="$(cd "$OUT" && pwd)"

    echo "Source: $BASE"
    echo "Output: $OUT"
    echo ""

    count=0
    for dir in "$BASE"/*/; do
        [ -d "$dir" ] || continue
        app_name=$(basename "$dir")

        # Skip dirs without main.rsx (not valid Retool apps)
        if ! is_valid_app "$dir"; then
            continue
        fi

        outfile="$OUT/${app_name}.toolscript-bundle"
        echo "Bundling: $app_name"
        if ! bundle_app "$dir" "$outfile"; then
            exit 1
        fi
        count=$((count + 1))
    done

    echo ""
    echo "Done. $count apps bundled."

else
    # Single-app mode
    if [ ${#POSITIONAL[@]} -lt 1 ]; then
        echo "Error: Missing app directory argument."
        echo "Usage: bash $0 <app-dir> [output-file]"
        echo "       bash $0 --all [source-dir] [output-dir]"
        echo "       bash $0 --help"
        exit 1
    fi

    APP_DIR="${POSITIONAL[0]}"

    if [ ! -d "$APP_DIR" ]; then
        echo "Error: $APP_DIR is not a directory"
        exit 1
    fi

    if ! is_valid_app "$APP_DIR"; then
        echo "Error: $APP_DIR does not contain main.rsx — not a valid Retool app"
        exit 1
    fi

    APP_DIR="$(cd "$APP_DIR" && pwd)"
    APP_NAME=$(basename "$APP_DIR")

    # Determine output path
    if [ ${#POSITIONAL[@]} -ge 2 ]; then
        OUTFILE="${POSITIONAL[1]}"
    else
        OUTFILE="$(dirname "$APP_DIR")/${APP_NAME}.toolscript-bundle"
    fi

    echo "Bundling: $APP_NAME"
    if ! bundle_app "$APP_DIR" "$OUTFILE"; then
        exit 1
    fi
    echo ""
    echo "Done. Bundle: $OUTFILE"
fi
