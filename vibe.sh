#!/bin/bash

# Clean Coding Vibe Terminal Screensaver - No Animation Version
# Colors without blinking
NEON_PINK='\033[1;95m'
NEON_CYAN='\033[1;96m'
NEON_GREEN='\033[1;92m'
NEON_YELLOW='\033[1;93m'
NEON_BLUE='\033[1;94m'
NEON_RED='\033[1;91m'
NEON_WHITE='\033[1;97m'
NEON_ORANGE='\033[38;5;208m'
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
    echo "Thanks for vibing! 🚀"
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
    OS=$(lsb_release -d 2>/dev/null | cut -f2 || uname -o)
    KERNEL=$(uname -r)
    UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' || uptime | cut -d',' -f1)
    SHELL_VERSION=$(echo $SHELL | xargs basename)
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1fGB", $3/1024/1024, $2/1024/1024}' || echo "N/A")
    DISK=$(df -h / 2>/dev/null | awk 'NR==2{printf "%s/%s", $3, $2}' || echo "N/A")
    CPU=$(lscpu 2>/dev/null | grep "Model name" | cut -f 2 -d ":" | awk '{$1=$1}1' | cut -c1-30 || echo "Unknown CPU")

    # Versions only
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 || echo "Not installed")
    NODE_VERSION=$(node --version 2>/dev/null || echo "Not installed")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 || echo "Not installed")
    CODE_EDITOR=$(which code nvim vim nano 2>/dev/null | head -n1 | xargs basename 2>/dev/null || echo "nano")

    # Network only
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "N/A")
    PUBLIC_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "Offline")
}

# ASCII Art - Put your custom art here
ascii_art() {
    cat << "EOF"
        # ╔══════════════════════════╗
        # ║   ██╗    ██╗██╗██████╗   ║
        # ║   ██║    ██║██║██╔══██╗  ║
        # ║   ██║ █╗ ██║██║██████╔╝  ║
        # ║   ██║███╗██║██║██╔═══╝   ║
        # ║   ╚███╔███╔╝██║██║       ║
        # ║    ╚══╝╚══╝ ╚═╝╚═╝       ║
        # ╚══════════════════════════╝
        #       [CODING MODE ON]
        
        #       _______________
        #      |               |
        #      | > whoami      |
        #      | developer     |
        #      | > status      |
        #      | in the zone   |
        #      | > coffee      |
        #      | ████████████  |
        #      |_______________|
        
        #       { VIBE MODE }

▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░█▓█▓▓█▓█░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░█▓██▒██████░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░░░█▓▓█████▓█▒████▒░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░▒▒▒█▓██▓▒█████▓███░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░██████▓▓████▓██████░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░█▒████▒████████▒██░░░░░░░▒░░░░░░░░░░░░░░
░░░░░░░░░░░░░░░░░░░░█▒█▓░▒▒█▓██████░▒░▒▒▒▒▓▓▒▒▒▓▓▒▒▒░░▒▒▒
░░▒░░░░░▒░░▒▒▒▒▒▒░░░░░▓██░░▒▒▓▒░███▒▒▓▒▓▒▒▓░▓▒░░░▓▓▓▓▓▒▒▒
▒▒▒▒▒▒▒░▒░░▒░▒░▒▒▒░░░▒░▒▓▒▒▒▒▓█▒█████░▒▒▒▓▒▓▒▒▓▓▓▒▒▒▒▓█▓▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▒█░▒▒▒▓██▒▒▒▒▒▓▒█▒▓▓▓▒▓▒▒▓█▓▒███▒▒▓█
▒▒▒▒▒▒▒░░▒▒▒▒▒▒█▓▒▓█▒▒▒▓█████▓▒▓▒░░▒██▓░▒▓█▓█░░▒▓▒▓▓▒▓▒▒▒
▒▒▒▓▒▓▒▒▒▒▒▒▒▒▓██▒▒▓▒▒█▓█░░▓▒▒▒░░░▒░███░█▒▓▓▓▓▒▒▓▓░▒░▓▓▒▓
▓▒▓▒▒▒▓▒▒▒▒▓▒▓▒█▒██░▒▒▒▓██░░░▒▒░░░▓▒▓██▒▓░▓░▒▒▓▒▒▓▓░▒▒▓▓▓
▒▒▓░▒▒░▓▒▒▒▒▓▒████▓░▒▓▒▒█▓█░░▒▒▒▒█░░██▒█▒█▒░▓███▒▒▓▓█▒▒▒█
░█▓█▓▒▒▒▓▒▒▓█▒▒▒▓██░▒░▓▒▓█░▓░░░▒░░▒░██▓▓▓█▒███▓█▓▓▒█▓▓▒▓▒
░▒▓▓▓▓█▓▒▒█▒░█▓███▒▓▒██▒▒▒▒▓░░░▒░░▒░▓██░██▓███▓██▒▒▒▒▒█▓▓
▒▒▓▓▓█▒░█████▓███▒░▓█▓▓▒▒▒▒▓░░▒░░░░░░▓▓███▓██████▓▓░▓▒▒▓▓
░▒▓░▒▒▓▓▒▓▒█████▒▒▒██▓▒▒░▒▓▒░░░░▒░░░░█▓████▒▓░░▓▓░▓█▓█▒█▓
▒░▒▓▓▓▓░░██▓███▒▒▒▓████▒░▒▓▒░░▒░░▒▒░▒█████████████▒░▒▒▒▓▒
▓▓▓▓▓▓███▒██▓▓▓▓▒▒▒▒█▓█▓▒▒▓▓░░░░░▒░░░▒███████▒▒▓█▓▓▒▓▓▓▓▓
▓▒▒██████░▓██▓░▒░▒▓▒██▓▒▓▒█▓░░░░░░░░░░▓██▓█▒▒▒██▓████████


EOF
}

