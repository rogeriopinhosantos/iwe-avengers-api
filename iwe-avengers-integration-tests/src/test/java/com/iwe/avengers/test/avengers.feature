Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://c43hcfbxrg.execute-api.us-east-1.amazonaws.com/dev'

Scenario: Get Avenger by Id

Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method get
Then status 200
And match response == {id: '#string', name: 'Iron Man',	secretIdentity: 'Tony Stark'}

Scenario: Registry a new Avenger

Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Iron Man',	secretIdentity: 'Tony Stark'}

Scenario: Delete a Avenger

Given path 'avengers', 'sdsa-sasa-asas-sasa'
When method delete
Then status 204

Scenario: Update a Avenger

Given path 'avengers', 'sdsa-sasa-asas-ssss'
And request {name: 'Iron Man',	secretIdentity: 'Tony Stark'}
When method put
Then status 200
And match response == {id: '#string', name: 'Iron Man',	secretIdentity: 'Tony Stark'}