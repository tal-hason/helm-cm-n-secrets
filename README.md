# ConfigMap And Secrets Helm Chart

latest_vesion: 0.0.16

![HELM](https://raw.githubusercontent.com/tal-hason/helm-cm-n-secrets/main/assests/Helm-logo.webp)

## This is a HELM Chart repo for a chart that creates a configMaps and Secrets from an array in the value file

- support multiline string date with user defrined file name.
- support Key & Value for environment variables.
- support all K8S secret type by changing the secretType for each secret.
- support adding common labels and annotations to all configmaps and secrets.
- added a global enable/disable for configmaps and secrets.

*to add this HELM repo to you HELM client run the following:*

```bash
helm repo add configmap-n-secrets https://tal-hason.github.io/helm-cm-n-secrets/
```

*to pull the chart run:*

```bash
helm pull configmap-n-secrets/configMapSecrets
```

### Value file structure

```YAML
commonLables:
  this-is-a-label: some-label

commonAnnotations: 
  this-is-an-annotaion: some-annotation

configMaps:
  enabled: true
  configMapDetails: # an array of configmaps with their details and values
  - name: app-properties # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are available 1, string(file style) 2, Key & values(environment variables)
    fileName: application.properties # the name of the file/key in the config map
    data: | # this is the Key that will store the data of the configmap to both types
      some file content
      with details of the application
  - name: some-files # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are available 1, string(file style) 2, Key & values(environment variables)
    fileName: files1 # the name of the file/key in the config map
    data: | # this is the Key that will store the data of the configmap to both types
      '12334455666777888'
  - name: env-details # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: keyValues # the type of the configmap, 2 types are available 1, string(file style) 2, Key & values(environment variables)
    data: # this is the Key that will store the data of the configmap to both types
      HOST: localhost # Key & Values 1
      PORT: "8080" # Key & Values 2
      ENV: develop # Key & Values 3

secrets:
  enabled: false
  secretDetails: # an array of configmaps with their details and values will be Base64 encoded
  - name: app-properties # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are available 1, string(file style) 2, Key & values(environment variables)
    fileName: dbstring # the name of the file/key in the secret
    secretType: Opaque # k8s secret type (Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson, kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token)
    data: | # this is the Key that will store the data of the configmap to both types
      some file content
      with details of the application
  - name: env-details # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: keyValues # the type of the configmap, 2 types are available 1, string(file style) 2, Key & values(environment variables)
    secretType: Opaque # k8s secret type (Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson, kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token)
    data: # this is the Key that will store the data of the configmap to both types
      HOST: localhost # Key & Values 1
      PORT: "8080" # Key & Values 2
      ENV: develop # Key & Values 3
```

### the output will be

**for configMaps:**

```YAML
---
# Source: configMapSecrets/templates/configMap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-properties
  labels:
    helm-chart/release-name: demo
    helm.sh/chart: 'configMapSecrets-0.0.12'
    this-is-a-label: "some label" 
  annotations:
    helm-chart/release-version: 0.0.12
    this-is-an-annotaion: "some annotation" 
data:
  application.properties: |
    some file content
    with details of the application
---
# Source: configMapSecrets/templates/configMap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: some-files
  labels:
    helm-chart/release-name: demo
    helm.sh/chart: 'configMapSecrets-0.0.12'
    this-is-a-label: "some label" 
  annotations:
    helm-chart/release-version: 0.0.12
    this-is-an-annotaion: "some annotation" 
data:
  files1: |
    '12334455666777888'
---
# Source: configMapSecrets/templates/configMap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: env-details
  labels:
    helm-chart/release-name: demo
    helm.sh/chart: 'configMapSecrets-0.0.12'
    this-is-a-label: "some label" 
  annotations:
    helm-chart/release-version: 0.0.12
    this-is-an-annotaion: "some annotation" 
data:
  ENV: "develop"
  HOST: "localhost"
  PORT: "8080"
```

**For secrets:**

```YAML
---
# Source: configMapSecrets/templates/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-properties
  labels:
    helm-chart/release-name: demo
    helm.sh/chart: 'configMapSecrets-0.0.12'
    this-is-a-label: "some label" 
  annotations:
    helm-chart/release-version: 0.0.12
    this-is-an-annotaion: "some annotation" 
type: Opaque
data:
  dbstring: "ICAgIHNvbWUgZmlsZSBjb250ZW50CiAgICB3aXRoIGRldGFpbHMgb2YgdGhlIGFwcGxpY2F0aW9uCiAgICA="
---
# Source: configMapSecrets/templates/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: env-details
  labels:
    helm-chart/release-name: demo
    helm.sh/chart: 'configMapSecrets-0.0.12'
    this-is-a-label: "some label" 
  annotations:
    helm-chart/release-version: 0.0.12
    this-is-an-annotaion: "some annotation" 
type: Opaque
data:
  ENV: ImRldmVsb3Ai
  HOST: ImxvY2FsaG9zdCI=
  PORT: IjgwODAi
```
