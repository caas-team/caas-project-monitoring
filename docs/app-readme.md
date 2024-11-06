# CaaS Project Monitoring

CaaS Project Monitoring v3 is the evolution of Rancher Project Monitoring V1/V2 and should improve the usage of a monitoring stack with a simple and secure deployment. Based on the community project [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) the components Prometheus, Alertmanager, and
Grafana are installed in the user's namespace. 

The deployed prometheus uses the central cluster prometheus' federate endpoint to scrape metrics only related to the user's project. Additional `ServiceMonitors`, `PodMonitors` and `AlertmanagerConfigs` (as well as all other `coreos` custom resources) can be created in the user's namespace to monitor and alert on the user's resources.

## Usage

Installing this chart will install a copy of the kube-prometheus-stack in a rancher project namespace. With default settings at least install namespace are covered with metrics, permitted by the ServiceAccountToken in the Prometheus Pod. If the install namespace is in a project, all other namespaces are also covered by the token permission.

To make sure the deployed `prometheus` and `alertmanager` instances can work properly and scrape your `ServiceMonitors`, `AlertmanagerConfigs` and all other `coreos` custom resources as well, make sure to add your `projectId` to the values.yaml file.

```yaml
kube-prometheus-stack:
  alertmanager:
    alertmanagerSpec:
      alertmanagerConfigNamespaceSelector:
        matchLabels:
          field.cattle.io/projectId: p-xxxxx
  prometheus:
    prometheusSpec:
      podMonitorNamespaceSelector:
        matchLabels:
          field.cattle.io/projectId: p-xxxxx
      probeNamespaceSelector:
        matchLabels:
          field.cattle.io/projectId: p-xxxxx
      ruleNamespaceSelector:
        matchLabels:
          field.cattle.io/projectId: p-xxxxx
      serviceMonitorNamespaceSelector:
        matchLabels:
          field.cattle.io/projectId: p-xxxxx
```

To monitor additional Prometheus targets with `ServiceMonitors` and/or `AlertmanagerConfigs` in **other** project namespaces, those namespaces **must** by listed in `caas.projectNamespaces`.

### Debug

If you need to debug the various components, you can set the log level for each component in the values.yaml file:

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

## Preconditions for the cluster operator

* This app available in app catalog within Git repo or Helm chart repo. Generate an access token with read\_repo permissions, if the repo requires authorization.

* An installed version of [CaaS Cluster Monitoring](https://github.com/caas-team/caas-cluster-monitoring)
  * It is important that the `coreos` CRDs, which are installed in the cluster, are compatible with the `kube-prometheus-stack` version of this chart. If not, the installation may fail.

* An installed version of the [Navlinks Webhook](https://github.com/eumel8/navlinkswebhook), to create weblinks of the Project Monitoring in Rancher sidebar menu.

* The CaaS Project Owner must be assigned to the user installing the app. It provides the additional permissions for the project monitoring stack:

<details>
<summary>code snippet</summary>

```yaml
rules:
  - apiGroups:
      - monitoring.coreos.com
    resources:
      - alertmanagers
      - alertmanagerconfigs
      - prometheuses
    verbs:
      - create
      - delete
      - get
      - list
      - patch
      - update
      - view
      - watch
```

</details>

## Development

If you need to make any changes to the chart, you should follow this general development process:

1. Change any files needed for the chart.
2. Update any dependencies by using the Chart.yaml, if needed.
3. Update the README.md.gotmpl, if needed.
4. Update the app-readme.md, if needed.
5. Run `make chart` to prepare the chart for packaging.
6. Open a PR with the changes.
