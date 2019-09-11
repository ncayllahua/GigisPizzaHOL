# GigisPizzaHOL
Hands on Lab - Gigis pizza microservices/serverless app

HOL [link](https://github.com/oraclespainpresales/GigisPizzaHOL/edit/master/README.md)

OVA [link](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/9wPkmNOP5__c47V8ajoZCP8zE2qbL26XbmdItGgFd30/n/wedoinfra/b/DevCS_Clone_WedoDevops/o/OOW2019HOL.ova "ova hol")

OCI SETUP repair permissions error
```
oci setup repair-file-permissions –file /home/holouser/.oci/private.pem
```

Create OCIR Secret.
```
kubectl create secret docker-registry ocirsecret --docker-server=<region>.ocir.io --docker-username='<tenant_storage_namespace>/<your_user>' --docker-password='<your_auth_token>' --docker-email='<your_email>'
```
Example
```
kubectl create secret docker-registry ocirsecret --docker-server=fra.ocir.io --docker-username='wedoinfra/wedo.devops' --docker-password='92(·38434"4Gjhle14%' --docker-email='test.email@oracle.com'
```

Oracle Cloud Regions:
https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm

Oracle OCIR Regions:
https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab
