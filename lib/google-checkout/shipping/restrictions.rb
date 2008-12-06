module GoogleCheckout
  module Shipping
    module Restrictions

      attr_accessor :shipping_restrictions

      def shipping_restrictions?
        @shipping_restrictions != {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def shipping_restrictions_xml
        xml = Builder::XmlMarkup.new
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
        end
      end

    end
  end
end