import { computed } from 'vue';
import { useMapGetter } from 'dashboard/composables/store';
import { useAccount } from 'dashboard/composables/useAccount';
import { usePolicy } from 'dashboard/composables/usePolicy';
import { FEATURE_FLAGS } from 'dashboard/featureFlags';

/**
 * Composable for feature flag operations.
 * Provides a consistent way to check feature flags across the application.
 * @returns {Object} An object containing feature flag related methods and computed properties.
 */
export function useFeatureFlags() {
  const { accountId, currentAccount } = useAccount();
  const { shouldShow, shouldShowPaywall } = usePolicy();
  const isFeatureEnabledonAccount = useMapGetter('accounts/isFeatureEnabledonAccount');

  /**
   * Check if a feature flag is enabled for the current account
   * @param {string} featureFlag - The feature flag to check
   * @returns {boolean} Whether the feature flag is enabled
   */
  const isFeatureEnabled = featureFlag => {
    if (!featureFlag) return true;
    return isFeatureEnabledonAccount.value(accountId.value, featureFlag);
  };

  /**
   * Check if a feature should be shown based on permissions, feature flag, and installation type
   * @param {string} featureFlag - The feature flag to check
   * @param {Array} permissions - Required permissions
   * @param {Array} installationTypes - Allowed installation types
   * @returns {boolean} Whether the feature should be shown
   */
  const shouldShowFeature = (featureFlag, permissions = [], installationTypes = []) => {
    return shouldShow(featureFlag, permissions, installationTypes);
  };

  /**
   * Check if a paywall should be shown for a feature
   * @param {string} featureFlag - The feature flag to check
   * @returns {boolean} Whether the paywall should be shown
   */
  const shouldShowFeaturePaywall = featureFlag => {
    return shouldShowPaywall(featureFlag);
  };

  return {
    isFeatureEnabled,
    shouldShowFeature,
    shouldShowFeaturePaywall,
    FEATURE_FLAGS,
  };
} 