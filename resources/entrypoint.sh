#!/bin/sh

echo "${IPSETS_UPDATE_SCHEDULE} /usr/local/bin/ipsets-update.sh" > /etc/crontabs/ipsets-update

/usr/local/bin/ipsets-update.sh

exec "$@"