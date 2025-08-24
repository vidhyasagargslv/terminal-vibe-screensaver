#!/bin/bash

# Ultra Neon Cyberpunk Colors - Enhanced for maximum impact
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
NEON_LIME='\033[38;5;118m'      # Electric lime
GLOW='\033[5m'                  # Blinking effect
BOLD='\033[1m'                  # Bold text
DIM='\033[2m'                   # Dim text
NC='\033[0m'                    # No Color

# Matrix rain characters
MATRIX_CHARS="01アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン"

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
    echo -e "${NEON_CYAN}${GLOW}⚡ DISCONNECTED FROM THE MATRIX ⚡${NC}"
    exit 0
}

# Set trap for cleanup
trap cleanup INT TERM

# Hide cursor and prepare terminal
clear
tput civis 2>/dev/null || true

# Get system info with enhanced details
get_system_info() {
    USER_NAME=$(whoami)
    HOSTNAME=$(hostname)
    OS=$(lsb_release -d 2>/dev/null | cut -f2 | cut -c1-20 || uname -o | cut -c1-20)
    KERNEL=$(uname -r | cut -c1-18)
    UPTIME=$(uptime -p 2>/dev/null | sed 's/up //' | cut -c1-18 || uptime | cut -d',' -f1 | cut -c1-18)
    SHELL_VERSION=$(echo $SHELL | xargs basename)
    MEMORY=$(free -h 2>/dev/null | awk 'NR==2{printf "%.1f/%.1fGB (%.0f%%)", $3/1024/1024, $2/1024/1024, $3*100/$2}' || echo "N/A")
    DISK=$(df -h / 2>/dev/null | awk 'NR==2{printf "%s/%s (%s)", $3, $2, $5}' || echo "N/A")
    CPU_TEMP=$(sensors 2>/dev/null | grep "Core 0" | awk '{print $3}' | head -1 | cut -c2-5 || echo "N/A")
    LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | cut -c2-12)

    # Enhanced dev tools
    GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 | cut -c1-8 || echo "N/A")
    NODE_VERSION=$(node --version 2>/dev/null | cut -c2-8 || echo "N/A")
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -c1-6 || echo "N/A")
    DOCKER_VERSION=$(docker --version 2>/dev/null | cut -d' ' -f3 | cut -d',' -f1 | cut -c1-8 || echo "N/A")
    
    # Network with enhanced info
    LOCAL_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "127.0.0.1")
    PUBLIC_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "OFFLINE")
    GATEWAY=$(ip route | grep default | awk '{print $3}' | head -n1 || echo "N/A")
    
    # System stats
    PROCESSES=$(ps aux | wc -l)
    LOGGED_USERS=$(who | wc -l)
}

# Stunning ASCII Art - 3D Cyber Logo
ascii_art() {
    cat << "EOF"
  ████████╗██╗  ██╗███████╗    ██████╗ ██╗ ██████╗
  ╚══██╔══╝██║  ██║██╔════╝    ██╔══██╗██║██╔════╝
     ██║   ███████║█████╗      ██████╔╝██║██║  ███╗
     ██║   ██╔══██║██╔══╝      ██╔══██╗██║██║   ██║
     ██║   ██║  ██║███████╗    ██████╔╝██║╚██████╔╝
     ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚═════╝ ╚═╝ ╚═════╝
  
  ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗     
  ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║     
     ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║     
     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║     
     ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗
     ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
EOF
}

