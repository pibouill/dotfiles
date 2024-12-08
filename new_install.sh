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

#!/bin/bash

# Detect the operating system and check for specific hostname
OS="$(uname -s)"
HOSTNAME="$(hostname)"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

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
    "tree"
    "htop"
    "ncdu"
	"python"
	"python3"
	"cargo"
	"build-essential"
	"go"
	"docker"
	"nodejs"
)

LINUX_PACKAGES=(
)

OSX_PACKAGES=(
)
# Function to check if a package is installed
is_package_installed() {
    local package="$1"
    
    if command -v brew &> /dev/null; then
        brew list "$package" &> /dev/null
    elif command -v apt &> /dev/null; then
        dpkg -s "$package" &> /dev/null
    elif command -v yum &> /dev/null; then
        rpm -q "$package" &> /dev/null
    fi
}

# Function to install a package
install_package() {
    local package="$1"
    
    echo -e "${YELLOW}Installing $package...${NC}"
    
    if ! is_package_installed "$package"; then
        if command -v brew &> /dev/null; then
            brew install "$package"
        elif command -v apt &> /dev/null; then
            apt-get install -y "$package"
        elif command -v yum &> /dev/null; then
            yum install -y "$package"
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
    if ! command -v brew &> /dev/null; then
        echo -e "${YELLOW}Installing Homebrew...${NC}"
        
        if is_42prague; then
            # 42prague specific Homebrew installation
            HOMEBREW_DIR="$HOME/sgoinfre/homebrew"
			/bin/bash -c scripts/42brew_install.sh
            mkdir -p "$HOMEBREW_DIR"
            
            # Download and extract Homebrew
            # curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "$HOMEBREW_DIR"
            
            # Add Homebrew to PATH
            # export PATH="$HOMEBREW_DIR/bin:$PATH"
            # echo "export PATH=\"$HOMEBREW_DIR/bin:\$PATH\"" >> ~/.bashrc
            # echo "export HOMEBREW_PREFIX=\"$HOMEBREW_DIR\"" >> ~/.bashrc
        else
            # Standard Homebrew installation
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for Linux
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    else
        echo -e "${GREEN}Homebrew is already installed${NC}"
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
    echo -e "${YELLOW}Updating packages...${NC}"
    brew update
    brew upgrade

    echo -e "${GREEN}✓ Installation complete!${NC}"
}

# Run the main function
main
