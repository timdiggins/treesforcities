ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

$: << File.expand_path(File.dirname(__FILE__) + "/integration/dsl")
require 'basics_dsl'
require 'test_help'
require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true

  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #include AuthenticatedTestHelper
end

class ActionController::IntegrationTest

  def new_session(&block) 
    open_session do | session | 
      session.extend(BasicsDsl)
      session.host!("trees.dev")
      session.instance_eval(&block) if block
      session
    end 
  end 
  
  def new_session_as(user_symbol, &block)
    session = new_session
    session.login(user_symbol)
    session.instance_eval(&block) if block
    session
  end 

  def logger
    Rails.logger
  end

  def assert_response_404
    assert_response 404
    assert_select "a[href=/]"
  end
    
    def login!(login, password = "monkey")
    @logged_in = super
  end

end
module ActionController
  module Integration
    module Runner
      def reset!
        @integration_session = new_session
      end
    end
  end
end