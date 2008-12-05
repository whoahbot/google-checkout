module GoogleCheckout
  module Geography
    class UsCountry < Area

      VALID_REGIONS = [:continental_48, :full_50_states, :all]

      attr_accessor :region

      def initialize(region)
        self.region = region
      end

      def to_xml
        unless VALID_REGIONS.include?(@region.to_sym)
          raise ArgumentError,
            ":#{@region.to_s} is not a valid region. You may use :continental_48, :full_50_states or :all"
        end
        xml = Builder::XmlMarkup.new
        xml.tag!('us-country-area', 'country-area' => @region.to_s.upcase)
      end

    end
  end
end