require File.dirname(__FILE__) + "/../../spec_helper"

describe GoogleCheckout::Shipping::CarrierCalculated do
  before(:each) do
    @shipping = GoogleCheckout::Shipping::CarrierCalculated.new('USPS')
  end
end
