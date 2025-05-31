export interface Conversation {
  id: number;
  average_sentiment?: number;
  sentiment_calculated_at?: string;
  custom_attributes?: {
    sentiment?: {
      average_score: number;
      label: string;
      calculated_at: string;
    };
    [key: string]: any;
  };
} 