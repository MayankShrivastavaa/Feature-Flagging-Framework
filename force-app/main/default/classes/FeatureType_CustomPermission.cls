public with sharing class FeatureType_CustomPermission implements IFeatureType {
    public Boolean status(Feature_Flag__mdt feature) {
        return FeatureManagement.checkPermission(feature.Rollout_Value__c);
    }
}