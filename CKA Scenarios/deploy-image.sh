# Create a deployment named “apache” that uses the image httpd:2.4.54 and contains three pod replicas
kubectl create deployment apache --image=httpd:2.4.54 --replicas=3

# Scale the deployment named 'apache' from 3 replicas to 5.

kubectl scale deployment apache --replicas=5

# Change the image used for the pods in the 'apache' deployment to httpd:alpine .
k set image deploy apache httpd=httpd:latest httpd=httpd:alpine

k get deploy apache -o yaml | grep image


