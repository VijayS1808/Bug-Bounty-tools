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
Usage: script.sh
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

# Set the headers and subdomains file
headers_file="headers.txt"
subdomains_file="sub.txt"

# Ensure necessary tools are installed
for tool in subfinder httpx curl; do
  if ! command -v "$tool" &>/dev/null; then
    echo "Error: $tool is not installed."
    exit 1
  fi
done

# Check if the headers file exists and is non-empty
if [ -f "$headers_file" ]; then
  if [ ! -s "$headers_file" ]; then
    echo "Error: The headers file is empty."
    exit 1
  fi
else
  echo "Error: No headers file provided or the file does not exist."
  exit 1
fi

# Read custom headers from the provided file and set evil.com as the value for all headers
headers=()
echo "Reading headers from $headers_file..."
while IFS= read -r header; do
  if [[ "$header" =~ ^[^:]+: ]]; then  # Ensure the line has a valid header format
    header_name=$(echo "$header" | cut -d ':' -f 1)
    headers+=("-H $header_name: evil.com")
    echo "Header: $header_name: evil.com"
  fi
done < "$headers_file"

# Ensure the subdomains file exists and is non-empty
if [ -f "$subdomains_file" ]; then
  if [ ! -s "$subdomains_file" ]; then
    echo "Error: The subdomains file is empty."
    exit 1
  fi
else
  echo "Error: No subdomains file provided or the file does not exist."
  exit 1
fi

echo "Reading subdomains from $subdomains_file..."

# Test for injection vulnerabilities with the provided custom headers
while IFS= read -r subdomain; do
  # Ensure the subdomain is valid
  if [[ ! "$subdomain" =~ ^https?:// ]]; then
    subdomain="http://$subdomain"  # Assume HTTP if not specified
  fi

  # Building the curl command with dynamic headers
  curl_command="curl --max-time 5 -s -I -H 'Host: evil.com' ${headers[@]} '$subdomain'"

  # Execute the curl command
  echo "Testing $subdomain for Host Header Injection..."
  response=$($curl_command)

  # Check for vulnerabilities based on the response
  if echo "$response" | grep -q "evil.com"; then
    print_color "31" "$subdomain is vulnerable to Host Header Injection"  # Red color for vulnerability
  else
    print_color "32" "$subdomain is not vulnerable to Host Header Injection"  # Green color for no vulnerability
  fi
done < "$subdomains_file"

echo "Script execution completed."
