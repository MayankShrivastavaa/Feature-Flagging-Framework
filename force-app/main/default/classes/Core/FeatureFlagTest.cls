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
}