# Requireds
zombie  = require 'zombie'
assert  = require 'assert'
sinon   = require 'sinon'
should  = require 'should'
vowsbdd = require 'vows-bdd'
    

# Create a new browser
browser = new zombie.Browser debug: false

# Define the feature
vowsbdd.Feature('Create a Project')


  .scenario('With invalid params')
  
  
  .given 'the server is ready', ->    
    server.ready @callback
  
    
  .when 'I visit the project\'s page', ->
    browser.visit 'http://localhost:3000/projects', @callback

    
  .and 'I wait until the DOM is ready and all scripts are loaded', (browser, status) ->
    browser.wait @callback


  .and 'I click on the Add Project button', (browser, status) ->
    browser.clickLink '#add_project_button', @callback

    
  .then 'I should see the New Project form', (err, browser, status) ->
    should.exist browser.query('#project_new form')


  .when 'I fill in and submit the form', (browser, status) ->
    sinon.stub browser.window.jQuery, 'ajax'
    browser.pressButton 'Create Project', @callback


  .then 'an alert should appear stating the errors', (err, browser) ->
    browser.prompted("Start date can't be blank, End date can't be blank").should.be.true

  
  .and 'an ajax request should not have been triggered', (err, browser, event) ->
    browser.window.jQuery.ajax.called.should.be.false


  .and 'the New Project form should still be present', (err, browser) ->
    should.exist browser.query('#project_new form')


  .and 'the new project should not appear in the Projects Timeline', (err, browser) ->
    browser.query('#projects_timeline li:last').innerHTML.should.not.match /Zombie/
  
  
    
  
  .complete(-> browser.window.jQuery.ajax.restore())
  .finish module