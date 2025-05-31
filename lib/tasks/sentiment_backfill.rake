namespace :sentiment do
  desc 'Backfill sentiment analysis for existing messages'
  task backfill: :environment do
    puts 'Starting sentiment analysis backfill...'
    
    total_messages = Message.where(sentiment_score: nil)
                           .where(content_type: [:text, :input_text, :input_textarea, :input_email])
                           .where(private: false)
                           .count
    
    puts "Found #{total_messages} messages to analyze"
    
    Message.where(sentiment_score: nil)
           .where(content_type: [:text, :input_text, :input_textarea, :input_email])
           .where(private: false)
           .find_each(batch_size: 100) do |message|
      begin
        AnalyzeMessageSentimentJob.perform_now(message.id)
        print '.'
      rescue StandardError => e
        puts "\nError processing message #{message.id}: #{e.message}"
      end
    end
    
    puts "\nBackfill completed!"
  end

  desc 'Recalculate average sentiment for all conversations'
  task recalculate_averages: :environment do
    puts 'Starting conversation average sentiment recalculation...'
    
    total_conversations = Conversation.count
    puts "Found #{total_conversations} conversations to process"
    
    Conversation.find_each(batch_size: 100) do |conversation|
      begin
        SentimentAnalyzerService.update_conversation_sentiment(conversation)
        print '.'
      rescue StandardError => e
        puts "\nError processing conversation #{conversation.id}: #{e.message}"
      end
    end
    
    puts "\nRecalculation completed!"
  end
end 