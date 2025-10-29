#!/bin/bash
# =========================================
# Kubernetes Installation & Setup Script
# =========================================

# 1. Extract Kubernetes client and move binaries
tar -xzvf kubernetes-client-linux-amd64.tar.gz
sudo mv kubernetes/client/bin/kubectl /usr/local/bin/
sudo chmod +x /usr/local/bin/kubectl

# Verify kubectl
kubectl version --client

# 2. Extract Kubernetes server and move binaries
tar -xzvf kubernetes-server-linux-amd64.tar.gz
sudo mv kubernetes/server/bin/kubeadm /usr/local/bin/
sudo mv kubernetes/server/bin/kubelet /usr/local/bin/
sudo chmod +x /usr/local/bin/{kubeadm,kubelet}

# Verify kubeadm and kubelet
kubeadm version
kubelet --version

# 3. Initialize Kubernetes cluster (single-node example)
# Adjust --pod-network-cidr according to CNI plugin you plan to use
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# 4. Set up kubeconfig for the current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 5. (Optional) Install a CNI plugin
# Example: Flannel
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

echo "Kubernetes setup completed successfully!"
echo "You can check nodes with: kubectl get nodes"
