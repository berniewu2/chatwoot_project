class AnalyzeMessageSentimentJob
  include Sidekiq::Job
  sidekiq_options queue: :default, retry: 3

  def perform(message_id)
    message = Message.find_by(id: message_id)
    return unless message

    SentimentAnalyzerService.analyze_message(message)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("Message ##{message_id} not found; skipping sentiment analysis.")
  rescue StandardError => e
    Rails.logger.error("Sentiment analysis failed for Message ##{message_id}: #{e.message}")
    raise e
  end
end 