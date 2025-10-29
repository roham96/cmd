# Remove old repo
sudo rm /etc/apt/sources.list.d/kubernetes.list

# Add correct repo
echo "deb [signed-by=/usr/share/keyrings/k8s-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-jammy main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update
sudo apt-get update

# Install specific version
K8S_VERSION="1.34.1-00"
sudo apt-get install -y kubelet=${K8S_VERSION} kubeadm=${K8S_VERSION} kubectl=${K8S_VERSION}

# Hold version
sudo apt-mark hold kubelet kubeadm kubectl

# Enable kubelet
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Verify
kubectl version --client
kubeadm version
kubelet --version
