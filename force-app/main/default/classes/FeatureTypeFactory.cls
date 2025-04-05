public with sharing class FeatureTypeFactory {
    private Static Final String CLASS_PREFIX = 'FeatureType_';
    public static IFeatureType getFeatureType(String rolloutType) {
        try{
            String className = CLASS_PREFIX + String.valueOf(rolloutType).replace(' ', '');
            return (IFeatureType)Type.forName(className).newInstance();
        }catch(Exception e){
            System.debug('Class not found for feature type: ' + rolloutType);
            return (IFeatureType)Type.forName('FeatureType_Disabled').newInstance();
        }
    }
}