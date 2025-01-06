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
reset="\033[0m"

# Loop through each domain in sub.txt
while read -r domain; do
  echo -e "${blue}Fetching files for: ${green}$domain${reset}"

  # Fetch files once and save to a temporary file
  curl "https://web.archive.org/cdx/search?url=$domain&matchType=domain&collapse=urlkey&output=text&fl=original&limit=100000" > temp_results.txt

  # Highlight URLs as they are filtered and saved
  echo -e "${red}Processing and saving URLs for different file types...${reset}"

  # Filter and store different file types from the temporary file
  grep -E "\\.php" temp_results.txt | tee -a php_results.txt | sed "s|.*|${green}&${reset}|"
  grep -E "\\.asp" temp_results.txt | tee -a asp_results.txt | sed "s|.*|${yellow}&${reset}|"
  grep -E "\\.jsp" temp_results.txt | tee -a jsp_results.txt | sed "s|.*|${purple}&${reset}|"
  grep -E "\\.json" temp_results.txt | tee -a json_results.txt | sed "s|.*|${cyan}&${reset}|"
  grep -E "\\.pdf" temp_results.txt | tee -a pdf_results.txt | sed "s|.*|${silver}&${reset}|"
  grep -E "\\.zip" temp_results.txt | tee -a zip_results.txt | sed "s|.*|${pink}&${reset}|"
  grep -E "\\.tar" temp_results.txt | tee -a tar_results.txt | sed "s|.*|${green}&${reset}|"
  grep -E "\\.js" temp_results.txt | tee -a js_results.txt | sed "s|.*|${yellow}&${reset}|"
  grep -E "\\.sql" temp_results.txt | tee -a sql_results.txt | sed "s|.*|${purple}&${reset}|"

  # Filter additional extensions and combine into one file
  echo -e "${red}Combining additional extensions into combined_results.txt...${reset}"
  grep -E "\\.asa|\\.inc|\\.config|\\.gz|\\.tgz|\\.rar|\\.txt|\\.docx|\\.rtf|\\.xlsx|\\.pptx|\\.bak|\\.old|\\.yaml|\\.properties|\\.py|\\.pem|\\.env|\\.gitignore|\\.git|\\.xml" temp_results.txt | tee -a combined_results.txt | sed "s|.*|${cyan}&${reset}|"

  # Hunt for URLs with parameters and save them
  echo -e "${red}Finding URLs with parameters...${reset}"
  grep -E "\\?.*=" temp_results.txt | tee -a parameterized_urls.txt | sed "s|.*|${pink}&${reset}|"

  # Remove temporary file
  rm temp_results.txt

done < sub.txt

echo -e "${blue}All done! Results saved in respective files.${reset}"
