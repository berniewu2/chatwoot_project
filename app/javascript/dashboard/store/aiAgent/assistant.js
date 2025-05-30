import AiAgentTopicAPI from 'dashboard/api/aiAgent/topic';
import { createStore } from './storeFactory';

export default createStore({
  name: 'AiAgentTopic',
  API: AiAgentTopicAPI,
});
