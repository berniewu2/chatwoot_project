<script setup>
defineProps({
  message: {
    type: Object,
    required: true,
  },
});
</script>

<template>
  <div class="space-y-1 text-n-slate-12">
    <div class="font-medium">{{ $t('AI_AGENT.COPILOT.YOU') }}</div>
    <div class="break-words">
      {{ message.content }}
    </div>
  </div>
</template>
