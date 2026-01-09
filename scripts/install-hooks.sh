#!/bin/bash

# TuringMind Code Review - Git Hook Installer
# Run this in any git repository to enable pre-push code review

set -e

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo -e "${CYAN}🧠 TuringMind Code Review - Git Hook Installer${NC}"
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: Not a git repository${NC}"
    echo "   Run this command from a git project root."
    exit 1
fi

# Check if Claude CLI is installed
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}⚠️  Claude CLI not found${NC}"
    echo "   Install it with: npm install -g @anthropic-ai/claude-code"
    echo ""
fi

# URL to fetch the hook from GitHub
HOOK_URL="https://raw.githubusercontent.com/turingmindai/turingmind-code-review/main/hooks/pre-push"

# Check for existing pre-push hook
if [ -f ".git/hooks/pre-push" ]; then
    echo -e "${YELLOW}⚠️  Existing pre-push hook found${NC}"
    # Check if running interactively (not piped)
    if [ -t 0 ]; then
        read -p "   Overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "   Skipped. Existing hook preserved."
            exit 0
        fi
    else
        # Non-interactive (piped) - backup and overwrite
        echo "   Backing up to .git/hooks/pre-push.backup"
        cp ".git/hooks/pre-push" ".git/hooks/pre-push.backup"
    fi
fi

# Download and install pre-push hook
echo "📥 Downloading pre-push hook..."
if curl -sSL "$HOOK_URL" -o ".git/hooks/pre-push"; then
    chmod +x ".git/hooks/pre-push"
    echo -e "${GREEN}✅ Pre-push hook installed${NC}"
else
    echo -e "${RED}❌ Failed to download hook${NC}"
    echo "   Check your internet connection or install manually."
    exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${CYAN}What happens now:${NC}"
echo "  • Every 'git push' runs TuringMind code review"
echo "  • 🔴 Critical issues (95-100) block the push"
echo "  • 🟠 Warning issues (80-94) are shown but don't block"
echo "  • All changed files are reviewed"
echo ""
echo -e "${CYAN}To uninstall:${NC}"
echo "  rm .git/hooks/pre-push"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

