module GoogleCheckout
  module Geography
    class Postal < GeographicArea

      attr_accessor :country, :postal_pattern

      def initialize(country, postal_pattern=nil)
        @country = country
        @postal_pattern = postal_pattern
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('postal-area') do
          xml.tag!('country-code') do
            xml.text! @country
          end
          xml.tag!('postal-code-pattern') do
            xml.text! @postal_pattern
          end if @postal_pattern
        end
      end

    end
  end
end