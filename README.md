# Introduction
As part of the [DigitalOcean Kubernetes Challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge) I've decided to take on the challenge of deploying a log monitoring system. To accomplish this, I'll be using Grafana Loki and Promtail to get logs from a sample MongoDB deployment and then display them using Grafana.

# Components
[Grafana Loki](https://grafana.com/oss/loki/) - Grafana Loki is a log aggregation system which stores and processes logs. It's unique in that it can be queried for logs much like [Prometheus](https://prometheus.io/) and that it mainly stores the metadata of logs to cut down on log size and thereby cost/storage space.

[Promtail](https://grafana.com/docs/loki/latest/clients/promtail/) - Promtail retrieves logs and sends them to Grafana Loki. Promtail automatically discovers logs using a ```scrape_configs``` configuration much like Prometheus. 

[Grafana](https://grafana.com/docs/) - Grafana is used to display logs or metrics. Grafana Loki has a native integration with Grafana which is utilized in this project via ```grafana-dashboard/grafana-dashboardDatasources.yaml```. These datasources can be changed to include other popular datasources like Prometheus, Jaeger, or MongoDB itself. 

MongoDB Test Target - For this challenge I've decided to use MongoDB as a test target which will generate logs for Grafana Loki/Promtail. The files I used for this deployment come from an [article written by Bibin Wilson and Shishir Khandelwal](https://devopscube.com/deploy-mongodb-kubernetes/). I highly recommend giving it a read if you have time, it's quite well written and was very useful. 

# Prerequisites
- [kubectl](https://kubernetes.io/docs/tasks/tools/) - Used to deploy and manage almost everything Kubernetes
- Kubernetes cluster - You can either host your own cluster or [spin one up in Digital Ocean](https://www.digitalocean.com/products/kubernetes/)
- [Lens](https://k8slens.dev/) - Lens is a way to easily view and interact with your cluster in a GUI, it's not technically required for this but I'd highly recommend it

# Connecting to a Digital Ocean Kubernetes Cluster
First, download your cluster config file:
![image](https://user-images.githubusercontent.com/42356848/147760721-6f7b7ad7-2361-4490-865a-94395580c241.png)

Open Lens and click *File* -> *Add Cluster* 
![image](https://user-images.githubusercontent.com/42356848/147760984-974bc232-23e5-455e-8fdf-f5820d3ca898.png)

Paste in the contents of your cluster config file into Lens:
![image](https://user-images.githubusercontent.com/42356848/147761048-f251a67d-b85a-4da1-931b-c896c3ab71c7.png)

This will display your Kubernetes cluster for you in Lens which you connect to by clicking on the cluster name and then clicking the link symbol:
![image](https://user-images.githubusercontent.com/42356848/147761137-a703d511-d7dc-4039-9c17-4ad4d164ed18.png)

# Deployment


Open a terminal by clicking the *+* in the bottom left and select *Terminal*
![image](https://user-images.githubusercontent.com/42356848/147761789-75bca302-01ce-4cc3-b2d4-bb7e6a7a4b36.png)

Simply clone this repository by using the ```git clone https://github.com/nickzas/do-kubernetes-challenge-2021.git``` command and run the ```quick-deploy.sh``` script:
![image](https://user-images.githubusercontent.com/42356848/147762296-57900aa1-ce1d-4626-acb0-698ab6783d35.png)

Navigate to *Workloads* -> *Pods* and set it to view to *All Namespaces* so you can see your pods come up in real time:
![image](https://user-images.githubusercontent.com/42356848/147761360-d2d7d6cb-f7ea-4c8a-af6f-78a70f8bac0f.png)

After a few minutes you should have a *MongoDB* and * MongoDB client* pod, a *Grafana* pod, a *Loki-stack* pod, and one *Loki-stack-Promtail* pod per node in your cluster. Promtail needs to be on each node in the cluster to gather all available logs, as a result Promtail is deployed as a DaemonSet which automatically deploys it on each node.
![image](https://user-images.githubusercontent.com/42356848/147768836-8d58d93e-851c-436e-8647-f7a73c0a164a.png)

# Testing
To verify the logging system works, click the Grafana pod in Lens and click the *http:3000/TCP* hyperlink which will automatically portforward Grafana to a random port for you and open it in your default browser after a brief period:
![image](https://user-images.githubusercontent.com/42356848/147769652-1348737a-2b49-4506-afed-d691b6d721ec.png)

The default username is *admin* and the default password is *admin*, you will be prompted for a password change upon login:
![image](https://user-images.githubusercontent.com/42356848/147769820-69c1a868-c3de-4402-8b51-f11af8b0cb38.png)
![image](https://user-images.githubusercontent.com/42356848/147769864-d079f943-6d8c-443b-b2d6-01dcbebb1462.png)

Once logged into Grafana, navigate to the *Explore* section which is represented by a compass and select Loki from the drop down menu in the top left:
![image](https://user-images.githubusercontent.com/42356848/147770942-ae4778e7-e03e-4f3b-bea3-2e28bd80facb.png)

Enter ```{namespace="mongodb"}``` in the Loki query section and you'll see logs from all pods in the *mongodb* namespace:
![image](https://user-images.githubusercontent.com/42356848/147771085-663b0d72-bc1c-4d1a-b239-a585219ba53c.png)

To generate some MongoDB logs, you can first open a shell on the *mongo-client* pod using kubectl exec:
```kubectl exec --namespace=mongodb deployment/mongo-client -it -- /bin/bash```

Then log into the database:
```mongo --host mongo-nodeport-svc --port 27017 -u adminuser -p password123```
*Please note that this username/password are hardcoded in this repository purely for demonstration purposes.*

And finally add some data to the *blogs* database:
```db.blogs.insert({name: "example" })``` 

Running these commands will generate some logs for you to see Grafana.

This log comes from login made to the database:
![image](https://user-images.githubusercontent.com/42356848/147778086-e8382da2-108a-4645-b1c2-82a95d9af63d.png)

These logs come from adding to the *blogs* database:
![image](https://user-images.githubusercontent.com/42356848/147778147-620f458e-a476-4b3e-bb3f-04fdb4ca2a16.png)

# Sources
https://devopscube.com/deploy-mongodb-kubernetes/ - Used for the MongoDB test target YAML and commands to connect into the MongoDB pod for log generation

https://artifacthub.io/packages/helm/grafana/loki-stack - Used for YAML template for Grafana Loki/Promtail

https://github.com/prometheus-operator/kube-prometheus - Used for Grafana YAML template












