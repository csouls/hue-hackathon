require 'spec_helper'

describe "Matches" do
  describe "POST /matches" do
    let(:device) { create(:device) }
    let(:other_device) { create(:device) }
    let(:device_location) { create(:device_location, device_id: 123, hue_ip: "192.168.1.156") }

    it "returns success when affinity level 1" do
      create(:affinity, from_device_id: device.id, to_device_id: other_device.id, level: 1)
      post matches_path, {from_minor_id: device_location.device_id, match_minor_ids: [device.id, other_device.id]}
      expect(response.status).to eq(200)
    end

    it "returns success when affinity level 3" do
      create(:affinity, from_device_id: device.id, to_device_id: other_device.id, level: 3)
      post matches_path, {from_minor_id: device_location.device_id, match_minor_ids: [device.id, other_device.id]}
      expect(response.status).to eq(200)
    end

    it "returns success when affinity level 5" do
      create(:affinity, from_device_id: device.id, to_device_id: other_device.id, level: 5)
      post matches_path, {from_minor_id: device_location.device_id, match_minor_ids: [device.id, other_device.id]}
      expect(response.status).to eq(200)
    end
  end
end
