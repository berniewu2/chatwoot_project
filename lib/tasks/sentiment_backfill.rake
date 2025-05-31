namespace :sentiment do
  desc "Backfill sentiment_score for all existing messages without one"
  task backfill_messages: :environment do
    Message.where(sentiment_score: nil).find_each(batch_size: 500) do |msg|
      AnalyzeMessageSentimentJob.perform_async(msg.id)
    end
  end

  desc "Recalculate average_sentiment for all conversations"
  task recalc_conversations: :environment do
    Conversation.find_each(batch_size: 200) do |conv|
      scores = conv.messages.where.not(sentiment_score: nil).pluck(:sentiment_score)
      next if scores.empty?
      avg = scores.sum(0.0) / scores.size
      label = SentimentAnalyzer.label(avg)
      
      conv.update!(
        average_sentiment: avg,
        sentiment_calculated_at: Time.current,
        custom_attributes: conv.custom_attributes.merge(
          sentiment: {
            average_score: avg,
            label: label,
            calculated_at: Time.current.iso8601
          }
        )
      )
    end
  end
end 