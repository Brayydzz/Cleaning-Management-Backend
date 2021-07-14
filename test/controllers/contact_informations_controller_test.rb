require "test_helper"

class ContactInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_information = contact_informations(:one)
  end

  test "should get index" do
    get contact_informations_url, as: :json
    assert_response :success
  end

  test "should create contact_information" do
    assert_difference('ContactInformation.count') do
      post contact_informations_url,
           params: { contact_information: { address_id: @contact_information.address_id, first_name: @contact_information.first_name, last_name: @contact_information.last_name, phone_number: @contact_information.phone_number } }, as: :json
    end

    assert_response 201
  end

  test "should show contact_information" do
    get contact_information_url(@contact_information), as: :json
    assert_response :success
  end

  test "should update contact_information" do
    patch contact_information_url(@contact_information),
          params: { contact_information: { address_id: @contact_information.address_id, first_name: @contact_information.first_name, last_name: @contact_information.last_name, phone_number: @contact_information.phone_number } }, as: :json
    assert_response 200
  end

  test "should destroy contact_information" do
    assert_difference('ContactInformation.count', -1) do
      delete contact_information_url(@contact_information), as: :json
    end

    assert_response 204
  end
end
