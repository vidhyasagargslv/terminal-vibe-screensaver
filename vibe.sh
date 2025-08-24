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

# ASCII Art - CODE MODE with wizard theme
ascii_art() {
    cat << "EOF"
    🧙‍♂️ ═══════════════════════════════════ 🧙‍♂️
    ⚡             CODE WIZARD              ⚡
    🔮 ═══════════════════════════════════ 🔮
    
            ████████╗██╗  ██╗███████╗
            ╚══██╔══╝██║  ██║██╔════╝
               ██║   ███████║█████╗  
               ██║   ██╔══██║██╔══╝  
               ██║   ██║  ██║███████╗
               ╚═╝   ╚═╝  ╚═╝╚══════╝
    
          ████████╗███████╗██████╗ ███╗   ███╗
          ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
             ██║   █████╗  ██████╔╝██╔████╔██║
             ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
             ██║   ███████╗██║  ██║██║ ╚═╝ ██║
             ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
    
            🎯 LOCKED AND LOADED 🎯
              { CODE.EXECUTE() }
    
          💻 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ 💻
            ⚡ TERMINAL WIZARD ACTIVE ⚡
          💻 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ 💻
EOF
}

# Left panel: Code Wizard + Network
display_left_panel() {
    echo -e "${NEON_MAGENTA}"
    ascii_art
    echo -e "${NC}"
    echo
    echo -e "${NEON_CYAN}    🌐 NETWORK INTERFACE 🌐${NC}"
    echo -e "${NEON_GREEN}    ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼${NC}"
    echo -e "${NEON_ORANGE}    🔗 Local IP:  ${NEON_WHITE}$LOCAL_IP${NC}"
    echo -e "${NEON_ORANGE}    🌍 Public IP: ${NEON_WHITE}$PUBLIC_IP${NC}"
    echo -e "${NEON_GREEN}    ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲${NC}"
    echo
    echo -e "${NEON_YELLOW}    ⚡ CONNECTION ESTABLISHED ⚡${NC}"
}

# Right panel: System Wizard Stats + Code Arsenal
display_right_panel() {
    echo -e "${NEON_PINK}    🖥️  SYSTEM MATRIX 🖥️${NC}"
    echo -e "${NEON_CYAN}    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${NEON_YELLOW}    👤 Wizard:    ${NEON_WHITE}$USER_NAME@$HOSTNAME${NC}"
    echo -e "${NEON_YELLOW}    🏠 Domain:    ${NEON_WHITE}$(echo $OS | cut -c1-25)${NC}"
    echo -e "${NEON_YELLOW}    ⚙️  Core:      ${NEON_WHITE}$KERNEL${NC}"
    echo -e "${NEON_YELLOW}    🐚 Shell:     ${NEON_WHITE}$SHELL_VERSION${NC}"
    echo -e "${NEON_YELLOW}    ⏱️  Runtime:   ${NEON_WHITE}$(echo $UPTIME | cut -c1-25)${NC}"
    echo -e "${NEON_YELLOW}    🧠 Memory:    ${NEON_WHITE}$MEMORY${NC}"
    echo -e "${NEON_YELLOW}    💾 Storage:   ${NEON_WHITE}$DISK${NC}"
    echo -e "${NEON_YELLOW}    🔥 Processor: ${NEON_WHITE}$(echo $CPU | cut -c1-25)${NC}"
    echo
    echo -e "${NEON_GREEN}    🛠️  CODE ARSENAL 🛠️${NC}"
    echo -e "${NEON_MAGENTA}    ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼ ▼${NC}"
    echo -e "${NEON_GREEN}    📝 Editor:    ${NEON_WHITE}$CODE_EDITOR${NC}"
    echo -e "${NEON_GREEN}    🔄 Git:       ${NEON_WHITE}$GIT_VERSION${NC}"
    echo -e "${NEON_GREEN}    🐍 Python:    ${NEON_WHITE}$PYTHON_VERSION${NC}"
    echo -e "${NEON_GREEN}    📦 Node.js:   ${NEON_WHITE}$NODE_VERSION${NC}"
    echo -e "${NEON_MAGENTA}    ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲ ▲${NC}"
    echo
    echo -e "${NEON_RED}    ⚡ WIZARD MODE: ACTIVATED ⚡${NC}"
}

# Static display - CODE WIZARD MODE
main_display() {
    get_system_info
    clear
    
    # Epic wizard header
    echo -e "${NEON_MAGENTA}    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░${NC}"
    echo -e "${NEON_CYAN}    ✦✧✦✧✦✧✦✧✦✧✦✧✦✧✦✧✦ 🧙‍♂️ TERMINAL CODE WIZARD 🧙‍♂️ ✦✧✦✧✦✧✦✧✦✧✦✧✦✧✦✧✦${NC}"
    echo -e "${NEON_MAGENTA}    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░${NC}"
    echo
# Main display
main_display() {
    # Get fresh system info
    get_system_info
    
    # Clear and position
    clear
    
    # Compact header
    colors=("${NEON_CYAN}" "${NEON_PURPLE}" "${NEON_PINK}")
    color=${colors[$((RANDOM % 3))]}
    
    echo -e "${color}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${color}║${NEON_WHITE}                       🚀 CODE VIBES 🚀                      ${color}║${NC}"
    echo -e "${color}╚═══════════════════════════════════════════════════════════════╝${NC}"
    
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
    
    # Display side by side with better spacing
    for ((i=0; i<max_lines; i++)); do
        left_line="${left_lines[i]:-}"
        right_line="${right_lines[i]:-}"
        
        # Calculate spacing for perfect alignment
        left_clean=$(echo -e "$left_line" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\x1b\[[0-9]*;//g')
        spaces_needed=$((50 - ${#left_clean}))
        if [ $spaces_needed -lt 2 ]; then
            spaces_needed=2
        fi
        
        printf "%s%*s%s\n" "$left_line" $spaces_needed "" "$right_line"
    done
    
    echo
    echo -e "${NEON_RED}                   ⚡ Press Ctrl+C to exit ⚡${NC}"
}

# Get system info once and display
echo -e "${NEON_MAGENTA}🔮 Initializing Terminal Wizard...${NC}"
sleep 1
echo -e "${NEON_CYAN}⚡ Loading magical code powers...${NC}"
sleep 1
echo -e "${NEON_GREEN}🧙‍♂️ Wizard mode activated!${NC}"
sleep 1

# Single display - no loop, no flicker
main_display

# Wait for user input to exit
while true; do
    sleep 1
done