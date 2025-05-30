class AiAgent::Copilot::ResponseJob < ApplicationJob
  queue_as :default

  def perform(topic:, conversation_id:, user_id:, copilot_thread_id:, message:)
    Rails.logger.info("#{self.class.name} Copilot response job for topic_id=#{topic.id} user_id=#{user_id}")
    generate_chat_response(
      topic: topic,
      conversation_id: conversation_id,
      user_id: user_id,
      copilot_thread_id: copilot_thread_id,
      message: message
    )
  end

  private

  def generate_chat_response(topic:, conversation_id:, user_id:, copilot_thread_id:, message:)
    AiAgent::Copilot::ChatService.new(
      topic,
      user_id: user_id,
      copilot_thread_id: copilot_thread_id,
      conversation_id: conversation_id
    ).generate_response(message)
  end
end
