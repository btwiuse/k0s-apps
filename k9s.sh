kubectl create serviceaccount k9s-serviceaccount
kubectl create clusterrole k9s-clusterrole --verb='*' --resource='*' 
kubectl create clusterrolebinding k9s-clusterrolebinding --serviceaccount=default:k9s-serviceaccount --clusterrole=k9s-clusterrole

kubectl run -it --rm k9s --image=latestarch/linux --restart=Never --serviceaccount=k9s-serviceaccount --command /bin/bash
kubectl run -it --rm k9s --image=derailed/k9s --restart=Never --serviceaccount=k9s-serviceaccount --command '["/bin/bash", "-c"]' -- echo hello k9s
kubectl run -it --rm k9s --image=derailed/k9s --restart=Never --serviceaccount=k9s-serviceaccount --command /bin/sh -- -c apk add curl bash; curl https://get.k0s.io/install.sh | bash; ~/.k0s/bin/k0s agent -cmd 'while :; do reset; env TERM=xterm-256color k9s; sleep 1; done' -verbose

# kubectl get clusterrolebinding/k9s-clusterrolebinding -o yaml > k9s-crb
# kubectl get clusterrole/k9s-clusterrole -o yaml > k9s-cr
# kubectl get serviceaccount/k9s-serviceaccount -o yaml > k9s-sa
