go get -u github.com/tomnomnom/gf
cd gopath/bin
mv -v gf /usr/bin
cd
wget https://github.com/KathanP19/Gxss/releases/download/v4.1/Gxss_4.1_Linux_x86_64.tar.gz
tar -xvf Gxss_4.1_Linux_x86_64.tar.gz
mv -v Gxss /usr/bin
cd

pip3 install uro





toilet XSS --gay

echo -e "\e[1;31;47m "Enter the domain::: " \e[1m"

read s

waybackurls $s | grep "=" | gf xss | sort -u | tee urls.txt

cat urls.txt | httpx -mc 200 | tee 200.txt

tee 200.txt | uro | Gxss -p test | tee dalfox.txt
cat dalfox.txt | dalfox pipe --skip-bav r --silence --skip-mining-dom --ignore-return 302,404,403 -only-custom-payload xss.txt | tee out.txt

rm -rf urls.txt 200.txt dalfox.txt

