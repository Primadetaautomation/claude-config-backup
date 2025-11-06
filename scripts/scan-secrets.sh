#!/usr/bin/env bash
# Secret Scanner for Claude Memory Files
# Scans for common secrets, API keys, tokens, and sensitive data
#
# Usage: ./scripts/scan-secrets.sh [directory]
#
# Exit codes:
#   0 - No secrets found
#   1 - Secrets detected
#   2 - Script error

set -eo pipefail

SCAN_DIR="${1:-.claude-memory}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Change to repo directory
cd "$REPO_DIR"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# Check if directory exists
if [[ ! -d "$SCAN_DIR" ]]; then
    log_error "Directory not found: $SCAN_DIR"
    exit 2
fi

log_info "Scanning directory: $SCAN_DIR"
echo ""

found_secrets=0
total_checks=0

# Function to check pattern
check_pattern() {
    local name="$1"
    local pattern="$2"
    ((total_checks++))

    local matches
    matches=$(grep -rEI "$pattern" "$SCAN_DIR" 2>/dev/null || true)

    if [[ -n "$matches" ]]; then
        log_error "$name detected:"
        echo "$matches" | while IFS= read -r line; do
            echo "  → $line"
        done
        echo ""
        ((found_secrets++))
    fi
}

# Run all pattern checks
check_pattern "Email addresses" '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
check_pattern "API Keys" '(api[_-]?key[:=]\s*['\''"]?[A-Za-z0-9-_]{20,}['\''"]?)'
check_pattern "Passwords" '(password[:=]\s*['\''"]?[^\s]{6,}['\''"]?)'
check_pattern "JWT Tokens" 'Bearer [A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+'
check_pattern "Generic Tokens" '(token[:=]\s*['\''"]?[A-Za-z0-9-_]{20,}['\''"]?)'
check_pattern "Secrets" '(secret[:=]\s*['\''"]?[A-Za-z0-9-_]{20,}['\''"]?)'
check_pattern "AWS Keys" '(AKIA[0-9A-Z]{16})'
check_pattern "Private Keys" '-----BEGIN (RSA|DSA|EC|OPENSSH) PRIVATE KEY-----'
check_pattern "SSH Keys" 'ssh-(rsa|ed25519|ecdsa) [A-Za-z0-9+/]+[=]{0,2}'
check_pattern "GitHub PAT" 'ghp_[A-Za-z0-9]{36}'
check_pattern "OpenAI API Keys" 'sk-[A-Za-z0-9]{20,}'
check_pattern "Anthropic API Keys" 'sk-ant-api03-[A-Za-z0-9-_]+'
check_pattern "Stripe Keys" '(sk|pk)_(test|live)_[A-Za-z0-9]{24,}'
check_pattern "Google API Keys" 'AIza[0-9A-Za-z-_]{35}'
check_pattern "Supabase Keys" 'eyJ[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+'
check_pattern "IP Addresses" '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
check_pattern "Home Directories" '(/Users/[a-zA-Z0-9-_]+|/home/[a-zA-Z0-9-_]+)'

# Summary
echo ""
log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log_info "Scan Summary:"
log_info "  Directory: $SCAN_DIR"
log_info "  Checks performed: $total_checks"

if [[ $found_secrets -gt 0 ]]; then
    log_error "Secret types detected: $found_secrets"
    log_error "⚠️  REVIEW REQUIRED: Sensitive data found!"
    echo ""
    log_warn "Recommended actions:"
    log_warn "  1. Review detected secrets above"
    log_warn "  2. Remove or redact sensitive data"
    log_warn "  3. Run: ./scripts/memory-cleanup.sh"
    log_warn "  4. Verify .gitignore is protecting memory files"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
else
    log_success "No secrets detected! ✓"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
fi
