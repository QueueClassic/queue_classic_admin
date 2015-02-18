require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicScheduledJobsController do
    def create_job args = {}
      job = QueueClassicJob.new
      job.q_name = args[:q_name] || 'default'
      job.method = args[:method] || 'puts'
      job.args = args[:args] || '1'
      job.save!
      job
    end

    let!(:queue_classic_job) { create_job }

    it "should get index" do
      get :index, use_route: "queue_classic_admin"
      response.should be_success
      assigns(:queue_classic_jobs).should_not be_nil
    end

    it "should destroy queue_classic_job" do
      expect do
        delete :destroy, id: queue_classic_job.id, use_route: "queue_classic_admin"
      end.to change(QueueClassicJob, :count).by(-1)

      response.code.to_i.should == 302
    end

    context "#destroy_all" do
      it "should destroy everything" do
        delete :destroy_all, use_route: "queue_classic_admin"
        QueueClassicJob.count.should == 0
      end

      it "should destroy the contents of the selected queue" do
        create_job q_name: 'foo'
        create_job q_name: 'bar'

        delete :destroy_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicJob.where(q_name: 'foo').count.should == 0
        QueueClassicJob.where(q_name: 'bar').count.should == 1
      end
    end
  end
end
