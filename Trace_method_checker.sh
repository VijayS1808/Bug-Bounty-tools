#!/bin/bash

input_file="sub.txt"

output_file="trace_results.txt"

> "$output_file" # Clear output file

while read -r domain; do
    echo "Checking $domain..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -X TRACE "$domain")
    if [ "$response" -eq 405 ]; then
        echo "$domain: TRACE Disabled (Method Not Allowed)" >> "$output_file"
    elif [ "$response" -eq 200 ]; then
        echo "$domain: TRACE Enabled" >> "$output_file"
    else
        echo "$domain: Unknown Response ($response)" >> "$output_file"
    fi
done < "$input_file"

echo "Check complete. Results saved in $output_file"
