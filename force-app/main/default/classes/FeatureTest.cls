@isTest
private class FeatureTest {

    @isTest
    private static void testFeature() {
        Feature_Flag__mdt Mockfeature = new Feature_Flag__mdt();
        Mockfeature.DeveloperName = 'TestFlagTrue';
        Mockfeature.Rollout_Type__c = 'Enabled';
        FeatureFlag.mockedMetadata = Mockfeature;
        System.AssertEquals(true, Feature.isActive('TestFlagTrue')); //Integration Testing with Mock Data
        System.AssertEquals(true, Feature.FeatureCache.get('TestFlagTrue')); //Cache Hit Testing
        System.AssertEquals(true, Feature.featureStatus('TestFlagTrue')); //LWC Function Testing
    }

    @isTest 
    public static void testFeatureWithMock() {
        
        FeatureFlagMockDataProvider stub = new FeatureFlagMockDataProvider(FeatureFlag.class);
        FeatureFlagMockDataProvider.MethodCall methodToTrack = new FeatureFlagMockDataProvider.MethodCall('evaluate').withReturnValue(true);
        stub.trackMethod(methodToTrack);
        System.assertEquals(
            true,
            Feature.isActive('featureName'), 
            'expected feature flag to be enabled');
    }
}