# aidbox

[Aidbox](https://docs.aidbox.app/) is an efficient and scalable FHIR server built to handle healthcare data effectively, empowering healthcare providers and developers alike with its comprehensive platform for storing, accessing, and exchanging healthcare information in accordance with FHIR standards.

![Version: 0.1.18](https://img.shields.io/badge/Version-0.1.18-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: edge](https://img.shields.io/badge/AppVersion-edge-informational?style=flat-square)

> Important! Starting from version: 0.2.0, the repo fully switched to the new environment variable naming conventions introduced in Aidbox version: 2503.
To keep the old naming convention, stick with version: 0.1.18. More information about naming convention you can find [here](https://docs.aidbox.app/reference/settings).

## Installation

1. Obtain a [license](https://docs.aidbox.app/~/changes/cP0dGveACDeqsL8PvFlu/overview/editions-and-pricing#aidbox-licenses).
2. Prepare the configuration file. Please refer to the [Recommended Aidbox environment variables](https://docs.aidbox.app/configuration/configure-aidbox-and-multibox) for details. For the whole list of available environment variables follow [the settings documentation](https://docs.aidbox.app/reference/settings).

```yaml
host: <your host here, e.g. my.domain.tld>
protocol: <http or https>

config:
  BOX_DB_HOST: <PostgreSQL host to connect to>
  BOX_DB_DATABASE: <name of the database that is used to store resources>
  BOX_DB_USER: <PostgreSQL user>
  BOX_DB_PASSWORD: <PostgreSQL password>
```

```console
helm repo add aidbox https://aidbox.github.io/helm-charts

helm upgrade --install aidbox aidbox/aidbox \
  --namespace aidbox --create-namespace \
  --values /path/to/config/file
```

It will install the Aidbox in the `aidbox` namespace, creating that namespace if it doesn't already exist.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config | object | `{"AIDBOX_PORT":8080,"BOX_METRICS_PORT":8765,"PGPORT":5432}` | Aidbox config see [Aidbox environment variables](https://docs.aidbox.app/reference/configuration/environment-variables) for details |
| extraEnvFromConfigMaps | list | `[]` |  |
| extraEnvFromSecrets | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| host | string | `"my.domain.tld"` | Host name Aidbox will be available at |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"healthsamurai/aidboxone"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` | Optional array of imagePullSecrets containing private registry credentials # Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.defaultPath | string | `"/"` |  |
| ingress.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `10` |  |
| livenessProbe.httpGet.path | string | `"/health"` |  |
| livenessProbe.httpGet.port | string | `"api"` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| nameOverride | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| protocol | string | `"http"` | Protocol to be used to access Aidbox (http or https) |
| readinessProbe.failureThreshold | int | `5` |  |
| readinessProbe.httpGet.path | string | `"/health"` |  |
| readinessProbe.httpGet.port | string | `"api"` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| replicaCount | int | `1` |  |
| resources.requests.cpu | string | `"500m"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.apiPort | int | `80` |  |
| service.metricsPort | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.name | string | `""` | ServiceAccount to use |
| serviceMonitor.enabled | bool | `false` |  |
| startupProbe.failureThreshold | int | `10` |  |
| startupProbe.httpGet.path | string | `"/health"` |  |
| startupProbe.httpGet.port | string | `"api"` |  |
| startupProbe.initialDelaySeconds | int | `20` |  |
| startupProbe.periodSeconds | int | `5` |  |
| tolerations | list | `[]` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |
