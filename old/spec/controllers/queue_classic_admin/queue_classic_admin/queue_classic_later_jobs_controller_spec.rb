require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicLaterJobsController do
    let(:queue_classic_job) { QueueClassicLaterJob.create }
  
    it "should get index" do
      get :index, use_route: "queue_classic_admin"
      response.should be_success
      assigns(:queue_classic_jobs).should_not be_nil
    end
  
    it "should destroy queue_classic_job" do
      queue_classic_job
      expect do
        delete :destroy, id: queue_classic_job.id, use_route: "queue_classic_admin"
      end.to change(QueueClassicLaterJob, :count).by(-1)
  
      response.code.to_i.should == 302
    end

    context "#destroy_all" do
      it "should destroy everything" do
        queue_classic_job 
        delete :destroy_all, use_route: "queue_classic_admin"
        QueueClassicLaterJob.count.should == 0
      end

      it "should destroy the contents of the selected queue" do
        QueueClassicLaterJob.create! q_name: 'foo'
        QueueClassicLaterJob.create! q_name: 'bar'

        delete :destroy_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicLaterJob.where(q_name: 'foo').count.should == 0
        QueueClassicLaterJob.where(q_name: 'bar').count.should == 1
      end
    end
  end
end
