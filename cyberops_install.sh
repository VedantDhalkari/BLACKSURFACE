#!/bin/bash
# CYBER OPS V6.0 AUTO-INSTALLER
# Automated environment setup for penetration testing

echo "[*] CYBER OPS V6.0 INSTALLATION INITIATED"
echo "[*] System Preparation..."

# Update system
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget python3 python3-pip python3-venv golang-go     nmap masscan nikto sqlmap john hashcat hydra metasploit-framework     docker.io docker-compose build-essential libssl-dev libffi-dev

# Configure Go environment
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.bashrc

# Install Go tools
echo "[*] Installing Go-based tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/owasp-amass/amass/v3/...@master
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/ffuf/ffuf@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/assetfinder@latest

# Install Python tools
echo "[*] Installing Python tools..."
pip3 install arjun droopescan xsstrike commix jwt-tool
pip3 install scoutsuite cloudsploit pacu

# Download wordlists
echo "[*] Downloading security wordlists..."
mkdir -p ~/wordlists
git clone https://github.com/danielmiessler/SecLists.git ~/wordlists/SecLists
git clone https://github.com/berzerk0/Probable-Wordlists.git ~/wordlists/Probable-Wordlists

# Setup directories
mkdir -p ~/tools ~/reports ~/scans

echo "[*] Installation complete!"
echo "[*] Please restart your terminal or run: source ~/.bashrc"
echo "[*] CYBER OPS V6.0 READY FOR DEPLOYMENT"
