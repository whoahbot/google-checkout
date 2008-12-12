module GoogleCheckout
  class MerchantCalculation

    attr_accessor :doc

    def self.parse(raw_xml)
      doc = Hpricot.XML(raw_xml)
      return new(doc)
    end

    def initialize(doc) # :nodoc:
      @doc = doc
    end

    def address_id
      @doc.at('anonymous-address').attributes['id']
    end

    def method_missing(method_name, *args)
      element_name = method_name.to_s.gsub(/_/, '-')
      if element = (@doc.at element_name)
        if element.respond_to?(:inner_html)
          return element.inner_html
        end
      end
      super
    end

  end
end