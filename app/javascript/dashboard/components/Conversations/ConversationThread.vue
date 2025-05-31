<template>
  <div class="conversation-thread">
    <div v-for="message in messages" :key="message.id" class="message">
      <!-- ... existing message content ... -->
      <div v-if="message.content_attributes?.sentiment" class="message-sentiment">
        <sentiment-badge
          :score="message.content_attributes.sentiment.score"
          :show-label="true"
        />
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SentimentBadge from '../widgets/SentimentBadge.vue';
import type { Message } from '../../types/message';

export default defineComponent({
  name: 'ConversationThread',
  components: {
    SentimentBadge
  },
  props: {
    messages: {
      type: Array as () => Message[],
      required: true
    }
  }
  // ... rest of existing script
});
</script>

<style lang="scss" scoped>
.message-sentiment {
  margin-top: 4px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
</style> 