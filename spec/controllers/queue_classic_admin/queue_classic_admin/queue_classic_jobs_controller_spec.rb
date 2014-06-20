require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicJobsController do
    let(:queue_classic_job) { QueueClassicJob.create! }

    it "should get index" do
      get :index, use_route: "queue_classic_admin"
      response.should be_success
      assigns(:queue_classic_jobs).should_not be_nil
    end

    context "#destroy" do
      it "should destroy queue_classic_job" do
        queue_classic_job
        expect do
          delete :destroy, id: queue_classic_job.id, use_route: "queue_classic_admin"
        end.to change(QueueClassicJob, :count).by(-1)

        response.code.to_i.should == 302
      end
    end

    context "#destroy_all" do
      it "should destroy everything" do
        queue_classic_job
        delete :destroy_all, use_route: "queue_classic_admin"
        QueueClassicJob.count.should == 0
      end

      it "should destroy all in the filtered queue" do
        QueueClassicJob.create! q_name: 'foo'
        QueueClassicJob.create! q_name: 'bar'

        delete :destroy_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicJob.where(q_name: 'foo').count.should == 0
        QueueClassicJob.where(q_name: 'bar').count.should == 1
      end
    end

    context "#unlock_all" do
      def lock_job job, lock_time
        job.locked_at = lock_time
        job.save!
      end

      let(:broken_time) { 10.minutes.ago }
      let(:in_progress_time) { Time.now }

      before do
        lock_job(QueueClassicJob.create!(q_name: 'bar'), broken_time)
        lock_job(QueueClassicJob.create!(q_name: 'foo'), broken_time)
        lock_job(QueueClassicJob.create!(q_name: 'foo'), in_progress_time)
      end

      it "should unlock everything not currently running" do
        delete :unlock_all, use_route: "queue_classic_admin"
        QueueClassicJob.where(locked_at: nil).count.should == 2
        QueueClassicJob.where(locked_at: in_progress_time).count.should == 1
      end

      it "should unlock all not currently running in the filtered queue" do
        delete :unlock_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicJob.where(q_name: 'foo').where('locked_at IS NULL').count.should == 1
        QueueClassicJob.where(q_name: 'foo', locked_at: in_progress_time).count.should == 1
        QueueClassicJob.where(q_name: 'bar', locked_at: broken_time).count.should == 1
      end
    end

    context "#unlock" do
      it "unlocks locked job" do
        locked_job = queue_classic_job
        locked_job.locked_at = Time.now
        locked_job.save!
        post :unlock, use_route: "queue_classic_admin", id: locked_job
        locked_job.reload.locked_at.should be_nil
      end
    end

    context "#custom" do
      it "runs the custom action" do
        custom_job = nil
        QueueClassicAdmin.add_custom_action("Test") { |job| custom_job = job }
        job = queue_classic_job

        post :custom, use_route: "queue_classic_admin", id: job, custom_action: "test"

        expect(custom_job).to_not be_nil
        expect(custom_job).to eql(job)
      end
    end
  end
end
