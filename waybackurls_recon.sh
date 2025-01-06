#!/bin/bash

# Colors for output
green="\033[0;32m"
blue="\033[0;34m"
red="\033[0;31m"
yellow="\033[1;33m"
purple="\033[0;35m"
cyan="\033[0;36m"
silver="\033[0;37m"
pink="\033[1;35m"

# Loop through each domain in sub.txt
while read -r domain; do
  echo -e "${blue}Fetching files for: ${green}$domain"

  # Fetch files once and save to a temporary file
  curl "https://web.archive.org/cdx/search?url=$domain&matchType=domain&collapse=urlkey&output=text&fl=original&limit=100000" > temp_results.txt

  # Highlight URLs as they are filtered and saved
  echo -e "${red}Processing and saving URLs for different file types..."

  # Filter and store different file types from the temporary file
  grep -E "\\.php" temp_results.txt | tee -a php_results.txt | sed "s|.*|${green}&|"
  grep -E "\\.asp" temp_results.txt | tee -a asp_results.txt | sed "s|.*|${yellow}&|"
  grep -E "\\.jsp" temp_results.txt | tee -a jsp_results.txt | sed "s|.*|${purple}&|"
  grep -E "\\.json" temp_results.txt | tee -a json_results.txt | sed "s|.*|${cyan}&|"
  grep -E "\\.pdf" temp_results.txt | tee -a pdf_results.txt | sed "s|.*|${silver}&|"
  grep -E "\\.zip" temp_results.txt | tee -a zip_results.txt | sed "s|.*|${pink}&|"
  grep -E "\\.tar" temp_results.txt | tee -a tar_results.txt | sed "s|.*|${green}&|"
  grep -E "\\.js" temp_results.txt | tee -a js_results.txt | sed "s|.*|${yellow}&|"
  grep -E "\\.sql" temp_results.txt | tee -a sql_results.txt | sed "s|.*|${purple}&|"

  # Filter additional extensions and combine into one file
  echo -e "${red}Combining additional extensions into combined_results.txt..."
  grep -E "\\.asa|\\.inc|\\.config|\\.gz|\\.tgz|\\.rar|\\.txt|\\.docx|\\.rtf|\\.xlsx|\\.pptx|\\.bak|\\.old|\\.yaml|\\.properties|\\.py|\\.pem|\\.env|\\.gitignore|\\.git|\\.xml" temp_results.txt | tee -a combined_results.txt | sed "s|.*|${cyan}&|"

  # Hunt for URLs with parameters and save them
  echo -e "${red}Finding URLs with parameters..."
  grep -E "\\?.*=" temp_results.txt | tee -a parameterized_urls.txt | sed "s|.*|${pink}&|"

  # Remove temporary file
  rm temp_results.txt

done < sub.txt

echo -e "${blue}All done! Results saved in respective files."
