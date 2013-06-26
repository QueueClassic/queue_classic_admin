require 'test_helper'

module QueueClassicAdmin
  class QueueClassicLaterJobsControllerTest < ActionController::TestCase
    setup do
      @queue_classic_later_job = queue_classic_later_jobs(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:queue_classic_later_jobs)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create queue_classic_later_job" do
      assert_difference('QueueClassicLaterJob.count') do
        post :create, queue_classic_later_job: { destroy: @queue_classic_later_job.destroy, index: @queue_classic_later_job.index }
      end
  
      assert_redirected_to queue_classic_later_job_path(assigns(:queue_classic_later_job))
    end
  
    test "should show queue_classic_later_job" do
      get :show, id: @queue_classic_later_job
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @queue_classic_later_job
      assert_response :success
    end
  
    test "should update queue_classic_later_job" do
      put :update, id: @queue_classic_later_job, queue_classic_later_job: { destroy: @queue_classic_later_job.destroy, index: @queue_classic_later_job.index }
      assert_redirected_to queue_classic_later_job_path(assigns(:queue_classic_later_job))
    end
  
    test "should destroy queue_classic_later_job" do
      assert_difference('QueueClassicLaterJob.count', -1) do
        delete :destroy, id: @queue_classic_later_job
      end
  
      assert_redirected_to queue_classic_later_jobs_path
    end
  end
end
