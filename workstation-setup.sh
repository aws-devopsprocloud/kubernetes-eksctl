#!/bin/bash

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

sudo growpart /dev/nvme0n1 4
sudo pvresize /dev/nvme0n1p4
sudo lvextend -L +20G /dev/mapper/RootVG-varVol
sudo xfs_growfs /var
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user
sudo systemctl start docker
sudo yum install docker-compose-plugin -y
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
sudo curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
sudo tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
curl -sS https://webinstall.dev/k9s | bash


