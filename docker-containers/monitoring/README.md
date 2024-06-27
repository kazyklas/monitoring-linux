# monitoring-linux

## Prerequisites

Before you begin you should have the following available:

1. A Grafana Cloud account. To create an account, please see Grafana Cloud and click on Start for free.
2. A Grafana Cloud API key with the Metrics Publisher role
3. A Linux machine
4. Docker and Docker Compose installed on your Linux machine

## Configure Prometheus

Edit this file (`prometheus.yaml`) to include your Grafana Cloud username,
API key, and remote_write endpoint. You can find these in the Prometheus panel of the Cloud Portal.

## Grafana

Dashboards for monitoring:
 - https://grafana.com/grafana/dashboards/12239-nvidia-dcgm-exporter-dashboard/
 - https://grafana.com/grafana/dashboards/1860-node-exporter-full/

## Links
https://grafana.com/docs/grafana-cloud/send-data/metrics/metrics-prometheus/prometheus-config-examples/docker-compose-linux/
