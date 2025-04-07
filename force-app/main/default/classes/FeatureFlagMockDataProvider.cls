public with sharing class FeatureFlagMockDataProvider implements System.StubProvider{

    public Object handleMethodCall(
        Object stubbedObject, 
        String stubbedMethodName, 
        Type returnType, 
        List<Type> listOfParamTypes, 
        List<String> listOfParamNames, 
        List<Object> listOfArgs) {
        
            for(MethodCall methodCall : methodCalls){
                if(methodCall.methodName.toLowerCase() == stubbedMethodName.toLowerCase()){
                    return methodCall.handleCall();
                }
            }
        return null;
    }

    List<MethodCall> methodCalls = new List<MethodCall>();
    Type objectType;

    public FeatureFlagMockDataProvider(Type objectType){
        this.objectType = objectType;
    }

    public FeatureFlagMockDataProvider trackMethod(MethodCall toTrack){
        this.methodCalls.add(toTrack);
        return this;
    }

    public FeatureFlagMockDataProvider trackMethods(List<MethodCall> toTrack){
        this.methodCalls.addAll(toTrack);
        return this;
    } 

    public Object generate(){
        return Test.createStub(this.objectType, this);
    }

    public class MethodCall{

        String methodName;
        Object returnValue;
        Integer countCalls;
        Boolean throwsException =  false;
        String exceptionMessage;

        public MethodCall(String methodName){
            this.methodName = methodName;
        }

        public MethodCall withReturnValue(Object returnValue){
            this.returnValue = returnValue;
             return this;
        }

        public MethodCall withThrowException(String exceptionMessage){
            this.exceptionMessage = exceptionMessage;
            return this;
        }

        public Object handleCall(){
            countCalls++;

            if(throwsException){
                throw new FeatureFlagMockException(exceptionMessage);
            }

            return returnValue;
        }
    }

    public class FeatureFlagMockException extends Exception{}
}
