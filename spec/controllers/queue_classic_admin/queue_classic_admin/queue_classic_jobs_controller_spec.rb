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

    it "should destroy destroy everything" do
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

    it "unlocks locked job" do
      locked_job = queue_classic_job
      locked_job.locked_at = Time.now
      locked_job.save!
      post :unlock, use_route: "queue_classic_admin", id: locked_job 
      locked_job.reload.locked_at.should be_nil
    end
  end
end
