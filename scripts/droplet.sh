#! /bin/bash
echo -n "name?"
read -r "name"

echo "Regions availabe: ams3,blr1,fra1,lon1,nyc3,sfo3,sgp1,tor1"
echo -n "region?"
read -r "region"

echo "sizes avalaible: s-1vcpu-1gb,s-1vcpu-1gb-intel,s-1vcpu-1gb-amd"
echo -n "size?"
read -r "size"

echo "image available: centos-7-x64 "
echo -n "image?"
read -r "image"

droplet_id=$(curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d '{"name":"'$name'","region":"'$region'","size":"'$size'","image":"'$image'","ssh_keys":[35624875],"backups":false,"ipv6":true,"user_data":null,"private_networking":null,"volumes": null,"tags":["web"]}' "https://api.digitalocean.com/v2/droplets" | jq '.droplet.id')
sleep 30
echo "$droplet_id"
IP=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/droplets/$droplet_id" | jq -r '.droplet.networks.v4[0].ip_address')
echo "Your new Droplet's IP address is: $IP"