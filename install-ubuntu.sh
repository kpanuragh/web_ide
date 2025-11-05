#!/usr/bin/env bash
# ============================================================================
# Neovim IDE Installation Script for Ubuntu/Debian
# ============================================================================
# This script installs all required dependencies for a full-featured
# Neovim development environment.
#
# Usage: ./install-ubuntu.sh
# ============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
}

# Check if running on Ubuntu/Debian
if ! command -v apt-get &> /dev/null; then
    print_error "This script is designed for Ubuntu/Debian systems with apt-get"
    exit 1
fi

# Check for sudo privileges
if [ "$EUID" -eq 0 ]; then
    print_warning "Please run this script as a normal user (not root). It will ask for sudo when needed."
    exit 1
fi

print_header "Neovim IDE Installation for Ubuntu"

# ============================================================================
# 1. System Update
# ============================================================================
print_header "Updating System Packages"
sudo apt-get update
print_success "System packages updated"

# ============================================================================
# 2. Install Essential Build Tools
# ============================================================================
print_header "Installing Essential Build Tools"
sudo apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    autoconf \
    automake \
    libtool \
    unzip \
    curl \
    wget \
    git \
    ninja-build \
    gettext

print_success "Build tools installed"

# ============================================================================
# 3. Install Neovim (Latest Stable)
# ============================================================================
print_header "Installing Neovim"

# Check if Neovim is already installed
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n1)
    print_info "Neovim already installed: $NVIM_VERSION"
    read -p "Do you want to reinstall the latest version? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Skipping Neovim installation"
    else
        # Install latest Neovim from PPA
        print_info "Installing latest Neovim from unstable PPA..."
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt-get update
        sudo apt-get install -y neovim
        print_success "Neovim installed/updated"
    fi
else
    print_info "Installing Neovim from unstable PPA..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update
    sudo apt-get install -y neovim
    print_success "Neovim installed"
fi

# ============================================================================
# 4. Install Node.js (for LSP servers and Copilot)
# ============================================================================
print_header "Installing Node.js"

if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_info "Node.js already installed: $NODE_VERSION"
else
    print_info "Installing Node.js 20.x LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    print_success "Node.js installed"
fi

# ============================================================================
# 5. Install Python and pip
# ============================================================================
print_header "Installing Python Development Tools"
sudo apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

print_success "Python tools installed"

# ============================================================================
# 6. Install Programming Languages & Runtimes
# ============================================================================
print_header "Installing Programming Languages"

# PHP
print_info "Installing PHP..."
sudo apt-get install -y php php-cli php-mbstring php-xml php-curl

# Go
print_info "Installing Go..."
if ! command -v go &> /dev/null; then
    wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz -O /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz

    # Add Go to PATH if not already there
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
        echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
    fi

    export PATH=$PATH:/usr/local/go/bin
    print_success "Go installed"
else
    print_info "Go already installed: $(go version)"
fi

# Rust (optional)
print_info "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    print_success "Rust installed"
else
    print_info "Rust already installed: $(rustc --version)"
fi

print_success "Programming languages installed"

# ============================================================================
# 7. Install CLI Tools
# ============================================================================
print_header "Installing CLI Tools"

# ripgrep (for Telescope grep)
print_info "Installing ripgrep..."
sudo apt-get install -y ripgrep

# fd-find (for Telescope find)
print_info "Installing fd-find..."
sudo apt-get install -y fd-find
# Create symlink if it doesn't exist
if [ ! -f ~/.local/bin/fd ]; then
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
fi

# bat (better cat)
print_info "Installing bat..."
sudo apt-get install -y bat
# Create symlink if it doesn't exist
if [ ! -f ~/.local/bin/bat ]; then
    mkdir -p ~/.local/bin
    ln -s $(which batcat) ~/.local/bin/bat
fi

# tree-sitter CLI
print_info "Installing tree-sitter CLI..."
npm install -g tree-sitter-cli

# Other useful tools
print_info "Installing other useful tools..."
sudo apt-get install -y \
    xclip \
    wl-clipboard \
    fontconfig

print_success "CLI tools installed"

# ============================================================================
# 8. Install Language Servers (via npm)
# ============================================================================
print_header "Installing Language Servers"

print_info "Installing LSP servers via npm..."
npm install -g \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    @vue/language-server \
    @angular/language-server \
    yaml-language-server \
    dockerfile-language-server-nodejs \
    sql-language-server

