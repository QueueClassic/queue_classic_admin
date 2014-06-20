require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicJob do

    def create_job(args)
      QueueClassicJob.new.tap do |job|
        args.each do |k,v|
          job.send("#{k}=", v)
        end
        job.save!
      end
    end

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
      before do
        create_job method: "thing1foo"
        create_job method: "thing2bar"
      end

      it "should work" do
        results = QueueClassicJob.search "foo"
        expect(results.size).to be(1)
      end

    end
  end
end
