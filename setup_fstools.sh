#!/bin/bash
# ===============================================================
# Ubuntu 22.04.5 LTS - Full Stack Environment Installer
# Categories: Dev / DevOps / Network / DB / API / Monitoring
# ===============================================================

set -e

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing base utilities..."
sudo apt install -y \
build-essential \
git \
curl \
wget \
vim \
nano \
zip unzip \
htop \
jq \
python3 python3-pip python3-venv \
nodejs npm \
openjdk-17-jdk \
maven \
gradle \
golang \
clang \
g++ \
cmake \
make \
autoconf automake \
pkg-config \
shellcheck \
fish zsh tmux screen tree \
gnupg ca-certificates lsb-release lsof fzf tar p7zip-full bat neofetch

echo "⚙️ Installing DevOps & automation tools..."
sudo apt install -y \
ansible \
terraform \
vagrant \
docker.io \
docker-compose \
podman \
kubectl \
helm \
minikube \
jenkins \
gitlab-runner \
prometheus \
grafana \
bmon \
iftop \
nmon \
nload \
sysstat \
nginx \
apache2 \
ufw \
fail2ban \
certbot python3-certbot-nginx \
supervisor \
etckeeper

echo "🌐 Installing network & security tools..."
sudo apt install -y \
net-tools \
iproute2 \
dnsutils \
traceroute \
mtr \
nmap \
tcpdump \
wireshark \
iperf3 \
ethtool \
whois \
telnet \
ssh \
openssh-server \
openvpn \
wireguard \
iptables \
netcat-openbsd \
socat

# Optional security / penetration tools
sudo apt install -y \
hydra \
john \
aircrack-ng \
nikto \
metasploit-framework || true

echo "🗃️ Installing database systems..."
sudo apt install -y \
mysql-server \
postgresql postgresql-contrib \
sqlite3 \
redis-server \
mongodb \
mariadb-server \
etcd \
influxdb \
couchdb

echo "🧩 Installing database clients and tools..."
sudo apt install -y \
pgadmin4 \
mysql-client \
redis-tools \
mongosh

echo "🔌 Installing API development & testing tools..."
sudo apt install -y \
httpie \
curl \
jq \
netcat \
python3-requests \
python3-flask \
python3-fastapi \
gunicorn \
uvicorn \
sqlite3

# Optional: Postman (usually via snap)
if command -v snap &> /dev/null; then
  echo "Installing Postman via snap..."
  sudo snap install postman
fi

echo "🧠 Installing monitoring & logging tools..."
sudo apt install -y \
prometheus \
grafana \
node-exporter \
cadvisor \
loki \
rsyslog \
logrotate

echo "✅ Installation completed successfully!"
echo "🧩 You can now use: Docker, Jenkins, Grafana, Prometheus, kubectl, Ansible, etc."
echo "🚀 Enjoy your full DevOps + Development environment!"

