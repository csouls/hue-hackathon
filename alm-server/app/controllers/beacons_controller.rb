class BeaconsController < ApplicationController
  # POST /beacons
  # POST /beacons.json
  def create(device_id)
    @device = Device.where(device_id: device_id)
    unless @device.exists?
      @device = Device.create(
        device_id: device_id,
        major_id: Settings.beacon.major_id,
      )
    end

    render json: {major_id: @device.major_id, minor_id: @device.id}
  end
end
