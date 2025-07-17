# MPI Module Installation Guide

This guide describes how to install the MPI (Master Patient Index) module using the Helm chart.

## Prerequisites

Before installing the MPI module, ensure you have the following prerequisites:

1. **Kubernetes Cluster**: A running Kubernetes cluster with access to pull images
2. **Helm 3**: Helm CLI tool installed (version 3.x or later)
3. **Service Account**: Access to the private Google Cloud registry containing the MPI image
4. **Aidbox**: Aidbox and AidboxDB instances

## Image Pull Secret Setup

The MPI module uses a private Docker image stored in Google Cloud Artifact Registry. You need to create a Kubernetes secret to authenticate with the registry:

### 1. Request Service Account Key

Request a service account key file from Aidbox team.

### 2. Create Kubernetes Secret

Create a Kubernetes secret for Docker registry authentication using the service account key file:

```bash
# Create the secret using kubectl
kubectl create secret docker-registry google-ar-json-key \
  --docker-server=us-east1-docker.pkg.dev \
  --docker-username=_json_key \
  --docker-password="$(cat key.json)"
```

## Aidbox Setup

The MPI module requires an Aidbox solution. You can deploy it using the [AidboxDB Helm chart](https://github.com/Aidbox/helm-charts/tree/main/aidboxdb) and [Aidbox Helm chart](https://github.com/Aidbox/helm-charts/tree/main/aidbox).

## MPI Module Installation

Prepare the configuration file.

```yaml
host: mpi.yourdomain.com
protocol: https

config:
  PGHOST: sonic-db-aidboxdb.sonic.svc # host of aidbox postgres db
  PGDATABASE: postgres # database in aidbox postgres db
  PGUSER: postgres # user of aidbox postgres db
  PGPASSWORD: my_super_secret # pwd for user of aidbox postgres db
  MPI_BINDING: "0.0.0.0" # use 127.0.0.1 for local development/testing; use 0.0.0.0 if you want external access.
  MPI_LOG_LEVEL: 2 # log level for mpi backend, default is 1 (if value set in 2 than debug logs will be show)
  MPI_ENABLE_AUTHENTICATION: false # use aidbox for authentication
  MPI_ENABLE_AUTHORIZATION: false # use aidbox for authorization
  AIDBOX_BASE_URL: https://box.mpi.aidbox.io # aidbox url (protocol is required!)
  AIDBOX_CLIENT_ID: mpi # client should be with authorization code grant (see: https://docs.aidbox.app/tutorials/security-access-control-tutorials/authorization-code-grant, also see example in aidbox-client-example.json (this repo))
  AIDBOX_CLIENT_SECRET: super_pass
  MPI_BASIC_ROLE: SIT_EMPI_USER_DEV # mpi assume to see this roles in User.data.roles array
  MPI_ADMIN_ROLE: SIT_EMPI_ADMIN_DEV # mpi assume to see this roles in User.data.roles array (with this role user can merge and unmerge)
  PG_TRGM_SIMILARITY_THRESHOLD: 0.9 # this value will be set for pg_trgm.similarity_threshold on transaction level
  PG_TRGM_STRICT_WORD_SIMILARITY_THRESHOLD: 0.9 # this value will be set for pg_trgm.strict_word_similarity_threshold on transaction level
  MPI_NOTIFICATION_WORKER_ENABLE: false # turn on or turn off notification worker
  MPI_NOTIFICATION_CONSUMER_URL: http://localhost:9876
  MPI_NOTIFICATION_INTERVAL: 1000 # time interval between sending notifications (in ms)
  MPI_NOTIFICATION_BATCH_SIZE: 10
  MPI_NOTIFICATION_LOCK_ID: 12345 # will be used for pg_try_advisory_xact_lock, this is needed to avoid race condition or deadlock between mpi instances (should be the same for all mpi instances and different from other lock ids)
  MPI_AUDIT_WORKER_ENABLE: false # turn on or turn off audit send worker. Audit will be recorded anyway, but will not be sent to external audit repository 
  MPI_AUDIT_CONSUMER_URL: http://localhost:9877
  MPI_AUDIT_INTERVAL: 1000 # time interval between sending notifications (in ms)
  MPI_AUDIT_BATCH_SIZE: 10 
  MPI_AUDIT_LOCK_ID: 54321 # will be used for pg_try_advisory_xact_lock, this is needed to avoid race condition or deadlock between mpi instances (should be the same for all mpi instances and different from other lock ids)

image:
  repository: us-east1-docker.pkg.dev/aidbox2-205511/sonic/mpi
  tag: "edge"
  pullPolicy: Always

imagePullSecrets:
  - name: google-ar-json-key

ingress:
  enabled: true
  className: "nginx"
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
```

Install the MPI module:

```bash
helm repo add aidbox https://aidbox.github.io/helm-charts

helm upgrade --install mpi aidbox/mpi --values /path/to/config/file
```

## Observability

The MPI module provides health endpoints:

- **Health Check**: `GET /health`
- **Metrics**: Available on port 8765
