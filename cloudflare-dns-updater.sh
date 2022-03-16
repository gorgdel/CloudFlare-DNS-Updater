#!/bin/sh

zone='dellas.id.au'
dns[0]='dellas.id.au'
dns[1]='home.dellas.id.au'
dns[2]='print.dellas.id.au'
dns[3]='steam.dellas.id.au'
dns[4]='vaultwarden.dellas.id.au'


email='YOUR-EMAIL'
key='YOUR-API-KEY'

ip=$(curl -s -X GET https://checkip.amazonaws.com)

echo "Current IP is $ip"


for i in ${dns[@]}

do
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
  -H "Authorization: Bearer $key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')

dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$i" \
  -H "X-Auth-Email: $email" \
  -H "Authorization: Bearer $key" \
  -H "Content-Type: application/json" | jq -r '{"result"}[] | .[0] | .id')
  echo $dnsrecordid
  echo $i

curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $email" \
  -H "Authorization: Bearer $key" \  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$i\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":true}" | jq

  
done






