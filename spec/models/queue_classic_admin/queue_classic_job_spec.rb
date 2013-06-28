require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicJob do
    before do
      QueueClassicJob.connection.execute "
        ALTER TABLE #{QueueClassicJob.table_name} ADD COLUMN test_column VARCHAR(255) 
      "
      QueueClassicJob.reset_column_information
    end

    after do
      QueueClassicJob.connection.execute "
        ALTER TABLE #{QueueClassicJob.table_name} DROP COLUMN test_column
      "
      QueueClassicJob.reset_column_information
    end

    it "list extra columns" do
      QueueClassicJob.extra_columns.should == ["test_column"]
    end
  end
end
