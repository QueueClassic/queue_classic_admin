require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicJobsController do
    let(:queue_classic_job) { QueueClassicJob.create! }

    it "should get index" do
      get :index, use_route: "queue_classic_admin"
      response.should be_success
      assigns(:queue_classic_jobs).should_not be_nil
    end
  
    it "should destroy queue_classic_job" do
      queue_classic_job
      expect do
        delete :destroy, id: queue_classic_job.id, use_route: "queue_classic_admin"
      end.to change(QueueClassicJob, :count).by(-1)
  
      response.code.to_i.should == 302
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
      def lock_job job
        job.locked_at = lock_time
        job.save!
      end

      let(:lock_time) { Time.now }

      before do
        lock_job QueueClassicJob.create!(q_name: 'bar')
        lock_job QueueClassicJob.create!(q_name: 'foo')
      end

      it "should unlock everything" do
        delete :unlock_all, use_route: "queue_classic_admin"
        QueueClassicJob.where(locked_at: nil).count.should == 2
      end

      it "should unlock all in the filtered queue" do
        delete :unlock_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicJob.where(q_name: 'foo').where('locked_at IS NULL').count.should == 1
        QueueClassicJob.where(q_name: 'bar', locked_at: lock_time).count.should == 1
      end
    end
  end
end
