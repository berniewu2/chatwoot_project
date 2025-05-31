class SentimentAnalyzerService
  require 'vader_sentiment_ruby'

  def self.analyze(text)
    return nil if text.blank?

    analyzer = VaderSentimentRuby::SentimentIntensityAnalyzer.new
    scores = analyzer.polarity_scores(text)
    
    {
      compound: scores[:compound],
      positive: scores[:pos],
      negative: scores[:neg],
      neutral: scores[:neu]
    }
  end

  def self.analyze_message(message)
    return unless message&.content.present?

    scores = analyze(message.content)
    return unless scores

    message.update!(
      sentiment_score: scores[:compound],
      sentiment_analyzed_at: Time.current,
      sentiment: scores.merge(
        analyzed_at: Time.current.iso8601,
        version: 'vader_sentiment_ruby_1.2'
      )
    )

    update_conversation_sentiment(message.conversation)
  end

  def self.update_conversation_sentiment(conversation)
    return unless conversation

    scores = conversation.messages
                        .where.not(sentiment_score: nil)
                        .pluck(:sentiment_score)

    return if scores.empty?

    average = scores.sum(0.0) / scores.size
    conversation.update!(
      average_sentiment: average,
      sentiment_calculated_at: Time.current
    )
  end
end 