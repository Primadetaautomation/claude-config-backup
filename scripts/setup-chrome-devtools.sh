#!/bin/bash

# Chrome DevTools MCP Setup Script
# Automatically configures Chrome DevTools MCP for Claude agents on new machines

set -e

echo "🚀 Chrome DevTools MCP Setup for Claude Agents"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
check_prerequisites() {
    echo "📋 Checking prerequisites..."
    
    # Check Node.js version
    if command -v node > /dev/null; then
        NODE_VERSION=$(node --version | cut -d'v' -f2)
        NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1)
        NODE_MINOR=$(echo $NODE_VERSION | cut -d'.' -f2)
        
        if [ "$NODE_MAJOR" -lt 22 ] || ([ "$NODE_MAJOR" -eq 22 ] && [ "$NODE_MINOR" -lt 12 ]); then
            echo -e "${YELLOW}⚠️ Node.js 22.12.0 or higher required. Current: v$NODE_VERSION${NC}"
            echo "Please update Node.js: https://nodejs.org/"
            exit 1
        else
            echo -e "${GREEN}✅ Node.js v$NODE_VERSION${NC}"
        fi
    else
        echo -e "${RED}❌ Node.js not found. Please install Node.js 22.12.0 or higher${NC}"
        exit 1
    fi
    
    # Check Chrome installation
    if command -v google-chrome > /dev/null; then
        echo -e "${GREEN}✅ Chrome installed${NC}"
    elif command -v chromium > /dev/null; then
        echo -e "${GREEN}✅ Chromium installed${NC}"
    elif [ -d "/Applications/Google Chrome.app" ]; then
        echo -e "${GREEN}✅ Chrome installed (macOS)${NC}"
    else
        echo -e "${YELLOW}⚠️ Chrome not found. Please install Google Chrome${NC}"
        echo "Download from: https://www.google.com/chrome/"
    fi
    
    # Check Claude CLI
    if command -v claude > /dev/null; then
        echo -e "${GREEN}✅ Claude CLI installed${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ Claude CLI not found${NC}"
        return 1
    fi
}

# Install via Claude CLI
install_via_cli() {
    echo ""
    echo "📦 Installing Chrome DevTools MCP via Claude CLI..."
    
    # Check if already installed
    if claude mcp list 2>/dev/null | grep -q "chrome-devtools"; then
        echo -e "${GREEN}✅ Chrome DevTools MCP already installed${NC}"
    else
        # Install Chrome DevTools MCP
        if claude mcp add chrome-devtools npx chrome-devtools-mcp@latest; then
            echo -e "${GREEN}✅ Chrome DevTools MCP installed successfully${NC}"
        else
            echo -e "${RED}❌ Failed to install via CLI${NC}"
            return 1
        fi
    fi
    
    # Install headless version for CI/CD
    if ! claude mcp list 2>/dev/null | grep -q "chrome-devtools-headless"; then
        echo "📦 Installing headless configuration for CI/CD..."
        claude mcp add chrome-devtools-headless npx "chrome-devtools-mcp@latest --headless=true --isolated=true" 2>/dev/null || true
    fi
}

# Manual configuration
manual_config() {
    echo ""
    echo "📝 Setting up manual configuration..."
    
    # Find or create mcp-config.json
    MCP_CONFIG_PATH=""
    
    if [ -f "$HOME/.claude/mcp-config.json" ]; then
        MCP_CONFIG_PATH="$HOME/.claude/mcp-config.json"
    elif [ -f "$HOME/.config/claude/mcp-config.json" ]; then
        MCP_CONFIG_PATH="$HOME/.config/claude/mcp-config.json"
    else
        # Create config directory
        mkdir -p "$HOME/.claude"
        MCP_CONFIG_PATH="$HOME/.claude/mcp-config.json"
        echo '{}' > "$MCP_CONFIG_PATH"
    fi
    
    echo "Found config at: $MCP_CONFIG_PATH"
    
    # Check if chrome-devtools already exists
    if grep -q "chrome-devtools" "$MCP_CONFIG_PATH"; then
        echo -e "${YELLOW}Chrome DevTools already configured in $MCP_CONFIG_PATH${NC}"
    else
        # Backup existing config
        cp "$MCP_CONFIG_PATH" "$MCP_CONFIG_PATH.backup.$(date +%Y%m%d_%H%M%S)"
        
        # Update config using Node.js
        node -e "
        const fs = require('fs');
        const configPath = '$MCP_CONFIG_PATH';
        let config = {};
        
        try {
            const content = fs.readFileSync(configPath, 'utf8');
            config = JSON.parse(content || '{}');
        } catch (e) {
            config = {};
        }
        
        config.mcpServers = config.mcpServers || {};
        
        // Add chrome-devtools configuration
        config.mcpServers['chrome-devtools'] = {
            command: 'npx',
            args: ['chrome-devtools-mcp@latest'],
            description: 'Live browser control for testing and debugging'
        };
        
        config.mcpServers['chrome-devtools-headless'] = {
            command: 'npx',
            args: ['chrome-devtools-mcp@latest', '--headless=true', '--isolated=true'],
            description: 'Headless Chrome for CI/CD'
        };
        
        fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
        console.log('✅ Configuration updated successfully');
        "
        
        echo -e "${GREEN}✅ Manual configuration completed${NC}"
    fi
}

