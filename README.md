# fastcrwpa-script
Small script to automate pwnagotchi's pcap cracking using hashcat in the docker
### usage
##### Fill variables with corresponding paths on your system
```bash
WORDLISTS_DIR=/tmp/wordlists
UNCRACKED_HASH_DIR=/tmp/hashes
CRACKED_HASH_DIR=/tmp/cracked_hashes
```
##### run script
```bash
./fastcrwpa.sh <hash/hashes> <wordlist/wordlists>
```

tested on NVIDIA GeForce GTX 1650 with Max-Q Design
