@isTest
public with sharing class FeatureTypeTest {
    
    @IsTest
    private static void testEnabledFeature() {
        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'Enabled';
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Enabled').newInstance();
        System.assertEquals(true, featureType.status(Mockfeature));
    }

    @IsTest
    private static void testDisabledFeature() {
        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'Disabled';
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_Disabled').newInstance();
        System.assertEquals(false, featureType.status(Mockfeature));
    }

    @IsTest
    private static void testCustomPermissionFeature() {
        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'CustomPermission';
        Mockfeature.Rollout_Value__c = 'SomePermission';
        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_CustomPermission').newInstance();
        System.assertEquals(false, featureType.status(Mockfeature));
    }
}