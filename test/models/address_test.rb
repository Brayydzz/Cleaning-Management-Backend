require "test_helper"

class AddressTest < ActiveSupport::TestCase
  setup do
    @address_info = { street_address: "Beck", street_number: "94", postcode: "4064", suburb: "Paddington",
                      state: "Queensland" }
    @address_info2 = { street_address: "home", street_number: "94", postcode: "4064", suburb: "Paddington",
                      state: "Queensland" }
    @address = Address.new(@address_info)
  end

  # test address validation in the Application_Controller
  test "should check if address already exist and return that address" do
    create_address = Address.create(@address_info)

    address_array = Address.where(@address_info).first
    assert(create_address == address_array)
  end

  test "should check if address does not exist then create new instance" do
    address_array = Address.where(@address_info2).first
    if !address_array
      create_address = Address.create(@address_info2)
    end
    assert(create_address)
  end
end
