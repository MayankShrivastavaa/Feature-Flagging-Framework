@isTest
public with sharing class FeatureTypeFactoryTest {
    
    @IsTest
    private static void testValidRolloutClass() {
        String Rollout = 'Enabled';
        IFeatureType featureType = FeatureTypeFactory.getFeatureType(Rollout);
        System.assertEquals('FeatureType_Enabled', String.valueOf(featureType).split(':')[0]);
        Rollout = 'invalid';
        featureType = FeatureTypeFactory.getFeatureType(Rollout);
        System.assertEquals('FeatureType_Disabled', String.valueOf(featureType).split(':')[0]);
    }
}