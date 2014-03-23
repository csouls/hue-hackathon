require 'spec_helper'

describe "Questions" do
  describe "POST /questions" do
    let(:device) { create(:device) }
    let(:device_token) { "IJC6S3YJRPHVCRKTDTQNGGZKXICPHOJRWVB28224FHEX6EPPIFW4VV2S1IMGSV2L" }
    let(:questions) { {"1" => "A", "2" => "B"} }

    before do
      other_device = create(:device)
      create(:question, device_id: other_device.id, question: 1, answer: "A")
    end

    it "returns success" do
      post questions_path, {minor_id: device.id, device_token: device_token, questions: questions}
      expect(response.status).to eq(200)
      expect(Question.where(device_id: device.id).count).to eq 2
      expect(Affinity.find_by(from_device_id: device.id).level).to eq 1
    end
  end
end
