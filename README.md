# ConfigMap And Secrets Helm Chart

This is a HELM Chart repo for a chart that creates a configMaps and Secrets from an array in the value file

```YAML
configMaps: # an array of configmaps with their details and values
  - name: app-properties # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are avialble 1,string(file style) 2, Key & values(enviorment variables)
    fileName: application.properties # the name of the file/key in the config map
    data: # this is the Key that will store the data of the configmap to both types
      some file content
      with details of the application
  - name: some-files # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are avialble 1,string(file style) 2, Key & values(enviorment variables)
    fileName: files1 # the name of the file/key in the config map
    data: # this is the Key that will store the data of the configmap to both types
      12334455666777888
  - name: env-details # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: keyValues # the type of the configmap, 2 types are avialble 1,string(file style) 2, Key & values(enviorment variables)
    data: # this is the Key that will store the data of the configmap to both types
      HOST: localhost # Key & Values 1
      PORT: "8080" # Key & Values 2
      ENV: develop # Key & Values 3

secrets: # an array of configmaps with their details and values will be Base64 encoded
  - name: app-properties # the name of the configMap
    enabled: true # this will enable the creation of the configMap
    type: string # the type of the configmap, 2 types are avialble 1,string(file style) 2, Key & values(enviorment variables)
    fileName: db.string # the name of the file/key in the secret
    secretType: Opaque # k8s secret type (Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson, kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token)
    data: | # this is the Key that will store the data of the configmap to both types
      some file content
      with details of the application
  - name: env-details # the name of the configMap
    enabled: false # this will enable the creation of the configMap
    type: keyValues # the type of the configmap, 2 types are avialble 1,string(file style) 2, Key & values(enviorment variables)
    secretType: Opaque # k8s secret type (Opaque, kubernetes.io/service-account-token, kubernetes.io/dockercfg, kubernetes.io/dockerconfigjson, kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token)
    data: # this is the Key that will store the data of the configmap to both types
      HOST: localhost # Key & Values 1
      PORT: "8080" # Key & Values 2
      ENV: develop # Key & Values 3
```

the output will be:

