require_relative "spec_helper"
# require 'capybara/rspec'

describe "The Login Functions" do
  it "responds with a welcome message and starts logged out" do
    visit '/'
    expect(page.status_code).to eq(200)
    expect(page).to have_content("Welcome to the Sinatra Template!")
    expect(page).to have_content("NOT Logged In")
  end

  it "logs in" do
    visit '/'
    click_link 'register'
    within '#registration' do
      fill_in 'username',:with => 'test'
      fill_in 'password',:with => 'test'
      click_button 'Signup!'
    end
    visit '/'
    click_link 'login'
    expect(page.status_code).to eq(200)
    within '#login' do
      fill_in 'username',:with => 'test'
      fill_in 'password',:with => 'test'
      click_button 'submit'
    end
    expect(page).to have_content("Welcome to the Sinatra Template!")
    expect(page).to have_content("Logged In")
  end
end