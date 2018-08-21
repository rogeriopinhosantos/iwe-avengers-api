Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://c43hcfbxrg.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Should return Unauthorized access

Given path 'avengers', 'invalid'
When method get
Then status 401

Scenario: Registry a new Avenger

#Create a new Avenger
Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America',	secretIdentity: 'Steve Rogers'}

* def savedAvenger = response

#Get Avenger by id
Given path 'avengers', savedAvenger.id
When method get
Then status 200
And match $ == savedAvenger 



Scenario: Update a Avenger

#create a new Avenger
Given path 'avengers'
And request {name: 'Thor', secretIdentity: 'Thor Odinson'}
When method post
Then status 201

* def createdAvenger = response

#update the Avenger 
Given path 'avengers', createdAvenger.id
And request {name: 'Rogerio Pinho',	secretIdentity: 'Thor - The Lightining God'}
When method put
Then status 200
And match $.id == createdAvenger.id
And match $.name == 'Rogerio Pinho'
And match $.secretIdentity == 'Thor - The Lightining God'

* def updatedAvenger = response

#Get the Avenger updated
Given path 'avengers', updatedAvenger.id
When method get
Then status 200
And match $ == updatedAvenger


Scenario: Delete a Avenger by Id

#Create a new Avenger
Given path 'avengers'
And request {name: 'Black Wildow', secretIdentity: 'Natasha Homanoff'}
When method post
Then status 201

* def deletedAvenger = response

#Delete the Avenger
Given path 'avengers', deletedAvenger.id
When method delete
Then status 204

#Search deleted Avenger
Given path 'avengers', deletedAvenger.id
When method get
Then status 404


Scenario: Delete a Avenger Not Found

Given path 'avengers', 'invalid code'
When method delete
Then status 404

Scenario: Registry Avenger with Invalid Payload

Given path 'avengers'
And request {secretIdentity: 'Steve Rogers'}
When method post
Then status 400


Scenario: Updates Avenger with Invalid Payload

#Create a new Avenger
Given path 'avengers'
And request {name: 'Teste Carolina', secretIdentity: 'Japinha'}
When method post
Then status 201

* def variavel = response

Given path 'avengers', variavel.id
And request {secretIdentity: 'Steve Rogers'}
When method put
Then status 400