<script setup>
import TopicCard from './TopicCard.vue';
import { topicsList } from 'dashboard/components-next/aiAgent/pageComponents/emptyStates/aiAgentEmptyStateContent.js';
</script>

<template>
  <Story
    title="AiAgent/Topic/TopicCard"
    :layout="{ type: 'grid', width: '700px' }"
  >
    <Variant title="Topic Card">
      <div
        v-for="(topic, index) in topicsList"
        :key="index"
        class="px-20 py-4 bg-white dark:bg-slate-900"
      >
        <TopicCard
          :id="topic.id"
          :name="topic.name"
          :description="topic.description"
          :updated-at="topic.updated_at || topic.created_at"
          :created-at="topic.created_at"
        />
      </div>
    </Variant>
  </Story>
</template>
