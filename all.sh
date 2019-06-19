curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#step-2
#Adding a docker repository

sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#step-3
#Now add the gpg key for k8s repo

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#step4
#Adding a repository information in sources.list

sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list

#step5
#Update the system

sudo apt-get update

#step6
#Installing a stable and compatible version of kublet kubeadm and kubectl

sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu kubelet=1.12.7-00 kubeadm=1.12.7-00 kubectl=1.12.7-00


#step7
#If you do not want to update or upgrade the k8s componemt, hold them by

sudo apt-mark hold docker-ce kubelet kubeadm kubectl


#step8
#Adding a network pluggins or sysctl value required for k8s networking and added it to /etc/sysctl/conf file for making it permanant

echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf

#Now to name this setting effective immediately run

sudo sysctl -p
