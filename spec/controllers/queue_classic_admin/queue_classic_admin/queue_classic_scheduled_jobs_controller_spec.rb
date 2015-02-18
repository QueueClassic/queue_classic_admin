require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicScheduledJobsController do
    let!(:queue_classic_job) { create_job_qc_job }
    let!(:scheduled_job) { create_job_qc_job scheduled_at: 1.minute.from_now }

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
        QueueClassicJob.ready.count.should == 1
        QueueClassicJob.scheduled.count.should == 1
        delete :destroy_all, use_route: "queue_classic_admin"
        QueueClassicJob.ready.count.should == 1
        QueueClassicJob.scheduled.count.should == 0
      end

      it "should destroy the contents of the selected queue but only scheduled jobs" do
        create_job_qc_job q_name: 'foo'
        create_job_qc_job q_name: 'foo', scheduled_at: 1.minute.from_now
        create_job_qc_job q_name: 'bar'


        delete :destroy_all, use_route: "queue_classic_admin", q_name: 'foo'
        QueueClassicJob.where(q_name: 'foo').count.should == 1
        QueueClassicJob.where(q_name: 'bar').count.should == 1
      end
    end
  end
end
