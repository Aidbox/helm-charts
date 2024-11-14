# aidboxdb

[AidboxDB](https://docs.aidbox.app/storage-1/aidboxdb-image) is a specialized version of the open-source PostgreSQL database, tailored for use as the data storage backend for Aidbox. It serves various purposes, including initializing and operating as a master database for Aidbox, functioning as a streaming replica, optimizing FHIR search queries, and supporting backup and maintenance functionalities.

![Version: 0.1.11](https://img.shields.io/badge/Version-0.1.11-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 17](https://img.shields.io/badge/AppVersion-17-informational?style=flat-square)

## Add the helm repository

```console
helm repo add aidbox https://aidbox.github.io/helm-charts
```

## Installation with the PostgreSQL default credentials

```console
helm upgrade --install aidboxdb aidbox/aidboxdb \
  --namespace postgres --create-namespace
```

It will install the AidboxDB with default credentials in the `postgres` namespace, creating that namespace if it doesn't already exist.

## Installation using custom PostgreSQL config and/or environment variables

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
helm upgrade --install aidboxdb aidbox/aidboxdb \
  --namespace postgres --create-namespace \
  --values /path/to/values.yaml
```

## Database backup

AidboxDB image contains [WAL-G](https://github.com/wal-g/wal-g). For more information see [documentation](https://docs.aidbox.app/storage-1/backup-and-restore/archiving)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | string | `"max_wal_size = '4GB'\nshared_buffers = '2GB'"` | PostgreSQL config |
| env | object | `{"PGDATA":"/data/pg","POSTGRES_DB":"postgres","POSTGRES_PASSWORD":"postgres","POSTGRES_USER":"postgres"}` | [AidboxDB environment variables](https://docs.aidbox.app/reference/configuration/environment-variables/aidboxdb-environment-variables) |
| extraEnvFromSecrets | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"healthsamurai/aidboxdb"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. Has one-to-one mapping to the PostgreSQL version. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount | string | `""` |  |
| storage.className | string | `""` | Storage className to use |
| storage.size | string | `"300Gi"` | Storage volume size request |
| volumeMounts | list | `[]` | Additional volume mounts |
| volumes | list | `[]` | Additional volumes |
