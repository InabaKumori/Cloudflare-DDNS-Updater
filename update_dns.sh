#!/bin/bash

while true; do
echo "Checking IP..."
# Cloudflare Details
API_KEY="mnpZFxxxxxxxxxxxxxxxxxxoX"
ZONE_ID="52bxxxxxxxxxxxxxxxxxxd6c"
RECORD_NAME="ddns.xxxxxxxxx.com"

# Fetch current public IP
CURRENT_IP=$(curl -s -4 http://ifconfig.me)

# Fetch DNS record details
RECORD=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$RECORD_NAME" \
     -H "Authorization: Bearer $API_KEY" \
     -H "Content-Type: application/json")

# Extract the existing IP
EXISTING_IP=$(echo $RECORD | jq -r '.result[0].content')

# Update DNS if IP has changed
if [ "$CURRENT_IP" != "$EXISTING_IP" ]; then
    RECORD_ID=$(echo $RECORD | jq -r '.result[0].id')
    UPDATE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
         -H "Authorization: Bearer $API_KEY" \
         -H "Content-Type: application/json" \
         --data "{\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$CURRENT_IP\"}")
    echo "Update Result:"
    echo $UPDATE | jq
else
    echo "Already up to date."
fi

sleep 60
done
