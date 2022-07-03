toilet XSS --gay

echo -e "\e[1;31;47m "Enter the domain::: \e[1m" 

read s

waybackurls $s | gf xss | sed 's/=.*/=/' | sort -u | uniq | tee urls.txt

tee urls.txt | dalfox pipe --silence --skip-mining-dict --skip-mining-all >> output.txt
