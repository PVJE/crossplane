{{/*
Expand the name of the chart.
*/}}
{{- define "own-crossplane-vpc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "own-crossplane-vpc.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "own-crossplane-vpc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "own-crossplane-vpc.labels" -}}
helm.sh/chart: {{ include "own-crossplane-vpc.chart" . }}
{{ include "own-crossplane-vpc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "own-crossplane-vpc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "own-crossplane-vpc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "own-crossplane-vpc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "own-crossplane-vpc.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/* genarate project tags */}}
{{- define "project.tags" }}
{{- range $key, $value := $.Values.projectTags }}
- key: {{ $key }} 
  value: {{ toYaml $value }}
{{- end }}
{{- end }}

{{/* genarate project names */}}
{{- define "project.names" }}
{{- range $key, $value := $.Chart.projectTags }}
- key: {{ $key }} 
  value: {{ toYaml $value }}
{{- end }}
{{- end }}

{{/* generate subnet tags for nb */}}
{{- define "nb.tags" }}
- key: "kubernetes.io/role/internal-elb"
  value: "1"
{{- end }}

{{/* create labels for object */}}
{{- define "project.labels" }}
{{- range $key, $value := . }}
{{- $key }}: {{ $value }}
{{- end }}
{{- end }}