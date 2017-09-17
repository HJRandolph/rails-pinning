ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'




RSpec.configure do |config|



config.before(:all) do
  FactoryGirl.reload
end
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end
  
  config.around(:each) do |clean|
  	DatabaseCleaner.cleaning do
  	  clean.run
  	end
  end
end

