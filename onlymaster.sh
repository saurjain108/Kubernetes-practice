sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#This command may take few minutes since most of the k8s files will be downloaded
#On succesfull completion the you will get an output, to start you k8s cluter, so simply copy ans paste that in master server.

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

