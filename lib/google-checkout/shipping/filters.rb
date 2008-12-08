module GoogleCheckout
  module Shipping
    module Filters

      attr_accessor :address_filters

      def address_filters?
        @address_filters != {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def address_filters_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('address-filters') do
          xml.tag!('allowed-areas') do
            @address_filters[:allowed].each do |area|
              xml << area.to_xml
            end
          end unless @address_filters[:allowed].empty?
          xml.tag!('excluded-areas') do
            @address_filters[:excluded].each do |area|
              xml << area.to_xml
            end
          end unless @address_filters[:excluded].empty?
          xml.tag!('allow-us-po-box') do
            xml.text! 'false'
          end unless @address_filters[:allow_us_po_box]
        end
      end

    end
  end
end