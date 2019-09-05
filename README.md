# GigisPizzaHOL
Hands on Lab - Gigis pizza microservices/serverless app

OVA https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/9wPkmNOP5__c47V8ajoZCP8zE2qbL26XbmdItGgFd30/n/wedoinfra/b/DevCS_Clone_WedoDevops/o/OOW2019HOL.ova

OCI SETUP
oci setup repair-file-permissions –file /home/holouser/.oci/private.pem

Create OCIR Secret.
<code>kubectl create secret docker-registry ocirsecret --docker-server=fra.ocir.io --docker-username='<tenant_storage_namespace>/<your_user>' --dockerpassword='<your_auth_token>' --docker-email='<your_email>'</code>
