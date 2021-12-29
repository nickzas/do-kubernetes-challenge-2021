kubectl apply -f setup/
wait 5 #The setup folder needs to be applied first because it has the prerequisite namespaces for all other folders
kubectl apply -f loki-promtail/
kubectl apply -f test-target/
kubectl apply -f grafana-dashboard/