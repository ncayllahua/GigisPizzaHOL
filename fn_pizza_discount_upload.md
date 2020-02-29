# Function fn discount upload
Summary:
- [fn discount upload IDE preparation](#fn-discount-cloud-events-ide-preparation)
- [fn discount upload java code](#fn-discount-cloud-events-java-code)
- [Changing func.yaml file](#changing-funcyaml-file)
- [Overwriting pom.xml file](#overwriting-pomxml-file)
- [Creating OCI config and oci_api_key.pem files](#creating-oci-config-and-oci_api_keypem-files)
- [Creating Multi Stage Dockerfile](#creating-multi-stage-dockerfile)
- [Deploy fn discount cloud-events function](#deploy-fn-discount-cloud-events-function)
- [Code recap (OPTIONAL)](#code-recap-optional)

Verify that your cloud_events function has 2 files (func.yaml and pom.xml) and a **src** directory.

```sh 
cd fn_discount_upload

ls -la
```

![](./media/fn-discount-upload/faas-create-function01.PNG)

The serverless function should be created at ```src/main/java/com/example/fn/HelloFunction.java``` and you can review the example code with and your IDE or text editor. This file will be change in the next section.

![](./media/fn-discount-upload/faas-create-function02.PNG)

A Junit textfile should be created at ```src/test/java/com/example/fn/HelloFunctionTest.java``` and used to test the serverless function before deploy it in OCI FaaS. We won't use Junit testing in this lab, but you could add some testing Junit file to your serverles function if you want.

![](./media/fn-discount-upload/faas-create-function03.PNG)

## fn discount upload IDE preparation
You could deploy this new serverless function in your FaaS environment, but the idea is to change the example code by the real function code. You can use a text editor or you favourite IDE software. In this lab we used Visual Studio Code (from the developer machine imagen in OCI marketplace), so all images was captured with that IDE, but you can use what you want.

Open Visual Studio Code (Applications -> Accessories in the development VM) or your favourite IDE 

![](./media/faas-create-function07.PNG)

Select **add workspace folder ...** in the Start Menu.

![](./media/faas-create-function08.PNG)

Click in HOME directory and next select the appropiate path to your function project directory [opc/holserverless/fn_discount_upload]. Then click Add button to create a workspace from this directory in Visual Studio Core.

![](./media/fn-discount-upload/faas-create-function04.PNG)

A new project will be available as workspace in the IDE

![](./media/fn-discount-upload/faas-create-function05.PNG)

You can click in **HelloFunction.java** to review your serverless function code. Same for **HelloFunctionTest.java** file.

![](./media/fn-discount-upload/faas-create-function06.PNG)

### fn discount upload java code
The function code is in the next github [repository](https://github.com/oraclespainpresales/fn_pizza_discount_upload). You can open it in other web brower tab (```CRTL + mouse click```, to review the project.

You can access java code to copy and paste it in your develpment machine IDE project. You could clone this github repository if you want, instead of copy and paste the different files. You can learn how to clone the git repo in this [section](clone-git project to IDE).

For educational purposes you will change the code created before with ```fn init``` command instead of clone the git repo, but you could use that method to replicate the entire function project.

You can copy the java function code creating a new file with the function name, in the fn directory or overwriting the existing code inside the **[HelloFunction.java]** function and next rename it (F2 key or right mouse button and Rename). We show you both methods in the next sections, please choose one of them.

#### Creating new file
Create new file in ```/src/main/java/com/example/fn``` directory. Right mouse button and then New File.

![](./media/fn-discount-upload/faas-create-function07.PNG)

Then set the same name as java class **[UploadDiscountCampaigns.java]**

![](./media/fn-discount-upload/faas-create-function08.PNG)

Now copy raw function code and paste it from the [java function code](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_upload/master/src/main/java/com/example/fn/UploadDiscountCampaigns.java).

![](./media/fn-discount-upload/faas-create-function09.PNG)

Delete HelloFunction.java and HelloFunctionTest.java from your IDE project.

#### Overwriting HelloFunction.java
You can overwrite the HelloFunction.java code with the DiscountCampaignUploader Function code.

Select the raw [java function code]https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_upload/master/src/main/java/com/example/fn/UploadDiscountCampaigns.java) from the repository and paste it overwriting the HelloFunction.java Function.

![](./media/fn-discount-upload/faas-create-function10.PNG)

Click right mouse button in the HelloFunction.java file to Rename the file. You can press F2 key to rename the HelloFunction.java file as a shortcut.

![](./media/fn-discount-upload/faas-create-function11.PNG)

Change the name of the java file to **[UploadDiscountCampaigns.java]**.

![](./media/fn-discount-upload/faas-create-function12.PNG)

You can delete the HelloFunctionTest.java file (and the test directory tree) or rename it and change the code to create your JUnit tests. In this lab we won't create JUnit test.

![](./media/fn-discount-upload/faas-create-function13.PNG)

You should have the java function code, the func.yaml and pom.xml files in your project directory right now.

![](./media/fn-discount-upload/faas-create-function14.PNG)

## Changing func.yaml file
You have to delete several files in the func.yaml code to create your custom Docker multi stage file. In you IDE select func.yaml file and delete next lines:

```
runtime: java
build_image: fnproject/fn-java-fdk-build:jdk11-1.0.105
run_image: fnproject/fn-java-fdk:jre11-1.0.105
cmd: com.example.fn.HelloFunction::handleRequest
```
![](./media/fn-discount-upload/faas-create-function15.PNG)

## Overwriting pom.xml file
Next you must overwrite the example maven pom.xml file with the [pom.xml](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_upload/master/pom.xml) content of the github function project. Maven is used to import all the dependencies and java classes needed to create your serverless function jar. Before click in Save All, review that your dependency **com.fasterxml.jackson.core** version is **2.9.10.1** or higher due a security reasons.

```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.9.10.1</version>
    <scope>compile</scope>
</dependency>
```
![](./media/fn-discount-upload/faas-create-function16.PNG)

Then click in File -> Save All in your IDE to save the changes.

![](./media/fn-discount-upload/faas-create-function17.PNG)

## Creating Multi Stage Dockerfile
You must create a new multi stage docker file, to deploy your serverless function as a docker image in your OCIR repository. This file must be created before deploying the function.

Select fn_discount_cloud_events folder in your IDE and create new file with [Dockerfile] name clicking right mouse button

![](./media/fn-discount-upload/faas-create-function18.PNG)

Next copy from raw [Docker file code](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_upload/master/Dockerfile) to your new local Dockerfile file.

![](./media/fn-discount-upload/faas-create-function19.PNG)

After that, click in File -> Save All in your IDE to save all changes.

## Deploy fn discount cloud-events function
To deploy your serverless function please follow next steps, your function will be created in OCI Functions inside your serverles app [gigis-serverless-hol]. 

Open a terminal in your development machine and execute:
```sh
cd $HOME/holserverless/fn_discount_upload
```
Then you must login in OCIR registry with ```docker login``` command. Introduce your OCI user like ```<namespace>/<user>``` when docker login ask you about username and your previously created **OCI Authtoken** as password.
```sh
docker login fra.ocir.io
```
![](./media/fn-discount-upload/faas-create-function20.PNG)

You must execute next command with ```--verbose``` option to get all the information about the deploy process.
```sh
fn --verbose deploy --app gigis-serverless-hol
```

![](./media/fn-discount-upload/faas-create-function21.PNG)

Wait to maven project download dependencies and build jar, docker image creation and function deploy in OCI serverless app finish.

![](./media/fn-discount-upload/faas-create-function22.PNG)

Check that your new function is created in your serverless app [gigis-serverless-hol] at Developer Services -> Functions menu.

![](./media/fn-discount-upload/faas-create-function23.PNG)

Click in the function name **fn_discount_upload**, click in show OCID and show Endpoint and note their ids as you will need them to create the environment variables in **fn_discount_cloud_events** function section in the next function creation.

## Code recap (OPTIONAL)
You copy the function code and made several changes in the configuration files like func.yaml and pom.xml then you created a new Dockerfile to deploy the function. Now we'll explain this changes:

### DiscountCampaignUploader.java
Your function name is the same as main class and this class must have a public handleRequest method. String invokeEndpointURL and String functionId variables must be changed to call your [UploadDiscountCampaigns] function.
```java
Public class DiscountCampaignUploader {

    public String handleRequest(CloudEvent event) {
        String responseMess      = "";
        String invokeEndpointURL = "https://gw7unyffbla.eu-frankfurt-1.functions.oci.oraclecloud.com";
        String functionId        = "ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaaaack6vdtmj7n2wy3caoljvjvbcuexmvvhm3tp2k7673cg4jj3ir4a";
```
Next is the code for cloud event trigger catch. After a cloud event trigger firing you'll must receive a cloud event similar to
```yaml
{
    "eventType" : "com.oraclecloud.objectstorage.createobject",
    "cloudEventsVersion" : "0.1",
    "eventTypeVersion" : "2.0",
    "source" : "ObjectStorage",
    "eventTime" : "2020-01-21T16:26:30.849Z",
    "contentType" : "application/json",
    "data" : {
      "compartmentId" : "ocid1.compartment.oc1..aaaaaaaatz2chvjiz4d3xdrtzmtxspkul",
      "compartmentName" : "DevOps",
      "resourceName" : "campaigns.json",
      "resourceId" : "/n/wedoinfra/b/bucket-gigis-pizza-discounts/o/campaigns.json",
      "availabilityDomain" : "FRA-AD-1",
      "additionalDetails" : {
        "bucketName" : "bucket-gigis-pizza-discounts",
        "archivalState" : "Available",
        "namespace" : "wedoinfra",
        "bucketId" : "ocid1.bucket.oc1.eu-frankfurt-1.aaaaaaaasndscagkbrqhfcrezkla6cqa2sippfq",
        "eTag" : "199f8dbf-0b8c-41b6-9596-4d2a6792d7e5"
      }
    },
    "eventID" : "3e47d127-19de-6eb8-eb67-0c1ab961fcbc",
    "extensions" : {
      "compartmentId" : "ocid1.compartment.oc1..aaaaaaaatz2chvjiz4d3xdrtzmtxspkul"
    }
}
```
this piece of code parse the cloudevent json description and get the important data like compartmentid, object storage name, bucket name or namespace.
```java
//get upload file properties like namespace or buckername.
            ObjectMapper objectMapper = new ObjectMapper();
            Map data                  = objectMapper.convertValue(event.getData().get(), Map.class);
            Map additionalDetails     = objectMapper.convertValue(data.get("additionalDetails"), Map.class);

            GetObjectRequest jsonFileRequest = GetObjectRequest.builder()
                            .namespaceName(additionalDetails.get("namespace").toString())
                            .bucketName(additionalDetails.get("bucketName").toString())
                            .objectName(data.get("resourceName").toString())
                            .build();
```
That relevant data will be use to access (with authProvider) to the object storage and get the campaign.json file.
```java
AuthenticationDetailsProvider authProvider = new ConfigFileAuthenticationDetailsProvider("/.oci/config","DEFAULT");
            ObjectStorageClient objStoreClient         = ObjectStorageClient.builder().build(authProvider);
            GetObjectResponse jsonFile                 = objStoreClient.getObject(jsonFileRequest);

            StringBuilder jsonfileUrl = new StringBuilder("https://objectstorage.eu-frankfurt-1.oraclecloud.com/n/")
                    .append(additionalDetails.get("namespace"))
                    .append("/b/")
                    .append(additionalDetails.get("bucketName"))
                    .append("/o/")
                    .append(data.get("resourceName"));

            System.out.println("JSON FILE:: " + jsonfileUrl.toString());
            //InputStream isJson = new URL(jsonfileUrl.toString()).openStream();
            InputStream isJson = jsonFile.getInputStream();

            JSONTokener tokener = new JSONTokener(isJson);
			JSONObject joResult = new JSONObject(tokener);

            JSONArray campaigns = joResult.getJSONArray("campaigns");
            System.out.println("Campaigns:: " + campaigns.length());
			for (int i = 0; i < campaigns.length(); i++) {
                JSONObject obj = campaigns.getJSONObject(i);
                responseMess += invokeCreateCampaingFunction (invokeEndpointURL,functionId,obj.toString());
            }
```
			 


### func.yaml

```yaml
schema_version: 20180708
name: fn_discount_cloud_events
version: 0.0.1
```
You must have deleted this 4 lines to create your customized Dockerfile. This lines are using to setup the default deploy fn docker images for java.
```
runtime: java
build_image: fnproject/fn-java-fdk-build:jdk11-1.0.105
run_image: fnproject/fn-java-fdk:jre11-1.0.105
cmd: com.example.fn.HelloFunction::handleRequest
```
Last line is the entry point to execute the function. Represent the path to the funcion name and handleRequest public method and you can find it in the new Dockerfile as CMD command.
```
cmd: com.example.fn.HelloFunction::handleRequest
```
### pom.xml

### Dockerfile
