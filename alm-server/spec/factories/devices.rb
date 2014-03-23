# == Schema Information
#
# Table name: devices
#
#  id           :integer          not null, primary key
#  device_id    :string(255)      not null
#  major_id     :integer
#  minor_id     :integer
#  device_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
  end
end
