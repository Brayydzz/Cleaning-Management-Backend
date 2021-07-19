require "test_helper"

class ApplicationControllerTest < ActiveSupport::TestCase
  setup do
    @address = Address.new(street_address: "Beck", street_number: "94", postcode: "4064", suburb: "Paddington", state: "Queensland")
  end

  # test address validation in the Application_Controller
  test "should check if address already exist and return that address" do
    assert @address.valid?
    return Address[-1]
  end

  # test "should check if address does not exist then create new instance" do
  #   assert
  # end

end