# Test the installation
test_installation() {
    echo ""
    echo "🧪 Testing Chrome DevTools MCP installation..."
    
    # Create a simple test prompt
    cat > /tmp/test-chrome-devtools.txt << 'EOF'
Use chrome devtools to navigate to https://example.com and take a screenshot
EOF
    
    echo "Test prompt created at: /tmp/test-chrome-devtools.txt"
    echo ""
    echo "To test the installation, run Claude with:"
    echo -e "${YELLOW}claude < /tmp/test-chrome-devtools.txt${NC}"
    echo ""
    echo "Or simply ask Claude:"
    echo -e "${YELLOW}\"Check if chrome devtools is working by navigating to example.com\"${NC}"
}

# Create usage examples
create_examples() {
    echo ""
    echo "📚 Creating example prompts..."
    
    mkdir -p examples/chrome-devtools
    
    # Performance testing example
    cat > examples/chrome-devtools/performance-test.md << 'EOF'
# Performance Testing Example

Use chrome devtools to:
1. Navigate to our homepage
2. Start a performance trace
3. Click through the main user journey
4. Stop the trace and analyze performance bottlenecks
5. Provide recommendations for optimization
EOF
    
    # Debugging example
    cat > examples/chrome-devtools/debug-test.md << 'EOF'
# Debug Test Failure Example

My Playwright test is failing at the login step with "element not found". 
Use chrome devtools to:
1. Navigate to the login page
2. Inspect the login form elements
3. Check for console errors
4. Monitor network requests during login
5. Identify why the test is failing
EOF
    
    # Exploratory testing example
    cat > examples/chrome-devtools/explore-feature.md << 'EOF'
# Exploratory Testing Example

Use chrome devtools to explore our new shopping cart feature:
1. Open the application
2. Add items to cart
3. Test different quantities
4. Check the checkout flow
5. Take screenshots of important states
6. Create a Playwright test based on your exploration
EOF
    
    echo -e "${GREEN}✅ Examples created in examples/chrome-devtools/${NC}"
}

# Main execution
main() {
    echo ""
    
    # Check prerequisites
    HAS_CLAUDE_CLI=0
    if check_prerequisites; then
        HAS_CLAUDE_CLI=1
    fi
    
    # Try CLI installation first if available
    if [ $HAS_CLAUDE_CLI -eq 1 ]; then
        if ! install_via_cli; then
            echo "Falling back to manual configuration..."
            manual_config
        fi
    else
        # Direct to manual configuration
        manual_config
    fi
    
    # Create examples
    create_examples
    
    # Test installation
    test_installation
    
    echo ""
    echo "=============================================="
    echo -e "${GREEN}🎉 Chrome DevTools MCP Setup Complete!${NC}"
    echo ""
    echo "📋 Next Steps:"
    echo "1. Restart Claude if it's currently running"
    echo "2. Test with: claude \"use chrome devtools to navigate to example.com\""
    echo "3. Check examples in: examples/chrome-devtools/"
    echo ""
    echo "🔧 Available Commands:"
    echo "- Exploration: \"use chrome devtools to explore [feature]\""
    echo "- Debugging: \"use chrome devtools to debug [issue]\""
    echo "- Performance: \"use chrome devtools to analyze performance of [page]\""
    echo ""
    echo "📚 Documentation:"
    echo "- Chrome DevTools Integration: docs/CHROME_DEVTOOLS_INTEGRATION.md"
    echo "- Chrome DevTools MCP: https://github.com/ChromeDevTools/chrome-devtools-mcp"
    echo ""
    echo "Happy Testing! 🧪"
}

# Run main function
main