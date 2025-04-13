public with sharing class FeatureType_Profile implements IFeatureType {
    static Map<String, boolean> profileCache = new Map<String, Boolean>(); //Static Map to hold profile values as cached values.
    public Boolean status(Feature_Flag__mdt feature) {
        try{
            
            String UserFeatureProfile = UserInfo.getUserId()+'_'+feature.DeveloperName+'_'+UserInfo.getProfileId(); // Create a unique key for the user, feature and profile.
            if(profileCache.containsKey(UserFeatureProfile)){
                return profileCache.get(UserFeatureProfile); // Check and return status if the user with profile is in the cache.
            }
            FeatureType_RollTypeValidator validator = new FeatureType_RollTypeValidator('Profile', feature.Rollout_Value__c); // Create an instance of the validator.
            profileCache.put(UserFeatureProfile, validator.validate()); // Initialize the cache with false.
            return profileCache.get(UserFeatureProfile); // Return the profile status.
            
        }catch(Exception e){
            System.debug('Error processing feature' + feature.DeveloperName + ' , '+e.getMessage());
            return false;
        }
        
    }
}