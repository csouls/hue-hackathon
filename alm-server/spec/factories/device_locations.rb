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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device_location do
  end
end
