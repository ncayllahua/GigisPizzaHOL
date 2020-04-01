Coming Soon!
# Conecting Microservices to Severless Function with API Gateway
Once you have finished the microservices HOL and the serverless HOL, you might have a architecure quite similar to next figure.

![](./media/gigis-architect-HOL1-2.png)

As you can see there isn't any connection or call from microservice orchestrator to the new discount campaign serverless app or serverless function. You might have connected the old serverless function to your microservice orchestrator, but the idea is that you could use the new serverless app.

To connect your microservice orchestrator to the new serverless app, you'll use [OCI api gateway service](https://docs.cloud.oracle.com/es-ww/iaas/Content/APIGateway/Concepts/apigatewayoverview.htm). Following next HOL you'll can create an API Gateway in OCI to invoke your calculate discount serverless function from microservice orchestrator in a simple way.

If you review the orchestrator nodejs code you can see that a direct serverless function invoke is a little tricky, because you must create an access file with your credentials, OCI tenancy, OCI comparment and so. You must read this file, create a context and invoke the serverless function. All this task are simplfied using an API Gateway and you improve security as you don't have to create text plain config files included in your docker image for example.

The Api Gateway let you more configuration options and more management improves. The idea is at the end of this HOL you have an architecture similar to that:

![](./media/gigis-architect-HOL1-2-API.png)

Lets create an OCI Api Gateway!

## OCI Policies to use API Gateway.
To use API Gateway you must create a new Security Policy in your **root compartment**. Go to OCI main menu -> Identity -> Policies

![](./media/api-gateway/api-gateway-policies01.png)

Then select your root compartment and then Create Policy.

![](./media/api-gateway/api-gateway-policies02.png)

Write a descriptive name for the new Policy like [gigis-apigateway-policy]. Then a Description for the policy. Keep Policy Current, and in Statement 1 write:
```sh
Edit Policy Statements
Allow any-user to use functions-family in compartment wedo:devops where ALL {request.principal.type = 'ApiGateway', request.resource.compartment.id = 'ocid1.compartment.oc1.your_hands_on_lab_compartment_id'}
```

Then Click Create Button to create the new api gateway policy.

![](./media/api-gateway/api-gateway-policies03.png)

## OCI Api Gateway Creation.
Go to OCI main menu -> Developer Services -> API Gateway.

![](./media/api-gateway/api-gateway-creation01.png)

Select your compartment (you can use the last HOL-serverless compartment for example) [HandsOnLab] and Click Create Gateway Button.

![](./media/api-gateway/api-gateway-creation02.png)

Write a descriptive name like [gigis-api-gateway] or something like that. You could create this apigateway as Private as you have the microservices and serverless functions in the same cloud provider and in the same compartment (even the same virtual network). For academical purpose you will create the apigateway as PUBLIC (to invoke the function from internet or other tenants for example). Next select a VCN and a Public Subnet (we recomend that you have created a Regional Public Subnet or add one to your VCN). Click on Create button to create your API Gateway.

![](./media/api-gateway/api-gateway-creation03.png)

Wait several seconds to API Gateway creation (wait green Active).

![](./media/api-gateway/api-gateway-creation04.png)

Once you have the API Gateway created you need to create Deployments. Click on Deployments link and click Create Deployment.

![](./media/api-gateway/api-gateway-creation05.png)

Select From Scratch to create a new API Gateway from the OCI UI. But you could create a configuration JSON file to import it and create the API Gateway from a file. Then

- Write a descriptive name like **[gigis-functions-discount-campaign]**
- Write a path to access to the new API call, like **[/discount-fn]**
- Select your compartment **[HandOnLabs]**

You could create an API Request Policies like Authentification policies, CORS or Rate Limiting. Also you could enable Access Loggin and Execution Loggin, but all these policies aren't necessary for this HOL. You could add or modify these policies later if you need to. Then Click Next to continue with the API gateway creation.

![](./media/api-gateway/api-gateway-creation06.png)

Next step is to create a Route to access to the serverless function. 

- Write a descriptive **PATH** name to your serverless function CALL like **[/discount]**
- Select GET and POST api call type **METHOD**s
- Select **Oracle Functions** TYPE
- Select your serverless app [gigis-fn]
- Select your serverless function [fnpizzadiscountcampaign] or [fnpizzadiscountcampaignpool] if you complete the optional serverless function HOL.

