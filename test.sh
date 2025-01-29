declare -a tcp_ports=(21 22 53 57 80 123 443 1000 1645 1646 3389 5432 5433 10000)
for port in "${tcp_ports[@]}"; do
    ufw allow "$port"/tcp
done