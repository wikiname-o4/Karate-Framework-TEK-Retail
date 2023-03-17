@CompleteTest
Feature: TEK Retail Shoppping Cart Feature

  Background: 
    Given url retailUrl
    * def login = callonce read('TokenGenerator.feature')
    * def token = login.token
    * def buyerID = login.response.roleId
    * header x-access-token = token

  @CreateCartItem
  Scenario: Create a new Cart Item
    * path '/shopping-cart'
    * def cartItems = callonce read('ShoppingCart.feature@GetAllCartItems')
    * def productIDFunction =
      """
      function(x) {
      return parseInt(Math.random() * (89) + 1);
      }
      """
    * def productID = call productIDFunction
    * request
      """
      {
      "productId": "#(productID)",
      "quantity": 2
      }
      """
    * method post
    * status 200
    * print response

  @GetAllCartItems
  Scenario: Get all cart items
    * path '/shopping-cart'
    * param buyerId = buyerID
    * method get
    * status 200
    * print response

  @UpdateCartItem
  Scenario: Update Cart Item
    * def items = callonce read('ShoppingCart.feature@GetAllCartItems')
    * def itemID = items.response[0].id
    * path '/shopping-cart/' + itemID
    * request {"quantity": 5}
    * method patch
    * status 200
    * print response

  @DeleteCartItem
  Scenario: Delete Cart Item
    * def items = callonce read('ShoppingCart.feature@GetAllCartItems')
    * def itemID = items.response[0].id
    * path '/shopping-cart/' + itemID
    * method delete
    * status 200
    * print response

  @DeleteMultipleCartItems
  Scenario: Delete multiple cart items by id
    # Create 2 items
    * def func = function(i){ return karate.call('ShoppingCart.feature@CreateCartItem') }
    * def run = karate.repeat(2, func )
    * path '/shopping-cart/bulk-delete'
    * def items = callonce read('ShoppingCart.feature@GetAllCartItems')
    * def item1ID = items.response[0].id
    * def item2ID = items.response[1].id
    * request
      """
      {
      "items": [
        "#(item1ID)",
        "#(item2ID)"
      ]
      }
      """
    * method delete
    * status 200
    * print response
