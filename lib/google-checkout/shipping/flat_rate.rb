module GoogleCheckout
  module Shipping
    class FlatRate < ShippingMethod

      attr_accessor :name, :price, :currency

      def initialize(name, price, currency = 'USD')
        @name = name
        @price = price
        @currency = currency
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('flat-rate-shipping', :name => name) do
          xml.tag!('price', price, :currency => currency)
        end
      end

    end
  end
end