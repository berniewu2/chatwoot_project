class AnalyzeMessageSentimentJob
  include Sidekiq::Worker
  sidekiq_options retry: 3, queue: :default

  def perform(message_id)
    message = Message.find_by(id: message_id)
    return unless message&.content.present?

    # 1. Compute sentiment score with VADER
    score = SentimentAnalyzer.score(message.content)
    detailed_scores = SentimentAnalyzer.detailed_scores(message.content)
    label = SentimentAnalyzer.label(score)

    # 2. Update message record
    message.update!(
      sentiment_score: score,
      sentiment_analyzed_at: Time.current,
      content_attributes: message.content_attributes.merge(
        sentiment: {
          score: score,
          label: label,
          details: detailed_scores,
          analyzed_at: Time.current.iso8601
        }
      )
    )

    # 3. Update conversation-level aggregate (average)
    update_conversation_sentiment(message.conversation)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.warn("Message ##{message_id} not found; skipping sentiment analysis.")
  rescue StandardError => e
    Rails.logger.error("Sentiment analysis failed for Message ##{message_id}: #{e.message}")
  end

  private

  def update_conversation_sentiment(conversation)
    # Only recalc if conversation exists
    return unless conversation

    scores = conversation.messages.where.not(sentiment_score: nil).pluck(:sentiment_score)
    return if scores.empty?

    average = scores.sum(0.0) / scores.size
    label = SentimentAnalyzer.label(average)
    
    conversation.update!(
      average_sentiment: average,
      sentiment_calculated_at: Time.current,
      custom_attributes: conversation.custom_attributes.merge(
        sentiment: {
          average_score: average,
          label: label,
          calculated_at: Time.current.iso8601
        }
      )
    )
  end
end 