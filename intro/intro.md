This HOL is based in a Demo developed by WeDo Team as part of an innovation initiative to approach Oracle Cloud Solutions by providing practical examples that could be “touched” and easily understood.

Demo is known as Gigi’s Pizza. The Use Case is focused in microservices/serverless (fn) and Multitenant DataBase. We have three microservices coded in different languages like nodejs and of course Java (Helidon framework). This three microservices are part of a delivery pizza app, one microservice controls the orders, other one controls the pizza delivery and the last one controls the accounting. We coded a serverless function to calculate discounts, according to several bussiness rules like credit card type or pizza order total prize.

1. Order data will be saved as JSON files in multitenant DB (nodejs microservice)
2. Delivery data will be accessed as graph node DB (nodejs microservice and mobile app)
3. Accounting data will be saved as regular SQL data (Java -Helidon- microservice)

We have coded the front-end part of Gigi's pizza app with Visual Builder Cloud Service, that is the Oracle WYSIWYG - What You See Is What You Get - Service. We have three front-end webapps:

1. Orders front-end. It's a list of orders to the cookers (only PIZZA ORDER and PIZZA COOKED status are visualized)
2. Payment front-end. It's the accounting part of the demo and a dashboard to the manager of the gigi's pizza store.
3. Stream front-end. It visualize the pizza status messages (We use Oracle Cloud Streams).

Finally we have tied a chatbot(Skill) with the microservice-order as a front-end to order the pizzas. And a mobile application for the delivery employees. This mobile app gets the PIZZA OUT FOR DELIVERY status orders and calculates the best route from the Gigi's pizza store to the customer address using Oracle Spatial PDB as location gps points/nodes database.

![](./images/gigis-architect01.png)

