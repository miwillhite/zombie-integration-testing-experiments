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
vowsbdd.Feature('Create a Project')


  .scenario('With valid params')
  
  
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
    
    browser
      .fill( 'title'      , 'Zombie Project' )
      .fill( 'start_date' , 'Jan 01, 2012'   )
      .fill( 'end_date'   , 'Jan 30, 2012'   )
      .pressButton 'Create Project', @callback
      
    
  .then 'an ajax request should have been triggered', (err, browser, event) ->
    browser.window.jQuery.ajax.called.should.be.true
    
  
  .when 'the response is successful', (browser, status) ->
    browser.window.jQuery.ajax.getCall(0).args[0].success()
    browser.wait @callback
    
    
  .then 'a new Project Detail card should appear', (err, browser) ->
    browser.text( '#project_detail h3'     ).trim().should.equal 'Zombie Project'
    browser.text( '.timeline_marker.start' ).trim().should.equal 'Jan 1, 2012'
    browser.text( '.timeline_marker.end'   ).trim().should.equal 'Jan 30, 2012'
    
  
  .and 'the new project appears in the Projects Timeline', (err, browser) ->
    browser.query('#projects_timeline li:last').innerHTML.should.match /Zombie/

  .complete(teardown)
  .finish module