#!/bin/bash
#
# DESCRIPTION:
# This script will automatically fetch a random https website from the
# 'sites.txt' file.
# It can be used for generating random traffic or 'cover traffic'.
# This can help thwart (active) surveillance.
#
# TODO:
# - Add more then 50.000 https sites to sites.txt
#
# SUPPORT PROJECT:
# Bitcoin:
# 18ZFXYDnZthJLF2uMgDahQn9rxdHTtwrwZ
#
# Monero:
# 463DQj1ebHSWrsyuFTfHSTDaACx3WZtmMFMwb6QEX7asGyUBaRe2fHbhMchpZnaQ6XKXcHZLq8Vt1BRSLpbqdr283QinCRK

# Bash options
set -o errexit # exit script when a command fails
set -o nounset # exit script when a variable is not set

### VARIABLES ###

# General settings
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sites_file="${script_dir}"/sites.txt
min_wait=0
max_wait=3600 # 3600 seconds is 1 hour
random_wait=$(shuf -i "${min_wait}"-"${max_wait}" -n 1)
random_site=$(shuf -n 1 "${sites_file}")
socks_ip=127.0.0.1
socks_port=9050
bandwidth=500K
download_quota=2m
connection_timeout=20
max_connection_timeout=40
max_redirects=0
ciphers="EECDH+AESGCM EDH+AESGCM EECDH+AES256 EDH+AES256"

# HTTP headers
header_ua="User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0"
header_accept="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
header_lang="Accept-Language: en-US,en;q=0.5"
header_enc="Accept-Encoding: gzip, deflate"
header_con="Connection: keep-alive"

### FETCH SITE ###

# Wait for X seconds before fetching website
sleep "${random_wait}"

### curl - pre v7.34.0 ###
curl --header "${header_ua}" \
     --header "${header_accept}" \
     --header "${header_lang}" \
     --header "${header_enc}" \
     --header "${header_con}" \
     --limit-rate "${bandwidth}" \
     --connect-timeout "${connection_timeout}" \
     --max-time "${max_connection_timeout}" \
     --proto -all,+https \
     --ciphers "${ciphers}" \
     --no-sessionid \
     --ipv4 \
     --max-redirs "${max_redirects}" \
     --socks5-hostname "${socks_ip}":"${socks_port}" \
     --silent \
     https://"${random_site}" >> /dev/null

### curl - post v7.34.0 ###
#curl --header "${header_ua}" \
#     --header "${header_accept}" \
#     --header "${header_lang}" \
#     --header "${header_enc}" \
#     --header "${header_con}" \
#     --limit-rate "${bandwidth}" \
#     --connect-timeout "${connection_timeout}" \
#     --max-time "${max_connection_timeout}" \
#     --proto -all,+https \
#     --ciphers "${ciphers}" \
#     --no-sessionid \
#     --tlsv1.2 \
#     --ipv4 \
#     --max-redirs "${max_redirects}" \
#     --socks5-hostname "${socks_ip}":"${socks_port}" \
#     --silent \
#     https://"${random_site}" >> /dev/null

### Debug curl ###
#curl --header "${header_ua}" \
#     --header "${header_accept}" \
#     --header "${header_lang}" \
#     --header "${header_enc}" \
#     --header "${header_con}" \
#     --limit-rate "${bandwidth}" \
#     --connect-timeout "${connection_timeout}" \
#     --max-time "${max_connection_timeout}" \
#     --proto -all,+https \
#     --ciphers "${ciphers}" \
#     --no-sessionid \
#     --ipv4 \
#     --max-redirs "${max_redirects}" \
#     --socks5-hostname "${socks_ip}":"${socks_port}" \
#     --verbose \
#     https://"${random_site}" >> /dev/null

### wget - pre v.1.16 ###
#torify wget --header "${header_ua}" \
#            --header "${header_accept}" \
#            --header "${header_lang}" \
#            --header "${header_enc}" \
#            --header "${header_con}" \
#            --limit-rate "${bandwidth}" \
#            --timeout "${max_connection_timeout}" \
#            --secure-protocol TLSv1 \
#            --inet4-only \
#            --no-cookies \
#            --no-dns-cache \
#            --max-redirect "${max_redirects}" \
#            --quota "${download_quota}" \
#            --quiet \
#            --background \
#            --output-document - > /dev/null \
#            https://"${random_site}"

### wget - post v1.16 ###
#torify wget --header "${header_ua}" \
#            --header "${header_accept}" \
#            --header "${header_lang}" \
#            --header "${header_enc}" \
#            --header "${header_con}" \
#            --limit-rate "${bandwidth}" \
#            --timeout "${max_connection_timeout}" \
#            --secure-protocol PFS \
#            --https-only \
#            --inet4-only \
#            --no-cookies \
#            --no-dns-cache \
#            --max-redirect "${max_redirects}" \
#            --quota "${download_quota}" \
#            --quiet \
#            --background \
#            --output-document - > /dev/null \
#            https://"${random_site}"

### Debug wget ###
#torify wget --header "${header_ua}" \
#            --header "${header_accept}" \
#            --header "${header_lang}" \
#            --header "${header_enc}" \
#            --header "${header_con}" \
#            --limit-rate "${bandwidth}" \
#            --timeout "${max_connection_timeout}" \
#            --secure-protocol TLSv1 \
#            --inet4-only \
#            --no-cookies \
#            --no-dns-cache \
#            --max-redirect "${max_redirects}" \
#            --quota "${download_quota}" \
#            --debug \
#            --verbose \
#            --output-document - > /dev/null \
#            https://"${random_site}"
