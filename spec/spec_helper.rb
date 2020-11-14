ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  DatabaseCleaner.strategy = :truncation

  config.before do
    Author.destroy_all
    Comment.destroy_all
    Facebook.destroy_all
    Post.destroy_all
    Profile.destroy_all
    Twitter.destroy_all
  end

  config.after do
    Author.destroy_all
    Comment.destroy_all
    Facebook.destroy_all
    Post.destroy_all
    Profile.destroy_all
    Twitter.destroy_all
  end

  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
