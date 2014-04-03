require 'spec_helper'

describe "The root page", :type => :feature do
  it "should display hello world" do
    visit '/'
    page.should have_content "Hello World"
  end
end
