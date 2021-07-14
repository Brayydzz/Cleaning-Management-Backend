require "test_helper"

class ServiceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_type = service_types(:one)
  end

  test "should get index" do
    get service_types_url, as: :json
    assert_response :success
  end

  test "should create service_type" do
    assert_difference('ServiceType.count') do
      post service_types_url, params: { service_type: { name: @service_type.name } }, as: :json
    end

    assert_response 201
  end

  test "should show service_type" do
    get service_type_url(@service_type), as: :json
    assert_response :success
  end

  test "should update service_type" do
    patch service_type_url(@service_type), params: { service_type: { name: @service_type.name } }, as: :json
    assert_response 200
  end

  test "should destroy service_type" do
    assert_difference('ServiceType.count', -1) do
      delete service_type_url(@service_type), as: :json
    end

    assert_response 204
  end
end
