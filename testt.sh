#!/bin/bash

#The following steps are for installing the kubernetes cluster on ubuntu 18

#PLEASE RUN THE FOLLWOING COMMANDS ON ALL THE SERVERS(MASTER AND NODES)

#step 1
#Adding the key docker gpg key for docker repo

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

#At this point all the servers (master and node) are configured with all requirement

#RUN THE GIVEN COMMAND ONLY ON MASTER NODE

#step9
#Adding a underlying network for k8s to communicate with each otehr

sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#This command may take few minutes since most of the k8s files will be downloaded
#On succesfull completion the you will get an output, to start you k8s cluter, so simply copy ans paste that in master server.

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Also save the final command which says "kubeadm join................." somewhere so we can use it later on for connecting a nodes to master. 

#Until now we have created a a single node kubernetes cluster with master but it the status of the master will be "NotReady" since we have not created the underline flannel network

#Step10
#adding a flaneel network

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml


#now run the saved "kubeadm join....." command on each nodes


#To test the connection use the following command and check for the status of nodes and master

kubectl get nodes
