# k8s-project-docker-tools ![.github/workflows/build.yml](https://github.com/dmartinlozano/k8s-project-docker-tools/workflows/.github/workflows/build.yml/badge.svg)

This project generates docker images for k8s-project.
Only update `index.json` and push it in this repository.

=========================================================================
# GitBucket on Docker and Kubernetes

A [GitBucket](https://github.com/gitbucket/gitbucket) Docker image and Kubernetes Helm chart.

This repository is automatically updated to the latest GitBucket by [CircleCI](https://circleci.com/gh/dmartinlozano/gitbucket-docker).


## Docker

```sh
docker run -p 8080:8080 -p 29418:29418 dmartinlozano/gitbucket
```

You can save your GitBucket data to `./gitbucket` persistently as follows:

```sh
mkdir -p /data/gitbucket
chown -R 1000:1000 /data/gitbucket
docker run -p 8080:8080 -p 29418:29418 -v /data/gitbucket:/var/gitbucket dmartinlozano/gitbucket
```

This image runs as `gitbucket` user (uid=1000, gid=1000), not `root` for security reason.

This image exposes the following ports:

- `8080` - Web service
- `29418` - SSH access to git repository

### Environment variables

You can set the following environment variables:

| Name | Value
|------|------
| `GITBUCKET_HOME`          | Directory to store data. Defaults to `/var/gitbucket`.
| `GITBUCKET_BASE_URL`      | Base URL. This may be required if container is behind a reverse proxy.
| `GITBUCKET_DB_URL`        | [External database](https://github.com/gitbucket/gitbucket/wiki/External-database-configuration) URL. Defaults to H2.
| `GITBUCKET_DB_USER`       | External database user.
| `GITBUCKET_DB_PASSWORD`   | External database password.
| `GITBUCKET_OPTS`          | GitBucket command line options.
| `JAVA_OPTS`               | JVM options. Defaults to options setting JVM heap by container memory limit. See [`Dockerfile`](Dockerfile) for more.


## Kubernetes Helm

```sh
helm repo add dmartinlozano https://github.com/dmartinlozano/helm-chart
helm repo update
helm install dmartinlozano/gitbucket
```

The Helm chart considers the followings:

- Mount the persistent volume to `/var/gitbucket`.
- Fix owner of `/var/gitbucket` by the init container.
- Set readiness probe and liveness probe with access to `:8080/signin`. It should return 200.

### Values

You can set the following values:

| Name | Value
|------|------
| `gitbucket.options`           | GitBucket command line options.
| `javavm.options`              | JVM options. Defaults to setting JVM heap by the memory limit. See [`Dockerfile`](Dockerfile) for more.
| `externalDatabase.url`        | The [external database](https://github.com/gitbucket/gitbucket/wiki/External-database-configuration) URL. Defaults to H2.
| `externalDatabase.user`       | The external database user.
| `externalDatabase.password`   | The external database password.
| `externalDatabase.existingSecret`     | Name of an existing secret to be used for the database password.
| `externalDatabase.existingSecretKey`  | The key for the database password in the existing secret.
| `persistentVolume.existingClaim`  | Name of an existing Persistent Volume Claim.
| `persistentVolume.size`           | Size of a Persistent Volume Claim for dynamic provisioning. Defaults to `10Gi`.
| `resources.limits.memory`         | Memory limit. Defaults to `1Gi`.
| `resources.requests.memory`       | Memory request. Defaults to `1Gi`.
| `ingress.enabled`                 | If true, an ingress is be created.
| `ingress.hosts`                   | A list of hosts for the ingress.


## External database

You can create a database and user for the GitBucket as follows:

```sql
# PostgreSQL
CREATE DATABASE gitbucket;
CREATE USER gitbucket PASSWORD 'gitbucket';
GRANT ALL PRIVILEGES ON DATABASE gitbucket TO gitbucket;

# MySQL
CREATE DATABASE gitbucket;
GRANT ALL PRIVILEGES ON gitbucket.* to gitbucket@'%' identified by 'gitbucket';
FLUSH PRIVILEGES; 
```


## Contributions

This is an open source software licensed under Apache License 2.0.
Feel free to open issues and pull requests.
=========================================================================
# Wiki.js on Docker and Kubernetes

A [Wiki.js](https://github.com/Requarks/wiki) Docker image and Kubernetes Helm chart.

This repository is automatically updated to the latest GitBucket by [CircleCI](https://circleci.com/gh/dmartinlozano/wiki-js-docker).


## Docker

```sh
docker run -p 8080:3000 dmartinlozano/wiki-js
```

This image exposes the following ports:

- `3000` - Web service

## Kubernetes Helm

```sh
helm repo add dmartinlozano https://github.com/dmartinlozano/helm-chart
helm repo update
helm install dmartinlozano/wiki-js
```

### Values

You can set the following values:

| Name | Value | Default |
|------|-------|---------|
| `image.repository` | Name of docker image to use | `requarks/wiki`
| `image.tage` | Tag of docker image to use | `2.3.81`
| `persistentVolume.existingClaim` | Provide the name of a PVC | Not set
| `persistentVolume.size` | Size of PVC | 10Gi
| `persistentVolume.accessModes` | PVC access mode | `ReadWriteOnce`
| `database.type` | Type of external database (mysql, postgres, mariadb, mssql or sqlite)| `postgres`
| `database.host` | Hostname or IP of the database | `localhost`
| `database.port` | Port of the database | `5432`
| `database.name` | Database name | `wiki`
| `database.user` | Username to connect to the database | `wikijs`
| `database.password` | Password to connect to the database | `wikijsrocks`
| `service.type` | k8s service type | `ClusterIP`
| `fixWizardAndKeycloakSidecar.enabled` | Apply job to skip wizard and apply keycloack integration | `false`
| `fixWizardAndKeycloakSidecar.wikiConfig.host` | Internal service name of wiki, for example `k8s-project-wiki-js.k8s-project`| `wiki-js`
| `fixWizardAndKeycloakSidecar.wikiConfig.adminEmail` | Email of admin for wiki.js | `admin@example.com`
| `fixWizardAndKeycloakSidecar.wikiConfig.adminPassword` |Password of admin for wiki.js | `admin1234`
| `fixWizardAndKeycloakSidecar.wikiConfig.siteUrl` | URL where wiji-js is deployed | `http://wiki-js.com:3000/wiki-js`
| `fixWizardAndKeycloakSidecar.wikiConfig.telemetry` | Allows the developers of Wiki.js to improve the software by collecting basic anonymized data about its usage and the host info | `false`
| `fixWizardAndKeycloakSidecar.keycloak.protocol` | Protocol where keycloak is installed | `http`
| `fixWizardAndKeycloakSidecar.keycloak.host` | Domain where keycloak is installed | `keycloak.com`
=========================================================================
# k8s-project-docker-tools ![.github/workflows/build.yml](https://github.com/dmartinlozano/k8s-project-docker-tools/workflows/.github/workflows/build.yml/badge.svg)

This project generates docker images for k8s-project.
Only update `index.json` and push it in this repository.

=========================================================================
# GitBucket on Docker and Kubernetes

A [GitBucket](https://github.com/gitbucket/gitbucket) Docker image and Kubernetes Helm chart.

This repository is automatically updated to the latest GitBucket by [CircleCI](https://circleci.com/gh/dmartinlozano/gitbucket-docker).


## Docker

```sh
docker run -p 8080:8080 -p 29418:29418 dmartinlozano/gitbucket
```

You can save your GitBucket data to `./gitbucket` persistently as follows:

```sh
mkdir -p /data/gitbucket
chown -R 1000:1000 /data/gitbucket
docker run -p 8080:8080 -p 29418:29418 -v /data/gitbucket:/var/gitbucket dmartinlozano/gitbucket
```

This image runs as `gitbucket` user (uid=1000, gid=1000), not `root` for security reason.

This image exposes the following ports:

- `8080` - Web service
- `29418` - SSH access to git repository

### Environment variables

You can set the following environment variables:

| Name | Value
|------|------
| `GITBUCKET_HOME`          | Directory to store data. Defaults to `/var/gitbucket`.
| `GITBUCKET_BASE_URL`      | Base URL. This may be required if container is behind a reverse proxy.
| `GITBUCKET_DB_URL`        | [External database](https://github.com/gitbucket/gitbucket/wiki/External-database-configuration) URL. Defaults to H2.
| `GITBUCKET_DB_USER`       | External database user.
| `GITBUCKET_DB_PASSWORD`   | External database password.
| `GITBUCKET_OPTS`          | GitBucket command line options.
| `JAVA_OPTS`               | JVM options. Defaults to options setting JVM heap by container memory limit. See [`Dockerfile`](Dockerfile) for more.


## Kubernetes Helm

```sh
helm repo add dmartinlozano https://github.com/dmartinlozano/helm-chart
helm repo update
helm install dmartinlozano/gitbucket
```

The Helm chart considers the followings:

- Mount the persistent volume to `/var/gitbucket`.
- Fix owner of `/var/gitbucket` by the init container.
- Set readiness probe and liveness probe with access to `:8080/signin`. It should return 200.

### Values

You can set the following values:

| Name | Value
|------|------
| `gitbucket.options`           | GitBucket command line options.
| `javavm.options`              | JVM options. Defaults to setting JVM heap by the memory limit. See [`Dockerfile`](Dockerfile) for more.
| `externalDatabase.url`        | The [external database](https://github.com/gitbucket/gitbucket/wiki/External-database-configuration) URL. Defaults to H2.
| `externalDatabase.user`       | The external database user.
| `externalDatabase.password`   | The external database password.
| `externalDatabase.existingSecret`     | Name of an existing secret to be used for the database password.
| `externalDatabase.existingSecretKey`  | The key for the database password in the existing secret.
| `persistentVolume.existingClaim`  | Name of an existing Persistent Volume Claim.
| `persistentVolume.size`           | Size of a Persistent Volume Claim for dynamic provisioning. Defaults to `10Gi`.
| `resources.limits.memory`         | Memory limit. Defaults to `1Gi`.
| `resources.requests.memory`       | Memory request. Defaults to `1Gi`.
| `ingress.enabled`                 | If true, an ingress is be created.
| `ingress.hosts`                   | A list of hosts for the ingress.


## External database

You can create a database and user for the GitBucket as follows:

```sql
# PostgreSQL
CREATE DATABASE gitbucket;
CREATE USER gitbucket PASSWORD 'gitbucket';
GRANT ALL PRIVILEGES ON DATABASE gitbucket TO gitbucket;

# MySQL
CREATE DATABASE gitbucket;
GRANT ALL PRIVILEGES ON gitbucket.* to gitbucket@'%' identified by 'gitbucket';
FLUSH PRIVILEGES; 
```


## Contributions

This is an open source software licensed under Apache License 2.0.
Feel free to open issues and pull requests.
=========================================================================
# Wiki.js on Docker and Kubernetes

A [Wiki.js](https://github.com/Requarks/wiki) Docker image and Kubernetes Helm chart.

This repository is automatically updated to the latest GitBucket by [CircleCI](https://circleci.com/gh/dmartinlozano/wiki-js-docker).


## Docker

```sh
docker run -p 8080:3000 dmartinlozano/wiki-js
```

This image exposes the following ports:

- `3000` - Web service

## Kubernetes Helm

```sh
helm repo add dmartinlozano https://github.com/dmartinlozano/helm-chart
helm repo update
helm install dmartinlozano/wiki-js
```

### Values

You can set the following values:

| Name | Value | Default |
|------|-------|---------|
| `image.repository` | Name of docker image to use | `requarks/wiki`
| `image.tage` | Tag of docker image to use | `2.3.81`
| `persistentVolume.existingClaim` | Provide the name of a PVC | Not set
| `persistentVolume.size` | Size of PVC | 10Gi
| `persistentVolume.accessModes` | PVC access mode | `ReadWriteOnce`
| `database.type` | Type of external database (mysql, postgres, mariadb, mssql or sqlite)| `postgres`
| `database.host` | Hostname or IP of the database | `localhost`
| `database.port` | Port of the database | `5432`
| `database.name` | Database name | `wiki`
| `database.user` | Username to connect to the database | `wikijs`
| `database.password` | Password to connect to the database | `wikijsrocks`
| `service.type` | k8s service type | `ClusterIP`
| `fixWizardAndKeycloakSidecar.enabled` | Apply job to skip wizard and apply keycloack integration | `false`
| `fixWizardAndKeycloakSidecar.wikiConfig.host` | Internal service name of wiki, for example `k8s-project-wiki-js.k8s-project`| `wiki-js`
| `fixWizardAndKeycloakSidecar.wikiConfig.adminEmail` | Email of admin for wiki.js | `admin@example.com`
| `fixWizardAndKeycloakSidecar.wikiConfig.adminPassword` |Password of admin for wiki.js | `admin1234`
| `fixWizardAndKeycloakSidecar.wikiConfig.siteUrl` | URL where wiji-js is deployed | `http://wiki-js.com:3000/wiki-js`
| `fixWizardAndKeycloakSidecar.wikiConfig.telemetry` | Allows the developers of Wiki.js to improve the software by collecting basic anonymized data about its usage and the host info | `false`
| `fixWizardAndKeycloakSidecar.keycloak.protocol` | Protocol where keycloak is installed | `http`
| `fixWizardAndKeycloakSidecar.keycloak.host` | Domain where keycloak is installed | `keycloak.com`
=========================================================================
# k8s-project-docker-tools ![.github/workflows/build.yml](https://github.com/dmartinlozano/k8s-project-docker-tools/workflows/.github/workflows/build.yml/badge.svg)

This project generates docker images for k8s-project.
Only update `index.json` and push it in this repository.

%README%=========================================================================
# Testlink on docker and Kubernetes

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
| `service.type` | k8s service type | `ClusterIP`=========================================================================
# Testlink on docker and Kubernetes

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