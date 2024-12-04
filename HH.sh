#!/bin/bash

# Function to print in color
print_color() {
  color_code="$1"
  message="$2"
  echo -e "\033[${color_code}m${message}\033[0m"
}

# Adjust banner size based on desired width
adjust_banner_size() {
  banner_text="$1"
  desired_width="$2"
  banner_lines=()
  max_line_length=0

  # Split the banner text into lines
  IFS=$'\n' read -rd '' -a banner_lines <<<"$banner_text"

  # Find the length of the longest line
  for line in "${banner_lines[@]}"; do
    line_length=${#line}
    if (( line_length > max_line_length )); then
      max_line_length=$line_length
    fi
  done

  # Calculate the adjusted width
  adjusted_width=$(( desired_width - max_line_length ))

  # Print the adjusted banner from the left side
  for line in "${banner_lines[@]}"; do
    printf "%s%*s\n" "$line" "$adjusted_width" ""
  done
}

# Define the banners
banner_text1=$(cat << "EOF"
██╗  ██╗███████╗███╗   ███╗ █████╗ ███╗   ██╗████████╗███████╗ ██████╗ ██╗      ██████╗ 
██║  ██║██╔════╝████╗ ████║██╔══██╗████╗  ██║╚══██╔══╝██╔════╝██╔═══██╗██║     ██╔═══██╗
███████║█████╗  ██╔████╔██║███████║██╔██╗ ██║   ██║   ███████╗██║   ██║██║     ██║   ██║
██╔══██║██╔══╝  ██║╚██╔╝██║██╔══██║██║╚██╗██║   ██║   ╚════██║██║   ██║██║     ██║   ██║
██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║   ██║   ███████║╚██████╔╝███████╗╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ ╚══════╝ ╚═════╝ 
          Host Header Injection - Vulnerability Scanner
EOF
)

banner_text2=$(cat << "EOF"
-----------------------------------------------------------
                      Author  : Hemant Patidar
                      GitHub  : @HemantSolo
                      Twitter : @HemantSolo
                      Website : hemantsolo.in
-----------------------------------------------------------
EOF
)

banner_text3=$(cat << "EOF"
Usage: script.sh <options> <arguments>
Options:
      -l : Input file of the URLs
      -d : Domain to test
      -h : File containing custom headers for injection
-----------------------------------------------------------

EOF
)

# Get terminal width
term_width=$(tput cols)

# Adjust and print the banners
print_color "36" "$(adjust_banner_size "$banner_text1" "$term_width")"
echo "$(print_color "33" "$(adjust_banner_size "$banner_text2" "$term_width")")"
echo "$(print_color "32" "$(adjust_banner_size "$banner_text3" "$term_width")")"

# Check command line arguments
if [ "$1" = "-l" ]; then
  file="$2"
elif [ "$1" = "-d" ]; then
  domain="$2"
  file="$domain.txt"
  subfinder -d "$domain" 2>/dev/null | httpx > "$file" 2>/dev/null
elif [ "$1" = "-h" ]; then
  headers_file="$2"
else
  echo "Invalid command. Usage: script.sh -l file.txt OR script.sh -d domain.com OR script.sh -h headers.txt"
  exit 1
fi

# Read custom headers from the provided file and set evil.com as the value for all headers
if [ -n "$headers_file" ] && [ -f "$headers_file" ]; then
  while IFS= read -r header; do
    # Replace the value of each header with evil.com
    header_name=$(echo "$header" | cut -d ':' -f 1)
    headers+=("-H $header_name: evil.com")
  done < "$headers_file"
else
  echo "No headers file provided or the file does not exist."
  exit 1
fi

# Test for injection vulnerabilities with the provided custom headers
while IFS= read -r url; do
  # Building the curl command with dynamic headers
  curl_command="curl --max-time 5 -s -I -H 'Host: evil.com' ${headers[@]} '$url'"

  # Execute the curl command
  response=$($curl_command)

  # Check for vulnerabilities based on the response
  if echo "$response" | grep -q "evil.com"; then
    print_color "31" "$url is vulnerable to Host Header Injection"  # Red color for vulnerability
  else
    print_color "32" "$url is not vulnerable to Host Header Injection"  # Green color for no vulnerability
  fi
done < "$file"
