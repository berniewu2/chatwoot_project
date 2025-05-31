<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import { FEATURE_FLAGS } from 'dashboard/featureFlags';
import { useMapGetter } from 'dashboard/composables/store';

const props = defineProps({
  sentiment: {
    type: Object,
    default: () => ({}),
  },
});

const { t } = useI18n();
const isFeatureEnabled = useMapGetter('accounts/isFeatureEnabledonAccount');
const accountId = useMapGetter('getCurrentAccountId');

const isSentimentAnalysisEnabled = computed(() => {
  return isFeatureEnabled.value(accountId.value, FEATURE_FLAGS.SENTIMENT_ANALYSIS);
});

const sentimentScore = computed(() => {
  return props.sentiment?.score || 0;
});

const sentimentIcon = computed(() => {
  if (sentimentScore.value >= 0.5) return 'emoji-happy';
  if (sentimentScore.value <= -0.5) return 'emoji-sad';
  return 'emoji-neutral';
});

const sentimentColor = computed(() => {
  if (sentimentScore.value >= 0.5) return 'text-green-500';
  if (sentimentScore.value <= -0.5) return 'text-red-500';
  return 'text-yellow-500';
});

const sentimentLabel = computed(() => {
  if (sentimentScore.value >= 0.5) return t('SENTIMENT.POSITIVE');
  if (sentimentScore.value <= -0.5) return t('SENTIMENT.NEGATIVE');
  return t('SENTIMENT.NEUTRAL');
});

const showSentiment = computed(() => {
  return isSentimentAnalysisEnabled.value && props.sentiment?.score !== undefined;
});
</script>

<template>
  <div v-if="showSentiment" class="flex items-center gap-1 mt-1 text-xs">
    <fluent-icon
      :icon="sentimentIcon"
      size="14"
      :class="sentimentColor"
      class="inline-block"
    />
    <span :class="sentimentColor" class="font-medium">
      {{ sentimentLabel }}
    </span>
    <span class="text-slate-500">
      ({{ (sentimentScore * 100).toFixed(0) }}%)
    </span>
  </div>
</template> 