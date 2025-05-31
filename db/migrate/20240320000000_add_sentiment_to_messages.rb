class AddSentimentToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :sentiment_score, :float, default: nil
    add_column :messages, :sentiment_analyzed_at, :datetime, default: nil
    add_column :conversations, :average_sentiment, :float, default: nil
    add_column :conversations, :sentiment_calculated_at, :datetime, default: nil
    add_index :messages, :sentiment_score
    add_index :conversations, :average_sentiment
  end
end 