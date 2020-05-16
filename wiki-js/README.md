# Wiki.js on Docker and Kubernetes [![CircleCI](https://circleci.com/gh/dmartinlozano/wiki-js-docker.svg?style=shield)](https://circleci.com/gh/dmartinlozano/wiki-js-docker)

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
