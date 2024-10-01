# CaaS Project Monitoring

Evolution of Rancher Monitoring V1/V2. We call it: V3

Please read the [Application Readme](./docs/app-readme.md) for more details.

## Installation via Helm

This Helm Chart installs `kube-prometheus-spec` with some default values, configured for a hardened and safe deployment.
You can use this chart as part from rancher-monitoring from command line to install in project namespace:

```bash
helm dependency build
helm -n mynamespace upgrade -i project-monitoring -f values.yaml .
```

Or install the chart by using the packaged chart:

```bash
helm -n mynamespace upgrade -i project-monitoring -f values.yaml --repo oci://mtr.devops.telekom.de/caas/charts/caas-project-monitoring --version 1.3.0
```
