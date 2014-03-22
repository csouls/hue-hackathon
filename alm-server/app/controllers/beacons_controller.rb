class BeaconsController < ApplicationController
  # POST /beacons
  # POST /beacons.json
  def create
    key = cache_key(params[:device_id])

    @beacon = Rails.cache.read(key)
    unless @beacon
      @beacon = {
        major_id: Settings.beacon.major_id,
        minor_id: Rails.cache.increment(:minor_id),
      }
      Rails.cache.write(key)
    end

    render json: @beacon
  end

  private

  def cache_key(id)
    "beacons:#{id}"
  end
end
