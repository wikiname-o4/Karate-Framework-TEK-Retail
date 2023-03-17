@CompleteTest
Feature: Tek Retail API Payment Feature

  Background: 
    Given url retailUrl
    * def login = callonce read('TokenGenerator.feature')
    * def token = login.token
    * header x-access-token = token

  @CreatePayment
  Scenario: Create a new payment method
    * path '/payment'
    * def gen = Java.type('data.DataGenerator')
    * def cardNumber = gen.getCardNumber()
    * def nameOnCard = gen.getFullName()
    * request
      """
      {
      "cardNumber": "#(cardNumber)",
      "nameOnCard": "#(nameOnCard)",
      "expirationMonth": 12,
      "expirationYear": 2025,
      "securityCode": "707"
      }
      """
    * method post
    * status 200
    * print response

  @GetAllPayments
  Scenario: Get all payment methods of a customer
    * path '/payment'
    * method get
    * status 200
    * print response

  @UpdatePayment
  Scenario: Update a payment method of a customer
    * def payment = callonce read('Payment.feature@GetAllPayments')
    * def paymentId = payment.response[0].id
    * path '/payment/' + paymentId
    * request
      """
      {
      "expirationMonth": 12,
      "expirationYear": 2026
      }
      """
    * method put
    * status 200
    * print response

  @DeletePayment
  Scenario: Delete Payment method of a customer
    * def payment = callonce read('Payment.feature@GetAllPayments')
    * def paymentId = payment.response[0].id
    * path '/payment/' + paymentId
    * method delete
    * status 200
    * print response
    
    
    