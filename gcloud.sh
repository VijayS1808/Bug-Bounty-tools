





#!/bin/bash

apt install figlet -y
apt install toilet -y


echo -e "\e[33m @ ...............Tool made by @Vijay Sutar@ \e[0m"

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

apt install photon -y

echo -e "\e[34m Installing arjun ...\e[0m"

pip3 install arjun
cd $HOME

echo -e "\e[34m ..............Go to Directory "go/bin"...\e[0m"

cd go/bin
mv -v waybackurls nuclei gau qsreplace httpx httprobe dalfox /usr/bin
cd $HOME
clear


cd Bug-Bounty-tools

go get -u github.com/tomnomnom/gf

cd $HOME

cd gopath/bin

mv -v gf /usr/bin

cd $HOME

git clone https://github.com/1ndianl33t/Gf-Patterns

mkdir .gf

mv ~/Gf-Patterns/*.json ~/.gf
