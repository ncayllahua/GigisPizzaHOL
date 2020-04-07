# :pizza: GigisPizzaHOL :pizza:
Gigi's pizza Hands On Labs are a series of labs based on a Demo developed by WeDo Team as part of an innovation initiative to approach Oracle Cloud Solutions by providing practical examples that could be “touched” and easily understood.

Demo is known as Gigi’s Pizza. The Use Case is focused in microservices/serverless (fn) and Multitenant DataBase. We have three microservices coded in different languages like nodejs and of course Java (Helidon framework). This three microservices are part of a delivery pizza app, one microservice controls the orders, other one controls the pizza delivery and the last one controls the accounting. We coded a serverless function to calculate discounts, according to several bussiness rules like credit card type or pizza order total prize.

Hands on Labs - Gigis pizza microservices/serverless app (Oracle Cloud Infraestructure OCI)

- [x] [HOL 5967 - Microservices](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/microservices/hol5967_userguide.md)
- [x] [HOL serverless](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/serverless/gigis-serverless-HOL.md)
- [x] [HOL serverless with pipelines](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/serverless/devcs2fn.md)

* To connect serverless HOL to microservices HOL you can follow the Api Gateeway HOL.
- [X] [HOL Api Gateway](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/api-gateway/oci_apigateway.md)

- [I have a Freetier or Oracle Cloud account](https://github.com/oraclespainpresales/GigisPizzaHOL/freetier/index.html)
- [I have an account from SSWorkshop](https://github.com/oraclespainpresales/GigisPizzaHOL/ssworkshop/index.html)


## Get an Oracle Cloud Trial Account for Free!
If you don't have an Oracle Cloud account then you can quickly and easily sign up for a free trial account that provides:
- $300 of free credits good for up to 3500 hours of Oracle Cloud usage
- Credits can be used on all eligible Cloud Platform and Infrastructure services for the next 30 days
- Your credit card will only be used for verification purposes and will not be charged unless you 'Upgrade to Paid' in My Services

Click here to request your trial account: [https://www.oracle.com/cloud/free](https://www.oracle.com/cloud/free)


## Product Pages
- [Oracle Database 19c](https://www.oracle.com/database/)
- [Oracle Database ATP](https://www.oracle.com/database/atp-cloud.html)
- [Oracle Cloud Native - OKE](https://www.oracle.com/cloud/compute/container-engine-kubernetes.html)
- [Oracle Cloud Native - Registry](https://www.oracle.com/cloud/compute/container-registry.html)
- [Oracle Cloud Native - Functions](https://www.oracle.com/cloud/cloud-native/functions)
- [Oracle Cloud Native - API-Gateway](https://www.oracle.com/cloud/cloud-native/api-gateway/)

## Documentation
- [Database Product Management YouTube Channel](https://www.youtube.com/channel/UCr6mzwq_gcdsefQWBI72wIQ)
- [Oracle Database ATP](https://docs.oracle.com/en/cloud/paas/atp-cloud/index.html)
- [Oracle Cloud Native - OKE](https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengoverview.htm)
- [Oracle Cloud Native - Registry](https://docs.cloud.oracle.com/en-us/iaas/Content/Registry/Concepts/registryoverview.htm)
- [Oracle Cloud Native - Functions](https://docs.cloud.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.htm)
- [Oracle Cloud Native - API-Gateway](https://docs.cloud.oracle.com/en-us/iaas/Content/APIGateway/Concepts/apigatewayoverview.htm)

## :notebook: Interesting information for the HOLs.

:computer: OVA VM machine [link](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/smpE_ekRW19rd4H31B4fPspIqXxRm-iSuaQ9kOc8_K8/n/wedoinfra/b/DevCS_Clone_WedoDevops/o/HOL5967-OOW2019%20OVAHOL5967-OOW2019.ova "ova hol")
- oci version 2.9.1
- kubectl version 1.17.0
- fn cli 0.5.92

:computer: marketplace developer VM machine [link](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/devmachine-marketplace/devmachine-marketplaceor.md)

### Python upgrade to python 3
```sh
sudo yum install python3
```
### OCICLI upgrade to latest version
```sh
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```
### Install Kubectl with curl
1. Download last version of kubectl
```sh
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
```
2. Change permission of the binary file
```sh
chmod +x ./kubectl
```
3. Move binary to you PATH
```sh
sudo mv ./kubectl /usr/local/bin/kubectl
```
### OCI SETUP repair permissions error
```sh
oci setup repair-file-permissions –file /home/holouser/.oci/private.pem
```
### Fn Cli install
```sh
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh
```
## Create OCIR Secret.
```sh
kubectl create secret docker-registry ocirsecret --docker-server=<region>.ocir.io --docker-username='<tenant_storage_namespace>/<your_user>' --docker-password='<your_auth_token>' --docker-email='<your_email>'
```
Example
```sh
kubectl create secret docker-registry ocirsecret --docker-server=fra.ocir.io --docker-username='wedoinfra/wedo.devops' --docker-password='xxxxxxxxxxxxx' --docker-email='test.email@oracle.com'
```
## Oracle Cloud Regions:
https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm

## Oracle OCIR Regions:
https://docs.cloud.oracle.com/iaas/Content/Registry/Concepts/registryprerequisites.htm#Availab

# OKE in Rancher UI

https://medium.com/swlh/oke-clusters-from-rancher-2-0-409131ad1293
