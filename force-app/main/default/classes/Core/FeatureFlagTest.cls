@isTest
public with sharing class FeatureFlagTest {
    
    @IsTest
    private static void testFeature() {

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();

        System.AssertEquals(false, FeatureFlag.evaluate('InvalidFeature')); //Integration Testing with invalid data

        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'Enabled';
        FeatureFlag.mockedMetadata = Mockfeature;

        System.AssertEquals(true, FeatureFlag.evaluate('TestFlagTrue')); //Integration Testing with Mock Data
        System.AssertEquals(true, FeatureFlag.evaluate('TestFlagTrue')); //Cache Testing with Mock Data
    }

    @IsTest
    private static void testFeatureWithStartAndEndDate() {

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();

        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'Enabled';
        Mockfeature.Start_date__c = System.today().addDays(1); // Set start date to a future date
        FeatureFlag.mockedMetadata = Mockfeature;
        
        System.AssertEquals(false, FeatureFlag.evaluate('TestFlagTrue')); //Integration Testing with future start Date

        Mockfeature.End_date__c = System.today().addDays(-1); // Set End date to a past date
        FeatureFlag.mockedMetadata = Mockfeature;

        System.AssertEquals(false, FeatureFlag.evaluate('TestFlagTrue')); //Integration Testing with Past End Date

    }
}