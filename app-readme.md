# Abstract

CaaS Project Monitoring v3 is the evolution of Rancher Project Monitoring V1/V2 and should improve the usage of a monitoring stack with a simple and secure deployment. Based on the community project [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) the components Prometheus, Alertmanager, and
Grafana will be installed in a namespaced manner. Cluster metrics are fetched via federate from Cluster Rancher Monitoring.

# Preconditions

* This app available in app catalog within Git repo or Helm chart repo. Generate an access token with read\_repo permissions, if the repo requires authorization.

* Installed [Rancher Monitoring](https://github.com/rancher/charts/tree/release-v2.7/charts/rancher-monitoring) in the cluster incl. the [rancher-monitoring-crd](https://github.com/rancher/charts/tree/release-v2.7/charts/rancher-monitoring-crd). Important is the usage of the same CRD version between cluster-monitoring and project-monitoring.
Ask the administrator for the installed version. CRDs may have new features or values.

* Extension of the V2 cluster-monitoring with [prometheus-auth](https://github.com/caas-team/prometheus-auth/tree/fix/boundtoken). This includes additional container in prometheus statefulset, service endpoint, cluster role for access additional like subjectaccessreviews and tokenreviews.

<details>
<summary>code snippet</summary>

### prometheus

```yaml
  prometheus:
    additionalRulesForClusterRole:
    - apiGroups:
      - ""
      resources:
      - namespaces
      - nodes
      - nodes/metrics
      - services
      - endpoints
      - pods
      - secrets
      verbs:
      - get
      - list
      - watch
    - apiGroups:
      - networking.k8s.io
      resources:
      - ingresses
      verbs:
      - get
      - list
      - watch
    - nonResourceURLs:
      - /metrics
      - /metrics/cadvisor
      verbs:
      - get
    - apiGroups:
      - authentication.k8s.io
      resources:
      - tokenreviews
      verbs:
      - get
      - list
      - create
      - update
      - delete
      - watch
    - apiGroups:
      - authorization.k8s.io
      resources:
      - subjectaccessreviews
      verbs:
      - get
      - list
      - create
      - update
      - delete
      - watch
  prometheusSpec:
    containers: |
    - args:
      - --proxy-url=http://127.0.0.1:9090
      - --listen-address=$(POD_IP):9091
      - --filter-reader-labels=prometheus
      - --filter-reader-labels=prometheus_replica
      - --log.debug=true
      command:
      - prometheus-auth
      env:
      - name: POD_IP
        valueFrom:
          fieldRef:
            fieldPath: status.podIP
      image: mtr.devops.telekom.de/caas/prometheus-auth:0.4.1
      name: prometheus-agent
      ports:
      - containerPort: 9091
        name: http-auth
        protocol: TCP
      resources:
        limits:
          cpu: 500m
          memory: 500Mi
        requests:
          cpu: 100m
          memory: 500Mi
    service:
      additionalPorts:
      - name: http-auth
        port: 9091
        protocol: TCP
        targetPort: http-auth
```
</details>

* Installed [Navlinks Webhook](https://github.com/eumel8/navlinkswebhook) to appear weblinks of the Project Monitoring in Rancher menu.

* Networkpolicies to protect anonymous endpoints (used by cluster-monitoring self and v2 project-monitoring with [prometheus-federator](https://github.com/rancher/prometheus-federator)

<details>
<summary>code snippet</summary>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-prometheus-auth
  namespace: cattle-monitoring-system
spec:
  ingress:
  - ports:
    - port: 9091
      protocol: TCP
  podSelector: {}
  policyTypes:
  - Ingress
```
</details>


* The CaaS Project Owner must be assigned to the user installing the app. It provides the additional permissions for the project monitoring stack:

<details>
<summary>code snippet</summary>

### rancher

```yaml
rules:
  - apiGroups:
      - monitoring.coreos.com
      - monitoring.cattle.io
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

# Usage

kube-prometheus-stack will installed in a project namespace with Project-Owner permissions + the additional permissions above.
With default settings at least install namespace are covered with metrics, permitted by the ServiceAccountToken in the Prometheus Pod. If the install namespace is in a project, all other namespaces are also covered by the token permission.

To monitor additional Prometheus targets with `ServiceMonitors` and/or `AlertmanagerConfigs` in other project namespaces, those namespaces **must** by listed in `caas.projectNamespaces`.

<details>
<summary>code snippet</summary>

### helm values

Change at least the kube-prometheus-stack selectors to target the namespaces of your project:

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

</details>
