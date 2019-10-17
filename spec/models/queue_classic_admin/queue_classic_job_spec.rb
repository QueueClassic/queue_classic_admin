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
      expect(QueueClassicJob.extra_columns).to contain_exactly('test_column')
    end

    describe '.ready' do
      before do
        QC.enqueue 'puts'
      end

      it { expect(QueueClassicJob.ready.count).to eq 1 }
      it { expect(QueueClassicJob.scheduled.count).to eq 0 }
    end

    describe '.scheduled' do
      before do
        QC.enqueue_in 10, 'puts'
      end

      it { expect(QueueClassicJob.ready.count).to eq 0 }
      it { expect(QueueClassicJob.scheduled.count).to eq 1 }
    end

    context ".search" do
      let!(:job1) { create_job_qc_job method: "thing1foo", q_name: 'high' }
      let!(:job2) { create_job_qc_job method: "thing2bar", q_name: 'low' }

      it "works" do
        results = QueueClassicJob.search "foo"
        expect(results).to contain_exactly(job1)
      end

      context "custom extra column" do
        before do
          @old_columns = described_class.searchable_columns.dup
          described_class.searchable_columns << :q_name
        end

        after do
          described_class.searchable_columns.replace(@old_columns)
        end

        it "supports extra columns" do
          results = described_class.search('low')
          expect(results).to contain_exactly(job2)
        end
      end
    end
  end
end
