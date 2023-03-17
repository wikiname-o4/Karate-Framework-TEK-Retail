@CompleteTest
Feature: Tek Retail Token Generator

Background: 
    Given url retailUrl

  @RetailLogin
  Scenario: TEK Retail Login
    * path '/auth/login'
    * request { "email": "apiaccount@gmail.com","password": "Test@122333"}
    * method post
    * status 200
    * print response
    * def token = response.accessToken
    * print token