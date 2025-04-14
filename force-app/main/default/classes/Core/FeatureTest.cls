@isTest
private class FeatureTest {

    @isTest
    private static void testFeature() {
        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.MasterLabel = 'Test Flag True';
        Mockfeature.DeveloperName = 'Test_Flag_True';
        Mockfeature.Rollout_Type__c = 'Enabled';
        FeatureFlag.mockedMetadata = Mockfeature;
        System.AssertEquals(true, Feature.isActive('Test Flag True')); //Integration Testing with Mock Data
        System.AssertEquals(true, Feature.FeatureCache.get('Test Flag True')); //Cache Hit Testing
        System.AssertEquals(true, Feature.featureStatus('Test Flag True')); //LWC Function Testing
    }
}