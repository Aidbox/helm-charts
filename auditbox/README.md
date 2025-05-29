# auditbox

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Installation

1. Prepare the configuration file.

```yaml
extraEnvFromSecrets: ["auditbox"]
config:
  ELASTIC_URI: <Elastic URI>
  AUDITBOX_BASE_URL: <Auditbox Base URL>
  IDP_AUTHORIZE_ENDPOINT: <IDP Authorize Endpoint>
  IDP_TOKEN_ENDPOINT: <IDP Token Endpoint>
  IDP_CLIENT_ID: <IDP Client ID>
  IDP_CLIENT_SECRET: <IDP Client Secret>
```

```console
helm repo add aidbox https://aidbox.github.io/helm-charts

helm upgrade --install auditbox aidbox/auditbox \
  --namespace auditbox --create-namespace \
  --values /path/to/config/file
```

It will install the Auditbox in the `auditbox` namespace, creating that namespace if it doesn't already exist.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| extraEnvFromConfigMaps | list | `[]` |  |
| extraEnvFromSecrets | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"healthsamurai/auditbox"` |  |
| image.tag | string | `"alpha"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"auditbox.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.failureThreshold | int | `100` |  |
| livenessProbe.httpGet.path | string | `"/AuditEvent"` |  |
| livenessProbe.httpGet.port | string | `"main"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.failureThreshold | int | `100` |  |
| readinessProbe.httpGet.path | string | `"/AuditEvent"` |  |
| readinessProbe.httpGet.port | string | `"main"` |  |
| replicaCount | int | `1` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"714Mi"` |  |
| securityContext | object | `{}` |  |
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
