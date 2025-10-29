#!/bin/bash
set -e

# === نسخه Kubernetes ===
K8S_VERSION="v1.34.1"
echo "=== Installing Kubernetes version $K8S_VERSION from mirror ==="

# === Step 1: Update system and install dependencies ===
sudo apt-get update -y
sudo apt-get install -y curl apt-transport-https ca-certificates gnupg lsb-release

# === Step 2: Disable swap ===
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# === Step 3: Load required kernel modules ===
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sudo sysctl --system

# === Step 4: Download binaries from GitHub mirror ===
BINARIES=("kubectl" "kubeadm" "kubelet")
INSTALL_DIR="/usr/local/bin"
mkdir -p ~/k8s-bin
cd ~/k8s-bin

for binary in "${BINARIES[@]}"; do
    echo "Downloading $binary..."
    # لینک GitHub release رسمی
    URL="https://github.com/kubernetes/kubernetes/releases/download/${K8S_VERSION}/bin/linux/amd64/${binary}"
    # fallback به mirror کره‌ای (در صورت خطای 403)
    curl -fLO "$URL" || curl -fLO "https://mirror.kakao.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/${binary}"
    chmod +x $binary
    sudo mv $binary $INSTALL_DIR/
done

# === Step 5: Enable kubelet service ===
sudo systemctl enable kubelet.service
sudo systemctl start kubelet.service

# === Step 6: Verify installation ===
echo "=== Installed versions ==="
kubectl version --client
kubeadm version
kubelet --version

echo "✅ Kubernetes tools installed successfully!"
