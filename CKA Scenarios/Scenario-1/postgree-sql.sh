# In this scenario, you'll be able to practice installing a postgreSQL database operator in Kubernetes!
Once you have forked this repo, you can clone your forked repo with the following commands:L

# set your username
export GITHUB_USERNAME="<your-github-username>"
# clone the repo
git clone --depth 1 "https://github.com/${GITHUB_USERNAME}/postgres-operator-examples.git"

# change directory 
cd postgres-operator-examples
You can install PGO, the Postgres Operator from Crunchy Data, using the following command.

kubectl apply -k kustomize/install/namespace
kubectl apply --server-side -k kustomize/install/default
This will create a namespace called postgres-operator  and create all of the objects required to deploy PGO.

To check on the status of your installation, you can run the following command.

k -n postgres-operator get po -w

k get crds | grep postgres
# If the PGO Pod is healthy, you should see output similar to this.

# NAME                                READY   STATUS    RESTARTS   AGE
# postgres-operator-9dd545d64-t4h8d   1/1     Running   0          3s
