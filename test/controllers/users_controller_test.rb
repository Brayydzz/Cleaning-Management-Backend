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
    get users_url, headers: { Authorization: "Bearer " + ENV["TESTING_TOKEN"] }, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post signup_path, headers: { Authorization: "Bearer " + ENV["TESTING_TOKEN"] },
                        params: { email: @user.email, first_name: @ci.first_name, last_name: @ci.last_name, phone_number: @ci.phone_number, street_address: @add.street_address, street_number: @add.street_number, suburb: @add.suburb, state: @add.state, postcode: @add.postcode }, as: :json
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), headers: { Authorization: "Bearer " + ENV["TESTING_TOKEN"] }, as: :json
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user),
          params: { user: { contact_information_id: @user.contact_information_id, email: @user.email, isAdmin: @user.isAdmin, password_digest: @user.password_digest } }, headers: { Authorization: "Bearer " + ENV["TESTING_TOKEN"] }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user), headers: { Authorization: "Bearer " + ENV["TESTING_TOKEN"] }, as: :json
    end

    assert_response 204
  end
end
