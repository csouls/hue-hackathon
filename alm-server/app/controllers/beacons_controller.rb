class BeaconsController < ApplicationController
  # POST /beacons
  # POST /beacons.json
  def create(device_id)
    @device = Device.where(device_id: device_id)
    unless @device.exists?
      @device = Device.create(
        device_id: device_id,
        major_id: Settings.beacon.major_id,
        minor_id: Rails.cache.increment(:minor_id),
      )
    end

    render json: @device.as_json(only: [:major_id, :minor_id])
  end

  private

  def cache_key(id)
    "beacons:#{id}"
  end
end
