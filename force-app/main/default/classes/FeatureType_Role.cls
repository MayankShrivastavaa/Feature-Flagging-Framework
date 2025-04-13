public with sharing class FeatureType_Role implements IFeatureType {
    static Map<String, boolean> RoleCache = new Map<String, Boolean>(); //Static Map to hold Role values as cached values.
    public Boolean status(Feature_Flag__mdt feature) {
        try{
            
            String UserFeatureRole = UserInfo.getUserId()+'_'+feature.DeveloperName+'_'+UserInfo.getUserRoleId(); // Create a unique key for the user, feature and profile.
            if(RoleCache.containsKey(UserFeatureRole)){
                return RoleCache.get(UserFeatureRole); // Check and return status if the user with role is in the cache.
            }
            FeatureType_RollTypeValidator validator = new FeatureType_RollTypeValidator('Role', feature.Rollout_Value__c); // Create an instance of the validator.
            RoleCache.put(UserFeatureRole, validator.validate()); // Initialize the cache with false.
            return RoleCache.get(UserFeatureRole); // Return the profile status.
            
        }catch(Exception e){
            System.debug('Error processing feature' + feature.DeveloperName + ' , '+e.getMessage());
            return false;
        }
        
    }
}