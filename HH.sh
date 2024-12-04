#!/bin/bash

# ================== Color Definitions ==================
NC='\033[0m'                   # No Color
RED='\033[1;38;5;196m'         # Bright Red
GREEN='\033[1;38;5;040m'       # Bright Green
ORANGE='\033[1;38;5;202m'      # Bright Orange
BLUE='\033[1;38;5;012m'        # Bright Blue
BLUE2='\033[1;38;5;032m'       # Another shade of Blue
PINK='\033[1;38;5;013m'        # Bright Pink
GRAY='\033[1;38;5;004m'        # Gray
NEW='\033[1;38;5;154m'         # New Color
YELLOW='\033[1;38;5;214m'      # Bright Yellow
CG='\033[1;38;5;087m'          # Cyan Green
CP='\033[1;38;5;221m'          # Cyan Pink
CPO='\033[1;38;5;205m'         # Cyan Pink Orange
CN='\033[1;38;5;247m'          # Cyan Normal
CNC='\033[1;38;5;051m'         # Cyan Cyan

# ================== Banner Function ==================
function banner(){
    echo -e "${RED}#####################################################################"
    echo -e "${CP}    _   _           _     ___        _           _                   #"
    echo -e "${CP}   | | | | ___  ___| |_  |_ _|_ __  (_) ___  ___| |_ ___  _ __       #"
    echo -e "${CP}   | |_| |/ _ \/ __| __|  | || '_ \ | |/ _ \/ __| __/ _ \| '__|      #"
    echo -e "${CP}   |  _  | (_) \__ \ |_   | || | | || |  __/ (__| || (_) | |         #"
    echo -e "${CP}   |_| |_|\___/|___/\__| |___|_| |_|/ |\___|\___|\__\___/|_|         #"
    echo -e "${CP}                                  |__/                               #"
    echo -e "${BLUE2}          A Framework for Host Header Injection                      #"
    echo -e "${YELLOW}             https://facebook.com/unknownclay                        #"
    echo -e "${ORANGE}             Coded By: Machine404                                    #"
    echo -e "${BLUE}             https://github.com/machine1337                          #"
    echo -e "${RED}#####################################################################${NC}"
}

# ================== Internet Connectivity Check ==================
echo -e "${CP}[+] Checking Internet Connectivity${NC}"
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo -e "${GREEN}Internet is present${NC}"
else
    echo -e "${RED}No Internet Connection${NC}"
    exit 1
fi

# ================== Inject Single Domain Function ==================
function inject_single(){
    clear
    banner
    echo -e -n "${BLUE}\n[+] Enter domain name (e.g https://target.com) : ${NC}"
    read domain

    # Validate domain input
    if [[ -z "$domain" ]]; then
        echo -e "${RED}[!] No domain entered. Exiting.${NC}"
        exit 1
    fi

    # Check if headers.txt exists
    if [[ ! -f "headers.txt" ]]; then
        echo -e "${RED}[!] Headers file not found: headers.txt${NC}"
        exit 1
    fi

    echo -e "${CNC}\n[+] Searching For Host Header Injection${NC}"
    
    # Read headers from headers.txt
    headers=$(paste -sd "; " headers.txt)

    # Send request with custom headers
    response=$(curl -s -m5 -I "$domain" $(echo "$headers" | awk -F'; ' '{for(i=1;i<=NF;i++) printf "-H \"%s\" ", $i}'))

    # Save response to output.txt
    echo -e "${YELLOW}\nURL: $domain${NC}" > output.txt
    echo "$response" >> output.txt

    # Check for 'evil' in the response headers
    if echo "$response" | grep -iq "evil"; then
        echo -e "${RED}URL: $domain  [Vulnerable]${NC}"
        echo "URL: $domain - Vulnerable at $(date)" >> vulnerable_urls.txt
    else
        echo -e "${GREEN}URL: $domain  [Not Vulnerable]${NC}"
    fi

    # Clean up
    rm -f output.txt
}

# ================== Inject Multiple URLs Function ==================
function inject_urls(){
    clear
    banner

    # Define target and headers files
    urls_file="sub.txt"
    headers_file="headers.txt"

    # Check if target and headers files exist
    if [[ ! -f "$urls_file" ]]; then
        echo -e "${RED}[!] Target file not found: $urls_file${NC}"
        exit 1
    fi

    if [[ ! -f "$headers_file" ]]; then
        echo -e "${RED}[!] Headers file not found: $headers_file${NC}"
        exit 1
    fi

    echo -e "${PINK}\n[+] Reading target URLs from $urls_file${NC}"
    echo -e "${CNC}[+] Searching For Host Header Injection${NC}"

    # Read headers from headers.txt
    headers=$(paste -sd "; " "$headers_file")

    # Iterate through each URL in sub.txt
    while IFS= read -r target || [[ -n "$target" ]]; do
        # Skip empty lines
        [[ -z "$target" ]] && continue

        # Send request with custom headers
        response=$(curl -s -m5 -I "$target" $(echo "$headers" | awk -F'; ' '{for(i=1;i<=NF;i++) printf "-H \"%s\" ", $i}'))

        # Save response to output.txt
        echo -e "${YELLOW}\nURL: $target${NC}" > output.txt
        echo "$response" >> output.txt

        # Check for 'evil' in the response headers
        if echo "$response" | grep -iq "evil"; then
            echo -e "${RED}URL: $target  [Vulnerable]${NC}"
            echo "URL: $target - Vulnerable at $(date)" >> vulnerable_urls.txt
        else
            echo -e "${GREEN}URL: $target  [Not Vulnerable]${NC}"
        fi

        # Clean up
        rm -f output.txt
    done < "$urls_file"

    echo -e "${YELLOW}\nScan completed. Check vulnerable_urls.txt for results.${NC}"
}

# ================== Menu Function ==================
function menu(){
    while true; do
        clear
        banner
        echo -e "${YELLOW}\n[*] Which Type of Scan do you want to Perform?${NC}\n"
        echo -e "  ${NC}[${CG}1${NC}]${CNC} Single domain Scan"
        echo -e "  ${NC}[${CG}2${NC}]${CNC} List of domains Scan (from sub.txt)"
        echo -e "  ${NC}[${CG}3${NC}]${CNC} Exit"

        echo -ne "\n${YELLOW}[+] Select an option: ${NC}"
        read -r host_play

        case $host_play in
            1)
                inject_single
                read -rp "Press Enter to return to the menu..."
                ;;
            2)
                inject_urls
                read -rp "Press Enter to return to the menu..."
                ;;
            3)
                echo -e "${GREEN}Exiting. Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}[!] Invalid option. Please select 1, 2, or 3.${NC}"
                sleep 2
                ;;
        esac
    done
}

# ================== Start the Script ==================
menu
