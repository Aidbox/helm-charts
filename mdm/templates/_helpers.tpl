{{/*
Expand the name of the chart.
*/}}
{{- define "mdm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mdm.fullname" -}}
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
Returns full release name + "-frontend"
*/}}
{{- define "mdm.frontendName" -}}
{{- $fullname := include "mdm.fullname" . -}}
{{- if hasSuffix "-frontend" $fullname -}}
{{- $fullname -}}
{{- else -}}
{{- printf "%s-frontend" $fullname -}}
{{- end -}}
{{- end }}

{{/*
Returns full release name + "-backend"
*/}}
{{- define "mdm.backendName" -}}
{{- $fullname := include "mdm.fullname" . -}}
{{- if hasSuffix "-backend" $fullname -}}
{{- $fullname -}}
{{- else -}}
{{- printf "%s-backend" $fullname -}}
{{- end -}}
{{- end }}

{{/*
Frontend-specific labels
*/}}
{{- define "mdm.frontendLabels" -}}
helm.sh/chart: {{ include "mdm.chart" . }}
{{ include "mdm.frontendSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Frontend selector labels
*/}}
{{- define "mdm.frontendSelectorLabels" -}}
app.kubernetes.io/name: {{ include "mdm.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Backend-specific labels
*/}}
{{- define "mdm.backendLabels" -}}
helm.sh/chart: {{ include "mdm.chart" . }}
{{ include "mdm.backendSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "mdm.backendSelectorLabels" -}}
app.kubernetes.io/name: {{ include "mdm.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mdm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mdm.labels" -}}
helm.sh/chart: {{ include "mdm.chart" . }}
{{ include "mdm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mdm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mdm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mdm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mdm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
