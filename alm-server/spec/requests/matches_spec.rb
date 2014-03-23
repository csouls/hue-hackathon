require 'spec_helper'

describe "Matches" do
  describe "POST /matches" do
    let(:device) { create(:device) }
    let(:other_device) { create(:device) }
    let!(:affinity) { create(:affinity, from_device_id: device.id, to_device_id: other_device.id, level: 1) }
    let(:device_location) { create(:device_location, device_id: 123, hue_ip: "192.168.1.156") }

    it "returns success" do
      post matches_path, {from_minor_id: device_location.device_id, match_minor_ids: [device.id, other_device.id]}
      expect(response.status).to eq(200)
    end
  end
end
