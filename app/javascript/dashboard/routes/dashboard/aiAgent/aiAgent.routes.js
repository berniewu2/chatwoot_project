import { FEATURE_FLAGS } from 'dashboard/featureFlags';
import { INSTALLATION_TYPES } from 'dashboard/constants/installationTypes';
import { frontendURL } from '../../../helper/URLHelper';
import TopicIndex from './topics/Index.vue';
import TopicEdit from './topics/Edit.vue';
import TopicInboxesIndex from './topics/inboxes/Index.vue';
import DocumentsIndex from './documents/Index.vue';
import ResponsesIndex from './responses/Index.vue';

export const routes = [
  {
    path: frontendURL('accounts/:accountId/aiAgent/topics'),
    component: TopicIndex,
    name: 'aiAgent_topics_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/topics/:topicId'),
    component: TopicEdit,
    name: 'aiAgent_topics_edit',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL(
      'accounts/:accountId/aiAgent/topics/:topicId/inboxes'
    ),
    component: TopicInboxesIndex,
    name: 'aiAgent_topics_inboxes_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/documents'),
    component: DocumentsIndex,
    name: 'aiAgent_documents_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
  {
    path: frontendURL('accounts/:accountId/aiAgent/responses'),
    component: ResponsesIndex,
    name: 'aiAgent_responses_index',
    meta: {
      permissions: ['administrator', 'agent'],
      featureFlag: FEATURE_FLAGS.AI_AGENT,
      installationTypes: [
        INSTALLATION_TYPES.CLOUD,
        INSTALLATION_TYPES.ENTERPRISE,
      ],
    },
  },
];
