require File.dirname(__FILE__) + "/../../spec_helper"

describe GoogleCheckout::Shipping::FlatRate do
  before(:each) do
    @shipping = GoogleCheckout::Shipping::FlatRate.new('UPS Ground', '10.00')
  end

  it 'should include the name in the generated xml' do
    @shipping.to_xml.should match(%r{<flat-rate-shipping name="UPS Ground">})
  end

  it 'should include the price in the generated xml' do
    @shipping.price = '1.00'
    @shipping.to_xml.should match(%r{<price .*>1.00</price>})
  end

  it 'should include the currency in the generated xml' do
    @shipping.currency = 'CAD'
    @shipping.to_xml.should match(%r{<price currency="CAD">})
  end

end