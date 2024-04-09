# aidboxdb

AidboxDB is based on the official PostgreSQL and adapted to work with Aidbox.

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 16.1](https://img.shields.io/badge/AppVersion-16.1-informational?style=flat-square)

## Installation with default credentials

```console
helm upgrade --install aidboxdb aidboxdb \
  --repo https://aidbox.github.io/helm-charts \
  --namespace postgres --create-namespace
```

It will install the AidboxDB with default credentials in the `postgres` namespace, creating that namespace if it doesn't already exist.

## Installation using custom PostgreSQL config or environment variables

Create values YAML like

```yaml
config: |-
  max_wal_size = '4GB'
  shared_buffers = '2GB'

env:
  POSTGRES_USER: superuser
  POSTGRES_PASSWORD: strongpassword
```

and apply it

```console
helm upgrade --install aidboxdb aidboxdb \
  --repo https://aidbox.github.io/helm-charts \
  --namespace postgres --create-namespace \
  --values /path/to/values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | string | `"max_wal_size = '4GB'\nshared_buffers = '2GB'"` | PostgreSQL config |
| env | object | [AidboxDB environment variables](https://docs.aidbox.app/reference/configuration/environment-variables/aidboxdb-environment-variables) | Environment variables |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"healthsamurai/aidboxdb"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. Has one-to-one mapping to the PostgreSQL version. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| storage.className | string | `""` | Storage className to use |
| storage.size | string | `"300Gi"` | Storage volume size request |
| volumeMounts | list | `[]` | Additional volume mounts |
| volumes | list | `[]` | Additional volumes |
