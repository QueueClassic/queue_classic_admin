require 'spec_helper'

describe "The root page", :type => :feature do
  it "should display a list of jobs" do
    QC.enqueue "Class.method"
    visit '/'
    page.should have_content "Class.method"
  end

  it "should support showing QC later jobs" do
    visit '/'
    click_link 'Later jobs'
    page.should have_content "not_before"
  end

  it "should error if the table isn't allowed" do
    visit '/non-existant-table'
    page.should have_content('Invalid table.')
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

  it "should allow the user to delete jobs" do
    QC.enqueue "Class.method"
    visit "/"

    page.should have_content "Class.method"
    click_button "Destroy"
    page.should have_no_content "Class.method"
  end

  it "should allow the user to unlock jobs" do
    QC.enqueue "Class.method"
    execute_sql "UPDATE queue_classic_jobs SET locked_at = now()"

    visit '/'

    page.should have_button "Unlock"
    click_button "Unlock"
    page.should have_no_button "Unlock"
    execute_sql("SELECT * FROM queue_classic_jobs WHERE locked_at IS NOT NULL").should == []
  end

  it "should allow the user to destroy all jobs" do
    2.times { QC.enqueue "Class.method" }
    visit "/"
    click_button "Destroy All"
    page.should have_no_content "Class.method"
    execute_sql("SELECT * FROM queue_classic_jobs").should == []
  end

  it "should allow the user to page back and forth between results" do
    101.times { |i| QC.enqueue "Class.method#{i}" }
    visit "/"
    page.should have_content "Class.method100"
    page.should have_content "Class.method51"
    page.should have_no_content "Class.method50"

    click_link "Next Page"
    page.should have_content "Class.method50"
    page.should have_content "Class.method1"
    page.should have_no_content "Class.method0"

    click_link "Next Page"
    page.should have_no_content "Class.method1"
    page.should have_content "Class.method0"

    click_link "Previous Page"
    page.should have_content "Class.method1"
  end
end
