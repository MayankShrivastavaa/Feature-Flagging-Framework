@isTest
public with sharing class FeatureType_ProfileTest {

    @TestSetup
    static void makeData(){
        Profile p = [Select Id from Profile where name = 'System Administrator'];
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

        insert u;
    }

    @IsTest
    private static void testProfileBasedRolloutPositive() {
        Test.startTest();
        
        User u = [Select id, name from user where username = 'Testing@someRandomUserName.com'];
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Profile').newInstance();

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.MasterLabel = 'Test Flag True';
        Mockfeature.DeveloperName = 'Test_Flag_True';
        Mockfeature.Rollout_Type__c = 'Profile';
        Mockfeature.Rollout_Value__c = 'System Administrator,Custom User,Custom Admin';
        FeatureFlag.mockedMetadata = Mockfeature;

        System.runAs(u) {
            System.assertEquals(true, featureType.status(Mockfeature)); //Positive Integration Testing with Mock Data
        }
        Test.stopTest();
         
    }

    @isTest
    private static void testProfileBasedRolloutNegative() {
        Test.startTest();

        User u = [Select id,ProfileId, name from user where username = 'Testing@someRandomUserName.com'];
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Profile').newInstance();

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature = new Feature_Flag__mdt();
        Mockfeature.MasterLabel = 'Test Flag False';
        Mockfeature.DeveloperName = 'Test_Flag_False';
        Mockfeature.Rollout_Type__c = 'Profile';
        Mockfeature.Rollout_Value__c = 'Custom Admin,Custom User';
        FeatureFlag.mockedMetadata = Mockfeature;

        System.runAs(u) {
            System.AssertEquals(false, featureType.status(Mockfeature)); //Negative Testing
            System.AssertEquals(false, featureType.status(Mockfeature)); //Cache Testing
        }
    }
    
}