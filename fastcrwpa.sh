#!/bin/bash
[[ -z "$1" ]] && { echo "usage: ./fastcrwpa <pcap file(s)> <wordlist(s)>"; exit 1; }
[[ -z "$2" ]] && WORDLIST="" || WORDLIST=${2##*/}
PCAP_FILE=$1
HASH_22000=${PCAP_FILE##*/}.22000

function_notify () {
	sudo -u $(id -un) DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus notify-send -t $1 -u $2 "${3}"
}

WORDLISTS_DIR=/tmp/wordlists
UNCRACKED_HASH_DIR=/tmp/hashes
CRACKED_HASH_DIR=/tmp/cracked_hashes


mkdir -p ${UNCRACKED_HASH_DIR}
rm -f ${UNCRACKED_HASH_DIR}/*
mkdir -p ${CRACKED_HASH_DIR}
hcxpcapngtool -o ${UNCRACKED_HASH_DIR}/${HASH_22000} $1


nvidia-docker run --gpus all -it \
	-v ${UNCRACKED_HASH_DIR}:/hashes \
	-v ${WORDLISTS_DIR}:/wl \
	dizcza/docker-hashcat:opencl-cuda \
	hashcat -m 22000 -a0 -w3 --status --status-timer 30 \
	-o /hashes/${HASH_22000}.result \
	/hashes/${HASH_22000} \
	/wl/${WORDLIST}

RC=$?
[[ "${RC}" == 0 ]] \
	&& { echo "success"; function_notify "8000" "critical" "Hash: ${HASH_22000} cracked successfuly"; \
	sudo chown $(id -un):$(id -un) ${UNCRACKED_HASH_DIR}/${HASH_22000}.result; mv ${UNCRACKED_HASH_DIR}/${HASH_22000}.result ${CRACKED_HASH_DIR}/${HASH_22000}.result; } \
	|| { [[ "${RC}" == 1 ]] && function_notify "8000" "normal" "Hash: ${HASH_22000} NOT cracked"; }
