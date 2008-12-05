module GoogleCheckout
  module Geography
    class UsZip < Area

      attr_accessor :zip_pattern

      def initialize(zip_pattern)
        @zip_pattern = zip_pattern
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('us-zip-area') do
          xml.tag!('zip-pattern') do
            xml.text! @zip_pattern
          end
        end
      end

    end
  end
end