# My Helm Chart

This Helm chart deploys a simple application using the Docker image `arikamir/my-app:latest`. 

## Prerequisites

- Kubernetes cluster
- Helm installed

## Installation

To install the chart, run the following command:

```bash
helm install my-release ./my-helm-chart
```

Replace `my-release` with your desired release name.

## Configuration

You can customize the deployment by modifying the `values.yaml` file. The default values can be overridden by providing your own values file:

```bash
helm install my-release ./my-helm-chart -f custom-values.yaml
```

## Uninstallation

To uninstall the chart, use the following command:

```bash
helm uninstall my-release
```

## Notes

- Ensure that your Kubernetes context is set to the correct cluster.
- For more information on Helm, visit the [Helm documentation](https://helm.sh/docs/).