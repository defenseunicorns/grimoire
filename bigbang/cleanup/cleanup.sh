#! /bin/bash


###Cleanup script for Big Bang deployment in case zarf package remove fails
###Suspend kyverno HelmRelease to avoid resoucres getting recreated during destroy process
flux suspend hr -n bigbang kyverno

###Deleting the BigBang HelmRelease will delete all the resources created by BigBang
kubectl delete hr -n bigbang bigbang &
sleep 30

###Delete lingering resources not deleted by BigBang HelmRelease removal
kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io kyverno-policy-validating-webhook-cfg kyverno-resource-validating-webhook-cfg
kubectl patch kialis.kiali.io -n kiali kiali -p '{"metadata":{"finalizers":null}}' --type=merge
kubectl patch istiooperators.install.istio.io -n istio-system istiocontrolplane -p '{"metadata":{"finalizers":null}}' --type=merge
kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io istio-validator-istio-system istiod-default-validator
kubectl delete gitrepositories.source.toolkit.fluxcd.io -n bigbang bigbang
kubectl delete ns bigbang

###Delete the Flux deployment (requires user interaction "Y")
flux uninstall

###Extra commands for cleaning up stuck resources (if needed)

# kubectl patch hr -n bigbang kyvernopolicies -p '{"metadata":{"finalizers":null}}' --type=merge

# hr=`kubectl get hr -n bigbang --no-headers -o custom-columns=":.metadata.name"`
# hc=`kubectl get hc -n bigbang --no-headers -o custom-columns=":.metadata.name"`
# gr=`kubectl get gitrepository -n bigbang --no-headers -o custom-columns=":.metadata.name"`


# for i in $hr; do
#     echo $i
#     kubectl patch hr -n bigbang $i -p '{"metadata":{"finalizers":null}}' --type=merge
# done

# for i in $hc; do
#     echo $i
#     kubectl patch hc -n bigbang $i -p '{"metadata":{"finalizers":null}}' --type=merge
# done

# for i in $gr; do
#     echo $i
#     kubectl patch gitrepository -n bigbang $i -p '{"metadata":{"finalizers":null}}' --type=merge
# done

# kubectl patch alert -n monitoring grafana -p '{"metadata":{"finalizers":null}}' --type=merge
# kubectl patch provider -n monitoring grafana -p '{"metadata":{"finalizers":null}}' --type=merge