# Left panel: Image + IP Address
display_left_panel() {
    echo -e "${NEON_CYAN}"
    ascii_art
    echo -e "${NC}"
    echo
    echo -e "${NEON_BLUE}╔═══════════════════════════════╗${NC}"
    echo -e "${NEON_BLUE}║${NEON_WHITE}        NETWORK INFO         ${NEON_BLUE}║${NC}"
    echo -e "${NEON_BLUE}╠═══════════════════════════════╣${NC}"
    printf "${NEON_BLUE}║${NEON_ORANGE} Local IP:  %-18s${NEON_BLUE}║${NC}\n" "$LOCAL_IP"
    printf "${NEON_BLUE}║${NEON_ORANGE} Public IP: %-18s${NEON_BLUE}║${NC}\n" "$PUBLIC_IP"
    echo -e "${NEON_BLUE}╚═══════════════════════════════╝${NC}"
}

# Right panel: System info + Versions only
display_right_panel() {
    echo -e "${NEON_PINK}╔════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║${NEON_WHITE}              SYSTEM INFO                ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠════════════════════════════════════════════╣${NC}"
    printf "${NEON_PINK}║${NEON_YELLOW} User:    %-30s${NEON_PINK}║${NC}\n" "$USER_NAME@$HOSTNAME"
    printf "${NEON_PINK}║${NEON_YELLOW} OS:      %-30s${NEON_PINK}║${NC}\n" "$(echo $OS | cut -c1-30)"
    printf "${NEON_PINK}║${NEON_YELLOW} Kernel:  %-30s${NEON_PINK}║${NC}\n" "$KERNEL"
    printf "${NEON_PINK}║${NEON_YELLOW} Shell:   %-30s${NEON_PINK}║${NC}\n" "$SHELL_VERSION"
    printf "${NEON_PINK}║${NEON_YELLOW} Uptime:  %-30s${NEON_PINK}║${NC}\n" "$(echo $UPTIME | cut -c1-30)"
    printf "${NEON_PINK}║${NEON_YELLOW} RAM:     %-30s${NEON_PINK}║${NC}\n" "$MEMORY"
    printf "${NEON_PINK}║${NEON_YELLOW} Disk:    %-30s${NEON_PINK}║${NC}\n" "$DISK"
    printf "${NEON_PINK}║${NEON_YELLOW} CPU:     %-30s${NEON_PINK}║${NC}\n" "$(echo $CPU | cut -c1-30)"
    echo -e "${NEON_PINK}╠════════════════════════════════════════════╣${NC}"
    echo -e "${NEON_PINK}║${NEON_GREEN}                VERSIONS                 ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠════════════════════════════════════════════╣${NC}"
    printf "${NEON_PINK}║${NEON_GREEN} Editor:  %-30s${NEON_PINK}║${NC}\n" "$CODE_EDITOR"
    printf "${NEON_PINK}║${NEON_GREEN} Git:     %-30s${NEON_PINK}║${NC}\n" "$GIT_VERSION"
    printf "${NEON_PINK}║${NEON_GREEN} Python:  %-30s${NEON_PINK}║${NC}\n" "$PYTHON_VERSION"
    printf "${NEON_PINK}║${NEON_GREEN} Node:    %-30s${NEON_PINK}║${NC}\n" "$NODE_VERSION"
    echo -e "${NEON_PINK}╚════════════════════════════════════════════╝${NC}"
}

# Static display - no animation, no flicker
main_display() {
    get_system_info
    clear
    
    # Simple header - no animation
    echo -e "${NEON_CYAN}╔════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_CYAN}║${NEON_WHITE}                              🚀 CODE VIBES 🚀                            ${NEON_CYAN}║${NC}"
    echo -e "${NEON_CYAN}╚════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
    
    # Create both panels
    left_content=$(display_left_panel)
    right_content=$(display_right_panel)
    
    # Split into arrays
    IFS=$'\n' read -rd '' -a left_lines <<< "$left_content" || true
    IFS=$'\n' read -rd '' -a right_lines <<< "$right_content" || true
    
    # Get max lines
    max_lines=${#left_lines[@]}
    if [ ${#right_lines[@]} -gt $max_lines ]; then
        max_lines=${#right_lines[@]}
    fi
    
    # Display side by side
    for ((i=0; i<max_lines; i++)); do
        left_line="${left_lines[i]:-}"
        right_line="${right_lines[i]:-}"
        
        # Calculate spacing (remove ANSI codes for length calculation)
        left_clean=$(echo -e "$left_line" | sed 's/\x1b\[[0-9;]*m//g')
        spaces_needed=$((40 - ${#left_clean}))
        if [ $spaces_needed -lt 2 ]; then
            spaces_needed=2
        fi
        
        printf "%s%*s%s\n" "$left_line" $spaces_needed "" "$right_line"
    done
    
    echo
    echo -e "${NEON_RED}                    Press Ctrl+C to exit${NC}"
}

# Get system info once and display
echo -e "${NEON_CYAN}Loading system information...${NC}"
sleep 1

# Single display - no loop, no flicker
main_display

# Wait for user input to exit
while true; do
    sleep 1
done