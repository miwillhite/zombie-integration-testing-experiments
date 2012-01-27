var zombie  = require('zombie'),
    assert  = require('assert'),
    sinon   = require('sinon'),
    should  = require('should'),
    vows    = require('vows');



vows.describe('Create a Project').addBatch({
  
  'When I visit the projects page': {
    topic: function() {
      var callback = this.callback;
      
      zombie.visit('http://localhost:3000/projects', function(err, browser) {
        browser.wait(callback);
      });
    },
    
    
    'When I click on the Add Project button': {
      topic: function(browser) {
        browser.clickLink('Add Project', this.callback);
      },
      
      
      'Then I should see the New Project form': function(err, browser, status) {
        should.exist(browser.query('#project_new form'));
      },
      
      
      'When I fill in valid information and submit the form': {
        topic: function(browser, status) {
          browser
            .fill( 'title'      , 'Zombie Project' )
            .fill( 'start_date' , 'Jan 01, 2012'   )
            .fill( 'end_date'   , 'Jan 30, 2012'   )
            .pressButton('Create Project', this.callback);
        },
        
        'Then an ajax request should have been triggered': function(err, browser, event) {
          browser.window.jQuery.ajax.called.should.be.true;
        }
              
      }, // When I fill in valid information and submit the form



      'When I fill in invalid information and submit the form': {
        topic: function(browser, status) {
          browser.pressButton('Create Project', this.callback);
        },
        
        'Then an ajax request should not have been triggered': function(err, browser, event) {
          browser.window.jQuery.ajax.called.should.not.be.true;
        }
              
      }, // When I fill in invalid information and submit the form
      
      
      
      
    } // When I click on the Add Project button
    
  } // When I visit the projects page
  
  
  
  

}).export(module);