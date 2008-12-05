module GoogleCheckout
  module Shipping
    class FlatRate < Method

      attr_accessor :name, :price, :currency

      attr_accessor :allowed_areas, :excluded_areas, :allow_us_po_box

      def initialize(name, price, currency = 'USD')
        @name = name
        @price = price
        @currency = currency
        @allowed_areas = []
        @excluded_areas = []
        @allow_us_po_box = true
      end

      def allow_us_po_box?
        @allow_us_po_box
      end

      def shipping_restrictions?
        !@allowed_areas.empty? || !@excluded_areas.empty? || !allow_us_po_box?
      end

      def to_xml
        validate_shipping_restrictions
        xml = Builder::XmlMarkup.new
        xml.tag!('flat-rate-shipping', :name => name) do
          xml.tag!('price', price, :currency => currency)
          xml.tag!('shipping-restrictions') do
            xml.tag!('allowed-areas') do
              @allowed_areas.each do |area|
                xml << area.to_xml
              end
            end unless @allowed_areas.empty?
            xml.tag!('excluded-areas') do
              @excluded_areas.each do |area|
                xml << area.to_xml
              end
            end unless @excluded_areas.empty?
            xml.tag!('allow-us-po-box') do
              xml.text! 'false'
            end unless allow_us_po_box?
          end if shipping_restrictions?
        end
      end

      private

      def validate_shipping_restrictions
        if (@allowed_areas.detect {|s| !s.kind_of?(GoogleCheckout::Geography::Area)} ||
            @excluded_areas.detect {|s| !s.kind_of?(GoogleCheckout::Geography::Area)})
          raise ArgumentError,
            "Shipping restrictions must be a subclass of GoogleCheckout::Geography::Area"
        end
        if !@excluded_areas.empty? && @allowed_areas.empty?
          raise ArgumentError,
            "You must have allowed areas if you have excluded areas."
        end
      end

    end
  end
end