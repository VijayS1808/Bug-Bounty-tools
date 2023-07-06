#!/bin/bash

apt install figlet -y
apt install toilet -y

toilet BBT --gay

ls

 echo -e "\e[1;31;47m .......@Tool made by "Vijay Sutar" \e[1m" 
 
 ls

echo -e "\e[31m Let's start!!!\e[0m"

echo -e "\e[34m Updating...\e[0m"

apt update -y

echo -e "\e[34m Installing golang ...\e[0m"

sudo apt install golang -y

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

echo -e "\e[34m Installing waybackurls ...\e[0m"

go install github.com/tomnomnom/waybackurls@latest

echo -e "\e[34m Installing nuclei ...\e[0m"

go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo -e "\e[34m Installing gau ...\e[0m"

go install github.com/lc/gau/v2/cmd/gau@latest


cd $HOME


echo -e "\e[34m Installing qsreplace ...\e[0m"

go install github.com/tomnomnom/qsreplace@latest

echo -e "\e[34m Installing httprobe ...\e[0m"


go install github.com/tomnomnom/httprobe@latest

echo -e "\e[34m Installing httpx ...\e[0m"

go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo -e "\e[34m Installing dalfox ...\e[0m"

go install github.com/hahwul/dalfox/v2@latest
 cd $HOME
echo -e "\e[34m Installing nuclei-templates ...\e[0m"

git clone https://github.com/projectdiscovery/nuclei-templates.git

echo -e "\e[34m Installing photon ...\e[0m"

pip3 install photon -y

echo -e "\e[34m Installing arjun ...\e[0m"

pip3 install arjun
cd $HOME

echo -e "\e[34m ..............Go to Directory "go/bin"...\e[0m"

cd go/bin
mv -v waybackurls nuclei gau qsreplace httpx httprobe dalfox /usr/bin
cd $HOME

clear


cd Bug-Bounty-tools
mv -v  gcloud.sh xss.sh $HOME
cd $HOME



mkdir .gf
git clone https://github.com/1ndianl33t/Gf-Patterns



mv ~/Gf-Patterns/*.json ~/.gf

cd $HOME







