public with sharing class FeatureType_RollTypeValidator {

    public boolean validate(String type, String roleValue){
        try{
            List<String> roleValueList = new List<String>();
            if (!String.isEmpty(roleValue)) {
                roleValueList = roleValue.split(',');
            }
            
            if(!FeatureFlag.userInfoMap.containsKey(UserInfo.getUserId())){
                User currentUser = [SELECT Id, Name,ProfileId, Profile.Name, UserRoleId, UserRole.Name FROM User WHERE Id = :UserInfo.getUserId()]; 
                FeatureFlag.userInfoMap.put(UserInfo.getUserId(), currentUser.getPopulatedFieldsAsMap());
            }
            if(FeatureFlag.UserInfoMap.get(UserInfo.getUserId()).containsKey(type) && FeatureFlag.UserInfoMap.get(UserInfo.getUserId()).get(type) != null){
                return roleValueList.contains((String)((Sobject) FeatureFlag.UserInfoMap.get(UserInfo.getUserId()).get(type)).get('Name')); // Check if the user has the role or profile in the list.
            }else{
                return false; // If the user does not have a Profile/Role, return false.
            }
        }catch(Exception e){
            System.debug('Error processing feature : '+e.getMessage());
            return false;
        }
    }
}