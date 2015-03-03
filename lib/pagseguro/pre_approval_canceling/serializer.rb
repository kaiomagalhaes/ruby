module PagSeguro
  class PreApprovalCanceling
    class Serializer
      attr_reader :xml

      def initialize(xml)
        @xml = xml
      end

      def serialize
        {}.tap do |data|
          data[:status] = xml.css(">status").text
          data[:date] = Time.parse(xml.css("date").text)
        end
      end

    end
  end
end