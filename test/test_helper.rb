ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module ActionDispatch
  class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
  end
end

module ActionController
  class ActionController::TestCase
    include Devise::Test::ControllerHelpers
  end
end

module ActiveSupport
  class TestCase
    fixtures :all
  end
end
