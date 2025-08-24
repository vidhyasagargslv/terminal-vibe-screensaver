#!/bin/bash

# Enhanced Coding Vibe Terminal Screensaver - FIXED VERSION
# Neon Colors with bright effects
NEON_PINK='\033[1;95m'
NEON_CYAN='\033[1;96m'
NEON_GREEN='\033[1;92m'
NEON_YELLOW='\033[1;93m'
NEON_BLUE='\033[1;94m'
NEON_PURPLE='\033[1;95m'
NEON_RED='\033[1;91m'
NEON_WHITE='\033[1;97m'
NEON_ORANGE='\033[38;5;208m'
MATRIX_GREEN='\033[38;5;46m'
GLOW='\033[5m'
BRIGHT='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# Check if we're in a proper terminal
if [ ! -t 0 ] || [ ! -t 1 ]; then
    echo "Error: This script must be run in an interactive terminal"
    exit 1
fi

# Cleanup function
cleanup() {
    tput cnorm 2>/dev/null || true
    stty echo 2>/dev/null || true
    echo -e "${NC}"
    clear
    echo "Thanks for vibing! 🚀"
    exit 0
}

# Set trap for cleanup
trap cleanup INT TERM

# Hide cursor and prepare terminal
clear
tput civis 2>/dev/null || true
stty -echo 2>/dev/null || true

# Terminal dimensions
COLS=$(tput cols)
ROWS=$(tput lines)

# Get system info with more coding-focused details
get_system_info() {
    USER_NAME=$(whoami)
    HOSTNAME=$(hostname)
    OS=$(lsb_release -d 2>/dev/null | cut -f2 || uname -o)
    KERNEL=$(uname -r)
    UPTIME=$(uptime -p 2>/dev/null || uptime)
    SHELL_VERSION=$(echo $SHELL | xargs basename)
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1fGB", $3/1024/1024, $2/1024/1024}' || echo "N/A")
    DISK=$(df -h / 2>/dev/null | awk 'NR==2{printf "%s/%s", $3, $2}' || echo "N/A")
    CPU=$(lscpu 2>/dev/null | grep "Model name" | cut -f 2 -d ":" | awk '{$1=$1}1' | cut -c1-25 || echo "Unknown CPU")
    LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -c2-15)

    # Coding environment details
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 || echo "Not installed")
    NODE_VERSION=$(node --version 2>/dev/null || echo "Not installed")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 || echo "Not installed")
    CODE_EDITOR=$(which code nvim vim nano 2>/dev/null | head -n1 | xargs basename 2>/dev/null || echo "Unknown")
    CURRENT_DIR=$(pwd | sed "s|$HOME|~|")
    GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "No repo")
    GIT_STATUS=$(git status --porcelain 2>/dev/null | wc -l || echo "0")

    # Network information
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "N/A")
    PUBLIC_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "Offline")
}

# ASCII Art for coder theme
ascii_art() {
    cat << "EOF"
    ╔═══════════════════════════════════════╗
    ║     ██████╗ ██████╗ ██████╗ ███████╗  ║
    ║    ██╔════╝██╔═══██╗██╔══██╗██╔════╝  ║
    ║    ██║     ██║   ██║██║  ██║█████╗    ║
    ║    ██║     ██║   ██║██║  ██║██╔══╝    ║
    ║    ╚██████╗╚██████╔╝██████╔╝███████╗  ║
    ║     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝  ║
    ║                                       ║
    ║    ██╗   ██╗██╗██████╗ ███████╗███████╗║
    ║    ██║   ██║██║██╔══██╗██╔════╝██╔════╝║
    ║    ██║   ██║██║██████╔╝█████╗  ███████╗║
    ║    ╚██╗ ██╔╝██║██╔══██╗██╔══╝  ╚════██║║
    ║     ╚████╔╝ ██║██████╔╝███████╗███████║║
    ║      ╚═══╝  ╚═╝╚═════╝ ╚══════╝╚══════╝║
    ║                                       ║
    ║        ⚡ POWERED BY CAFFEINE ⚡        ║
    ║                                       ║
    ║         { "status": "vibing" }        ║
    ║                                       ║
    ║    ┌─┐┬ ┬┌─┐┬─┐┬ ┬  ┌┬┐┌─┐┌┬┐┌─┐    ║
    ║    │─┼┐│ │├┤ ├┬┘└┬┘  ││││ │ ││├┤     ║
    ║    └─┘┘└─┘└─┘┴└─ ┴   ┴ ┴└─┘─┴┘└─┘    ║
    ╚═══════════════════════════════════════╝
EOF
}

