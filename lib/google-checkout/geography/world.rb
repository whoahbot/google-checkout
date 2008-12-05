module GoogleCheckout
  module Geography
    class World

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('world-area')
      end

    end
  end
end