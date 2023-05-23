{{/* vim: set filetype=mustache: */}}

{{- define "pulsar.admin.secret" -}}
{{- default (print .Values.clusterName "-neuron-pulsar-token-rbi-neuron-p-admin") .Values.clusterAdminSecretName -}}
{{- end -}}
