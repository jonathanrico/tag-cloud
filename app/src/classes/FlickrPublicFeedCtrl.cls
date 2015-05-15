public with sharing class FlickrPublicFeedCtrl{

    @AuraEnabled
    public static List<FlickrPhoto> getFlickrFeedPhotos(String userId){
        Map<String,String> params = new Map<String,String>();
        params.put('userId',userId);
        return FlickrService.getPhotos(params);
    }

}