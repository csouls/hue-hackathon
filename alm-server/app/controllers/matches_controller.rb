class MatchesController < ApplicationController
  # POST /matches
  # POST /matches.json
  def create(from_minor_id, match_minor_ids)
    ip = DeviceLocation.find(device_id: from_minor_id).hue_ip


    render json: {major_id: @device.major_id, minor_id: @device.id}
  end
end
