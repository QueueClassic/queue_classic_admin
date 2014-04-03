require 'spec_helper'

describe "The root page", :type => :feature do
  it "should display a list of jobs" do
    QC.enqueue "Class.method"
    visit '/'
    page.should have_content "Class.method"
  end

  it "should allow the user to switch between job queues" do
    QC.enqueue "Default.method"
    QC::Queue.new("named_queue").enqueue("Named.method")

    visit "/"
    page.should have_content "Default.method"
    page.should have_content "Named.method"

    click_link "named_queue"
    page.should have_content "Named.method"
    page.should have_no_content "Default.method"
  end
end
