#!/bin/bash

# Enhanced Coding Vibe Terminal Screensaver
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

# Clear screen and hide cursor
clear
tput civis

# Terminal dimensions
COLS=$(tput cols)
ROWS=$(tput lines)

# Trap to clean up on exit
trap 'tput cnorm; clear; exit 0' INT TERM EXIT

# Get system info with more coding-focused details
USER_NAME=$(whoami)
HOSTNAME=$(hostname)
OS=$(lsb_release -d | cut -f2 2>/dev/null || uname -o)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
SHELL_VERSION=$(echo $SHELL | xargs basename)
MEMORY=$(free -h | awk 'NR==2{printf "%.1f/%.1fGB (%.0f%%)", $3/1024/1024, $2/1024/1024, $3/$2*100}')
DISK=$(df -h / | awk 'NR==2{printf "%s/%s (%s)", $3, $2, $5}')
CPU=$(lscpu | grep "Model name" | cut -f 2 -d ":" | awk '{$1=$1}1' | cut -c1-35)
LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -c2-15)

# Coding environment details
GIT_VERSION=$(git --version 2>/dev/null | cut -d' ' -f3 || echo "Not installed")
NODE_VERSION=$(node --version 2>/dev/null || echo "Not installed")
PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2 || echo "Not installed")
CODE_EDITOR=$(which code nvim vim nano 2>/dev/null | head -n1 | xargs basename || echo "Unknown")
CURRENT_DIR=$(pwd | sed "s|$HOME|~|")
GIT_BRANCH=$(git branch --show-current 2>/dev/null || echo "No repo")
GIT_STATUS=$(git status --porcelain 2>/dev/null | wc -l || echo "0")

# Network information
LOCAL_IP=$(hostname -I | awk '{print $1}')
PUBLIC_IP=$(timeout 2 curl -s ifconfig.me 2>/dev/null || echo "Offline")

# Generate random code snippets for animation
code_snippets=(
    "function hackTheMatrix() {"
    "  const reality = new Matrix();"
    "  while(true) {"
    "    reality.bend();"
    "  }"
    "}"
    ""
    "class Developer {"
    "  constructor() {"
    "    this.coffee = Infinity;"
    "    this.bugs = Math.random();"
    "  }"
    "}"
    ""
    "// There is no spoon"
    "if (spoon.exists()) {"
    "  spoon.bend();"
    "} else {"
    "  mind.bend();"
    "}"
    ""
    "const vibes = await fetch('/vibes');"
    "vibes.forEach(vibe => {"
    "  terminal.display(vibe);"
    "});"
)

# ASCII Art for coder theme
ascii_art() {
    echo -e "${NEON_CYAN}${GLOW}"
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
    ║    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
    ║    ░▄▀█▀█▀▄░▄▀█▀█▀▄░▄▀█▀█▀▄░░░░░░░  ║
    ║    ░█▄▄▄▄▄█░█▄▄▄▄▄█░█▄▄▄▄▄█░░░░░░░  ║
    ║    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
    ║        < DEVELOPER FUEL />           ║
    ║                                       ║
    ║    ┌─┐┬ ┬┌─┐┬─┐┬ ┬  ┌┬┐┌─┐┌┬┐┌─┐    ║
    ║    │─┼┐│ │├┤ ├┬┘└┬┘  ││││ │ ││├┤     ║
    ║    └─┘┘└─┘└─┘┴└─ ┴   ┴ ┴└─┘─┴┘└─┘    ║
    ║                                       ║
    ║         { "status": "vibing" }        ║
    ╚═══════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

# Enhanced system info panel with coding focus
system_info_panel() {
    echo -e "${NEON_PINK}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${NEON_PINK}║${NEON_WHITE}${GLOW}                      SYSTEM STATUS                        ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_YELLOW} 👤 Coder:      ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$USER_NAME@$HOSTNAME"
    printf "${NEON_PINK}║${NEON_YELLOW} 💻 Machine:     ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$(echo $OS | cut -c1-30)"
    printf "${NEON_PINK}║${NEON_YELLOW} 🔧 Kernel:      ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$KERNEL"
    printf "${NEON_PINK}║${NEON_YELLOW} 🐚 Shell:       ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$SHELL_VERSION"
    printf "${NEON_PINK}║${NEON_YELLOW} ⏰ Runtime:     ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$UPTIME"
    printf "${NEON_PINK}║${NEON_YELLOW} 🧠 RAM:         ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$MEMORY"
    printf "${NEON_PINK}║${NEON_YELLOW} 💾 Storage:     ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$DISK"
    printf "${NEON_PINK}║${NEON_YELLOW} 🔥 Processor:   ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$CPU"
    printf "${NEON_PINK}║${NEON_YELLOW} 📊 Load:        ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$LOAD"
    
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${NEON_PINK}║${NEON_CYAN}${GLOW}                   CODING ENVIRONMENT                     ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_GREEN} 📝 Editor:      ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$CODE_EDITOR"
    printf "${NEON_PINK}║${NEON_GREEN} 📁 Directory:   ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$(echo $CURRENT_DIR | cut -c1-30)"
    printf "${NEON_PINK}║${NEON_GREEN} 🌿 Git Branch:  ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$GIT_BRANCH"
    printf "${NEON_PINK}║${NEON_GREEN} 📋 Git Changes: ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$GIT_STATUS files"
    printf "${NEON_PINK}║${NEON_GREEN} 🐍 Python:      ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$PYTHON_VERSION"
    printf "${NEON_PINK}║${NEON_GREEN} 📦 Node:        ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$NODE_VERSION"
    printf "${NEON_PINK}║${NEON_GREEN} 🔄 Git:         ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$GIT_VERSION"
    
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${NEON_PINK}║${NEON_BLUE}${GLOW}                    NETWORK STATUS                        ${NEON_PINK}║${NC}"
    echo -e "${NEON_PINK}╠══════════════════════════════════════════════════════════╣${NC}"
    
    printf "${NEON_PINK}║${NEON_ORANGE} 🏠 Local IP:    ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$LOCAL_IP"
    printf "${NEON_PINK}║${NEON_ORANGE} 🌍 Public IP:   ${NEON_WHITE}%-30s${NEON_PINK} ║${NC}\n" "$PUBLIC_IP"
    
    echo -e "${NEON_PINK}╚══════════════════════════════════════════════════════════╝${NC}"
}

