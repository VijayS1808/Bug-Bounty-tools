echo "Enter your Domain Name:"
read s

curl -s "https://crt.sh/?q=%25.$s&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee list
