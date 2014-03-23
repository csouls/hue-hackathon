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
    lights.each do |light|
      light.saturation = 255
      light.brightness = 255
    end
    colors = [0, 25500, 46920, 59160]

    Parallel.each(lights, in_threads: lights.count) do |light|
      8.times do |i|
        light.on = true
        index = (light.id.to_i + i) % 4
        puts index
        light.hue = colors[index]
        sleep 0.2
      end
      light.on = false
    end
  end
end
