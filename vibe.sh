#!/bin/bash

# Enhanced Neon Colors - True neon theme
NEON_PINK='\033[38;5;198m'      # Hot pink
NEON_CYAN='\033[38;5;51m'       # Electric cyan
NEON_GREEN='\033[38;5;46m'      # Matrix green
NEON_YELLOW='\033[38;5;226m'    # Electric yellow
NEON_BLUE='\033[38;5;33m'       # Electric blue
NEON_RED='\033[38;5;196m'       # Hot red
NEON_WHITE='\033[38;5;15m'      # Pure white
NEON_ORANGE='\033[38;5;202m'    # Electric orange
NEON_PURPLE='\033[38;5;129m'    # Electric purple
NEON_MAGENTA='\033[38;5;201m'   # Hot magenta
NC='\033[0m' # No Color

# Check if we're in a proper terminal
if [ ! -t 0 ] || [ ! -t 1 ]; then
    echo "Error: This script must be run in an interactive terminal"
    exit 1
fi

# Cleanup function
cleanup() {
    tput cnorm 2>/dev/null || true
    echo -e "${NC}"
    clear
    echo "Stay cyber! 💻"
    exit 0
}

# Set trap for cleanup
trap cleanup INT TERM

# Hide cursor and prepare terminal
clear
tput civis 2>/dev/null || true

# Get system info
get_system_info() {
    USER_NAME=$(whoami)
    HOSTNAME=$(hostname)
    OS=$(lsb_release -d 2>/dev/null | cut -f2 | cut -c1-15 || uname -o | cut -c1-15)
    KERNEL=$(uname -r | cut -c1-15)
    UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' | cut -c1-15 || uptime | cut -d',' -f1 | cut -c1-15)
    SHELL_VERSION=$(echo $SHELL | xargs basename)
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1fGB", $3/1024/1024, $2/1024/1024}' || echo "N/A")
    DISK=$(df -h / 2>/dev/null | awk 'NR==2{printf "%s/%s", $3, $2}' || echo "N/A")

    # Dev tools
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 | cut -c1-10 || echo "None")
    NODE_VERSION=$(node --version 2>/dev/null | cut -c1-10 || echo "None")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -c1-8 || echo "None")

    # Network
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "N/A")
    PUBLIC_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "Offline")
}

# ASCII Art - Cyberpunk Coder Theme
ascii_art() {
    cat << "EOF"
      ⚡ CYBER CODER ⚡
    ╔═══════════════════╗
    ║    ██╗  ██╗██╗    ║
    ║    ██║  ██║██║    ║
    ║    ███████║██║    ║
    ║    ██╔══██║██║    ║
    ║    ██║  ██║██║    ║
    ║    ╚═╝  ╚═╝╚═╝    ║
    ║  { CODE_MATRIX }  ║
    ║ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ║
    ║    [ONLINE]       ║
    ╚═══════════════════╝
      💻 HACK THE WORLD
EOF
}

# Left panel
display_left_panel() {
    echo -e "${NEON_CYAN}"
    ascii_art
    echo -e "${NC}"
    echo -e "${NEON_ORANGE}🌐 WAN: ${NEON_WHITE}$PUBLIC_IP${NC}"
    echo -e "${NEON_GREEN}🔗 LAN: ${NEON_WHITE}$LOCAL_IP${NC}"
}

# Right panel
display_right_panel() {
    echo -e "${NEON_PINK}🖥️  SYSTEM CORE${NC}"
    echo -e "${NEON_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${NEON_YELLOW}User: ${NEON_WHITE}$USER_NAME@$HOSTNAME${NC}"
    echo -e "${NEON_YELLOW}OS:   ${NEON_WHITE}$OS${NC}"
    echo -e "${NEON_YELLOW}Core: ${NEON_WHITE}$KERNEL${NC}"
    echo -e "${NEON_YELLOW}Up:   ${NEON_WHITE}$UPTIME${NC}"
    echo -e "${NEON_YELLOW}RAM:  ${NEON_WHITE}$MEMORY${NC}"
    echo -e "${NEON_YELLOW}Disk: ${NEON_WHITE}$DISK${NC}"
    echo
    echo -e "${NEON_GREEN}⚡ DEV STACK${NC}"
    echo -e "${NEON_MAGENTA}▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼${NC}"
    echo -e "${NEON_GREEN}Git:    ${NEON_WHITE}$GIT_VERSION${NC}"
    echo -e "${NEON_GREEN}Python: ${NEON_WHITE}$PYTHON_VERSION${NC}"
    echo -e "${NEON_GREEN}Node:   ${NEON_WHITE}$NODE_VERSION${NC}"
    echo -e "${NEON_GREEN}Shell:  ${NEON_WHITE}$SHELL_VERSION${NC}"
    echo -e "${NEON_MAGENTA}▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲${NC}"
}

# Main display for 80x20 terminal
main_display() {
    get_system_info
    clear
    
    # Header
    echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_CYAN}║${NEON_WHITE}                           💻 CYBER TERMINAL 💻                            ${NEON_CYAN}║${NC}"
    echo -e "${NEON_CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    # Create panels
    left_content=$(display_left_panel)
    right_content=$(display_right_panel)
    
    # Split into arrays
    IFS=$'\n' read -rd '' -a left_lines <<< "$left_content" || true
    IFS=$'\n' read -rd '' -a right_lines <<< "$right_content" || true
    
    # Display side by side
    max_lines=${#left_lines[@]}
    if [ ${#right_lines[@]} -gt $max_lines ]; then
        max_lines=${#right_lines[@]}
    fi
    
    for ((i=0; i<max_lines; i++)); do
        left_line="${left_lines[i]:-}"
        right_line="${right_lines[i]:-}"
        
        # Calculate spacing
        left_clean=$(echo -e "$left_line" | sed 's/\x1b\[[0-9;]*m//g')
        spaces_needed=$((38 - ${#left_clean}))
        if [ $spaces_needed -lt 1 ]; then
            spaces_needed=1
        fi
        
        printf "%s%*s%s\n" "$left_line" $spaces_needed "" "$right_line"
    done
    
    # Footer
    echo -e "${NEON_RED}                      ⚡ Press Ctrl+C to disconnect ⚡${NC}"
}

# Initialize
echo -e "${NEON_CYAN}🚀 Initializing cyber matrix...${NC}"
sleep 1

# Display once
main_display

# Wait for exit
while true; do
    sleep 1
done