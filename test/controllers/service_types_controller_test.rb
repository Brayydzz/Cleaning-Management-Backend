require "test_helper"

class ServiceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_type = service_types(:one)
  end

  test "should get index" do
    get service_types_url, as: :json
    assert_response :success
  end
end
