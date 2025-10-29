#!/bin/bash
set -e

echo "=== Step 1: Update system and install prerequisites ==="
sudo apt update -y
sudo apt install -y apt-transport-https ca-certificates curl gpg

echo "=== Step 2: Disable swap (Kubernetes requirement) ==="
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

echo "=== Step 3: Install and configure containerd ==="
sudo apt install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml > /dev/null
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "=== Step 4: Add Kubernetes apt repository ==="
sudo mkdir -p /etc/apt/keyrings
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" \
| sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "=== Step 5: Update apt and install kubeadm, kubelet, kubectl ==="
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "=== Step 6: Enable and start kubelet ==="
sudo systemctl enable kubelet
sudo systemctl start kubelet

echo "=== Installation complete! ==="
echo "Versions:"
kubectl version --client --output=yaml || true
kubeadm version || true
kubelet --version || true

echo ""
echo "✅ Kubernetes components installed successfully!"
echo "You can now initialize the control plane with:"
echo "  sudo kubeadm init --pod-network-cidr=10.244.0.0/16"
echo ""
