#!/bin/bash

# Enhanced Neon Colors - More vibrant and varied
NEON_PINK='\033[38;5;198m'      # Hot pink
NEON_CYAN='\033[38;5;51m'       # Electric cyan  
NEON_GREEN='\033[38;5;46m'      # Matrix green
NEON_YELLOW='\033[38;5;226m'    # Electric yellow
NEON_WHITE='\033[38;5;15m'      # Pure white
NEON_PURPLE='\033[38;5;129m'    # Electric purple
NEON_BLUE='\033[38;5;39m'       # Electric blue
NEON_RED='\033[38;5;196m'       # Hot red
NEON_ORANGE='\033[38;5;208m'    # Electric orange
NEON_MAGENTA='\033[38;5;201m'   # Hot magenta
BRIGHT='\033[1m'                # Bold/Bright
DIM='\033[2m'                   # Dim
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

# Get system info - enhanced
get_system_info() {
    USER_NAME=$(whoami)
    HOSTNAME=$(hostname)
    OS=$(lsb_release -d 2>/dev/null | cut -f2 | cut -c1-15 || echo "Ubuntu")
    UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' | cut -c1-12 || echo "unknown")
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1f", $3/1024/1024, $2/1024/1024}' || echo "N/A")
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "127.0.0.1")
    WIFI_IP=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+' || echo "N/A")
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 | cut -c1-6 || echo "N/A")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -c1-6 || echo "N/A")
    LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//' || echo "0.0")
}

# Compact ASCII - exactly sized for 80x20
display_terminal() {
    get_system_info
    clear

    echo # Spacing line (1 line)
    
    # Enhanced ASCII with rainbow gradient colors
    echo -e "${BRIGHT}${NEON_PURPLE}     ██████╗ ${NEON_MAGENTA}██████╗ ${NEON_PINK}██████╗ ${NEON_RED}███████╗${NEON_ORANGE}██████╗     ${NEON_CYAN}${BRIGHT}⚡ SYSTEM_CORE ⚡${NC}"
    echo -e "${BRIGHT}${NEON_PURPLE}    ██╔════╝${NEON_MAGENTA}██╔═══██╗${NEON_PINK}██╔══██╗${NEON_RED}██╔════╝${NEON_ORANGE}██╔══██╗    ${NEON_GREEN}${BRIGHT}▶ ADMIN:   ${NEON_PURPLE}$USER_NAME${NC}"
    echo -e "${BRIGHT}${NEON_PURPLE}    ██║     ${NEON_MAGENTA}██║   ██║${NEON_PINK}██║  ██║${NEON_RED}█████╗  ${NEON_ORANGE}██████╔╝    ${NEON_GREEN}${BRIGHT}▶ KERNEL:  ${NEON_PURPLE}$OS${NC}"
    echo -e "${BRIGHT}${NEON_PURPLE}    ██║     ${NEON_MAGENTA}██║   ██║${NEON_PINK}██║  ██║${NEON_RED}██╔══╝  ${NEON_ORANGE}██╔══██╗    ${NEON_GREEN}${BRIGHT}▶ UPTIME:  ${NEON_PURPLE}$UPTIME${NC}"
    echo -e "${BRIGHT}${NEON_PURPLE}    ╚██████╗${NEON_MAGENTA}╚██████╔╝${NEON_PINK}██████╔╝${NEON_RED}███████╗${NEON_ORANGE}██║  ██║    ${NEON_GREEN}${BRIGHT}▶ WiFiIp:  ${NEON_PURPLE}${WIFI_IP}${NC}"
    echo -e "${BRIGHT}${NEON_PURPLE}     ╚═════╝${NEON_MAGENTA} ╚═════╝ ${NEON_PINK}╚═════╝ ${NEON_RED}╚══════╝${NEON_ORANGE}╚═╝  ╚═╝    ${NEON_GREEN}${BRIGHT}▶ LOAD:    ${NEON_PURPLE}$LOAD_AVG${NC}"                                                    
    echo # Spacing
    # Enhanced second section with gradient colors
    echo -e "${BRIGHT}${NEON_GREEN}    ███████╗${NEON_CYAN}██████╗ ${NEON_BLUE} █████╗ ${NEON_PURPLE}██████╗ ${NEON_MAGENTA}███████╗     ${NEON_PINK}${BRIGHT}⚡ DEV_STACK ⚡${NC}"
    echo -e "${BRIGHT}${NEON_GREEN}    ██╔════╝${NEON_CYAN}██╔══██╗${NEON_BLUE}██╔══██╗${NEON_PURPLE}██╔════╝${NEON_MAGENTA}██╔════╝     ${NEON_YELLOW}${BRIGHT}◆ GIT:     ${NEON_BLUE}v${GIT_VERSION}${NC}"
    echo -e "${BRIGHT}${NEON_GREEN}    ███████╗${NEON_CYAN}██████╔╝${NEON_BLUE}███████║${NEON_PURPLE}██║     ${NEON_MAGENTA}█████╗       ${NEON_YELLOW}${BRIGHT}◆ PYTHON:  ${NEON_BLUE}v${PYTHON_VERSION}${NC}"
    echo -e "${BRIGHT}${NEON_GREEN}    ╚════██║${NEON_CYAN}██╔═══╝ ${NEON_BLUE}██╔══██║${NEON_PURPLE}██║     ${NEON_MAGENTA}██╔══╝       ${NEON_YELLOW}${BRIGHT}◆ SHELL:   ${NEON_BLUE}zsh${NC}"
    echo -e "${BRIGHT}${NEON_GREEN}    ███████║${NEON_CYAN}██║     ${NEON_BLUE}██║  ██║${NEON_PURPLE}╚██████╗${NEON_MAGENTA}███████╗     ${NEON_YELLOW}${BRIGHT}◆ STATUS:  ${NEON_BLUE}[${BRIGHT}ACTIVE${NC}${NEON_GREEN}]${NC}"
    echo -e "${BRIGHT}${NEON_GREEN}    ╚══════╝${NEON_CYAN}╚═╝     ${NEON_BLUE}╚═╝  ╚═╝${NEON_PURPLE} ╚═════╝${NEON_MAGENTA}╚══════╝     ${NEON_YELLOW}${BRIGHT}◆ TIME:    ${NEON_BLUE}$(date '+%H:%M:%S')${NC}"
    echo # Spacing
    

}

# Enhanced loading sequence
echo -e "${BRIGHT}${NEON_CYAN}◢◣◢◣ ${NEON_WHITE}Initializing Cyber Terminal${NEON_CYAN} ◢◣◢◣${NC}"
sleep 0.3
echo -e "${BRIGHT}${NEON_MAGENTA}⟨⟨⟨ ${NEON_WHITE}Loading matrix protocols${NEON_MAGENTA} ⟩⟩⟩${NC}"
sleep 0.3
echo -e "${BRIGHT}${NEON_GREEN}✦✧✦ ${NEON_WHITE}Terminal vibes activated${NEON_GREEN} ✦✧✦${NC}"
sleep 0.4

# Display the enhanced terminal
display_terminal

# Keep it running
while true; do
    sleep 1
done
        left_clean=$(echo -e "$left_line" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\x1b\[[0-9]*;//g')
        spaces_needed=$((50 - ${#left_clean}))
        if [ $spaces_needed -lt 2 ]; then
            spaces_needed=2
        fi
        
        printf "%s%*s%s\n" "$left_line" $spaces_needed "" "$right_line"
    done
    
    echo
    echo -e "${NEON_RED}                   ⚡ Press Ctrl+C to exit ⚡${NC}"


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