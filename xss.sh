wget https://github.com/KathanP19/Gxss/releases/download/v4.1/Gxss_4.1_Linux_x86_64.tar.gz

tar -xvzf Gxss_4.1_Linux_i386.tar.gz

mv -v Gxss /usr/bin

rm -rf Gxss_4.1_Linux_i386.tar.gz

cd $HOME



toilet XSS --gay

echo -e "\e[1;31;47m "Enter the domain::: " \e[1m" 

read s

waybackurls $s | gf xss | sed 's/=.*/=/' | sort -u | uniq | tee urls.txt

tee urls.txt | Gxss -p test | dalfox pipe --silence --skip-mining-dict --skip-mining-all >> output.txt
