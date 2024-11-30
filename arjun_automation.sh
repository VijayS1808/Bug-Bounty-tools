#!/bin/bash

# Input: Target URL
BASE_URL="https://webservices.fleetboard.com/?id=5521"

# Temporary file for Arjun output
ARJUN_OUTPUT_FILE=$(mktemp)

# Step 1: Run Arjun to find parameters and capture its output
echo "======================================================"
echo "Step 1: Running Arjun to detect parameters on the URL"
echo "======================================================"
echo "Command: arjun -u \"$BASE_URL\""
arjun -u "$BASE_URL" > "$ARJUN_OUTPUT_FILE"

# Display the raw output of Arjun
echo -e "\n[Arjun Output]"
cat "$ARJUN_OUTPUT_FILE"

# Step 2: Parse the detected parameters from Arjun's output
echo "======================================================"
echo "Step 2: Parsing detected parameters from Arjun output"
echo "======================================================"
PARAMETERS=$(grep "parameter detected" "$ARJUN_OUTPUT_FILE" | awk -F ': ' '{print $2}' | awk -F ',' '{print $1}')

if [[ -z "$PARAMETERS" ]]; then
    echo -e "\n[!] No parameters detected by Arjun."
    rm -f "$ARJUN_OUTPUT_FILE"
    exit 1
fi

echo -e "\n[Detected Parameters]"
echo "$PARAMETERS"

# Step 3: Construct the merged URL
echo "======================================================"
echo "Step 3: Constructing the merged URL with parameters"
echo "======================================================"
PARAMETERS_ARRAY=($(echo "$PARAMETERS"))
MERGED_URL="$BASE_URL"
for param in "${PARAMETERS_ARRAY[@]}"; do
    MERGED_URL+="&$param=test"
done

echo -e "\n[Merged URL]"
echo "$MERGED_URL"

# Step 4: Run kxss for XSS detection
echo "======================================================"
echo "Step 4: Running kxss for XSS detection on the merged URL"
echo "======================================================"
echo "Command: echo \"$MERGED_URL\" | kxss"
echo -e "\n[kxss Output]"
echo "$MERGED_URL" | kxss

# Step 5: Cleanup and completion message
echo "======================================================"
echo "Step 5: Cleanup temporary files and completion"
echo "======================================================"
rm -f "$ARJUN_OUTPUT_FILE"
echo "Process completed successfully!"
