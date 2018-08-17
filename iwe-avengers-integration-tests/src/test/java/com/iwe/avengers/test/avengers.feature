Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://c43hcfbxrg.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Avenger Not Found

Given path 'avengers', 'invalid'
When method get
Then status 404

Scenario: Registry a new Avenger

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

Given path 'avengers', 'sdsa-sasa-asas-sasa'
And request {name: 'Rogerio Pinho',	secretIdentity: 'Testes Testes'}
When method put
Then status 200
And match response == {id: '#string', name: 'Rogerio Pinho',	secretIdentity: 'Testes Testes'}

Scenario: Update a Avenger Not Found

Given path 'avengers', 'invalid code'
And request {name: 'Iron Man',	secretIdentity: 'Tony Stark'}
When method put
Then status 404

Scenario: Delete a Avenger by Id

Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method delete
Then status 204

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

Given path 'avengers', 'assd-dsfsd-dsfsd-sdfsd'
And request {secretIdentity: 'Steve Rogers'}
When method put
Then status 400