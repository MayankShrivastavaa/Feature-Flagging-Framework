public with sharing class FeatureFlag {

    public static Map<Id, Map<String, Object>> userInfoMap = new Map<Id, Map<String, Object>>(); //Static Map to hold user info values as cached values.
    @testVisible
    Private Static Map<String, IFeatureType> FeatureTypeCache = new Map<String, IFeatureType>(); //Static Map to hold feature flag types instances as cahed values.

    @testVisible
    private static Feature_Flag__mdt mockedMetadata = null;

    public static boolean evaluate(String featureName){
        try{
            Feature_Flag__mdt feature = mockedMetadata!=null ? mockedMetadata : Feature_Flag__mdt.getInstance(featureName);

            if(feature == null){
                return false;
            }

            IFeatureType featureType = FeatureTypeCache.containsKey(feature.Rollout_Type__c) ? FeatureTypeCache.get(feature.Rollout_Type__c) : FeatureTypeFactory.getFeatureType(feature.Rollout_Type__c); //Get Instance of feature type
            
            if(!FeatureTypeCache.containsKey(feature.Rollout_Type__c)) {
                FeatureTypeCache.put(feature.Rollout_Type__c, featureType);  //Write instance to the cache map
            }
            return (featureType != null) ? featureType.status(feature) : false; // Get feature type and check the feature flag.
        } catch(Exception e){
            System.debug('Error processing feature' + featureName + ' , '+e.getMessage());
            return false;
        }
    }

}