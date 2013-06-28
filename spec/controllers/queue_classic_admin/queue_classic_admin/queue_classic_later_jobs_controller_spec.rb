require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicLaterJobsController do
    let(:queue_classic_job) { QueueClassicLaterJob.create }
  
    it "should get index" do
      get :index
      response.should be_success
      assigns(:queue_classic_jobs).should_not be_nil
    end
  
    it "should destroy queue_classic_job" do
      expect do
        delete :destroy, id: queue_classic_job
      end.to change(QueueClassicJob, :count).by(-1)
  
      response.should redirect_to(queue_classic_jobs_path)
    end
  end
end
