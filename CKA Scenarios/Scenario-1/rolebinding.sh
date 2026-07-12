# create a service account named dev
kubectl create sa dev

# create a role binding named 'dev-view-binding' to allow the 'dev' service account to view resources in the default namespace
kubectl create rolebinding dev-view-binding --clusterrole=view --serviceaccount=default:dev --namespace=default

# verify the 'dev' service account can view pods in the default namespace
kubectl auth can-i get po --namespace default --as=system:serviceaccount:default:dev

# verify the 'dev' service account can view services in the default namespace
kubectl auth can-i get svc --namespace default --as=system:serviceaccount:default:dev

# verify that the 'dev' service account CANNOT view the pods in the 'kube-system' namespace
kubectl auth can-i get po --namespace kube-system --as=system:serviceaccount:default:dev

############################################################################################################################
# Create a new cluster role named “acme-corp-clusterrole” that can create deployments, replicasets and daemonsets.
# create a cluster role named 'acme-corp-clusterrole' and add the verb 'create' for deployments(deploy), replicaSets(rs), and daemonSets(ds)


kubectl create clusterrole acme-corp-clusterrole --verb=create --resource=deploy,rs,ds

# view the newly created role
# create a role binding named 'acme-corp-role-binding', add 'acme-corp-clusterrole' role and 'Sandra' user
kubectl -n default create rolebinding acme-corp-role-binding --clusterrole=acme-corp-clusterrole --serviceaccount=default:secure-sa

# list the newly created cluster role and role binding
kubectl get clusterrole,rolebinding

# using 'auth can-i', verify that you can create deployments as the 'secure-sa' service account in the default namespace
kubectl auth can-i create deploy --namespace default --as=system:serviceaccount:default:secure-sa

# using 'auth can-i', verify that you CANNOT delete daemonSets as the 'secure-sa' service account in the kube-system namespace 
kubectl auth can-i delete ds --namespace kube-system --as=system:serviceaccount:default:secure-sa

