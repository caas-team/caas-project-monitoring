# CaaS Project Monitoring

Evolution of Rancher Monitoring V1/V2. We call it: V3

Please read the [Application Readme](./app-readme.md) for more details.

## Installation via Helm

This Helm Chart installs `kube-prometheus-spec` with some default values, configured for a hardenend and safe deployment.
You can use this chart as part from rancher-monitoring from command line to install in project namespace:

```bash
helm dependency build
helm -n mynamespace upgrade -i project-monitoring -f values.yaml --skip-crds .
```

remote install:

```bash
helm -n mynamespace upgrade -i project-monitoring -f values.yaml --skip-crds --repo oci://mtr.devops.telekom.de/caas/charts/caas-project-monitoring --version 0.0.19
```

Note: the bundle in this repo doesn't contain the crds directory, because helm-operation from Rancher can't set `--skip-crds` flag

Debug kube-prometheus-spec

```yaml
kube-prometheus-spec:
  alertmanager:
    alertmanagerSpec:
      logLevel: debug
  grafana:
    grafana.ini:
      log:
        level: debug
  prometheus:
    prometheusSpec:
      logLevel: debug
```
