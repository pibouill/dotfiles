#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    new_install.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pibouill <pibouill@student.42prague.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/08 13:41:49 by pibouill          #+#    #+#              #
#    Updated: 2024/12/08 13:42:44 by pibouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Detect the operating system and check for specific hostname
OS="$(uname -s)"
HOSTNAME="$(hostname)"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # end color

# Check if running on 42prague
is_42prague() {
    echo "$HOSTNAME" | grep -q "42prague"
    return $?
}

# Packages to install
COMMON_PACKAGES=(
    "git"
    "wget"
    "curl"
    "vim"
    "nvim"
    "tmux"
	"htop"
    "tree"
	"lua"
	"luarocks"
    "python3"
    "nodejs"
    "go"
	"python3"
)

LINUX_PACKAGES=(
)

# Function to check if a package is installed
is_package_installed() {
    local package="$1"
    
    if command -v brew &> /dev/null; then
        brew list "$package" &> /dev/null
    elif command -v "$package" &> /dev/null; then
        return 0
    fi
    return 1
}

# Function to install a package
install_package() {
    local package="$1"
    
    echo -e "${YELLOW}Installing $package...${NC}"
    
    if ! is_package_installed "$package"; then
        if command -v brew &> /dev/null; then
            brew install "$package"
        elif command -v apt &> /dev/null && [ -w /var/lib/dpkg ]; then
            sudo apt-get install -y "$package"
        elif command -v apt &> /dev/null; then
            echo -e "${RED}Cannot install $package: insufficient permissions${NC}"
            return 1
        fi
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Installed $package${NC}"
        else
            echo -e "${RED}✗ Failed to install $package${NC}"
        fi
    else
        echo -e "${GREEN}✓ $package is already installed${NC}"
    fi
}

# Function to install Homebrew
install_homebrew() {
    if command -v brew &> /dev/null; then
        echo -e "${GREEN}Homebrew is already installed${NC}"
        return 0
    fi

    echo -e "${YELLOW}Installing Homebrew...${NC}"
    
    # Determine Homebrew installation directory
    if is_42prague; then
        # 42prague specific location
		echo -e "\n\n${GREEN}42Prague detected${NC}"
        HOMEBREW_DIR="$HOME/sgoinfre/homebrew"
    else
        # User-space installation
        HOMEBREW_DIR="$HOME/.homebrew"
    fi

    # Create Homebrew directory
    mkdir -p "$HOMEBREW_DIR"

    # Download and install Homebrew
    git clone https://github.com/Homebrew/brew.git "$HOMEBREW_DIR"

    # Add Homebrew to PATH
    export PATH="$HOMEBREW_DIR/bin:$PATH"
    
    # Persist Homebrew in shell configuration
    echo "export PATH=\"$HOMEBREW_DIR/bin:\$PATH\"" >> ~/.bashrc
    echo "export HOMEBREW_PREFIX=\"$HOMEBREW_DIR\"" >> ~/.bashrc

    # Source the updated configuration
    source ~/.zshrc

    # Verify installation
    if command -v brew &> /dev/null; then
        echo -e "${GREEN}✓ Homebrew installed successfully${NC}"
    else
        echo -e "${RED}✗ Failed to install Homebrew${NC}"
        return 1
    fi
}

# Main installation function
install_packages() {
    # Install common packages
    for package in "${COMMON_PACKAGES[@]}"; do
        install_package "$package"
    done

    # Install Linux-specific packages
    for package in "${LINUX_PACKAGES[@]}"; do
        install_package "$package"
    done
}

# Main script execution
main() {
    # Error check for root user
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}Error: Do not run this script as root${NC}"
        exit 1
    fi

    echo -e "${GREEN}Detected OS: $OS${NC}"
    echo -e "${GREEN}Hostname: $HOSTNAME${NC}"

    # Install Homebrew
    install_homebrew

    # Install packages
    install_packages

    # Update packages
    if command -v brew &> /dev/null; then
        echo -e "${YELLOW}Updating packages...${NC}"
        brew update
        brew upgrade
    fi

    echo -e "${GREEN}✓ Installation complete!${NC}"
}

# Run the main function
main
