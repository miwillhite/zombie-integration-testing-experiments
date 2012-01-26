# # Requireds
# zombie  = require 'zombie'
# assert  = require 'assert'
# sinon   = require 'sinon'
# should  = require 'should'
# vowsbdd = require 'vows-bdd'
#     
# 
# # Create a new browser
# browser = new zombie.Browser debug: false
# 
# # Define the feature
# vowsbdd.Feature('Edit a Project')
# 
# 
#   .scenario('Navigating to the New Project form')
#   
#   
#   .given 'the server is ready', ->    
#     server.ready @callback
#   
#     
#   .when 'I visit the project\'s page', ->
#     browser.visit 'http://localhost:3000/projects', @callback
# 
#     
#   .and 'I wait until the DOM is ready and all scripts are loaded', (browser, status) ->
#     browser.wait @callback
# 
# 
#   .and 'I click on the Add Project button', (browser, status) ->
#     browser.clickLink '#add_project_button', @callback
# 
#     
#   .then 'I should see the New Project form', (err, browser, status) ->
#     should.exist browser.query('#project_new form')
# 
# 
#   .when 'I fill in and submit the form', (browser, status) ->
#     sinon.stub browser.window.jQuery, 'ajax'
#     
#     browser
#       .fill( 'title'       , 'Zombie Project' )
#       .fill( 'start_date'  , 'Jan 01, 2012'   )
#       .fill( 'end_date'    , 'Jan 30, 2012'   )
#       .pressButton 'Create Project', @callback
#       
#     
#   .then 'an ajax request should have been triggered', (err, browser, event) ->
#     browser.window.jQuery.ajax.called.should.be.true
#     
#   
#   .when 'the response is successful', (browser, status) ->
#     browser.window.jQuery.ajax.getCall(0).args[0].success()
#     browser.wait @callback
#     
#     
#   .then 'a new Project Detail card should appear', (err, browser) ->
#     browser.query( '#project_detail h3'     ).innerHTML.trim().should.equal 'Zombie Project'
#     browser.query( '.timeline_marker.start' ).innerHTML.trim().should.equal 'Jan 1, 2012'
#     browser.query( '.timeline_marker.end'   ).innerHTML.trim().should.equal 'Jan 30, 2012'
#     
#   
#   .and 'the new project appears in the Projects Timeline', (err, browser) ->
#     browser.query('#projects_timeline li:last').innerHTML.should.match /Zombie/
#     
#     
#   .when 'the response is unsuccessful', (browser, status) ->
#     browser.window.jQuery.ajax.getCall(0).args[0].error()
#     browser.wait @callback
#   
#   
#   .then 'an alert should appear', (err, browser) ->
#     browser.prompted().should.be.ok
#     
#   
#   .complete(-> browser.window.jQuery.ajax.restore())
#   .finish module