# System info display
display_info() {
    echo -e "${NEON_PINK}╔══════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║${NEON_WHITE}${GLOW}                SYSTEM STATUS                ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_YELLOW} 👤 User:     ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$USER_NAME@$HOSTNAME"
    printf "${NEON_PINK}║${NEON_YELLOW} 💻 OS:       ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$(echo $OS | cut -c1-24)"
    printf "${NEON_PINK}║${NEON_YELLOW} 🔧 Kernel:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$KERNEL"
    printf "${NEON_PINK}║${NEON_YELLOW} 🐚 Shell:    ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$SHELL_VERSION"
    printf "${NEON_PINK}║${NEON_YELLOW} ⏰ Uptime:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$(echo $UPTIME | cut -c1-24)"
    printf "${NEON_PINK}║${NEON_YELLOW} 🧠 RAM:      ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$MEMORY"
    printf "${NEON_PINK}║${NEON_YELLOW} 💾 Disk:     ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$DISK"
    printf "${NEON_PINK}║${NEON_YELLOW} 🔥 CPU:      ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$CPU"
    
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${NEON_PINK}║${NEON_CYAN}${GLOW}             CODING ENVIRONMENT              ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_GREEN} 📝 Editor:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$CODE_EDITOR"
    printf "${NEON_PINK}║${NEON_GREEN} 📁 Path:     ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$(echo $CURRENT_DIR | cut -c1-24)"
    printf "${NEON_PINK}║${NEON_GREEN} 🌿 Branch:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$GIT_BRANCH"
    printf "${NEON_PINK}║${NEON_GREEN} 📋 Changes:  ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$GIT_STATUS files"
    printf "${NEON_PINK}║${NEON_GREEN} 🐍 Python:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$PYTHON_VERSION"
    printf "${NEON_PINK}║${NEON_GREEN} 📦 Node:     ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$NODE_VERSION"
    
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════╣${NC}"
    echo -e "${NEON_PINK}║${NEON_BLUE}${GLOW}              NETWORK STATUS                 ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_ORANGE} 🏠 Local:    ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$LOCAL_IP"
    printf "${NEON_PINK}║${NEON_ORANGE} 🌍 Public:   ${NEON_WHITE}%-24s${NEON_PINK} ║${NC}\n" "$PUBLIC_IP"
    
    echo -e "${NEON_PINK}╚══════════════════════════════════════════════╝${NC}"
}

# Matrix-style effect
matrix_line() {
    local width=$1
    local chars=("0" "1" "a" "b" "c" "d" "e" "f" "x" "y" "z" "+" "-" "*" "=" "|")
    echo -ne "${MATRIX_GREEN}${DIM}"
    for ((i=0; i<width; i++)); do
        if (( RANDOM % 4 == 0 )); then
            echo -ne "${chars[$((RANDOM % ${#chars[@]}))]}"
        else
            echo -ne " "
        fi
    done
    echo -ne "${NC}"
}

# Main display
main_display() {
    # Get fresh system info
    get_system_info
    
    # Clear and position
    clear
    
    # Top border with animation
    colors=("${NEON_CYAN}" "${NEON_PURPLE}" "${NEON_PINK}")
    color=${colors[$((RANDOM % 3))]}
    
    echo -e "${color}${GLOW}╔═════════════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${color}║${NEON_WHITE}${GLOW}                               🚀 CODE VIBES 🚀                                  ${color}║${NC}"
    echo -e "${color}╚═════════════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo
    
    # Display ASCII art
    echo -e "${NEON_CYAN}${GLOW}"
    ascii_art
    echo -e "${NC}"
    
    echo
    
    # Display system info
    display_info
    
    echo
    
    # Matrix effect
    echo -e "${NEON_YELLOW}╔═════════════════════════════════════════════════════════════════════════════════════╗${NC}"
    printf "${NEON_YELLOW}║${NEON_WHITE} Code: "
    matrix_line 70
    echo -e "${NEON_YELLOW}║${NC}"
    printf "${NEON_YELLOW}║${NEON_GREEN} >> const developer = { status: 'in the zone', coffee: '∞' }                    ${NEON_YELLOW}║${NC}\n"
    printf "${NEON_YELLOW}║${NEON_BLUE} // Time: %-50s                       ${NEON_YELLOW}║${NC}\n" "$(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "${NEON_YELLOW}╚═════════════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo
    echo -e "${NEON_RED}${GLOW}                        ⚡ Press Ctrl+C to exit the matrix ⚡${NC}"
}

# Main loop
echo -e "${NEON_CYAN}${GLOW}Initializing Code Vibes...${NC}"
sleep 1
echo -e "${MATRIX_GREEN}Loading developer environment...${NC}"
sleep 1
echo -e "${NEON_PINK}Connecting to the mainframe...${NC}"
sleep 1

while true; do
    main_display
    sleep 3
done