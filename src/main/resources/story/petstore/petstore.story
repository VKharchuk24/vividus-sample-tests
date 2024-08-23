Scenario: Verify that allows creating a User
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  {
  "id": 7,
  "username": "testuser",
  "firstName": "Test",
  "lastName": "User",
  "email": "testuser@example.com",
  "password": "password123",
  "phone": "1234567890",
  "userStatus": 1
  }
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/user`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows login as a User
When I execute HTTP GET request for resource with URL `https://petstore.swagger.io/v2/user/login?username=rrr&password=rrr`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows creating the list of Users
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  [{
  "id": 0,
  "username": "testuser",
  "firstName": "Test",
  "lastName": "User",
  "email": "testuser@example.com",
  "password": "password123",
  "phone": "1234567890",
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
   "id": 1,
  "category": {
    "id": 1,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 1,
      "name": "string"
    }
  ],
  "status": "available"
  }
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/pet`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows updating Pet’s image
Given request body: #{loadBinaryResource(/data/dog.png)}
When I set request headers:
|name         |value  	           |	
|accept		  |application/json    |
Given multipart request:
|type  |name      |value            |contentType        |fileName       |
|file  |file      |/data/dog.png    |image/png          |               |
When I execute HTTP POST request for resource with URL `https://petstore.swagger.io/v2/pet/1/uploadImage`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows updating Pet’s name and status
When I set request headers:
|name         | value            |
|Content-Type | application/json |
Given request body:  {
  "id": 0,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
  }
When I execute HTTP PUT request for resource with URL `https://petstore.swagger.io/v2/pet`
Then `${responseCode}` is equal to `200`


Scenario: Verify that allows deleting Pet 
When I set request headers:
|name         | value            						|
|accept       | application/json 						|
|api_key      |AIzaSyDaGmWKa4JsXZ-HjGw7ISLn_3namBGewQe  |
When I execute HTTP DELETE request for resource with URL `https://petstore.swagger.io/v2/pet/1`
Then `${responseCode}` is equal to `200`