class AddSentimentAnalysisColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :sentiment_score, :float
    add_column :messages, :sentiment_analyzed_at, :datetime
    add_column :conversations, :average_sentiment, :float
    add_column :conversations, :sentiment_calculated_at, :datetime
    
    add_index :messages, :sentiment_score
    add_index :conversations, :average_sentiment
  end
end 