# Matrix-style scrolling code effect
matrix_code_effect() {
    local line_num=$1
    local col_start=$2
    local width=$3
    
    # Random characters for matrix effect
    chars=("0" "1" "{" "}" "[" "]" "(" ")" "<" ">" "/" "\" ";" ":" "=" "+" "-" "*" "&" "|" "^" "%" "$" "#" "@" "!")
    
    for ((i=0; i<5; i++)); do
        tput cup $((line_num + i)) $col_start
        echo -ne "${MATRIX_GREEN}${DIM}"
        for ((j=0; j<width; j++)); do
            if (( RANDOM % 3 == 0 )); then
                echo -ne "${chars[$((RANDOM % ${#chars[@]}))]}"
            else
                echo -ne " "
            fi
        done
        echo -ne "${NC}"
    done
}

# Animated typing effect for code snippets
typing_effect() {
    local text="$1"
    local delay="$2"
    local row="$3"
    local col="$4"
    local color="$5"
    
    tput cup $row $col
    echo -ne "${color}"
    
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
    echo -ne "${NC}"
}

# Main display function with animations
display_dashboard() {
    tput cup 0 0
    
    # Animated top border
    colors=("${NEON_CYAN}" "${NEON_PURPLE}" "${NEON_PINK}")
    for color in "${colors[@]}"; do
        tput cup 0 0
        echo -e "${color}${GLOW}╔══════════════════════════════════════════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${color}║${NEON_WHITE}${GLOW}                                      🚀 CODE VIBES 🚀                                          ${color}║${NC}"
        echo -e "${color}╚══════════════════════════════════════════════════════════════════════════════════════════════════════╝${NC}"
        sleep 0.2
    done
    
    # Display ASCII art and system info side by side
    {
        ascii_art > /tmp/ascii_art.txt
        system_info_panel > /tmp/system_info.txt
        
        # Display both panels
        ascii_lines=$(cat /tmp/ascii_art.txt)
        system_lines=$(cat /tmp/system_info.txt)
        
        line_num=4
        while IFS= read -r ascii_line && IFS= read -r system_line <&3; do
            tput cup $line_num 2
            echo -e "$ascii_line"
            tput cup $line_num 45
            echo -e "$system_line"
            ((line_num++))
        done <<< "$ascii_lines" 3<<< "$system_lines"
        
        # Clean up temp files
        rm -f /tmp/ascii_art.txt /tmp/system_info.txt
    } &
    
    # Add matrix effect in background
    matrix_code_effect $((ROWS-15)) 2 40 &
    
    # Bottom section with animated code
    tput cup $((ROWS-10)) 0
    echo -e "${NEON_YELLOW}╔══════════════════════════════════════════════════════════════════════════════════════════════════════╗${NC}"
    
    # Animated code snippet
    snippet_line=$((ROWS-8))
    typing_effect "const developer = { status: 'in the zone', coffee: '∞', bugs: 'squashed' };" 0.05 $snippet_line 5 "${NEON_GREEN}" &
    
    sleep 2
    tput cup $((ROWS-7)) 5
    echo -e "${NEON_BLUE}// Time to hack the mainframe..."
    
    tput cup $((ROWS-6)) 0
    echo -e "${NEON_YELLOW}║${NEON_WHITE}                            Current Time: $(date '+%Y-%m-%d %H:%M:%S')                            ${NEON_YELLOW}║${NC}"
    
    tput cup $((ROWS-5)) 0
    echo -e "${NEON_YELLOW}╚══════════════════════════════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    tput cup $((ROWS-3)) 0
    echo -e "${NEON_RED}${GLOW}                              ⚡ Press CTRL+C to exit the matrix... ⚡${NC}"
    
    wait
}

# Continuous animation loop
animation_loop() {
    while true; do
        display_dashboard
        sleep 5
        clear
    done
}

# Main execution
echo -e "${NEON_CYAN}${GLOW}Initializing Code Vibes...${NC}"
sleep 1
echo -e "${MATRIX_GREEN}Loading developer environment...${NC}"
sleep 1
echo -e "${NEON_PINK}Establishing connection to the mainframe...${NC}"
sleep 1

animation_loop