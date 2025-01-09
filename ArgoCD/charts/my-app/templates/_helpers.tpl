{{- define "my-helm-chart.name" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}

{{- define "my-helm-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "my-helm-chart.labels" -}}
app: {{ .Chart.Name }}
release: {{ .Release.Name }}
{{- end -}}