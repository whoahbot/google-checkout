module GoogleCheckout
  module Shipping
    class Method

      def to_xml
        raise NotImplementedError
      end

    end
  end
end