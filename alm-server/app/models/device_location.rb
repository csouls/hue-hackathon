# == Schema Information
#
# Table name: device_locations
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  hue_ip     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class DeviceLocation < ActiveRecord::Base
end
