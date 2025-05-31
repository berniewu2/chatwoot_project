<template>
  <div class="conversation-item">
    <!-- ... existing template code ... -->
    <div class="conversation-meta">
      <!-- ... existing meta content ... -->
      <div v-if="conversation.custom_attributes?.sentiment" class="conversation-sentiment">
        <sentiment-badge
          :score="conversation.custom_attributes.sentiment.average_score"
          :show-label="false"
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SentimentBadge from '../widgets/SentimentBadge.vue';
import type { Conversation } from '../../types/conversation';

export default defineComponent({
  name: 'ConversationListItem',
  components: {
    SentimentBadge
  },
  props: {
    conversation: {
      type: Object as () => Conversation,
      required: true
    }
  }
  // ... rest of existing script
});
</script>

<style lang="scss" scoped>
// ... existing styles ...
.conversation-sentiment {
  margin-top: 4px;
  display: flex;
  align-items: center;
}
// ... existing styles ...
</style>
// ... existing code ... 