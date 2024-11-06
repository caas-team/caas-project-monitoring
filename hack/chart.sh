#!/bin/bash

helm dependency update
tarball=$(ls charts/kube-prometheus-stack-*.tgz)
echo "Extracting ${tarball}"
tar -xzf ${tarball} -C charts/

echo "Deleting CRD from kube-prometheus-stack"
rm -rf charts/kube-prometheus-stack/charts/crd/

echo "Building kube-prometheus dependencies"
helm dependency build charts/kube-prometheus-stack

echo "Packaging new chart"
helm package charts/kube-prometheus-stack -d charts

echo "Packaging caas-project-monitoring"
helm package .
