export interface Message {
  id: number;
  content: string;
  sentiment_score?: number;
  sentiment_analyzed_at?: string;
  content_attributes?: {
    sentiment?: {
      score: number;
      label: string;
      details: {
        neg: number;
        neu: number;
        pos: number;
        compound: number;
      };
      analyzed_at: string;
    };
    [key: string]: any;
  };
} 