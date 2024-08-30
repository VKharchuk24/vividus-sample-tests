Scenario: Precondition - Generate values for register
Given I initialize STORY variable `<variable>` with value `<value>`
Examples:
|variable  |value                            |
|userid    |#{randomInt(1, 10)}              |
|username  |testuser                         |
|firstName |#{generate(Name.firstName)}      |
|lastName  |#{generate(Name.lastName)}       |
|email     |#{generate(Internet.emailAddress)|
|password  |#{generate(Internet.password)    |
|phone     |#{generate(PhoneNumber.cellPhone)|

  
Scenario: Verify that allows creating a User
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  {
  "id": "${userid}",
  "username": "${username}",
  "firstName": "${firstName}",
  "lastName": "${lastName}",
  "email": "${email}",
  "password": "${password}",
  "phone": "${phone}",
  "userStatus": 1
  }
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/user`
Then `${responseCode}` is equal to `200`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/${username}`
Then `${responseCode}` is equal to `200`
Then JSON element value from `${response}` by JSON path `$.username` is equal to `${username}`


Scenario: Verify that allows login as a User
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/login?username=${username}`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows creating the list of Users
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  [{
  "id": "${userid}",
  "username": "${username}",
  "firstName": "${firstName}",
  "lastName": "${lastName}",
  "email": "${email}",
  "password": "${password}",
  "phone": "${phone}",
  "userStatus": 0
  }]
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/user/createWithList`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows Log out User
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/logout`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows adding a new Pet
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  {
   "id": 1111,
  "category": {
    "id": 1,
    "name": "tommi"
  },
  "name": "doggie",
  "photoUrls": [
    "dog1.png" 
  ],
  "tags": [
    {
      "id": 1,
      "name": "barsik"
    }
  ],
  "status": "available"
  }
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/pet`
Then `${responseCode}` is equal to `200`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/pet/1111`
Then `${responseCode}` is equal to `200`
Then JSON element value from `${response}` by JSON path `$.id` is equal to `1111`
Then JSON element value from `${response}` by JSON path `$.name` is equal to `doggie`


Scenario: Verify that allows updating Pet’s image
Given request body: #{loadBinaryResource(/data/dog.png)}
When I set request headers:
|name         |value  	           |	
|accept		  |application/json    |
Given multipart request:
|type  |name      |value            |contentType        |fileName       |
|file  |file      |/data/dog.png    |image/png          |               |
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/pet/1111/uploadImage`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows updating Pet’s name and status
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  {
  "id": 1,
  "category": {
    "id": 1,
    "name": "rokie"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 1,
      "name": "rex"
    }
  ],
  "status": "available"
  }
When I execute HTTP PUT request for resource with URL `https://petstore.swagger.io/v2/pet`
Then `${responseCode}` is equal to `200`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/pet/1`
Then `${responseCode}` is equal to `200`
Then JSON element value from `${response}` by JSON path `$.name` is equal to `doggie`
Then JSON element value from `${response}` by JSON path `$.status` is equal to `available`


Scenario: Verify that allows deleting Pet 
When I set request headers:
|name         | value            						|
|accept       | application/json 						|
|api_key      |AIzaSyDaGmWKa4JsXZ-HjGw7ISLn_3namBGewQe  |
When I execute HTTP DELETE request for resource with URL `https://petstore.swagger.io/v2/pet/1`
Then `${responseCode}` is equal to `200`
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/pet/1`
Then `${responseCode}` is equal to `404`




