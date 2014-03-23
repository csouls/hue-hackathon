require 'spec_helper'

describe "Questions" do
  describe "POST /questions" do
    let(:device) { create(:device) }
    let(:device_token) { "IJC6S3YJRPHVCRKTDTQNGGZKXICPHOJRWVB28224FHEX6EPPIFW4VV2S1IMGSV2L" }
    let(:questions) { {"1" => "A", "2" => "B"} }

    it "returns success" do
      post questions_path, {minor_id: device.id, device_token: device_token, questions: questions}
      expect(response.status).to eq(200)
      expect(Question.where(device_id: device.id).count).to eq 2
    end
  end
end
