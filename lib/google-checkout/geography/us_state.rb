module GoogleCheckout
  module Geography
    class UsState < Area

      attr_accessor :state

      def initialize(state)
        @state = state
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('us-state-area') do
          xml.tag!('state') do
            xml.text! @state
          end
        end
      end

    end
  end
end