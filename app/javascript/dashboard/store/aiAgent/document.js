import AiAgentDocumentAPI from 'dashboard/api/aiAgent/document';
import { createStore } from './storeFactory';

export default createStore({
  name: 'AiAgentDocument',
  API: AiAgentDocumentAPI,
});
