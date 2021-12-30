# Introduction
As part of the [Digital Ocean Kubernetes Challenge](https://www.digitalocean.com/community/pages/kubernetes-challenge) I've decided to take on the challenge of deploying a log monitoring system. To accomplish this, I'll be using Grafana Loki and Promtail to get logs from a sample MongoDB deployment and then display them using Grafana.

# Components
[Grafana Loki](https://grafana.com/oss/loki/) - Grafana Loki is a log aggregation system which stores and processes logs. It's unique in that it can be queried for logs much like [Prometheus](https://prometheus.io/) and that it mainly stores the metadata of logs to cut down on log size and thereby cost/storage space.

[Promtail](https://grafana.com/docs/loki/latest/clients/promtail/) - Promtail retrieves logs and sends them to Grafana Loki. Promtail automatically discovers logs using a ```scrape_configs``` configuration much like Prometheus. 

[Grafana](https://grafana.com/docs/) - Grafana is used to display logs or metrics. Grafana Loki has a native integration with Grafana which is utilized in this project via ```grafana-dashboard/grafana-dashboardDatasources.yaml```. These datasources can be changed to include other popular datasources like Prometheus, Jaeger, or MongoDB itself. 

MongoDB Test Target - For this challenge I've decided to use MongoDB as a test target which will generate logs for Grafana Loki/Promtail. The files I used for this deployment come from an [article written by Bibin Wilson and Shishir Khandelwal](https://devopscube.com/deploy-mongodb-kubernetes/). I highly recommend giving it a read if you have time, it's quite well written and was very useful. 

# Prerequisites
- [kubectl](https://kubernetes.io/docs/tasks/tools/) - Used to deploy and manage almost everything Kubernetes
- Kubernetes cluster(s) - You can either host your own cluster or [spin one up in Digital Ocean](https://www.digitalocean.com/products/kubernetes/)
- [Lens](https://k8slens.dev/) - Lens is a way to easily view your cluster ina GUI, it's not technically required for this but I'd highly recommend it

# Connecting to a Digital Ocean Kubernetes Cluster
First, download your cluster config file:
![image](https://user-images.githubusercontent.com/42356848/147760721-6f7b7ad7-2361-4490-865a-94395580c241.png)

Open Lens and click *File* -> *Add Cluster* 
![image](https://user-images.githubusercontent.com/42356848/147760984-974bc232-23e5-455e-8fdf-f5820d3ca898.png)

Paste in the contents of your cluster config file into Lens:
![image](https://user-images.githubusercontent.com/42356848/147761048-f251a67d-b85a-4da1-931b-c896c3ab71c7.png)

This will create a new Kubernetes cluster for you in Lens which you connect to by clicking on it and then clicking the link symbol:
![image](https://user-images.githubusercontent.com/42356848/147761137-a703d511-d7dc-4039-9c17-4ad4d164ed18.png)

# Deployment


Open a terminal by clicking the *+* in the bottom left and select *Terminal*
![image](https://user-images.githubusercontent.com/42356848/147761789-75bca302-01ce-4cc3-b2d4-bb7e6a7a4b36.png)

Simply clone this repository by using the ```git clone https://github.com/nickzas/do-kubernetes-challenge-2021.git``` command and run the ```quick-deploy.sh``` script:
![image](https://user-images.githubusercontent.com/42356848/147762296-57900aa1-ce1d-4626-acb0-698ab6783d35.png)

Navigate to *Workloads* -> *Pods* and set it to view to *All Namespaces* so you can see your pods come up in real time:
![image](https://user-images.githubusercontent.com/42356848/147761360-d2d7d6cb-f7ea-4c8a-af6f-78a70f8bac0f.png)







