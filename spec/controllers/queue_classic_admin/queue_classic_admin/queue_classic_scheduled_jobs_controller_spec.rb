require 'spec_helper'

module QueueClassicAdmin
  describe QueueClassicAdmin::QueueClassicScheduledJobsController do
    let!(:queue_classic_job) { create_job_qc_job }
    let!(:scheduled_job) { create_job_qc_job scheduled_at: 1.minute.from_now }

    it "gets index" do
      get :index, params: { use_route: "queue_classic_admin" }
      expect(response).to be_successful
      expect(assigns(:queue_classic_jobs)).to_not be_nil
    end

    it "destroys queue_classic_job" do
      expect do
        delete :destroy, params: { id: queue_classic_job.id, use_route: "queue_classic_admin" }
      end.to change(QueueClassicJob, :count).by(-1)

      expect(response.code.to_i).to eq(302)
    end

    context "#destroy_all" do
      it "destroys only scheduled jobs" do
        expect(QueueClassicJob.ready.count).to eq(1)
        expect(QueueClassicJob.scheduled.count).to eq(1)
        delete :destroy_all, params: { use_route: "queue_classic_admin" }
        expect(QueueClassicJob.ready.count).to eq(1)
        expect(QueueClassicJob.scheduled.count).to eq(0)
      end

      it "destroys the contents of the selected queue but only scheduled jobs" do
        create_job_qc_job q_name: 'foo'
        create_job_qc_job q_name: 'foo', scheduled_at: 1.minute.from_now
        create_job_qc_job q_name: 'bar'


        delete :destroy_all, params: { use_route: "queue_classic_admin", q_name: 'foo' }
        expect(QueueClassicJob.where(q_name: 'foo').count).to eq(1)
        expect(QueueClassicJob.where(q_name: 'bar').count).to eq(1)
      end
    end
  end
end
