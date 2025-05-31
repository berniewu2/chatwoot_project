class SentimentAnalyzer
  require 'vader_sentiment_ruby'

  # Compute sentiment for a single text string using VADER
  def self.score(text)
    return 0.0 if text.blank?
    analyzer = VaderSentimentRuby::SentimentIntensityAnalyzer.new
    vs = analyzer.p_scores(text)          # Returns hash with keys: :neg, :neu, :pos, :compound
    vs[:compound].to_f                    # Compound score between -1.0 and +1.0
  end

  # Get detailed sentiment scores for a text
  def self.detailed_scores(text)
    return { neg: 0.0, neu: 0.0, pos: 0.0, compound: 0.0 } if text.blank?
    analyzer = VaderSentimentRuby::SentimentIntensityAnalyzer.new
    analyzer.p_scores(text)
  end

  # Get sentiment label based on compound score
  def self.label(score)
    case score
    when -1.0..-0.05
      'negative'
    when 0.05..1.0
      'positive'
    else
      'neutral'
    end
  end
end 