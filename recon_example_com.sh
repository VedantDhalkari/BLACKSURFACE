#!/bin/bash
# CYBER OPS V6.0 RECONNAISSANCE SCRIPT
# Target: example.com
# Generated: 2026-01-05T00:39:23.088Z

TARGET="example.com"
OUTPUT_DIR="recon_${TARGET}_$(date +%Y%m%d_%H%M%S)"
mkdir -p "${OUTPUT_DIR}" && cd "${OUTPUT_DIR}"

echo "[*] Starting reconnaissance on ${TARGET}"
echo "[*] Output directory: ${OUTPUT_DIR}"

# Subdomain enumeration
echo "[+] Phase 1: Subdomain Discovery"
subfinder -d "${TARGET}" -o subfinder.txt
amass enum -passive -d "${TARGET}" -o amass.txt
assetfinder --subs-only "${TARGET}" > assetfinder.txt

# Merge and deduplicate
cat *.txt | sort -u > all_subs.txt
echo "[+] Found $(wc -l < all_subs.txt) unique subdomains"

# DNS resolution
echo "[+] Phase 2: DNS Resolution"
massdns -r resolvers.txt -o S -w resolved.txt < all_subs.txt

# Live host detection
echo "[+] Phase 3: Live Host Detection"
cat resolved.txt | cut -d' ' -f1 | httpx -title -sc -tech-detect -o live_hosts.txt

# Port scanning
echo "[+] Phase 4: Port Scanning"
naabu -list live_hosts.txt -top-ports 100 -o ports.txt

# Web crawling
echo "[+] Phase 5: Web Crawling"
cat live_hosts.txt | katana -d 3 -o crawled_urls.txt

# Vulnerability scanning
echo "[+] Phase 6: Vulnerability Assessment"
nuclei -list live_hosts.txt -s critical,high -o nuclei_critical.txt

# Screenshots
echo "[+] Phase 7: Visual Reconnaissance"
cat live_hosts.txt | aquatone -out screenshots

echo "[*] Reconnaissance complete!"
echo "[*] Results saved in: ${OUTPUT_DIR}"
echo "[*] Summary:"
echo "    - Subdomains: $(wc -l < all_subs.txt)"
echo "    - Live hosts: $(wc -l < live_hosts.txt)"
echo "    - Vulnerabilities: $(wc -l < nuclei_critical.txt)"
