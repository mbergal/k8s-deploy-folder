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

{{- define "init-container-win" }}

image: "registry.k8s.local/windows-7z"
volumeMounts:
- name: startup
  mountPath: c:/etc/startup
  readOnly: true
- name: config
  mountPath: c:/config
  readOnly: false
{{ range $path, $bytes := .Files.Glob "helm-data/data.zip.**"  }}
- name: {{ base $path | replace "." "-" }}
  mountPath: c:/etc/initial-data/{{ base $path }}
  readOnly: true
{{ end }}


{{- end }}

{{- define "init-volumes" }}

- name: config
  emptyDir: {}
- name: startup
  configMap:
    name: init-container-startup
{{ range $path, $bytes := .Files.Glob "helm-data/data.zip.**"  }}
- name: {{ base $path | replace "." "-" }}
  configMap:
    name: {{ base $path }}-win
{{ end }}

{{- end }}