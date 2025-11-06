#!/usr/bin/env bash
# Memory Cleanup & Redaction Script
# Automatically archives, redacts, and optionally encrypts old Claude memory files
#
# Usage: ./scripts/memory-cleanup.sh [archive-dir] [days-to-keep]
#
# Environment variables:
#   GPG_RECIPIENT - GPG key ID for encryption (optional)
#   KEEP_DAYS     - Days to keep before archiving (default: 30)

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ARCHIVE_DIR="${1:-$HOME/.claude-memory-archive}"
KEEP_DAYS="${2:-${KEEP_DAYS:-30}}"
MEM_DIR="$REPO_DIR/.claude-memory"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if memory directory exists
if [[ ! -d "$MEM_DIR" ]]; then
    log_error "Memory directory not found: $MEM_DIR"
    exit 1
fi

# Create archive directory
mkdir -p "$ARCHIVE_DIR"
log_info "Archive directory: $ARCHIVE_DIR"

# Redaction patterns
redact_file() {
    local file="$1"
    local tmp_file
    tmp_file="$(mktemp)"

    # Apply redaction patterns
    sed -E \
        -e 's/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/[REDACTED_EMAIL]/g' \
        -e 's/(api[_-]?key[:=]\s*)([A-Za-z0-9-_]{20,})/\1[REDACTED_API_KEY]/gi' \
        -e 's/(password[:=]\s*)([^\s]{6,})/\1[REDACTED_PASSWORD]/gi' \
        -e 's/(token[:=]\s*)([A-Za-z0-9-_]{20,})/\1[REDACTED_TOKEN]/gi' \
        -e 's/(secret[:=]\s*)([A-Za-z0-9-_]{20,})/\1[REDACTED_SECRET]/gi' \
        -e 's/Bearer [A-Za-z0-9-_\.]+/Bearer [REDACTED_JWT]/g' \
        -e 's/\b(?:\d{1,3}\.){3}\d{1,3}\b/[REDACTED_IP]/g' \
        -e 's|/Users/[^/\s]+|/Users/[REDACTED_USER]|g' \
        -e 's|/home/[^/\s]+|/home/[REDACTED_USER]|g' \
        "$file" > "$tmp_file"

    echo "$tmp_file"
}

# Archive and redact old session files
archive_count=0
log_info "Scanning for sessions older than $KEEP_DAYS days..."

while IFS= read -r -d '' file; do
    filename="$(basename "$file")"

    # Skip if not a session file
    if [[ ! "$filename" =~ ^session- ]]; then
        continue
    fi

    log_info "Processing: $filename"

    # Redact sensitive data
    redacted_file=$(redact_file "$file")

    # Generate archive filename with timestamp
    timestamp="$(date +%Y%m%d_%H%M%S)"
    archive_filename="${filename%.md}.${timestamp}.redacted.md"
    archive_path="$ARCHIVE_DIR/$archive_filename"

    # Move redacted file to archive
    mv "$redacted_file" "$archive_path"
    log_info "Archived (redacted): $archive_filename"

    # Optionally encrypt
    if [[ -n "${GPG_RECIPIENT:-}" ]]; then
        log_info "Encrypting with GPG (recipient: $GPG_RECIPIENT)..."
        gpg --yes --trust-model always -r "$GPG_RECIPIENT" -e "$archive_path"
        rm "$archive_path"
        log_info "Encrypted: ${archive_filename}.gpg"
    fi

    # Remove original file
    rm -f "$file"
    log_info "Removed original: $filename"

    ((archive_count++))

done < <(find "$MEM_DIR" -maxdepth 1 -type f -name 'session-*' -mtime +"$KEEP_DAYS" -print0)

# Summary
echo ""
log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log_info "Cleanup Summary:"
log_info "  Files archived: $archive_count"
log_info "  Archive location: $ARCHIVE_DIR"
log_info "  Retention policy: $KEEP_DAYS days"
if [[ -n "${GPG_RECIPIENT:-}" ]]; then
    log_info "  Encryption: Enabled (GPG)"
else
    log_info "  Encryption: Disabled (set GPG_RECIPIENT to enable)"
fi
log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check current memory directory size
current_size=$(du -sh "$MEM_DIR" | awk '{print $1}')
log_info "Current memory directory size: $current_size"

exit 0
