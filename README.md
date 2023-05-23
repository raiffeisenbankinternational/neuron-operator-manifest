![Operator](https://img.shields.io/badge/type-Operator-blue) ![Helm](https://img.shields.io/badge/customizing--tool-helm-green)

# Neuron Operator

This repo provides the Neuron Operator to manage the [Neuron Pulsar](https://code.rbi.tech/raiffeisen/neuron-pulsar-manifest) topology:
* tenant
* namespace
* topic
* schema

The supported custom resources are documented in the Neuron Operator [application repository](https://code.rbi.tech/raiffeisen/neuron-operator-application).

To deploy streaming functions please have a look at the [Neuron FunctionMesh Operator](https://code.rbi.tech/raiffeisen/neuron-functionmesh-manifest).

# How To Install

## 1. Enable neuron-operator per stage

The neuron-operator is meant to run next to each neuron-pulsar application.

For every neuron-pulsar cluster a `neuron-operator` application should be added to `<team/tribe>-cortex-bootstrap-app-catalog/community/<stage>/helm/`.

neuron-operator.yaml
```yaml
project: neuron
name: neuron-operator
namespace: neuron-pulsar
targetRevision: HEAD
repoURL: https://code.rbi.tech/raiffeisen/neuron-operator-manifest.git
helmRemoteValuesDirectoryURL: "https://code.rbi.tech/raiffeisen/cortex-bootstrap-app-values"
```

Directory structure:
```
📦 cortex-bootstrap-app-catalog
 ┗ 📂 community
   ┗ 📂 <dev01/test01/prod01>
     ┗ 📂 helm
       ┗ 📜 neuron-operator.yaml
```
See [here](https://code.rbi.tech/raiffeisen/cortex-bootstrap-app-catalog/blob/cortex-test/cortex-test01/community/dev01/helm/neuron-operator.yaml) how it is done on the Cortex community cluster.

## 2. Prepare parametrization

```yaml
# Set the name of the neuron-pulsar cluster to target.
# If the operator is being deployed next to dev01-neuron-pulsar this should
# be "dev01", if it's test01-neuron-pulsar this should be "test01" and so on.
clusterName: "dev01"

# If the neuron-pulsar cluster being targeted has SSL enabled this needs to match
# the domain name of the certificate being used by the pulsar proxy.
pulsarSSLHostname: "prod01-neuron-pulsar-proxy.cortex-test01.cortex-test.internal.rbigroup.cloud"

# For secured clusters a standard admin token secret will be used:
# default: "[custerName]-neuron-pulsar-token-rbi-neuron-p-admin"
# if your admin token is stored in a different secret (based on your ping-client name) please add the following key:
clusterAdminSecretName: "prod01-neuron-pulsar-token-nr-com-prod-adm-m-2m-t"

```

## 3. Check deployment

Operator pod is now be deployed in the "<dev01/test01/prod01>-neuron-pulsar" namespace on the cluster.

## Health status for the Neuron custom resource (CR) in ArgoCD
To let ArgoCD know about the new Neuron Operator CRs we included the health check config directly in ArgoCD. Have a look at this [configuration](https://code.rbi.tech/raiffeisen/cortex-argocd-manifest/blob/4f601961f882d8b3d0bd40935c2317ff9c784d2d/deployment/base/operator-cr.yaml#L397) for details.

