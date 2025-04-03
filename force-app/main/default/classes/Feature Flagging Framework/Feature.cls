public with sharing class Feature {
    Static Map<String, Boolean> FeatureCache = new Map<String, Boolean>(); //Static Map to hold feature flag values as cahed values.
    Static Map<String, IFeatureType> FeatureTypeCache = new Map<String, IFeatureType>(); //Static Map to hold feature flag types instances as cahed values.

    public Static Boolean isActive(String featureName) { //Public function to check the feature flag.
        if(FeatureCache.containsKey(featureName)){ // Check if the feature is in the cache.
            return FeatureCache.get(featureName);
        }
        Boolean isActive = false;
        Feature_Flag__mdt feature = Feature_Flag__mdt.getInstance(featureName);// Get the feature flag record.
        if (feature != null) {
            try{
                IFeatureType featureType = FeatureTypeCache.containsKey(feature.Rollout_Type__c) ? FeatureTypeCache.get(feature.Rollout_Type__c) : FeatureTypeFactory.getFeatureType(feature.Rollout_Type__c); //Get Instance of feature type
                if(!FeatureTypeCache.containsKey(feature.Rollout_Type__c)) FeatureTypeCache.put(feature.Rollout_Type__c, featureType); //Write instance to the cache map
                isActive = (featureType != null) ? featureType.status(feature) : false; // Get feature type and check the feature flag.
            } catch(Exception e){
                System.debug('Error processing feature' + featureName + ' , '+e.getMessage());
                FeatureCache.put(featureName, false);
            }
        }
        FeatureCache.put(featureName, isActive); // Write feature flag to the cache.
        return isActive;
    }
    @AuraEnabled
    public static Boolean featureStatus(String featureName){
        return isActive(featureName);
    }
}