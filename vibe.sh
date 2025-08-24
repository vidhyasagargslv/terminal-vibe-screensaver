#!/bin/bash

# Minimal Neon Colors - Bright and clean
NEON_PINK='\033[38;5;198m'      # Hot pink
NEON_CYAN='\033[38;5;51m'       # Electric cyan  
NEON_GREEN='\033[38;5;46m'      # Matrix green
NEON_YELLOW='\033[38;5;226m'    # Electric yellow
NEON_WHITE='\033[38;5;15m'      # Pure white
NEON_PURPLE='\033[38;5;129m'    # Electric purple
NC='\033[0m'                    # No Color

# Cleanup
cleanup() {
    tput cnorm 2>/dev/null || true
    echo -e "${NC}"
    clear
    exit 0
}
trap cleanup INT TERM

# Hide cursor
clear
tput civis 2>/dev/null || true

# Get system info - minimal and fast
get_system_info() {
    USER_NAME=$(whoami)
    HOSTNAME=$(hostname)
    OS=$(lsb_release -d 2>/dev/null | cut -f2 | cut -c1-15 || echo "Ubuntu")
    UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' | cut -c1-12 || echo "unknown")
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1f", $3/1024/1024, $2/1024/1024}' || echo "N/A")
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "127.0.0.1")
    WIFI_IP=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+' || echo "N/A")
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 | cut -c1-6 || echo "N/A")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -c1-5 || echo "N/A")
}

# Compact ASCII - exactly sized for 80x20
display_terminal() {
    get_system_info
    clear
    
    # Header (2 lines)
    echo -e "${NEON_CYAN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_CYAN}║${NEON_WHITE}                           💻 CYBER TERMINAL 💻      ${NEON_CYAN}║${NC}"
    echo -e "${NEON_CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo # Spacing line (1 line)
    
    # Main content area (14 lines total for 80x20)
    # Left side - Compact "CODER SPACE" ASCII
    echo -e "${NEON_PURPLE}     ██████╗ ██████╗ ██████╗ ███████╗██████╗     ${NEON_CYAN}⚡ SYSTEM_CORE${NC}"
    echo -e "${NEON_PURPLE}    ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗    ${NEON_GREEN}root@    ${NEON_WHITE}$USER_NAME@$HOSTNAME${NC}"
    echo -e "${NEON_PURPLE}    ██║     ██║   ██║██║  ██║█████╗  ██████╔╝    ${NEON_GREEN}kernel:  ${NEON_WHITE}$OS${NC}"
    echo -e "${NEON_PURPLE}    ██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗    ${NEON_GREEN}uptime:  ${NEON_WHITE}$UPTIME${NC}"
    echo -e "${NEON_PURPLE}    ╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║    ${NEON_GREEN}memory:  ${NEON_WHITE}${MEMORY}GB${NC}"
    echo -e "${NEON_PURPLE}     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ${NEON_GREEN}wifi:    ${NEON_WHITE}$WIFI_IP${NC}"
    echo                                                      
    echo # Spacing
    echo -e "${NEON_GREEN}    ███████╗██████╗  █████╗  ██████╗███████╗     ${NEON_PINK}⚡ DEV_STACK${NC}"
    echo -e "${NEON_GREEN}    ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝     ${NEON_YELLOW}git      ${NEON_WHITE}v$GIT_VERSION${NC}"
    echo -e "${NEON_GREEN}    ███████╗██████╔╝███████║██║     █████╗       ${NEON_YELLOW}python3  ${NEON_WHITE}v$PYTHON_VERSION${NC}"
    echo -e "${NEON_GREEN}    ╚════██║██╔═══╝ ██╔══██║██║     ██╔══╝       ${NEON_YELLOW}shell    ${NEON_WHITE}zsh${NC}"
    echo -e "${NEON_GREEN}    ███████║██║     ██║  ██║╚██████╗███████╗     ${NEON_CYAN}status:  ${NEON_WHITE}[ACTIVE]${NC}"
    echo -e "${NEON_GREEN}    ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚══════╝${NC}"
    echo # Spacing
    
    # Footer (2 lines)
    echo -e "${NEON_PINK}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║${NEON_PURPLE}                        ⚡ Press Ctrl+C to exit ⚡  ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
}

# Simple init - no fancy loading
echo -e "${NEON_CYAN}Loading...${NC}"
sleep 0.5

# Display once - no animations or loops
display_terminal

# Wait for exit
while true; do
    sleep 1
dones <<< "$left_content" || true
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