# oc get bc mpos-verification -oyaml &> bc.txt
# oc logs bc/mpos-verification &> bclogs.txt
# oc version &> version.txt
# oc get pods -owide &> pods.txt
# curl -v docker-registry.default.svc.cluster.local:5000/healthz &> healthz.txt
# oc get nodes -owide &> node.txt
# oc project &> project.txt
# oc whoami &> whoami.txt
# oc get rolebinding &> role.txt

## Basics

oc get nodes -o wide

oc get pods --all-namespaces
oc rsh po/<pod-name>




restarting etcd one at a time on each etcd host resolves the issue
systemctl restart etcd




## Operators

$ oc get csv <operator> -n <namespace> -o yaml
$ oc get sub <operator> -n <namespace> -o yaml


$ oc describe co <operator> (for Cluster operator)

oc get packagemanifests -n openshift-marketplace

$ oc get subscription jaeger -n openshift-operators -o yaml | grep currentCSV
  currentCSV: jaeger-operator.v1.8.2

$ oc delete subscription jaeger -n openshift-operators
subscription.operators.coreos.com "jaeger" deleted

$ oc delete clusterserviceversion jaeger-operator.v1.8.2 -n openshift-operators
clusterserviceversion.operators.coreos.com "jaeger-operator.v1.8.2" deleted

$ oc describe sub <subscription_name>
In the command output, find the Conditions section:

## MachineConfig 

$ oc get machineconfig

This provides a list of the available machine configuration objects you can select. By default, the two kubelet-related configs are 01-master-kubelet and 01-worker-kubelet.


## MachineSet

oc get machinesets -n openshift-machine-api

### Remove node from cluster

Mark the node as unschedulable by running the oc adm cordon command:
$ oc adm cordon <node_name> 

Specify the node name of one of the RHCOS compute machines.
Drain all the pods from the node:
$ oc adm drain <node_name> --force --delete-local-data --ignore-daemonsets 

Specify the node name of the RHCOS compute machine that you isolated.
Delete the node:
$ oc delete nodes <node_name> 

Specify the node name of the RHCOS compute machine that you drained.
Review the list of compute machines to ensure that only the RHEL nodes remain:
$ oc get nodes -o wide

## Registry

curl -kv https://docker-registry.default.svc.cluster.local:5000/healthz

$ oc describe pod docker-registry-2-n8d21
Name:                docker-registry-2-n8d21
Namespace:            default
Image(s):            registry.access.redhat.com/openshift3/ose-docker-registry:v3.1.1.6
Node:                infra01.ose.example.com/192.168.200.61

Check to see if the mount point exists on the node (in this case infra01)

[root@infra01 ~]# mount \|grep origin
(rw,relatime,rootcontext="system_u:object_r:svirt_sandbox_file_t:s0:c0,c1",seclabel)

getsebool virt_use_nfs
virt_use_nfs --> off

Set this boolean to on across any node that will host pods which may require NFS access (such as databases, registries etc):

setsebool -P virt_use_nfs=true



## CSR

oc get csr

NAME        AGE     REQUESTOR                                                                   CONDITION
csr-8b2br   15m     system:serviceaccount:openshift-machine-config-operator:node-bootstrapper   Pending 
csr-8vnps   15m     system:serviceaccount:openshift-machine-config-operator:node-bootstrapper   Pending
csr-bfd72   5m26s   system:node:ip-10-0-50-126.us-east-2.compute.internal                       Pending 
csr-c57lv   5m26s   system:node:ip-10-0-95-157.us-east-2.compute.internal                       Pending
...


oc adm certificate approve <csr_name>
oc get csr -o go-template='{{range .items}}{{if not .status}}{{.metadata.name}}{{"\n"}}{{end}}{{end}}' | xargs oc adm certificate approve


## ETCD

fio --rw=write --ioengine=sync --fdatasync=1 --directory=test-data --size=22m --bs=2300 --name=mytest


https://github.com/etcd-io/etcd/blob/master/Documentation/faq.md#what-does-the-etcd-warning-failed-to-send-out-heartbeat-on-time-mean


## Offline

https://cloud.redhat.com/openshift/register