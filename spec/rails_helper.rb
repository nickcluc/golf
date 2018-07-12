# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require File.join(File.dirname(__FILE__), 'support/valid_attribute')
require File.join(File.dirname(__FILE__), 'support/factory_girl')
require File.join(File.dirname(__FILE__), "support/helpers/authentication")
require 'capybara/rspec'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Helpers::Authentication, type: :feature
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  "80 Granite Street, Peabody, MA, 01960", [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => '80 Granite Street, Peabody, MA, 01960',
      'state'        => 'Peabody',
      'state_code'   => 'MA',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
