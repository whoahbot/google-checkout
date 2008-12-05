require File.dirname(__FILE__) + "/../../spec_helper"

describe GoogleCheckout::Geography::UsCountry do
  before(:each) do
    @area = GoogleCheckout::Geography::UsCountry.new(:all)
  end

  it 'should generate the us country area tag with the ALL region' do
    @area.to_xml.should match(%r{<us-country-area country-area="ALL"/>})
  end

  it 'should generate the us country area tag with the CONTINENTAL_48 region' do
    @area.region = :continental_48
    @area.to_xml.should match(%r{<us-country-area country-area="CONTINENTAL_48"/>})
  end

  it 'should generate the us country area tag with the FULL_50_STATES region' do
    @area.region = :full_50_states
    @area.to_xml.should match(%r{<us-country-area country-area="FULL_50_STATES"/>})
  end

  it 'should not allow invalid regions on initalization' do
    lambda {GoogleCheckout::Geography::UsCountry.new(:my_house)}.should raise_error(ArgumentError)
  end

  it 'should not allow region to be set to an invalid region' do
    lambda {@area.region = :my_house}.should raise_error(ArgumentError)
  end
end