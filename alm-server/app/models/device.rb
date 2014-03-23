# == Schema Information
#
# Table name: devices
#
#  id           :integer          not null, primary key
#  device_id    :string(255)      not null
#  major_id     :integer
#  device_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Device < ActiveRecord::Base
  has_many :questions
end
