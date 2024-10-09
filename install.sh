#!/bin/bash
read -p "Enter pasword for access to server: " P
sed -i "s|<password>|$P|g" docker-compose.yml
docker-compose up -d
docker cp vpn-ssh-server:/etc/passwd passwd
sed -i 's|:/config:|:/dev/null:|g' passwd
docker stop vpn-ssh-server
docker cp passwd vpn-ssh-server:/etc/passwd
docker start vpn-ssh-server
echo "Done. Login with:"
echo "ssh vpnuser@<your_server_ip> -p 2222"
echo "Password: $P"
