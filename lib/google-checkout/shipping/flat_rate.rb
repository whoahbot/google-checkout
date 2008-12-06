module GoogleCheckout
  module Shipping
    class FlatRate < Method

      attr_accessor :name, :price, :currency

      attr_accessor :shipping_restrictions

      def initialize(name, price, currency = 'USD')
        @name = name
        @price = price
        @currency = currency
        @shipping_restrictions = {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def shipping_restrictions?
        @shipping_restrictions != {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('flat-rate-shipping', :name => name) do
          xml.tag!('price', price, :currency => currency)
          xml.tag!('shipping-restrictions') do
            xml.tag!('allowed-areas') do
              @shipping_restrictions[:allowed].each do |area|
                xml << area.to_xml
              end
            end unless @shipping_restrictions[:allowed].empty?
            xml.tag!('excluded-areas') do
              @shipping_restrictions[:excluded].each do |area|
                xml << area.to_xml
              end
            end unless @shipping_restrictions[:excluded].empty?
            xml.tag!('allow-us-po-box') do
              xml.text! 'false'
            end unless @shipping_restrictions[:allow_us_po_box]
          end if shipping_restrictions?
        end
      end

    end
  end
end