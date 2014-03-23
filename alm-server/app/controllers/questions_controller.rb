class QuestionsController < ApplicationController
  # POST /questions
  # POST /questions.json
  def create(minor_id, device_token, questions)
    device = Device.find(minor_id)
    device.device_token = device_token
    device.save!

    questions.each do |question, answer|
      Question.create(device_id: device.id, question: question.to_i, answer: answer)
    end
  end
end
