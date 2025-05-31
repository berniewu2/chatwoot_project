<template>
  <div class="sentiment-badge" :class="sentimentClass">
    <span class="sentiment-icon">{{ sentimentIcon }}</span>
    <span class="sentiment-score">{{ formattedScore }}</span>
    <span v-if="showLabel" class="sentiment-label">{{ sentimentLabel }}</span>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from 'vue';

export default defineComponent({
  name: 'SentimentBadge',
  props: {
    score: {
      type: Number,
      required: true
    },
    showLabel: {
      type: Boolean,
      default: true
    }
  },
  setup(props) {
    const sentimentClass = computed(() => {
      if (props.score < -0.05) return 'negative';
      if (props.score > 0.05) return 'positive';
      return 'neutral';
    });

    const sentimentIcon = computed(() => {
      if (props.score < -0.05) return '😟';
      if (props.score > 0.05) return '😊';
      return '😐';
    });

    const sentimentLabel = computed(() => {
      if (props.score < -0.05) return 'Negative';
      if (props.score > 0.05) return 'Positive';
      return 'Neutral';
    });

    const formattedScore = computed(() => {
      return props.score.toFixed(2);
    });

    return {
      sentimentClass,
      sentimentIcon,
      sentimentLabel,
      formattedScore
    };
  }
});
</script>

<style lang="scss" scoped>
.sentiment-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.85rem;
  line-height: 1.2;

  &.negative {
    background-color: #fee2e2;
    color: #991b1b;
  }

  &.positive {
    background-color: #dcfce7;
    color: #166534;
  }

  &.neutral {
    background-color: #f3f4f6;
    color: #374151;
  }

  .sentiment-icon {
    font-size: 1rem;
  }

  .sentiment-score {
    font-weight: 500;
  }

  .sentiment-label {
    font-size: 0.75rem;
    text-transform: capitalize;
  }
}
</style> 