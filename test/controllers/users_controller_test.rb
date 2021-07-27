require "test_helper"
require "dotenv"
Dotenv.load

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @ci = ContactInformation.first()
    @add = Address.first()
  end

  # before do
  #   @request.set_header "Authorization", "Bearer " + ENV["TESTING_TOKEN"]
  # end

  test "should get index" do
    get users_url, headers: { Authorization: "Bearer " + "TEST" }, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post signup_path, headers: { Authorization: "Bearer " + "TEST" },
                        params: { email: @user.email, first_name: @ci.first_name, last_name: @ci.last_name, phone_number: @ci.phone_number, street_address: @add.street_address, street_number: @add.street_number, suburb: @add.suburb, state: @add.state, postcode: @add.postcode }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), headers: { Authorization: "Bearer " + "TEST" }, as: :json
    assert_response :success
  end
end
