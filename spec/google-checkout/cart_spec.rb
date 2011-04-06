require File.dirname(__FILE__) + "/../spec_helper"

describe GoogleCheckout, "Cart (generic)" do

  before(:each) do
    @cart = GoogleCheckout::Cart.new("my_id", "my_key", {
      :name => "PeepCode Screencast",
      :description => "A few screencasts",
      :price => 9.00
    })
    GoogleCheckout.use_sandbox
  end

  it "should generate proper live buy button_url" do
    GoogleCheckout.use_production
    @cart.button_url.should match(%r{http://checkout\.google\.com/buttons/buy\.gif})
  end

  it "should generate proper live checkout button_url" do
    GoogleCheckout.use_production
    @cart.button_url(:buy_or_checkout => :checkout).should match(%r{http://checkout\.google\.com/buttons/checkout\.gif})
  end

  it "should generate proper sandbox buy button_url" do
    @cart.button_url.should match(%r{http://sandbox\.google\.com/checkout/buttons/buy\.gif})
  end

  it "should generate proper sandbox checkout button_url" do
    @cart.button_url(:buy_or_checkout => :checkout).should match(%r{http://sandbox\.google\.com/checkout/buttons/checkout\.gif})
  end

  it "should generate checkout button" do
    @cart.checkout_button.should match(/buy\.gif/)
  end

end

describe GoogleCheckout, "Cart Post" do

  before(:each) do
    @cart = GoogleCheckout::Cart.new("my_id", "my_key", {
      :name => "PeepCode Screencast",
      :description => "One screencast",
      :price => 9.00
    })
    GoogleCheckout.use_sandbox
  end

  it "should get merchant_id" do
    @cart.merchant_id.should == 'my_id'
  end

  it "should get merchant_key" do
    @cart.merchant_key.should == 'my_key'
  end

  it "should post request to Google" do
    # :null_object means eat all other methods and return self
    net_http = mock("net_http", { :null_object => true })
    Net::HTTP.should_receive(:new).and_return(net_http)

    success_response = Net::HTTPSuccess.new(Net::HTTP.version_1_2, 200, "OK")
    success_response.should_receive(:body).and_return(read_xml_fixture('responses/checkout-redirect'))
    net_http.should_receive(:request).and_return(success_response)

    response = @cart.post
    response.should be_kind_of(GoogleCheckout::CheckoutRedirect)
    response.serial_number.should == 'bea6bc1b-e1e2-44fe-80ff-0180e33a2614'
    response.redirect_url.should == 'https://checkout.google.com/buy?foo=bar&id=8572098456'
  end

  it "should set merchant private data with a Hash" do
    @cart.merchant_private_data = { "merchant-order-number" => "1234-5678-9012" }
    @cart.merchant_private_data.should == "<merchant-order-number>1234-5678-9012</merchant-order-number>"
  end

  it "should include merchant private data in the generated xml with a Hash" do
    @cart.merchant_private_data = { "merchant-order-number" => "1234-5678-9012" }
    @cart.to_xml.should match(/<merchant-order-number>1234-5678-9012<\/merchant-order-number>/)
  end

  it "should set merchant private data with a String" do
    @cart.merchant_private_data = "<merchant-order-number>1234-5678-9012</merchant-order-number>"
    @cart.merchant_private_data.should == "<merchant-order-number>1234-5678-9012</merchant-order-number>"
  end

  it "should include merchant private data in the generated xml with a String" do
    @cart.merchant_private_data = "<merchant-order-number>1234-5678-9012</merchant-order-number>"
    @cart.to_xml.should match(/<merchant-order-number>1234-5678-9012<\/merchant-order-number>/)
  end

  it "should not include merchant private data if none is set" do
    @cart.to_xml.should_not match(/<merchant-private-data>/)
  end

  it "should include merchant-item-id in XML if :item_id was passed with the item" do
    @cart.add_item({
      :name => "Item",
      :description => "Item description",
      :price => "1.00",
      :quantity => 1,
      :item_id => "ITEM-007"
    })
    @cart.to_xml.should match(%r{<merchant-item-id>ITEM-007</merchant-item-id>})
  end

  it "should include the merchant calculations url in the generated xml" do
    @cart.merchant_calculations_url = 'http://my.calculations.com'
    @cart.to_xml.should match(%r{<merchant-calculations-url>http://my.calculations.com</merchant-calculations-url>})
  end

  it "should not include the merchant calculations url if it's not set" do
    @cart.to_xml.should_not match(%r{<merchant-calculations-url>})
  end

  it "should include the merchant parameterized urls in the generated xml" do
    @cart.parameterized_urls = [{
      :url => "http://www.someapi.com",
      :parameters => [
        {:name => 'order', :type => 'order-id'},
        {:name => 'rev', :type => 'order-total'}]}]
    @cart.to_xml.should match(%r{<parameterized-urls><parameterized-url url="http://www.someapi.com"><parameters><url-parameter type="order-id" name="order"></url-parameter><url-parameter type="order-total" name="rev"></url-parameter></parameters></parameterized-url></parameterized-urls>})
  end

  it "should not include the merchant parameterized urls if it's not set" do
    @cart.to_xml.should_not match(%r{<parameterized-urls>})
  end

  it "should include the item weight if specified" do
    @cart.add_item({
      :name => "Frogjiggler",
      :description => "Frog Jiggler (automatic)",
      :price => "100.00",
      :item_weight => 15
    })
    @cart.to_xml.should match(%r{<item-weight value="15" unit="LB"/>})
  end

  it "should generate XML"

  it "should receive error when placing false request"

end
