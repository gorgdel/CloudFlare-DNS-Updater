#!/bin/sh

# add your zone here
zone='examplezone.com'

# add your dns records here
dns[0]='example1.examplezone.com'
dns[1]='example2.examplezone.com'
dns[2]='example3.examplezone.com'
dns[3]='example4.examplezone.com'
dns[4]='example5.examplezone.com'

# credentials for api key/email
email='YOUR-EMAIL'
key='YOUR-API-KEY'

# get your current ISP IPv4
ip=$(curl -s -X GET https://checkip.amazonaws.com)

echo "Current IP is $ip"


for i in ${dns[@]}

do
zoneid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$zone&status=active" \
  -H "Authorization: Bearer $key" \
  -H "Content-Type: application/json")

dnsrecordid=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records?type=A&name=$i" \
  -H "X-Auth-Email: $email" \
  -H "Authorization: Bearer $key" \
  -H "Content-Type: application/json")

curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $email" \
  -H "Authorization: Bearer $key" \  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$i\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":true}"

  
done






