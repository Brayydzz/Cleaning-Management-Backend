require "test_helper"

class AddressTest < ActiveSupport::TestCase
  setup do
    @address = Address.new(street_address: "Beck", street_number: "94", postcode: "4064", suburb: "Paddington",
                           state: "Queensland")
  end

  # test address validation in the Application_Controller
  test "should check if address already exist and return that address" do
      create_address = Address.create(street_address: "Beck", street_number: "94", postcode: "4064", suburb: "Paddington",
        state: "Queensland"),

      address_array = Address.where(street_address: @address[:street_address], street_number: @address[:street_number],
          suburb: @address[:suburb], state: @address[:state], postcode: @address[:postcode]).first
          assert(create_address == address_array)
  end
  # if new address is equal to a value in Address model
  # return the return that address

  #  go through address array, find address that matches variable, return match.

  # test "should check if address does not exist then create new instance" do
  #   assert @address.valid?
  #   return Address.last
  # end
end
