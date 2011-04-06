module GoogleCheckout
  module Shipping
    class CarrierCalculated < Method

      include Restrictions
      include Filters

      attr_accessor :company, :type, :price, :ship_from, :currency, :additional_fixed_charge

      def initialize(company, type, price, ship_from, currency = 'USD')
        @company = company
        @type = type
        @price = price
        @currency = currency
        @ship_from = ship_from
        @shipping_restrictions = {:allowed => [], :excluded => [], :allow_us_po_box => true}
        @address_filters = {:allowed => [], :excluded => [], :allow_us_po_box => true}
      end

      def to_xml
        xml = Builder::XmlMarkup.new
        xml.tag!('carrier-calculated-shipping') do
          xml.tag!('carrier-calculated-shipping-options') {
            xml.tag!('carrier-calculated-shipping-option') {
              xml.tag!('shipping-type') {
                xml.text! type
              }
              xml.tag!('shipping-company') {
                xml.text! company
              }
              xml.tag!('price', price, :currency => currency)
              xml.tag!('additional-fixed-charge', :currency => "USD") {
                xml.text! additional_fixed_charge
              }
              xml.tag!('shipping-display-name') {
                xml.text! "#{company} #{type}"
              }
            }
          }
          xml.tag!('shipping-packages') {
            xml.tag!('shipping-package') {
              xml.tag!('ship-from', :id => "Fort Awesome") {
                xml.tag!('city') {
                  xml.text! ship_from['city']
                }
                xml.tag!('region') {
                  xml.text! ship_from['region']
                }
                xml.tag!('postal-code') {
                  xml.text! ship_from['zip']
                }
                xml.tag!('country-code') {
                  xml.text! ship_from['country']
                }
              }
            }
          }
          xml << shipping_restrictions_xml if shipping_restrictions?
          xml << address_filters_xml if address_filters?
        end
      end
    end
  end
end
