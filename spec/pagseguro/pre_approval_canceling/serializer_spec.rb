# -*- encoding: utf-8 -*-
require "spec_helper"

describe PagSeguro::PreApprovalCanceling::Serializer do
  context "for existing transactions" do
    let(:source) { File.read("./spec/fixtures/pre_approval_canceling/success.xml") }
    let(:xml) { Nokogiri::XML(source) }
    let(:serializer) { described_class.new(xml.css("result").first) }
    subject(:data) { serializer.serialize }

    it { expect(data).to include(status: "OK") }
    it { expect(data).to include(date: Time.parse("2011-11-25T20:04:23.000-02:00")) }
    end
end
