#!/usr/bin/env bash
set -e

GODADDY_DDNS_DIR="$(dirname $0)"
OLD_PUBLIC_IP_FILE="$GODADDY_DDNS_DIR/public-ip.old"

PUBLIC_IP=$(curl -s http://ipv4.icanhazip.com)
if [[ -e $OLD_PUBLIC_IP_FILE ]]; then
    OLD_PUBLIC_IP=$(cat $OLD_PUBLIC_IP_FILE)
    if [[ "$OLD_PUBLIC_IP" = "$PUBLIC_IP" ]]; then
        echo "The public IP didn't change. We don't need to update the DNS"
        exit 0
    fi
fi

$GODADDY_DDNS_DIR/godaddy_ddns.py %$GODADDY_DDNS_DIR/godaddy-ddns.config
echo $PUBLIC_IP > $OLD_PUBLIC_IP_FILE
