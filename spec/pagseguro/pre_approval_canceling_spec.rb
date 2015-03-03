require "spec_helper"

describe PagSeguro::PreApprovalCanceling do
  describe ".cancel" do
    it "cancel a pre approval by the given notificationCode" do
        allow(PagSeguro::PreApprovalCanceling).to receive(:load_from_response)
        expect(PagSeguro::Request).to receive(:get).with("pre-approvals/cancel/CODE").and_return(double.as_null_object)
        PagSeguro::PreApprovalCanceling.cancel("CODE")
    end

    it "returns response with errors when request fails" do
      body = %[<?xml version="1.0"?><errors><error><code>1234</code><message>Sample error</message></error></errors>]
      FakeWeb.register_uri :get, %r[.+], status: [400, "Bad Request"], body: body, content_type: "text/xml"
      response = PagSeguro::PreApprovalCanceling.cancel("invalid")

      expect(response).to be_a(PagSeguro::PreApprovalCanceling::Response)
      expect(response.errors).to include("Sample error")
    end
  end
end