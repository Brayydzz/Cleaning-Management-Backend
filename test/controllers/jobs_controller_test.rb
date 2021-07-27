require "test_helper"

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get jobs_url, headers: { Authorization: "Bearer " + "TEST" }, as: :json
    assert_response :success
  end

  test "should create job" do
    assert_difference("Job.count") do
      post jobs_url, params: { address_id: @job.address_id, client_id: @job.client_id, due_date: @job.due_date, service_type_id: @job.service_type_id, reoccuring: @job.reoccuring, reoccuring_length: @job.reoccuring_length, time_in: @job.time_in, time_out: @job.time_out, user_id: @job.user_id }, headers: { Authorization: "Bearer " + "TEST" }, as: :json
    end

    assert_response 201
  end

  test "should show job" do
    get job_url(@job), headers: { Authorization: "Bearer " + "TEST" }, as: :json
    assert_response :success
  end

  test "should update job" do
    patch job_url(@job), params: { job: { address_id: @job.address_id, client_id: @job.client_id, due_date: @job.due_date, service_type_id: @job.service_type_id, reoccuring: @job.reoccuring, reoccuring_length: @job.reoccuring_length, time_in: @job.time_in, time_out: @job.time_out, user_id: @job.user_id } }, headers: { Authorization: "Bearer " + "TEST" }, as: :json
    assert_response 200
  end
end
