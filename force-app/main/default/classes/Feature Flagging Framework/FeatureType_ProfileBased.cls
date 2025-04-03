public with sharing class FeatureType_ProfileBased implements IFeatureType{
    static string userProfileName;
    Static Map<String, Boolean> profileCache = new Map<String, Boolean>();
    public Boolean status(Feature_Flag__mdt feature) {
        
        if(userProfileName==null){
            userProfileName = [SELECT profile.Name FROM User WHERE Id = :UserInfo.getUserId()].profile.Name;
        }

        if (profileCache.containsKey(userProfileName)) {
            return profileCache.get(userProfileName);
        }

        Set<String> profiles = new Set<String>(feature.Rollout_Value__c.split(','));
        Boolean isActive = profiles.contains(userProfileName);
        profileCache.put(userProfileName, isActive);
        return isActive;
    }
}