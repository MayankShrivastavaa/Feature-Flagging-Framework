public class FeatureFlagMockResponse implements stubProvider{
	public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
        Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
        List<Object> listOfArgs) {
        if (stubbedMethodName == 'evaluate') {
            return true;
        }
        return null;
    }
}