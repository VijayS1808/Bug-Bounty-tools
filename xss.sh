go get -u github.com/tomnomnom/gf
cd gopath/bin
mv -v gf /usr/bin
cd 
wget https://github.com/KathanP19/Gxss/releases/download/v4.1/Gxss_4.1_Linux_x86_64.tar.gz
tar -xvf Gxss_4.1_Linux_x86_64.tar.gz
mv -v Gxss /usr/bin
cd 





toilet XSS --gay

echo -e "\e[1;31;47m "Enter the domain::: " \e[1m" 

read s

waybackurls $s | gf xss | sed 's/=.*/=/' | sort -u | uniq | tee urls.txt

tee urls.txt | Gxss -p test | dalfox pipe --silence --skip-mining-dict --skip-mining-all >> output.txt
rm urls.txt
