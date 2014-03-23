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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
    device_id "599F9C00-92DC-4B5C-9464-7971F01F8370"
  end
end
