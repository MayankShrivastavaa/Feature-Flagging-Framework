public class without sharing FeatureTypeFactory {
    public static IFeatureType getFeatureType(String rolloutType) {
        try{
            String className = 'FeatureType_' + String.valueOf(rolloutType).replace(' ', '');
            return (IFeatureType)Type.forName(className).newInstance();
        }catch(Exception e){
            System.debug('Class not found for feature type: ' + rolloutType);
            return (IFeatureType)Type.forName('FeatureType_Disabled').newInstance();
        }
    }

    class FeatureType_Enabled implements IFeatureType {
        public Boolean status(Feature_Flag__mdt feature) {
            return true;
        }
    }
    class FeatureType_Disabled implements IFeatureType {
        public Boolean status(Feature_Flag__mdt feature) {
            return false;
        }
    }
}