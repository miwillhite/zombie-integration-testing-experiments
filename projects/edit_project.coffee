# Requireds
zombie  = require 'zombie'
assert  = require 'assert'
sinon   = require 'sinon'
should  = require 'should'
vowsbdd = require 'vows-bdd'


# Define the teardown
teardown = -> browser.window.jQuery.ajax.restore()

    

# Create a new browser
browser = new zombie.Browser debug: false

# Define the feature
vowsbdd.Feature('Edit a Project')


  .scenario('With valid params')
  
  
  .given 'the server is ready', ->    
    server.ready @callback
  
    
  .when 'I visit the project\'s page', ->
    browser.visit 'http://localhost:3000/projects', @callback

    
  .and 'I wait until the DOM is ready and all scripts are loaded', (browser, status) ->
    browser.wait @callback
    
    
  .and 'I click to edit the first project', (browser, status) ->
    browser.clickLink '.project_bar:first', @callback
    
  
  .then 'I should see the project\'s detail card', (err, browser, status) ->
    browser.text( '#project_detail h3' ).trim().should.equal 'Rook' # Assume I had set this up prior
    
    
  .when 'I go to edit the project', ->
    browser.clickLink '#project_detail .edit_button', @callback
    
    
  .then 'I should see the project\'s edit form', (err, browser, status) ->
    browser.text( '#project_edit header h3' ).trim().should.equal 'Editing: Rook'
    should.exist browser.query( '#project_edit header .destroy' )
    should.exist browser.query( '#project_edit header .cancel' )
    should.exist browser.query( '#project_edit header .save' )
    should.exist browser.query( '#project_edit form' )
    
    
  .when 'I update and submit the form', ->
    sinon.stub browser.window.jQuery, 'ajax'
    
    browser
      .fill( 'title', 'Zombie Project' )
      .clickLink 'Save Changes', @callback
      
  
  .then 'an ajax request should have been triggered', (err, browser, event) ->
    browser.window.jQuery.ajax.called.should.be.true
  
  
  .when 'the response is successful', (browser, status) ->
    browser.window.jQuery.ajax.getCall(0).args[0].success()
    browser.wait @callback


  .then 'the Project Detail card should reappear', (err, browser) ->
    browser.text( '#project_detail h3' ).trim().should.equal 'Zombie Project'
  
    

  .complete(teardown)
  .finish module