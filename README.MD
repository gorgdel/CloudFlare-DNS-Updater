# CloudFlare DNS Auto Update - Linux

Auto updates cloudflare records. 

To change record type/proxy 

```shell
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zoneid/dns_records/$dnsrecordid" \
  -H "X-Auth-Email: $email" \
  -H "Authorization: Bearer $key" \  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$i\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":true}"
  ```

```shell
  --data "{\"type\":\"A\",\"name\":\"$i\",\"content\":\"$ip\",\"ttl\":1,\"proxied\":true}"
```
Change "A" to the type of record you need.

proxied - true/false

# Usage 

```shell
bash cloudflare-dns-updater.sh
```
