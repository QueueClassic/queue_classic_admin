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

    context ".search" do
      let!(:job1) { create_job_qc_job method: "thing1foo", q_name: 'high' }
      let!(:job2) { create_job_qc_job method: "thing2bar", q_name: 'low' }

      it "should work" do
        results = QueueClassicJob.search "foo"
        results.should == [job1]
      end

      context "custom extra column" do
        before do
          @old_columns = described_class.searchable_columns.dup
          described_class.searchable_columns << :q_name
        end

        after do
          described_class.searchable_columns.replace(@old_columns)
        end

        it "should support extra columns" do
          results = described_class.search('low')
          results.should == [job2]
        end
      end
    end
  end
end
