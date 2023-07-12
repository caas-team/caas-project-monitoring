{{/*
Expand the name of the chart.
*/}}
{{- define "caas-project-monitoring.name" -}}
  {{- default .Chart.Name .Values.caas.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "caas-project-monitoring.namespace" -}}
  {{- if .Values.caas.namespaceOverride -}}
    {{- .Values.caas.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "caas-project-monitoring.fullname" -}}
{{- if .Values.caas.fullnameOverride }}
{{- .Values.caas.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.caas.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "fullname" -}}
{{- $fullname := include "caas-project-monitoring.fullname" . }}
{{- printf "%s" $fullname }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "caas-project-monitoring.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "caas-project-monitoring.labels" -}}
helm.sh/chart: {{ include "caas-project-monitoring.chart" . }}
{{ include "caas-project-monitoring.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "caas-project-monitoring.selectorLabels" -}}
app.kubernetes.io/name: {{ include "caas-project-monitoring.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "caas-project-monitoring.serviceAccountName" -}}
{{- if .Values.caas.rbac.serviceAccount.create }}
{{- default (include "caas-project-monitoring.fullname" .) .Values.caas.rbac.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.caas.rbac.serviceAccount.name }}
{{- end }}
{{- end }}

