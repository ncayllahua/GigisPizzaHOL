# Function fn discount campaign
This serverless function access **ATP DB** with **JDBC driver** and get information about current and enabled discount campaigns. whether the current pizza order has a discount campaign available, based on the dates, method of payment and pizza price then this function will response with the new order price applying the discount to the original pizza price.

Table of Contents:
1. [fn discount upload IDE preparation](#fn-discount-upload-ide-preparation)
2. [fn discount upload java code](#fn-discount-upload-java-code)
3. [Changing func.yaml file](#changing-funcyaml-file)
4. [Overwriting pom.xml file](#overwriting-pomxml-file)
5. [Creating OCI config and oci_api_key.pem files](#creating-oci-config-and-oci_api_keypem-files)
6. [Creating Multi Stage Dockerfile](#creating-multi-stage-dockerfile)
7. [Copy necessary .libs and .so files](#copy-necessary-libs-and-so-files)
8. [Deploy fn discount upload function](#deploy-fn-discount-upload-function)
9. [Code recap (OPTIONAL)](#code-recap-optional)
10. [Continue the HOL](#continue-the-hol)

Verify that your cloud_events function has 2 files (func.yaml and pom.xml) and a **src** directory.

```sh 
cd fn_discount_campaign

ls -la
```

![](./media/fn-discount-campaign/faas-create-function01.PNG)

The serverless function should be created at ```src/main/java/com/example/fn/HelloFunction.java``` and you can review the example code with and your IDE or text editor. This file will be change in the next section.

![](./media/fn-discount-campaign/faas-create-function02.PNG)

A Junit textfile should be created at ```src/test/java/com/example/fn/HelloFunctionTest.java``` and used to test the serverless function before deploy it in OCI FaaS. We won't use Junit testing in this lab, but you could add some testing Junit file to your serverles function if you want.

![](./media/fn-discount-campaign/faas-create-function03.PNG)

## fn discount upload IDE preparation
You could deploy this new serverless function in your FaaS environment, but the idea is to change the example code by the real function code. You can use a text editor or you favourite IDE software. In this lab we used Visual Studio Code (from the developer machine imagen in OCI marketplace), so all images was captured with that IDE, but you can use what you want.

Open Visual Studio Code (Applications -> Accessories in the development VM) or your favourite IDE 

![](./media/faas-create-function07.PNG)

Select **add workspace folder ...** in the Start Menu.

![](./media/faas-create-function08.PNG)

Click in HOME directory and next select the appropiate path to your function project directory [opc/holserverless/fn_discount_campaign]. Then click Add button to create a workspace from this directory in Visual Studio Core.

![](./media/fn-discount-upload/faas-create-function04.PNG)

A new project will be available as workspace in the IDE

![](./media/fn-discount-upload/faas-create-function05.PNG)

You can click in **HelloFunction.java** to review your serverless function code. Same for **HelloFunctionTest.java** file.

![](./media/fn-discount-upload/faas-create-function06.PNG)

### fn discount upload java code
The function code is in the next github [repository](https://github.com/oraclespainpresales/fn_pizza_discount_campaign). You can open it in other web brower tab (```CRTL + mouse click```, to review the project.

You can access java code to copy and paste it in your develpment machine IDE project. You could clone this github repository if you want, instead of copy and paste the different files. You can learn how to clone the git repo in this [section](clone-git project to IDE).

For educational purposes you will change the code created before with ```fn init``` command instead of clone the git repo, but you could use that method to replicate the entire function project.

You can copy the java function code creating a new file with the function name, in the fn directory or overwriting the existing code inside the **[HelloFunction.java]** function and next rename it (F2 key or right mouse button and Rename). We show you both methods in the next sections, please choose one of them.

#### Creating new file
Create new file in ```/src/main/java/com/example/fn``` directory. Right mouse button and then New File.

![](./media/fn-discount-campaign/faas-create-function07.PNG)

Then set the same name as java class **[GetDiscount.java]**

![](./media/fn-discount-campaign/faas-create-function08.PNG)

Now copy raw function code and paste it from the [java function code](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_campaign/master/src/main/java/com/example/fn/GetDiscount.java).

![](./media/fn-discount-campaign/faas-create-function09.PNG)

Delete HelloFunction.java and HelloFunctionTest.java from your IDE project.

#### Overwriting HelloFunction.java
You can overwrite the HelloFunction.java code with the DiscountCampaignUploader Function code.

Select the raw [java function code](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_campaign/master/src/main/java/com/example/fn/GetDiscount.java) from the repository and paste it overwriting the HelloFunction.java Function.

![](./media/fn-discount-campaign/faas-create-function10.PNG)

Click right mouse button in the HelloFunction.java file to Rename the file. You can press F2 key to rename the HelloFunction.java file as a shortcut.

![](./media/fn-discount-campaign/faas-create-function11.PNG)

Change the name of the java file to **[GetDiscount.java]**.

![](./media/fn-discount-campaign/faas-create-function12.PNG)

You can delete the HelloFunctionTest.java file (and the test directory tree) or rename it and change the code to create your JUnit tests. In this lab we won't create JUnit test.

![](./media/fn-discount-campaign/faas-create-function13.PNG)

You should have the java function code, the func.yaml and pom.xml files in your project directory right now.

![](./media/fn-discount-campaign/faas-create-function14.PNG)

## Changing func.yaml file
You have to delete several files in the func.yaml code to create your custom Docker multi stage file. In you IDE select func.yaml file and delete next lines:

```
runtime: java
build_image: fnproject/fn-java-fdk-build:jdk11-1.0.105
run_image: fnproject/fn-java-fdk:jre11-1.0.105
cmd: com.example.fn.HelloFunction::handleRequest
```
![](./media/fn-discount-campaign/faas-create-function15.PNG)

## Overwriting pom.xml file
Next you must overwrite the example maven pom.xml file with the [pom.xml](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_campaign/master/pom.xml) content of the github function project. Maven is used to import all the dependencies and java classes needed to create your serverless function jar. 

![](./media/fn-discount-campaign/faas-create-function16.PNG)

Then click in File -> Save All in your IDE to save the changes.

![](./media/fn-discount-campaign/faas-create-function17.PNG)

## Creating Multi Stage Dockerfile
You must create a new multi stage docker file, to deploy your serverless function as a docker image in your OCIR repository. This file must be created before deploying the function.

Select fn_discount_cloud_events folder in your IDE and create new file with [Dockerfile] name clicking right mouse button

![](./media/fn-discount-campaign/faas-create-function18.PNG)

Next copy from raw [Docker file code](https://raw.githubusercontent.com/oraclespainpresales/fn_pizza_discount_campaign/master/Dockerfile) to your new local Dockerfile file.

![](./media/fn-discount-campaign/faas-create-function19.PNG)

After that, click in File -> Save All in your IDE to save all changes.

## Copy necessary .libs and .so files


## Deploy fn discount upload function
To deploy your serverless function please follow next steps, your function will be created in OCI Functions inside your serverles app [gigis-serverless-hol]. 

Open a terminal in your development machine and execute:
```sh
cd $HOME/holserverless/fn_discount_campaign
```
Then you must login in OCIR registry with ```docker login``` command. Introduce your OCI user like ```<namespace>/<user>``` when docker login ask you about username and your previously created **OCI Authtoken** as password.
```sh
docker login fra.ocir.io
```
![](./media/fn-discount-campaign/faas-create-function20.PNG)

You must execute next command with ```--verbose``` option to get all the information about the deploy process.
```sh
fn --verbose deploy --app gigis-serverless-hol
```

![](./media/fn-discount-campaign/faas-create-function21.PNG)

Wait to maven project download dependencies and build jar, docker image creation and function deploy in OCI serverless app finish.

![](./media/fn-discount-campaign/faas-create-function22.PNG)

Check that your new function is created in your serverless app [gigis-serverless-hol] at Developer Services -> Functions menu.

![](./media/fn-discount-campaign/faas-create-function23.PNG)

Now you can continue with the execution of the serverless application or optionally review the code to know more about this serverless function.

## Code recap (OPTIONAL)
You copy the function code and made several changes in the configuration files like func.yaml and pom.xml then you created a new Dockerfile to deploy the function. Now we'll explain this changes:

### GetDiscount.java
Your function name is the same as main class and this class must have a public handleRequest method. String invokeEndpointURL and String functionId variables must be changed to call your [GetDiscount] function. 

```java
```

### func.yaml

```yaml
schema_version: 20180708
name: fn_discount_cloud_campaign
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
Last line is the entrypoint to execute the function. Represent the path to the funcion name [HelloFunction] and [handleRequest] public method. Also you will find it in the new multi stage Dockerfile as CMD command.
```
cmd: com.example.fn.HelloFunction::handleRequest
```
### pom.xml
Pom.xml file is your maven project descriptor. First of all you must review properties, groupId, artifactId and version. In properties you select the fdk version for your project. GroupId is the java path to your class. ArtifactId is the name of the artifact to create and version is its version number [1.0.105].
```xml
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <fdk.version>1.0.105</fdk.version>
    </properties>
    <groupId>com.example.fn</groupId>
    <artifactId>discountcampaignuploader</artifactId>
    <version>1.0.0</version>
```
In repositories section you must describe what repositories will be used in your project. For this serverless function you will use only one repository (fn repository) but you could add more repositories as your needs.
```xml
    <repositories>
        <repository>
            <id>fn-release-repo</id>
            <url>https://dl.bintray.com/fnproject/fnproject</url>
            <releases>
                <enabled>true</enabled>
            </releases>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
        </repository>
    </repositories>
 ```
In the dependencies section you will describe your classes dependencies. In this pom.xml you have to put all jdbc dependencies and driver connection to the ATP: ojdbc8, ucp, oraclepki, osdt_core, osdt_cert for **version 18.3.0.0**. We are testing version 19.3.0.0 too, and you can see that dependencies for 19.3 are commented in the pom.xml file.

```xml
     <dependency>
        <groupId>com.fnproject.fn</groupId>
        <artifactId>api</artifactId>
        <version>${fdk.version}</version>
    </dependency>
    <dependency>
        <groupId>com.fnproject.fn</groupId>
        <artifactId>runtime</artifactId>
        <version>${fdk.version}</version>
    </dependency>
    <dependency>
        <groupId>com.oracle.jdbc</groupId>
        <artifactId>ojdbc8</artifactId>
        <version>18.3.0.0</version>
    </dependency>
    <dependency>
        <groupId>com.oracle.jdbc</groupId>
        <artifactId>ucp</artifactId>
        <version>18.3.0.0</version>
    </dependency>
    <dependency>
        <groupId>com.oracle.jdbc</groupId>
        <artifactId>oraclepki</artifactId>
        <version>18.3.0.0</version>
    </dependency>
    <dependency>
        <groupId>com.oracle.jdbc</groupId>
        <artifactId>osdt_core</artifactId>
        <version>18.3.0.0</version>
    </dependency>
    <dependency>
        <groupId>com.oracle.jdbc</groupId>
        <artifactId>osdt_cert</artifactId>
        <version>18.3.0.0</version>
    </dependency>
```
Build section is used to define the maven and other building configurations like jdk version [13] for example. And we are testing other jdk versions like 11 and 12. All these testing that we are doing is to try the graalvm native image in this kind of serverless projects. The problem with native image is that you need all jar/class dependecies and some manual configuration (like reflection or jni) to create a runnable native image with graalvm compiler. 
```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.0</version>
                <configuration>
                   <!--source>12</source>
                   <target>12</target-->
                   <release>13</release>
                   <compilerArgs>--enable-preview</compilerArgs>
                    <!--source>12</source>
                    <target>12</target-->
                </configuration>
            </plugin>
            <plugin>
                 <groupId>org.apache.maven.plugins</groupId>
                 <artifactId>maven-surefire-plugin</artifactId>
                 <version>2.22.1</version>
                 <configuration>
                     <useSystemClassLoader>false</useSystemClassLoader>
                 </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-deploy-plugin</artifactId>
                <version>2.8.2</version>
                <configuration>
                    <skip>true</skip>
                </configuration>
            </plugin>
        </plugins>
    </build>
```
### Dockerfile
You created a multi stage Dockerfile to customize the serverless function deploy. You have several stages before to create the final image docker. This intermediate stages are not included in the final image. In this dockerfile first stage is created as cache-stage and include the .so lib. Then you can see a second stage [build-stage] from a openjdk-13 to create the maven package.
```dockerfile
FROM delabassee/fn-cache:latest as cache-stage
FROM openjdk:13 as build-stage
WORKDIR /function
RUN curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -o apache-maven-3.6.3-bin.tar.gz 
RUN tar -zxvf apache-maven-3.6.3-bin.tar.gz
ENV PATH="/function/apache-maven-3.6.3/bin:${PATH}"
```
To access to your ATP DB you have to insert the dbwallet.zip file that you downloaded when you created the ATP DB. The dbwallet.zip must be unzipped, so you need to install unzip in this temporal stage layer ```yum install -y unzip```. Then you can unzip the **dbwallet.zip** file, copy the unzipped files to **[/function/wallet]** directory and finally delete these unzipped files. In the optional part of the demo with developer cloud service you can create a pipeline to download the dbwallet.zip file with oci cli command in real time, avoiding to download the dbwallet.zip file to your laptop or server hard disk. That method is safer than manual downloading.
```dockerfile
RUN yum install -y unzip

COPY dbwallet.zip /function
RUN unzip /function/dbwallet.zip -d /function/wallet/ && rm /function/dbwallet.zip
```
In this part of the dockerfile you will create the package, so you have to use the **pom.xml** file and insert all the jar dependecies from jdbc jar and other jar libraries.
```dockerfile
ENV MAVEN_OPTS -Dhttp.proxyHost= -Dhttp.proxyPort= -Dhttps.proxyHost= -Dhttps.proxyPort= -Dhttp.nonProxyHosts= -Dmaven.repo.local=/usr/share/maven/ref/repository
ADD pom.xml /function/pom.xml
ADD src /function/src
ADD libs/* /function/target/libs/

RUN ["mvn", "install:install-file", "-Dfile=/function/target/libs/ojdbc8.jar",    "-DgroupId=com.oracle.jdbc", "-DartifactId=ojdbc8",    "-Dversion=18.3.0.0", "-Dpackaging=jar"]
RUN ["mvn", "install:install-file", "-Dfile=/function/target/libs/ucp.jar",       "-DgroupId=com.oracle.jdbc", "-DartifactId=ucp",       "-Dversion=18.3.0.0", "-Dpackaging=jar"]
RUN ["mvn", "install:install-file", "-Dfile=/function/target/libs/oraclepki.jar", "-DgroupId=com.oracle.jdbc", "-DartifactId=oraclepki", "-Dversion=18.3.0.0", "-Dpackaging=jar"]
RUN ["mvn", "install:install-file", "-Dfile=/function/target/libs/osdt_core.jar", "-DgroupId=com.oracle.jdbc", "-DartifactId=osdt_core", "-Dversion=18.3.0.0", "-Dpackaging=jar"]
RUN ["mvn", "install:install-file", "-Dfile=/function/target/libs/osdt_cert.jar", "-DgroupId=com.oracle.jdbc", "-DartifactId=osdt_cert", "-Dversion=18.3.0.0", "-Dpackaging=jar"]

#RUN ["mvn", "package"]

RUN ["mvn", "package", \
    "dependency:copy-dependencies", \
    "-DincludeScope=runtime", \
    "-Dmdep.prependGroupId=true", \
    "-DoutputDirectory=target","-e" ]
```
After maven package and jar creation in this temporal layer target directory. You can see a [jdeps](https://docs.oracle.com/en/java/javase/13/docs/specs/man/jdeps.html) and [jlink](https://docs.oracle.com/en/java/javase/13/docs/specs/man/jlink.html) executions. They are java tools to analize dependencies and optimize them, creating a improve custom docker image. 
```dockerfile
#RUN /usr/java/openjdk-13/bin/jdeps --print-module-deps --class-path '/function/target/*' /function/target/function.jar
RUN /usr/java/openjdk-13/bin/jlink --no-header-files --no-man-pages --strip-java-debug-attributes --output /function/fnjre --add-modules $(/usr/java/openjdk-13/bin/jdeps --ignore-missing-deps --print-module-deps --class-path '/function/target/*' /function/target/function.jar)
```
Final stage layer of this dockerfile get the jars generated in the previous temporal layers, and optimized with jdes and jlink, get the /libfnunixsocket.so lib and the wallet files to be used in the function jar execution. Finally as always the CMD command with the Function **handleRequest** entrypoint path.
```dockerfile
FROM oraclelinux:8-slim
WORKDIR /function

COPY --from=build-stage /function/target/*.jar /function/
COPY --from=build-stage /function/fnjre/ /function/fnjre/
COPY --from=build-stage /function/wallet/ /function/wallet/
COPY --from=cache-stage /libfnunixsocket.so /lib
#COPY libfnunixsocket.so /lib

ENTRYPOINT [ "/function/fnjre/bin/java", \
    "--enable-preview", \
    "-cp", "/function/*", \
    "com.fnproject.fn.runtime.EntryPoint" ]

#ENTRYPOINT [ "/usr/bin/java","-XX:+UseSerialGC","--enable-preview","-Xshare:on","-cp", "/function/*","com.fnproject.fn.runtime.EntryPoint" ]

CMD ["com.example.fn.GetDiscount::handleRequest"]
```
# Continue the HOL

* [Execute you serverless Application](https://github.com/oraclespainpresales/GigisPizzaHOL/blob/master/fn_discount_campaign.md)