Then click Next to Review the Route.

![](./media/api-gateway/api-gateway-creation07.png)

Review your Route and then Click Create button. Wait until creationg will be completed.

![](./media/api-gateway/api-gateway-creation08.png)

Now you must have created and Active an API Gateway Deployment.

![](./media/api-gateway/api-gateway-creation09.png)

If you click on your new Deployment you could see the Deployment data including the Endpoint to do the api calls. Click in Show to review the Endpoint and Copy it to use in the next steps. You can view also the Telemetry use graphs.

![](./media/api-gateway/api-gateway-creation10.png)

## Test your API Route.
To test your new API Gateway deployment and route, you can use your development machine to execute a cURL command like:
```sh
curl -i -k --data '{"demozone":"madrid","paymentMethod":"amex","pizzaPrice":"21"}' https://<your_endpoint_id>.apigateway.eu-frankfurt-1.oci.customer-oci.com/discount-fn/discount
```
You must receive a response like
```html
HTTP/1.1 200 OK
Date: Wed, 01 Apr 2020 12:23:41 GMT
Content-Type: text/plain
Connection: keep-alive
Content-Length: 4
Server: Oracle API Gateway
Strict-Transport-Security: max-age=31536000
X-XSS-Protection: 1; mode=block
X-Frame-Options: sameorigin
X-Content-Type-Options: nosniff
opc-request-id: /56B744A399CAB72AE35DD23ABD7294D8/E72C6994D4E16D8C3F5DDD0742375F2A

21.0
```
## Modifiying your Microservice Orchestrator
Now that you have created and tested your serverless function with your new api gateway, let's change your microservice orchestrator to send an API call to your serverless function.

To modify your microservice orchestrator, you should use an IDE program like installed in your development machine (visual studio core for example). You could get the code from your GIT repository in Developer Cloud Service (git clone command).

### Git Clone microservice orchestrator project
You can use the same develpment machine as you used in serverless HOL. This machine should have intalled an IDE software like visual studio core, jdeveloper, eclipse... for example. The recomendation is to use a linux based machine but you can use windows too. This HOL was made with a linux based machine.

Create a new directory to store your git project. [vscode-projects-oci] then [nodejs] for example.

![](./media/api-gateway/api-gateway-microservice01.png)

Open Developer Cloud Service microservices project and select microservice_orchestrator in the GIT menu. Then select Clone dropdrownbox and copy https url.

![](./media/api-gateway/api-gateway-microservice04.png)

Next open your IDE software and create a git clone of the microservice orchestrator from Developer Cloud Service GIT repository that you imported in the microservices HOL. This HOL was made with visual studio core included in the [development image in OCI](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/devmachine-marketplace.md) as you could see in ther serverless HOL.

Then ```CTRL+SHIFT+p``` to open the commands menu and select ```git clone```

![](./media/api-gateway/api-gateway-microservice05.png)

Copy the https URL cloned from DevCS and press Enter.

![](./media/api-gateway/api-gateway-microservice06.png)

Select your recently created directory [vscode-projects-oci/nodejs] to put your local git repository and click Select Repository Location button.

![](./media/api-gateway/api-gateway-microservice07.png)

Next write your DevCS user password to access your GIT repository and press Enter. Visual Studio will create a new [.git] repository in your local directory.

![](./media/api-gateway/api-gateway-microservice08.png)

A new [microservice_orchetrator] directory will be created with the entire project inside it.

![](./media/api-gateway/api-gateway-microservice09.png)

### Changing your microservice orchestrator code.
You must change your microservice orchestrator code in order to make an api call to the discount serverless function. First you must introduce a new gateway config in the config.js file. Open this file and write this code after ```HOST: process.env.ORCH_HOST || 'localhost',``` line:

```javascript
    //############### JSON API GW CONFIG ####################
    jsonfncl: {
        getDiscount: {
            host: "fzskntbkilzlpa4dgbyiqbktpm.apigateway.eu-frankfurt-1.oci.customer-oci.com",
            port: 443,
            method: 'POST',
            path: '/discount-fn/getdiscount',
            headers: {
                'Content-Type': 'application/json'
            }
        }
    },
 ```