# Matrix-style animated border
matrix_border() {
    local width=80
    local border=""
    for ((i=0; i<width; i++)); do
        if (( RANDOM % 3 == 0 )); then
            char=${MATRIX_CHARS:$((RANDOM % ${#MATRIX_CHARS})):1}
            border+="$char"
        else
            border+="█"
        fi
    done
    echo -e "${NEON_GREEN}${GLOW}$border${NC}"
}

# Cyber glitch effect text
glitch_text() {
    local text="$1"
    local colors=("${NEON_PINK}" "${NEON_CYAN}" "${NEON_YELLOW}" "${NEON_MAGENTA}")
    local color=${colors[$((RANDOM % 4))]}
    echo -e "${color}${GLOW}$text${NC}"
}

# Enhanced left panel with 3D effects
display_left_panel() {
    echo -e "${NEON_CYAN}${BOLD}"
    ascii_art
    echo -e "${NC}"
    
    echo -e "${NEON_YELLOW}╔═══════════════════════════════════════╗${NC}"
    echo -e "${NEON_YELLOW}║${NEON_WHITE}${GLOW}          ⚡ NEURAL LINK ACTIVE ⚡        ${NEON_YELLOW}║${NC}"
    echo -e "${NEON_YELLOW}╚═══════════════════════════════════════╝${NC}"
    
    # Network status with visual indicators
    echo -e "${NEON_GREEN}▓▓▓▓▓▓▓ NETWORK MATRIX ▓▓▓▓▓▓▓${NC}"
    if [[ "$PUBLIC_IP" == "OFFLINE" ]]; then
        echo -e "${NEON_RED}🔴 WAN: ${NEON_WHITE}DISCONNECTED${NC}"
    else
        echo -e "${NEON_LIME}🟢 WAN: ${NEON_WHITE}$PUBLIC_IP${NC}"
    fi
    echo -e "${NEON_CYAN}🔗 LAN: ${NEON_WHITE}$LOCAL_IP${NC}"
    echo -e "${NEON_ORANGE}🌐 GW:  ${NEON_WHITE}$GATEWAY${NC}"
    
    # Live system indicators
    echo -e "${NEON_PURPLE}▓▓▓▓▓▓▓ LIVE STATS ▓▓▓▓▓▓▓${NC}"
    echo -e "${NEON_YELLOW}⚙️  Proc: ${NEON_WHITE}$PROCESSES${NC}"
    echo -e "${NEON_YELLOW}👥 Users: ${NEON_WHITE}$LOGGED_USERS${NC}"
    if [[ "$CPU_TEMP" != "N/A" ]]; then
        echo -e "${NEON_RED}🌡️  Temp: ${NEON_WHITE}$CPU_TEMP°C${NC}"
    fi
}

# Enhanced right panel with better organization
display_right_panel() {
    echo -e "${NEON_PINK}╔═══════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║${NEON_WHITE}${GLOW}            🖥️  SYSTEM CORE 🖥️             ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╚═══════════════════════════════════════╝${NC}"
    
    # System info with enhanced formatting
    echo -e "${NEON_CYAN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    printf "${NEON_YELLOW}👤 User: ${NEON_WHITE}%-25s${NC}\n" "$USER_NAME@$HOSTNAME"
    printf "${NEON_YELLOW}🏠 OS:   ${NEON_WHITE}%-25s${NC}\n" "$OS"
    printf "${NEON_YELLOW}⚙️  Core: ${NEON_WHITE}%-25s${NC}\n" "$KERNEL"
    printf "${NEON_YELLOW}⏱️  Up:   ${NEON_WHITE}%-25s${NC}\n" "$UPTIME"
    printf "${NEON_YELLOW}🧠 RAM:  ${NEON_WHITE}%-25s${NC}\n" "$MEMORY"
    printf "${NEON_YELLOW}💿 Disk: ${NEON_WHITE}%-25s${NC}\n" "$DISK"
    printf "${NEON_YELLOW}📊 Load: ${NEON_WHITE}%-25s${NC}\n" "$LOAD_AVG"
    printf "${NEON_YELLOW}🐚 Shell:${NEON_WHITE}%-25s${NC}\n" "$SHELL_VERSION"
    
    echo -e "${NEON_MAGENTA}╔═══════════════════════════════════════╗${NC}"
    echo -e "${NEON_MAGENTA}║${NEON_WHITE}${GLOW}             ⚡ DEV ARSENAL ⚡              ${NEON_MAGENTA}║${NC}"
    echo -e "${NEON_MAGENTA}╚═══════════════════════════════════════╝${NC}"
    
    # Development stack with status indicators
    echo -e "${NEON_GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
    printf "${NEON_GREEN}🔧 Git:    ${NEON_WHITE}%-20s${NC}\n" "$GIT_VERSION"
    printf "${NEON_GREEN}🐍 Python: ${NEON_WHITE}%-20s${NC}\n" "$PYTHON_VERSION"
    printf "${NEON_GREEN}📦 Node:   ${NEON_WHITE}%-20s${NC}\n" "$NODE_VERSION"
    printf "${NEON_GREEN}🐳 Docker: ${NEON_WHITE}%-20s${NC}\n" "$DOCKER_VERSION"
    echo -e "${NEON_GREEN}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${NC}"
}

# Animated loading sequence
loading_sequence() {
    local messages=(
        "🚀 Initializing neural interface..."
        "🔧 Loading quantum processors..."
        "⚡ Establishing matrix connection..."
        "🎯 Synchronizing cyber protocols..."
        "💻 Terminal ready for deployment..."
    )
    
    for msg in "${messages[@]}"; do
        echo -e "${NEON_CYAN}${msg}${NC}"
        sleep 0.5
        
        # Loading bar effect
        printf "${NEON_GREEN}["
        for ((i=0; i<20; i++)); do
            printf "█"
            sleep 0.03
        done
        printf "]${NC}\n"
        sleep 0.3
    done
}

# Main display with stunning effects
main_display() {
    get_system_info
    clear
    
    # Animated top border
    matrix_border
    
    # Epic header with glitch effects
    echo -e "${NEON_PINK}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║$(glitch_text "                        💻 THE BIG TERMINAL 💻                           ")║${NC}"
    echo -e "${NEON_PINK}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "${NEON_YELLOW}${GLOW}$(date '+%Y-%m-%d %H:%M:%S') - MATRIX TIME SYNCHRONIZATION ACTIVE${NC}"
    echo
    
    # Create panels with better spacing
    left_content=$(display_left_panel)
    right_content=$(display_right_panel)
    
    # Display side by side with perfect alignment
    IFS=$'\n' read -rd '' -a left_lines <<< "$left_content" || true
    IFS=$'\n' read -rd '' -a right_lines <<< "$right_content" || true
    
    max_lines=${#left_lines[@]}
    if [ ${#right_lines[@]} -gt $max_lines ]; then
        max_lines=${#right_lines[@]}
    fi
    
    for ((i=0; i<max_lines; i++)); do
        left_line="${left_lines[i]:-}"
        right_line="${right_lines[i]:-}"
        
        # Better spacing calculation
        left_clean=$(echo -e "$left_line" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/\x1b\[[0-9]*[mGKH]//g')
        spaces_needed=$((42 - ${#left_clean}))
        if [ $spaces_needed -lt 1 ]; then
            spaces_needed=1
        fi
        
        printf "%s%*s%s\n" "$left_line" $spaces_needed "" "$right_line"
    done
    
    echo
    matrix_border
    
    # Epic footer
    echo -e "${NEON_RED}${GLOW}                    ⚡ PRESS CTRL+C TO JACK OUT OF THE MATRIX ⚡${NC}"
    
    # Real-time clock in corner
    while true; do
        tput cup 3 65
        echo -e "${NEON_CYAN}$(date '+%H:%M:%S')${NC}"
        sleep 1
    done
}

# Epic initialization sequence
echo -e "${NEON_PINK}${GLOW}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${NEON_PINK}║${NEON_WHITE}                          NEURAL INTERFACE BOOTING...                        ${NEON_PINK}║${NC}"
echo -e "${NEON_PINK}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"

loading_sequence

clear
echo -e "${NEON_GREEN}${GLOW}⚡ WELCOME TO THE MATRIX ⚡${NC}"
sleep 1

# Display the stunning terminal
main_display