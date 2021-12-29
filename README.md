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

