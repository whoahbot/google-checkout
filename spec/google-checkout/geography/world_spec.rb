require File.dirname(__FILE__) + "/../../spec_helper"

describe GoogleCheckout::Geography::World do
  before(:each) do
    @area = GoogleCheckout::Geography::World.new
  end

  it 'should include the name in the generated xml' do
    @area.to_xml.should eql("<world-area/>")
  end

end