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
# hash must be the full path to hash
# wordlist name must be the name of the file in the directory specified in the WORDLISTS_DIR variable aka basename of abs path
./fastcrwpa.sh <hash/hashes> <wordlist/wordlists>

# example
./fastcrwpa.sh /tmp/obtained_hashes/somehash.pcap rockyou.txt.gz
```

tested on NVIDIA GeForce GTX 1650 with Max-Q Design
