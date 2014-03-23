class MatchesController < ApplicationController
  # POST /matches
  # POST /matches.json
  def create(from_minor_id, match_minor_ids)
    ip = DeviceLocation.find_by(device_id: from_minor_id).hue_ip

    likables = Affinity.likables(match_minor_ids).order(level: :desc)
    return if likables.count == 0

    max_level = likables.first.level
    likables.select! {|affinity| affinity.level == max_level }
    send = likables.sample
    devices = Device.where(id: [send.from_device_id, send.to_device_id])
    send_notification(devices)

    lighting(ip, max_level)
    render json: {}
  end


  def push_notification(device_token)
    client = Houston::Client.development
    client.certificate = File.read(Settings.apns.pem)

    notification = Houston::Notification.new
    notification.token = device_token
    notification.alert = "test" #option[:alert] if option[:alert]
    #notification.badge = option[:badge] if option[:badge]
    notification.sound = 'default'
    #notification.content_available = content_available if content_available
    client.push(notification)
  end

  private

  def lighting(ip, level)
    client = Hue::Client.new
    lights = client.bridges.map { |bridge| bridge.lights if bridge.ip == ip }.flatten.compact

    case level
    when 1..2
      lights.each do |light|
        light.on = true
        sleep 0.1
        light.hue = 46920
        light.saturation = 200
        light.brightness = 150
      end
      sleep 1.5
      lights.each { |light| light.on = false }
    when 3..4
      lights.each do |light|
        light.on = true
        sleep 0.1
        light.hue = 56100
        light.saturation = 200
        light.brightness = 200
      end
      sleep 1.5
      lights.each { |light| light.on = false }
    when 5
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

  def send_notification(devices)
    client = Houston::Client.development
    client.certificate = File.read(Settings.apns.pem)

    devices.each do |e|
      notification = Houston::Notification.new
      notification.token = e.device_token
      notification.alert = "test" #option[:alert] if option[:alert]
      #notification.badge = option[:badge] if option[:badge]
      notification.sound = 'default'
      #notification.content_available = content_available if content_available
      client.push(notification)
    end
  end
end

