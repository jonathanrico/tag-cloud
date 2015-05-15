public with sharing class FlickrService{

    public static List<FlickrPhoto> getPhotos(Map<String,String> params){
        List<FlickrPhoto> results = new List<FlickrPhoto>();

        String userId = getParamValue(params,'userId','35972800@N02');

        Map<String,String> reqParams = new Map<String,String>{
            'id' => userId,
            'jsoncallback' => '?',
            'format' => 'json'
        };

        PageReference reqEndpoint = new PageReference('https://api.flickr.com/services/feeds/photos_public.gne');
        reqEndpoint.getParameters().putAll(reqParams);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(reqEndpoint.getUrl());
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        String result = res.getBody();
        result = result.substring(1, result.length()-1);

        Map<String,Object> jsonResult = (Map<String,Object>)JSON.deserializeUntyped(result);

        if(jsonResult.get('items') != null){
            List<Object> events = (List<Object>)jsonResult.get('items');
            for(Object event : events){
                Map<String,Object> mapPhoto = (Map<String,Object>)event;
                FlickrPhoto mPhoto = new FlickrPhoto();
                mPhoto.title = (String)mapPhoto.get('title');
                mPhoto.link = (String)mapPhoto.get('link');
                if(mapPhoto.get('media') != null){
                    Map<String,Object> mapPhotoMedia = (Map<String,Object>)mapPhoto.get('media');
                    mPhoto.photoURL = (String)mapPhotoMedia.get('m');
                }
                results.add(mPhoto);
            }
        }


        return results;
    }

    private static String getParamValue(Map<String,String> params, String key, String defaultValue){
        String param = params.get(key);
        if(param != null){
            return param;
        }else{
            return defaultValue;
        }
    }

}