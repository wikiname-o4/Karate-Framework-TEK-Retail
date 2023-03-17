@CompleteTest
Feature: Tek Retail API Address Feature

  Background: 
    Given url retailUrl
    * def login = callonce read('TokenGenerator.feature')
    * def token = login.token
    * header x-access-token = token

  @CreateNewAddress
  Scenario: Create New Address
    * path '/address'
    * def gen = Java.type('data.DataGenerator')
    * def fullName = gen.getFullName()
    * def phoneNumber = gen.getPhoneNumber()
    * def streetAddress = gen.getStreetAddress()
    * def city = gen.getCity()
    * def state = gen.getState()
    * def zipCode = gen.getPostalCode()
    * request
      """
      {
      "country": "United States",
      "fullName": "#(fullName)",
      "phoneNumber": "#(phoneNumber)",
      "street": "#(streetAddress)",
      "apartment": "11",
      "city": "#(city)",
      "state": "#(state)",
      "zipCode": "#(zipCode)"
      }
      """
    * method post
    * status 200
    * print response

  @GetAddress
  Scenario: Get All Addresses of a customer
    * path '/address'
    * method get
    * status 200
    * print response

  @UpdateAddress
  Scenario: Update an Address
    * def address = callonce read('Address.feature@GetAddress')
    * def addressId = address.response[0].id
    * path '/address/'+ addressId
    * def gen = Java.type('data.DataGenerator')
    * def fullName = gen.getFullName()
    * request
      """
      {
      "country": "United States",
      "fullName": "#(fullName)"
      }
      """
    * method put
    * status 200
    * print response

  @DeleteAddress
  Scenario: Delete an Address
    * def address = callonce read('Address.feature@GetAddress')
    * def addressId = address.response[0].id
    * path '/address/'+ addressId
    * method delete
    * status 200
    * print response
