public with sharing class FeatureType_CustomPermission implements IFeatureType {
    Static Map<String,Boolean>  customPermissionCache = new Map<String, Boolean>(); //Static Map to hold custom permission values as cached values.
    String userIdPrefix = UserInfo.getUserId()+'_'; //Prefix for user specific caching.
    public Boolean status(Feature_Flag__mdt feature) {
        try{
            for(String permissionName : feature.Rollout_Value__c.split(',')){
                String userPermission = userIdPrefix+permissionName; // Create a unique key for the user and custom permission.
                if(customPermissionCache.containsKey(userPermission)){
                    if(!customPermissionCache.get(userPermission)){
                        return false;
                    }
                }else {
                    customPermissionCache.put(userPermission, FeatureManagement.checkPermission(permissionName)); // check and cache user custom permission.
                    if(!customPermissionCache.get(userPermission)){
                        return false;
                    }
                }
            }
            return true;
        }catch(Exception e){
            System.debug('Error processing feature' + feature.DeveloperName + ' , '+e.getMessage());
            return false;
        }
    }
}