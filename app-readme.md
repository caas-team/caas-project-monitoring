# Abstract

CaaS Project Monitoring v3 is the evolution of Rancher Project Monitoring V1/V2 and should improve the usage of a monitoring stack with a simple and secure deployment. Based on the community project [kube-prometheus-spec](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) the components Prometheus, Alertmanager, and
Grafana will be installed in a namespaced manner. Cluster metrics are fetched via federate from Cluster Rancher Monitoring.

# Preconditions

* This app available in app catalog within Git repo or Helm chart repo

* Installed [Rancher Monitoring](https://github.com/rancher/charts/tree/release-v2.7/charts/rancher-monitoring) in the cluster incl. the [rancher-monitoring-crd](https://github.com/rancher/charts/tree/release-v2.7/charts/rancher-monitoring-crd). Important is the usage of the same CRD version between cluster-monitoring and project-monitoring.
Ask the administrator for the installed version. CRDs may have new features or values.

* Extension of the V2 cluster-monitoring with [prometheus-auth](https://github.com/caas-team/prometheus-auth/tree/fix/boundtoken). This includes additional container in prometheus statefulset, service endpoint, cluster role for access additional like subjectaccessreviews and tokenreviews.

* Installed [Navlinks Webhook](https://github.com/eumel8/navlinkswebhook) to appear weblinks of the Project Monitoring in Rancher menu.

* Networkpolicies to protect anonymous endpoints (used by cluster-monitoring self and v2 project-monitoring with [prometheus-federator](https://github.com/rancher/prometheus-federator)

* Additional permissions for Project-Owner, assigned from administrator within RoleTemplate:

```yaml
apiVersion: management.cattle.io/v3
builtin: false
context: project
displayName: CaaS-Project-Monitoring-Admin
external: false
hidden: false
kind: RoleTemplate
metadata:
  annotations:
    cleanup.cattle.io/rtUpgradeCluster: 'true'
roleTemplateNames:
  - project-owner
rules:
  - apiGroups:
      - monitoring.coreos.com
    resources:
      - alertmanagers
      - prometheuses
    verbs:
      - create
      - delete
      - get
      - list
      - patch
      - update
      - watch
```

# Usage

kube-prometheus-stack will installed in a project namespace with Project-Owner permissions + the additional permissions above.
With default settings at least install namespace are covered with metrics, permitted by the ServiceAccountToken in the Prometheus Pod. If the install namespace is in a project, all other namespaces are also covered by the token permission.
For additonal Prometheus targets with ServiceMonitor in other project namespaces or AlertmanagerConfigs this namespaces must by listed in `caas.projectNamespaces` Prometheus discovery can be limited, e.g.

```yaml
   ruleNamespaceSelector:
      matchLabels:
        field.cattle.io/projectId: p-q8bp8
    serviceMonitorNamespaceSelector:
      matchLabels:
        field.cattle.io/projectId: p-q8bp8
    podMonitorNamespaceSelector:
      matchLabels:
        field.cattle.io/projectId: p-q8bp8
    probeNamespaceSelector:
      matchLabels:
        field.cattle.io/projectId: p-q8bp8
```

