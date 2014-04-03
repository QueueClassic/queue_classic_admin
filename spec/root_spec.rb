require 'spec_helper'

describe "The root page", :type => :feature do
  it "should display hello world" do
    QC.enqueue "Class.method"
    visit '/'
    page.should have_content "Class.method"
  end
end
