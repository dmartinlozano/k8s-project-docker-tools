# Testlink on docker and Kubernetes [![CircleCI](https://circleci.com/gh/dmartinlozano/testlink-docker.svg?style=shield)](https://circleci.com/gh/dmartinlozano/testlink-docker)


A [Testlink](https://github.com/TestLinkOpenSourceTRMS/testlink-code) Docker image and Kubernetes Helm chart based in https://github.com/bitnami/bitnami-docker-testlink.

This repository is automatically updated to the latest Testlink by [CircleCI](https://circleci.com/gh/dmartinlozano/testlink-docker).

## Docker-compose

```sh
docker-compose up
```

This image exposes the following ports:

- `8080` - Web service

### Environment variables

You can set the following environment variables:

| Name | Value
|------|------
| `BASE_PATH`          | Base path where test link is shown.
| `DATABASE_TYPE`      | Defaults to `postgres`
| `DATABASE_HOST`        | External postgre host. Must to by `HOST:PORT`, i.e. `"postgre.sql.com:5432"`
| `DATABASE_NAME`        | External postgre database 
| `DATABASE_USER`        | External postgre user 
| `DATABASE_PASS`        | External postgre password 


## Kubernetes Helm

```sh
helm repo add dmartinlozano https://github.com/dmartinlozano/helm-chart
helm repo update
helm install dmartinlozano/testlink
```

### Values

You can set the following values:

| Name | Value
|------|------
| `image.repository` | Name of docker image to use | `dmartinlozano/testlink`
| `image.tag` | Tag of docker image to use | `latest`
| `image.pullPolicy` | When pull the image (See)[https://kubernetes.io/docs/concepts/containers/images/]|`Always`
| `persistentVolume.existingClaim` | Provide the name of a PVC | Not set
| `persistentVolume.size` | Size of PVC | 10Gi
| `persistentVolume.accessModes` | PVC access mode | `ReadWriteOnce`
| `externalDatabase.type` | Type of external database (only postgres)| `postgres`
| `externalDatabase.host` | Hostname or IP of the database | `localhost`
| `externalDatabase.port` | Port of the database | `5432`
| `externalDatabase.name` | Database name | `testlinkdb`
| `externalDatabase.user` | Username to connect to the database | `testlinkdb`
| `externalDatabase.password` | Password to connect to the database | `testlinkrocks`
| `service.type` | k8s service type | `ClusterIP`