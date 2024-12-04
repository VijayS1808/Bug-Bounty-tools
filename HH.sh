#!/bin/bash

# Function to print in color
print_color() {
  color_code="$1"
  message="$2"
  echo -e "\033[${color_code}m${message}\033[0m"
}

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
while IFS= read -r header; do
  if [[ "$header" =~ ^[^:]+: ]]; then  # Ensure the line has a valid header format
    header_name=$(echo "$header" | cut -d ':' -f 1)
    headers+=("-H $header_name: evil.com")
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

# Test for injection vulnerabilities with the provided custom headers
while IFS= read -r subdomain; do
  # Ensure the subdomain is valid
  if [[ ! "$subdomain" =~ ^https?:// ]]; then
    subdomain="http://$subdomain"  # Assume HTTP if not specified
  fi

  # Building the curl command with dynamic headers
  curl_command="curl --max-time 5 -s -I -H 'Host: evil.com' ${headers[@]} '$subdomain'"

  # Execute the curl command
  response=$($curl_command)

  # Check for vulnerabilities based on the response
  if echo "$response" | grep -q "evil.com"; then
    print_color "31" "$subdomain is vulnerable to Host Header Injection"  # Red color for vulnerability
  else
    print_color "32" "$subdomain is not vulnerable to Host Header Injection"  # Green color for no vulnerability
  fi
done < "$subdomains_file"
