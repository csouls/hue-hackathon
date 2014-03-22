require 'spec_helper'

describe "Beacons" do
  describe "POST /beacons" do
    it "returns success" do
      post beacons_path, device_id: 'test-device-id'
      expect(response.status).to eq(200)

      body = JSON.parse response.body
      expect(body.keys).to eq(["major_id", "minor_id"])
    end
  end
end
