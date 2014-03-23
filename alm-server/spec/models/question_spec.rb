# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  question   :integer
#  answer     :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_questions_on_device_id_and_question  (device_id,question)
#

require 'spec_helper'

describe Question do
  pending "add some examples to (or delete) #{__FILE__}"
end
