#!/bin/bash
## change to "bin/sh" when necessary



auth_email="{{ (keepassxc "Cloudflare/auth_email").Password }}"                       # The email used to login 'https://dash.cloudflare.com'
auth_method="{{ (keepassxc "Cloudflare/auth_method").Password }}"                     # Set to "global" for Global API Key or "token" for Scoped API Token
auth_key="{{ (keepassxc "Cloudflare/auth_key").Password }}"                           # Your API Token or Global API Key
zone_identifier="{{ (keepassxc "Cloudflare/zone_identifier").Password }}"             # Can be found in the "Overview" tab of your domain
sitename="{{ (keepassxc .cfloc.site).Password }}"                                 # Title of site "Example Site"
record_name="{{ (keepassxc .cfloc.record).Password }}"                                # Which record `you want to be synced
ttl="{{ (keepassxc "Cloudflare/ttl").Password }}"                                     # Set the DNS TTL (seconds)
proxy="{{ (keepassxc "Cloudflare/proxy").Password }}"                                 # Set the proxy to true or false
slackchannel="{{ (keepassxc "Cloudflare/slackchannel").Password }}"                   # Slack Channel #example
slackuri="{{ (keepassxc "Cloudflare/slackuri").Password }}"                           # URI for Slack WebHook "https://hooks.slack.com/services/xxxxx"
discorduri="{{ (keepassxc "Cloudflare/discorduri").Password }}"                       # URI for Discord WebHook "https://discordapp.com/api/webhooks/xxxxx"


###########################################
## Check if we have a public IP
###########################################
REGEX_IPV4="^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$"
IP_SERVICES=(
  "https://api.ipify.org"
  "https://ipv4.icanhazip.com"
  "https://ipinfo.io/ip"
)

# Try all the ip services for a valid IPv4 address
for service in ${IP_SERVICES[@]}; do
  RAW_IP=$(curl -s $service)
  if [[ $RAW_IP =~ $REGEX_IPV4 ]]; then
    CURRENT_IP=$BASH_REMATCH
    logger -s "DDNS Updater: Fetched IP $CURRENT_IP"
    break
  else
    logger -s "DDNS Updater: IP service $service failed."
  fi
done

# Exit if IP fetching failed
if [[ -z "$CURRENT_IP" ]]; then
  logger -s "DDNS Updater: Failed to find a valid IP."
  exit 2
fi

###########################################
## Check and set the proper auth header
###########################################
if [[ "${auth_method}" == "global" ]]; then
  auth_header="X-Auth-Key:"
else
  auth_header="Authorization: Bearer"
fi

###########################################
## Seek for the A record
###########################################

logger "DDNS Updater: Check Initiated"
record=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?type=A&name=$record_name" \
                      -H "X-Auth-Email: $auth_email" \
                      -H "$auth_header $auth_key" \
                      -H "Content-Type: application/json")

###########################################
## Check if the domain has an A record
###########################################
if [[ $record == *"\"count\":0"* ]]; then
  logger -s "DDNS Updater: Record does not exist, perhaps create one first? (${CURRENT_IP} for ${record_name})"
  exit 1
fi

###########################################
## Get existing IP
###########################################
old_ip=$(echo "$record" | sed -E 's/.*"content":"(([0-9]{1,3}\.){3}[0-9]{1,3})".*/\1/')
# Compare if they're the same
if [[ $CURRENT_IP == $old_ip ]]; then
  logger "DDNS Updater: IP ($CURRENT_IP) for ${record_name} has not changed."
  exit 0
fi

###########################################
## Set the record identifier from result
###########################################
record_identifier=$(echo "$record" | sed -E 's/.*"id":"([A-Za-z0-9_]+)".*/\1/')

###########################################
## Change the IP@Cloudflare using the API
###########################################
update=$(curl -s -X PATCH "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$record_identifier" \
                     -H "X-Auth-Email: $auth_email" \
                     -H "$auth_header $auth_key" \
                     -H "Content-Type: application/json" \
                     --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$CURRENT_IP\",\"ttl\":$ttl,\"proxied\":${proxy}}")

###########################################
## Report the status
###########################################
case "$update" in
*"\"success\":false"*)
  echo -e "DDNS Updater: $CURRENT_IP $record_name DDNS failed for $record_identifier ($CURRENT_IP). DUMPING RESULTS:\n$update" | logger -s
  if [[ $slackuri != "" ]]; then
    curl -L -X POST $slackuri \
    --data-raw '{
      "channel": "'$slackchannel'",
      "text" : "'"$sitename"' DDNS Update Failed: '$record_name': '$record_identifier' ('$CURRENT_IP')."
    }'
  fi
  if [[ $discorduri != "" ]]; then
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST \
    --data-raw '{
      "content" : "'"$sitename"' DDNS Update Failed: '$record_name': '$record_identifier' ('$CURRENT_IP')."
    }' $discorduri
  fi
  exit 1;;
*)
  logger "DDNS Updater: $CURRENT_IP $record_name DDNS updated."
  if [[ $slackuri != "" ]]; then
    curl -L -X POST $slackuri \
    --data-raw '{
      "channel": "'$slackchannel'",
      "text" : "'"$sitename"' Updated: '$record_name''"'"'s'""' new IP Address is '$CURRENT_IP'"
    }'
  fi
  if [[ $discorduri != "" ]]; then
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST \
    --data-raw '{
      "content" : "'"$sitename"' Updated: '$record_name''"'"'s'""' new IP Address is '$CURRENT_IP'"
    }' $discorduri
  fi
  exit 0;;
esac
