public with sharing class Feature {
    @testVisible
    Private Static Map<String, Boolean> FeatureCache = new Map<String, Boolean>(); //Static Map to hold feature flag values as cahed values.
    
    public Static Boolean isActive(String featureName) { //Public function to check the feature flag.
        if(FeatureCache.containsKey(featureName)){ 
            return FeatureCache.get(featureName); // Check and return status if the feature is in the cache.
        }
        Boolean isActive = featureFlag.evaluate(featureName);
        
        FeatureCache.put(featureName, isActive); // Write feature flag to the cache.
        return isActive;
    }
    @AuraEnabled(cacheable=true)
    public static Boolean featureStatus(String featureName){
        return isActive(featureName);
    }
}