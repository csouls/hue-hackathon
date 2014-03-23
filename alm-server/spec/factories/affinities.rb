# == Schema Information
#
# Table name: affinities
#
#  id             :integer          not null, primary key
#  from_device_id :integer          not null
#  to_device_id   :integer          not null
#  level          :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :affinity do
  end
end