print_success "Language servers installed"

# ============================================================================
# 9. Install Formatters & Linters
# ============================================================================
print_header "Installing Formatters and Linters"

print_info "Installing formatters via npm..."
npm install -g \
    prettier \
    eslint \
    @fsouza/prettierd

print_info "Installing Python formatters..."
pip3 install --user --upgrade \
    ruff \
    black \
    isort

print_info "Installing Go tools..."
if command -v go &> /dev/null; then
    go install golang.org/x/tools/gopls@latest
    go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
fi

print_info "Installing Lua formatter..."
if command -v cargo &> /dev/null; then
    cargo install stylua
fi

print_success "Formatters and linters installed"

# ============================================================================
# 10. Install Fonts (Nerd Fonts for icons)
# ============================================================================
print_header "Installing Nerd Fonts"

print_info "Downloading and installing JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    cd /tmp
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip -o JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono"
    rm JetBrainsMono.zip
    fc-cache -fv
    print_success "JetBrainsMono Nerd Font installed"
else
    print_info "JetBrainsMono Nerd Font already installed"
fi

# ============================================================================
# 11. Install Database Tools (Optional)
# ============================================================================
print_header "Installing Database Tools"

print_info "Installing database CLI tools..."
sudo apt-get install -y \
    sqlite3 \
    postgresql-client \
    mysql-client

print_success "Database tools installed"

# ============================================================================
# 12. Clone/Backup Neovim Configuration
# ============================================================================
print_header "Setting Up Neovim Configuration"

NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG_DIR" ]; then
    print_warning "Neovim config already exists at $NVIM_CONFIG_DIR"
    read -p "Do you want to backup and replace it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_DIR="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Backing up to $BACKUP_DIR"
        mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"

        # Copy current config to nvim config directory
        print_info "Copying configuration..."
        mkdir -p "$NVIM_CONFIG_DIR"
        cp -r "$(pwd)"/* "$NVIM_CONFIG_DIR/"
        print_success "Configuration installed"
    else
        print_info "Keeping existing configuration"
    fi
else
    print_info "Installing Neovim configuration..."
    mkdir -p "$NVIM_CONFIG_DIR"
    cp -r "$(pwd)"/* "$NVIM_CONFIG_DIR/"
    print_success "Configuration installed"
fi

# ============================================================================
# 13. Install Neovim Plugins
# ============================================================================
print_header "Installing Neovim Plugins"

print_info "This will open Neovim and install all plugins..."
print_info "Press ENTER when ready..."
read

# Run Neovim and install plugins
nvim --headless "+Lazy! sync" +qa

print_success "Plugins installed"

# ============================================================================
# 14. Post-Installation Instructions
# ============================================================================
print_header "Installation Complete!"

echo ""
print_success "All dependencies have been installed successfully!"
echo ""
print_info "Next steps:"
echo "  1. Restart your terminal or run: source ~/.bashrc"
echo "  2. Set your terminal font to 'JetBrainsMono Nerd Font'"
echo "  3. Launch Neovim: nvim"
echo "  4. Run :checkhealth to verify everything is working"
echo "  5. Run :Mason to install additional LSP servers if needed"
echo ""
print_info "Key bindings:"
echo "  - Leader key: SPACE"
echo "  - File explorer: <leader>e"
echo "  - Find files: <leader>ff"
echo "  - Live grep: <leader>fg"
echo "  - LSP actions: gd, gr, K, <leader>ca, <leader>rn"
echo ""
print_info "Configuration location: $NVIM_CONFIG_DIR"
echo ""
print_warning "Note: Some features require additional setup:"
echo "  - GitHub Copilot: Run :Copilot setup after first launch"
echo "  - Database connections: Configure in :DBUI"
echo ""

# Optional: Display versions
print_header "Installed Versions"
echo "Neovim: $(nvim --version | head -n1)"
echo "Node.js: $(node --version)"
echo "Python: $(python3 --version)"
echo "Go: $(go version 2>/dev/null || echo 'Not in PATH yet')"
echo "Rust: $(rustc --version 2>/dev/null || echo 'Not in PATH yet')"
echo "PHP: $(php --version | head -n1)"
echo ""

print_success "Installation script completed successfully!"
print_info "Enjoy your new Neovim IDE! 🚀"
