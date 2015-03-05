module PagSeguro
  class PreApprovalCanceling
    include Extensions::MassAssignment
    include Extensions::EnsureType

    attr_accessor :status
    attr_accessor :date

    def self.cancel(code)
      load_from_response Request.get("pre-approvals/cancel/#{code}")
    end

    # Serialize the HTTP response into data.
    def self.load_from_response(response) # :nodoc:
      if response.success? and response.xml?
        load_from_xml Nokogiri::XML(response.body).css("result")
      else
        Response.new Errors.new(response)
      end
    end

    # Serialize the XML object.
    def self.load_from_xml(xml) # :nodoc:
      new Serializer.new(xml).serialize
    end
  end
end