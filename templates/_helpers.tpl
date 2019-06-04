{{- define "init-container" }}

image: "registry.k8s.local/ubuntu-zip"
volumeMounts:
- name: startup
  mountPath: /etc/startup
  readOnly: true
- name: config
  mountPath: /config
  readOnly: false
{{ range $path, $bytes := .Files.Glob "helm-data/data.zip.**"  }}
- name: {{ base $path | replace "." "-" }}
  mountPath: /etc/initial-data/{{ base $path }}
  subPath: {{ base $path }}
  readOnly: true
{{ end }}


{{- end }}