class QuestionsController < ApplicationController
  # POST /questions
  # POST /questions.json
  def create(minor_id, device_token, questions)
    device = Device.find(minor_id)
    device.device_token = device_token
    device.save!

    Question.delete_all(device_id: device.id)
    records = questions.map.with_index do |answer, question|
      Question.create(device_id: device.id, question: question + 1, answer: answer)
    end

    Affinity.delete_all(from_device_id: device.id)
    Affinity.delete_all(to_device_id: device.id)
    Device.where('id != ?', device.id).each do |other_device|
      level = 0
      other_device.questions.each do |question|
        answer = records.find {|record| record.question == question.question }.answer
        level = level + 1 if question.answer == answer
      end
      Affinity.create(from_device_id: device.id, to_device_id: other_device.id, level: level)
      Affinity.create(from_device_id: other_device.id, to_device_id: device.id, level: level)
    end

    render json: {}
  end
end
