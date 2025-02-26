#!/bin/bash

update_ipset() {
    ipset -exist create "$1" hash:net
    ipset -exist create "$2" hash:net
    ipset flush "$2"

    sed -i '/^#/d' "$3"
    while read -r line; do
        ipset add "$2" "$line"
    done < "$3"
    rm -rf "$3"

    ipset swap "$2" "$1"
    ipset destroy "$2"
}

if [ $FIREHOL_LEVEL1 -ne 0 ]; then
    wget -t 3 --no-verbose "$FIREHOL_LEVEL1_URL" -O firehol_level1.netset
    update_ipset firehol_level1 firehol_level1_netset firehol_level1.netset
fi

if [ $FIREHOL_LEVEL2 -ne 0 ]; then
    wget -t 3 --no-verbose "$FIREHOL_LEVEL2_URL" -O firehol_level2.netset
    update_ipset firehol_level2 firehol_level2_netset firehol_level2.netset
fi

if [ $FIREHOL_LEVEL3 -ne 0 ]; then
    wget -t 3 --no-verbose "$FIREHOL_LEVEL3_URL" -O firehol_level3.netset
    update_ipset firehol_level3 firehol_level3_netset firehol_level3.netset
fi

if [ $FIREHOL_LEVEL4 -ne 0 ]; then
    wget -t 3 --no-verbose "$FIREHOL_LEVEL4_URL" -O firehol_level4.netset
    update_ipset firehol_level4 firehol_level4_netset firehol_level4.netset
fi
