@isTest
private class TestFlickrPublicFeedCtrl{

    static testMethod void testValidFlickrResponse(){

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('FlickrMockResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            List<FlickrPhoto> result = FlickrPublicFeedCtrl.getFlickrFeedPhotos('35972800@N02');
            System.assert(result != null);
            System.assert(result.size() == 20);
        Test.stopTest();
    }

}