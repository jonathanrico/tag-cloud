@isTest
private class TestFlickrService{

    static testMethod void testValidFlickrResponse(){

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('FlickrMockResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            List<FlickrPhoto> result = FlickrService.getPhotos(getTestParams());
            System.assert(result != null);
            System.assert(result.size() == 20);
        Test.stopTest();
    }

    static Map<String,String> getTestParams(){
        Map<String,String> testParams = new Map<String,String>{
            'userId'=>'35972800@N02'
        };
        return testParams;
    }

}