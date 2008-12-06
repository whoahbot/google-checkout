module GoogleCheckout
  module Shipping
    class FlatRate < Method

      include Restrictions

      attr_accessor :name, :price, :currency

      def initialize(name, price, currency = 'USD')
        @name = name
        @price = price
        @currency = currency
        @shipping_restrictions = {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('flat-rate-shipping', :name => name) do
          xml.tag!('price', price, :currency => currency)
          xml << shipping_restrictions_xml if shipping_restrictions?
        end
      end

    end
  end
end