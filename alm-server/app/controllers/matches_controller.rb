class MatchesController < ApplicationController
  # POST /matches
  # POST /matches.json
  def create(from_minor_id, match_minor_ids)
    ip = DeviceLocation.find_by(device_id: from_minor_id).hue_ip

    likables = Affinity.likables(match_minor_ids).order(level: :desc)
    return if likables.count == 0

    max_level = likables.first.level
    likables.collect! {|affinity| affinity.level == max_level }
    send_to = likables.sample

    lighting(ip, max_level)
    render json: {}
  end

  private

  def lighting(ip, level)
    client = Hue::Client.new
    lights = client.bridges.map { |bridge| bridge.lights if bridge.ip == "192.168.1.156" }.flatten.compact

    last_hue = []
    4.times do
      lights.each do |light|
        hue = ([0, 12750, 25500, 46920, 53040, 59160] - last_hue).sample
        last_hue = [hue]
        light.hue = hue
      end
      sleep 0.2
    end
  end
end
