<script setup>
import InboxCard from './InboxCard.vue';
import { inboxes } from 'dashboard/components-next/aiAgent/pageComponents/emptyStates/aiAgentEmptyStateContent.js';
</script>

<template>
  <Story
    title="Agent/Topic/InboxCard"
    :layout="{ type: 'grid', width: '700px' }"
  >
    <Variant title="Inbox Card">
      <div
        v-for="inbox in inboxes"
        :key="inbox.id"
        class="px-20 py-4 bg-white dark:bg-slate-900"
      >
        <InboxCard :id="inbox.id" :inbox="inbox" />
      </div>
    </Variant>
  </Story>
</template>
