@isTest
public with sharing class FeatureType_RollTypeValidatorTest {
    
    @IsTest
    public static void validate() {

        Profile p = [Select Id from profile where name = 'System Administrator'];
        UserRole ur = [Select Id from UserRole where name = 'CEO' limit 1];
        User u = new User(
            Alias = 'standt', 
            Email='Testing@someRandomUserName.com', 
            EmailEncodingKey='UTF-8', 
            LastName='Testing', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='Testing@someRandomUserName.com',
            UserRoleId = ur.Id
        );

        FeatureType_RollTypeValidator validator = new FeatureType_RollTypeValidator();
        boolean result;

        system.runAs(u){
            
            result = validator.validate('Profile', 'System Administrator,Custom_Admin_User');
            System.assertEquals(true, result, 'Validation should return true for matching role values.');

            result = validator.validate('UserRole', 'CEO, Administrator,Custom_Admin_User');
            System.assertEquals(true, result, 'Validation should return true for matching role values.');
        }
        result = validator.validate('Role', '');
        System.assertEquals(false, result, 'Validation should return false for no role for user.');
    }
}