@isTest
public with sharing class FeatureType_EnabledDisabledTest {
    @IsTest
    private static void testEnabledFeature() {

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestGlobalEnabled';
        Mockfeature.Rollout_Type__c = 'Enabled';
        Mockfeature.MasterLabel = 'Test Global Enabled';
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Enabled').newInstance();
        System.assertEquals(true, featureType.status(Mockfeature));
    }

    @IsTest
    private static void testDisabledFeature() {

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestGlobalDisabled';
        Mockfeature.Rollout_Type__c = 'Disabled';
        Mockfeature.MasterLabel = 'Test Global Disabled';
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Disabled').newInstance();
        System.assertEquals(false, featureType.status(Mockfeature));
    }

}