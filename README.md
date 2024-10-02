# caas-project-monitoring

A Helm chart for Rancher Project Monitoring V3.
Please read the [Application Readme](./docs/app-readme.md) for more details.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| eumel8 | <f.kloeker@telekom.de> | <https://www.telekom.com> |
| puffitos | <bruno.bressi@telekom.de> | <https://www.telekom.com> |

## Source Code

* <https://github.com/caas-team/caas-project-monitoring>
* <https://github.com/prometheus-community/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 58.4.0 |

## Installation

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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| caas.fullnameOverride | string | `""` |  |
| caas.grafana.configmaps | bool | `true` | Whether to deploy additional nginx.conf and dashboard for Grafana |
| caas.nameOverride | string | `""` |  |
| caas.namespaceOverride | string | `""` | If not set, the namespace will be the same as the release namespace |
| caas.projectNamespaces | string | `""` | Example projectNamespaces: demoapp3 demoapp4 |
| caas.rbac.enabled | bool | `true` | Must be enabled if multiple namespaces are monitored |
| caas.rbac.serviceAccount.create | bool | `true` |  |
| caas.rbac.serviceAccount.name | string | `"project-monitoring"` | The name of the serviceAccount to use for all components |
| global.cattle.clusterId | string | `""` | Not necessary in deployment via the Rancher UI App store |
| global.cattle.projectId | string | `"p-xxxxx"` | or if you provide it here, it can be used as a default label for all resources |
| global.cattle.systemDefaultRegistry | string | `""` |  |
| global.imageRegistry | string | `"mtr.devops.telekom.de"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.alertmanagerConfigNamespaceSelector.matchLabels."field.cattle.io/projectId" | string | `"p-xxxxx"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.alertmanagerConfigSelector.matchExpressions[0].key | string | `"release"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.alertmanagerConfigSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.alertmanagerConfigSelector.matchExpressions[0].values[0] | string | `"rancher-monitoring"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.image.repository | string | `"kubeprometheusstack/alertmanager"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.resources.limits.cpu | string | `"800m"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.resources.limits.memory | string | `"750Mi"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.resources.requests.cpu | string | `"100m"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.resources.requests.memory | string | `"200Mi"` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.securityContext.fsGroup | int | `2000` |  |
| kube-prometheus-stack.alertmanager.alertmanagerSpec.securityContext.supplementalGroups[0] | int | `1000` |  |
| kube-prometheus-stack.alertmanager.config.route.routes[0].matchers[0] | string | `"alertname =~ \"InfoInhibitor|Watchdog\""` |  |
| kube-prometheus-stack.alertmanager.config.route.routes[0].receiver | string | `"null"` |  |
| kube-prometheus-stack.alertmanager.serviceMonitor.interval | string | `"30s"` |  |
| kube-prometheus-stack.commonLabels | object | `{"field.cattle.io/projectId":"p-xxxxx"}` | Labels to add to all deployed resources |
| kube-prometheus-stack.coreDns.enabled | bool | `false` |  |
| kube-prometheus-stack.defaultRules.create | bool | `true` | Whether to deploy the default rules |
| kube-prometheus-stack.defaultRules.disabled | object | `{"KubeletDown":true}` | Disabled PrometheusRule alerts |
| kube-prometheus-stack.defaultRules.rules.etcd | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.k8s | bool | `true` |  |
| kube-prometheus-stack.defaultRules.rules.kubeApiserverAvailability | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeApiserverBurnrate | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeApiserverHistogram | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeApiserverSlos | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeControllerManager | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubePrometheusNodeRecording | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeProxy | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubeScheduler | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.kubelet | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.node | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.nodeExporterAlerting | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.nodeExporterRecording | bool | `false` |  |
| kube-prometheus-stack.defaultRules.rules.prometheusOperator | bool | `false` |  |
| kube-prometheus-stack.fullnameOverride | string | `"project-monitoring"` |  |
| kube-prometheus-stack.global.rbac.create | bool | `false` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.anonymous".enabled | bool | `true` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.anonymous".org_role | string | `"Viewer"` |  |
| kube-prometheus-stack.grafana."grafana.ini"."auth.basic".enabled | bool | `false` |  |
| kube-prometheus-stack.grafana."grafana.ini".analytics.check_for_updates | bool | `false` |  |
| kube-prometheus-stack.grafana."grafana.ini".auth.disable_login_form | bool | `false` |  |
| kube-prometheus-stack.grafana."grafana.ini".log.level | string | `"info"` |  |
| kube-prometheus-stack.grafana."grafana.ini".security.allow_embedding | bool | `true` | Required to embed dashboards in Rancher Cluster Overview Dashboard on Cluster Explorer |
| kube-prometheus-stack.grafana."grafana.ini".users.auto_assign_org_role | string | `"Viewer"` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.privileged | bool | `false` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.runAsGroup | int | `472` |  |
| kube-prometheus-stack.grafana.containerSecurityContext.runAsUser | int | `472` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].access | string | `"proxy"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].isDefault | bool | `true` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].name | string | `"Prometheus"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| kube-prometheus-stack.grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://prometheus-operated:9090"` |  |
| kube-prometheus-stack.grafana.defaultDashboardsEnabled | bool | `false` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[0].emptyDir | object | `{}` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[0].name | string | `"nginx-home"` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[1].configMap.items[0].key | string | `"nginx.conf"` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[1].configMap.items[0].mode | int | `438` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[1].configMap.items[0].path | string | `"nginx.conf"` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[1].configMap.name | string | `"nginx-proxy-config-project-monitoring-grafana"` |  |
| kube-prometheus-stack.grafana.extraContainerVolumes[1].name | string | `"grafana-nginx"` |  |
| kube-prometheus-stack.grafana.extraContainers | string | `"- name: grafana-proxy\n  args:\n  - nginx\n  - -g\n  - daemon off;\n  - -c\n  - /nginx/nginx.conf\n  image: mtr.devops.telekom.de/kubeprometheusstack/nginx:1.23.2-alpine\n  ports:\n  - containerPort: 8080\n    name: nginx-http\n    protocol: TCP\n  resources:\n    limits:\n      cpu: 100m\n      memory: 100Mi\n    requests:\n      cpu: 50m\n      memory: 50Mi\n  securityContext:\n    allowPrivilegeEscalation: false\n    capabilities:\n      drop:\n      - ALL\n    privileged: false\n    runAsUser: 101\n    runAsGroup: 101\n    readOnlyRootFilesystem: true\n  volumeMounts:\n  - mountPath: /nginx\n    name: grafana-nginx\n  - mountPath: /var/cache/nginx\n    name: nginx-home\n"` |  |
| kube-prometheus-stack.grafana.forceDeployDashboards | bool | `true` |  |
| kube-prometheus-stack.grafana.forceDeployDatasources | bool | `true` |  |
| kube-prometheus-stack.grafana.fullnameOverride | string | `"project-monitoring-grafana"` |  |
| kube-prometheus-stack.grafana.image.repository | string | `"kubeprometheusstack/grafana"` |  |
| kube-prometheus-stack.grafana.initChownData.enabled | bool | `false` |  |
| kube-prometheus-stack.grafana.nameOverride | string | `"project-monitoring-grafana"` |  |
| kube-prometheus-stack.grafana.rbac.create | bool | `false` |  |
| kube-prometheus-stack.grafana.rbac.namespaced | bool | `true` |  |
| kube-prometheus-stack.grafana.resources.limits.cpu | string | `"600m"` |  |
| kube-prometheus-stack.grafana.resources.limits.memory | string | `"600Mi"` |  |
| kube-prometheus-stack.grafana.resources.requests.cpu | string | `"200m"` |  |
| kube-prometheus-stack.grafana.resources.requests.memory | string | `"200Mi"` |  |
| kube-prometheus-stack.grafana.securityContext.fsGroup | int | `472` |  |
| kube-prometheus-stack.grafana.securityContext.runAsGroup | int | `472` |  |
| kube-prometheus-stack.grafana.securityContext.runAsUser | int | `472` |  |
| kube-prometheus-stack.grafana.securityContext.supplementalGroups[0] | int | `472` |  |
| kube-prometheus-stack.grafana.service.port | int | `80` |  |
| kube-prometheus-stack.grafana.service.portName | string | `"nginx-http"` |  |
| kube-prometheus-stack.grafana.service.targetPort | int | `8080` |  |
| kube-prometheus-stack.grafana.serviceAccount.create | bool | `false` |  |
| kube-prometheus-stack.grafana.serviceAccount.name | string | `"project-monitoring"` |  |
| kube-prometheus-stack.grafana.serviceMonitor.interval | string | `"30s"` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.enabled | bool | `true` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.labelValue | string | `"1"` |  |
| kube-prometheus-stack.grafana.sidecar.dashboards.searchNamespace | string | `""` |  |
| kube-prometheus-stack.grafana.sidecar.datasources.defaultDatasourceEnabled | bool | `false` |  |
| kube-prometheus-stack.grafana.sidecar.datasources.label | string | `"grafana_datasource"` |  |
| kube-prometheus-stack.grafana.sidecar.datasources.labelValue | string | `"1"` |  |
| kube-prometheus-stack.grafana.sidecar.image.repository | string | `"kubeprometheusstack/k8s-sidecar"` |  |
| kube-prometheus-stack.grafana.sidecar.resources.limits.cpu | string | `"200m"` |  |
| kube-prometheus-stack.grafana.sidecar.resources.limits.memory | string | `"200Mi"` |  |
| kube-prometheus-stack.grafana.sidecar.resources.requests.cpu | string | `"50m"` |  |
| kube-prometheus-stack.grafana.sidecar.resources.requests.memory | string | `"50Mi"` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.privileged | bool | `false` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.runAsGroup | int | `472` |  |
| kube-prometheus-stack.grafana.sidecar.securityContext.runAsUser | int | `472` |  |
| kube-prometheus-stack.grafana.testFramework.enabled | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.prometheus.monitor.enabled | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.prometheus.monitor.honorLabels | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.rbac.create | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.releaseLabel | bool | `false` |  |
| kube-prometheus-stack.kube-state-metrics.selfMonitor.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeApiServer.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeControllerManager.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeDns.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeEtcd.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeProxy.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeScheduler.enabled | bool | `false` |  |
| kube-prometheus-stack.kubeStateMetrics.enabled | bool | `false` |  |
| kube-prometheus-stack.kubelet.enabled | bool | `false` |  |
| kube-prometheus-stack.nameOverride | string | `"project-monitoring"` |  |
| kube-prometheus-stack.nodeExporter.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.prometheus.monitor.enabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.rbac.pspEnabled | bool | `false` |  |
| kube-prometheus-stack.prometheus-node-exporter.releaseLabel | bool | `false` |  |
| kube-prometheus-stack.prometheus.enabled | bool | `true` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].bearer_token_file | string | `"/var/run/secrets/kubernetes.io/serviceaccount/token"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].honor_labels | bool | `true` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].job_name | string | `"federate"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].metrics_path | string | `"/federate"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].params.match[][0] | string | `"{__name__=~\".+\"}"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].scrape_interval | string | `"30s"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.additionalScrapeConfigs[0].static_configs[0].targets[0] | string | `"rancher-monitoring-prometheus.cattle-monitoring-system.svc:9091"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.evaluationInterval | string | `"30s"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.image.registry | string | `"mtr.devops.telekom.de"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.image.repository | string | `"kubeprometheusstack/prometheus"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.paused | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorNamespaceSelector | object | `{}` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelector.matchExpressions[0].key | string | `"release"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelector.matchExpressions[0].values[0] | string | `"rancher-monitoring"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.portName | string | `"http-web"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.prometheusExternalLabelName | string | `""` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.prometheusExternalLabelNameClear | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.prometheusRulesExcludedFromEnforce | list | `[]` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.query | object | `{}` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.queryLogFile | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.remoteRead | list | `[]` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.remoteWrite | list | `[]` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.remoteWriteDashboards | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.replicaExternalLabelName | string | `""` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.replicaExternalLabelNameClear | bool | `false` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.replicas | int | `1` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.limits.cpu | string | `"1000m"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.limits.memory | string | `"1000Mi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.requests.cpu | string | `"400m"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.resources.requests.memory | string | `"400Mi"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.retention | string | `"10d"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.routePrefix | string | `"/"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleNamespaceSelector | object | `{}` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleSelector.matchExpressions[0].key | string | `"release"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.ruleSelector.matchExpressions[0].values[0] | string | `"rancher-monitoring"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeInterval | string | `"30s"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.scrapeTimeout | string | `"10s"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.securityContext.fsGroup | int | `2000` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.securityContext.supplementalGroups[0] | int | `1000` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorNamespaceSelector | object | `{}` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelector.matchExpressions[0].key | string | `"release"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelector.matchExpressions[0].operator | string | `"NotIn"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelector.matchExpressions[0].values[0] | string | `"rancher-monitoring"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.shards | int | `1` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.storageSpec | object | `{}` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.tsdb.outOfOrderTimeWindow | string | `"5m"` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.volumeMounts | list | `[]` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.volumes | list | `[]` |  |
| kube-prometheus-stack.prometheus.prometheusSpec.walCompression | bool | `true` |  |
| kube-prometheus-stack.prometheus.serviceAccount.create | bool | `false` |  |
| kube-prometheus-stack.prometheus.serviceAccount.name | string | `"project-monitoring"` | The name of the serviceAccount to use for all components |
| kube-prometheus-stack.prometheus.serviceMonitor.interval | string | `"30s"` |  |
| kube-prometheus-stack.prometheusOperator.enabled | bool | `false` |  |
| kube-prometheus-stack.thanosRuler.enabled | bool | `false` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

