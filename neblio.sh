#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 
BLUE='\033[1;34m'
CYAN='\033[1;36m'

#Intro
clear

echo -e "${CYAN}                                 '/\' 
                               '/    \'
                              '/      \'
                            '/          \'
	                  '/      /\      \'
                         '/     /    \     \'
                        '|    /        \    |'
                        '|   |          |   |'
                        '|   |       ${BLUE}/\ ${CYAN}|   |'
                        '|   |       ${BLUE}\/ ${CYAN}|   |' 
                        '|    \        /    |'     
	                 '\     \    /     /' 
                          '\      \/      /'
                            '\          /'
		              '\      /'
                               '\    /'
		                 '\/'${NC}" 
echo -e "                       
                         ${CYAN}Neblio Wallet 3.2.1${NC}"
sleep 2s
echo -e "${GREEN}I will download required dependencies to run nebliod...${NC}"
sleep 1s

#Dependencies
sudo apt-get update && sudo apt-get install git python python-pip qt5-default qt5-qmake qtbase5-dev-tools \
qttools5-dev-tools build-essential libssl-dev libdb++-dev libminiupnpc-dev \
libqrencode-dev libcurl4-openssl-dev libldap2-dev libidn11-dev librtmp-dev libsodium-dev -y
pip install requests
sleep 1s 
echo -e "${GREEN}DONE! ${NC}"
sleep 1s

#Neblio daemon server node
echo -e "${GREEN}Downloading the nebliod wallet...${NC}"
wget -N https://github.com/NeblioTeam/neblio/releases/download/v3.2.1/2021-04-27---v3.2.1-76605e2---nebliod---ubuntu16.04.tar.gz
tar -xvf 2021-04-27---v3.2.1-76605e2---nebliod---ubuntu16.04.tar.gz
rm -rf 2021-04-27---v3.2.1-76605e2---nebliod---ubuntu16.04.tar.gz
sudo chmod -R 755 nebliod
echo -e "${GREEN}Neblio node server wallet has been downloaded!${NC}"
sleep 1s

#Directory with neblio.conf
echo -e "${GREEN}Creating directory and neblio.conf${NC}"
mkdir .neblio
cat <<EOF > ~/.neblio/neblio.conf
rpcuser=coldstaking
rpcpassword=coldstaking

EOF

#Install htop
apt install htop

#Starting the wallet
sleep 2s
echo -e "${GREEN}Starting nebliod as daemon process${NC}"
./nebliod -daemon=1 -debug=0 -debugnet=0 -shrinkdebugfile=1
sleep 2s
echo -e "${GREEN}Wallet is running! Wait for quicksync to be completed!${NC}"
sleep 1s
echo -e "${RED}This process may take up to 20 minutes!${NC}"
echo -e "${GREEN}Keep checking your debug.log file${NC}"
sleep 1s
rm -rf neblio.sh
echo -e "${YELLOW}Removing the script file from directory${NC}"
