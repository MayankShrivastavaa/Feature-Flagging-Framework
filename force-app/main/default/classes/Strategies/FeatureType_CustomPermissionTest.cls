@isTest
public with sharing class FeatureType_CustomPermissionTest {
    @IsTest
    private static void testCustomPermissionFeatureNegative() {

        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestCustomPermission';
        Mockfeature.Rollout_Type__c = 'Custom Permission';
        Mockfeature.MasterLabel = 'Test Custom Permission';
        Mockfeature.Rollout_Value__c = 'SomePermission';

        IFeatureType featureType = (IFeatureType) Type.forName('FeatureType_CustomPermission').newInstance();
        System.assertEquals(false, featureType.status(Mockfeature));
    }
}