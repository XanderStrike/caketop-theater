# This file is copied to spec/ when you run 'rails generate rspec:install'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'database_cleaner'

# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Require page objects
Dir[Rails.root.join("spec/page_objects/*.rb")].each { |f| require f }


RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.strategy = :truncation if example.metadata.fetch(:js, false)

    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def factory_attributes(klass)
  klass.attribute_names.map(&:to_sym) - [:id, :created_at, :updated_at]
end

def create_settings
  create(:setting, name: 'name', content: 'Caketop Theater', boolean: true)
  create(:setting, name: 'about', content: '<h1>About</h1>', boolean: true)
  create(:setting, name: 'banner', content: '', boolean: false)
  create(:setting, name: 'footer', content: 'This is the footer.', boolean: false)
  create(:setting, name: 'url', content: '/', boolean: false)
  
  create(:setting, name: 'admin', content: '', boolean: false)
  create(:setting, name: 'admin-pass', content: '', boolean: false)
end
