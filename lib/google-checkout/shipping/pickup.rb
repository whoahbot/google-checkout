module GoogleCheckout
  module Shipping
    class Pickup

      attr_accessor :name, :price, :currency

      def initialize(name, price = '0.00', currency = 'USD')
        @name = name
        @price = price
        @currency = currency
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('pickup', :name => name) do
          xml.tag!('price', price, :currency => currency)
        end
      end

    end
  end
end