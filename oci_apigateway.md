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

If you click on your new Deployment you could see the Deployment data including the Endpoint [```
https://je2d6ypgypxxafqh2bsev3vzsm.apigateway.eu-frankfurt-1.oci.customer-oci.com/discount-fn```] to do the api calls. Click in Show to review the Endpoint and Copy it to use in the next steps. You can view also the Telemetry use graphs.

![](./media/api-gateway/api-gateway-creation10.png)

