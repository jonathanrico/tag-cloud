public with sharing class MeetupService{

    public static List<MeetupEvent> getOpenEvents(Map<String,String> params){
    
        String meetupAPIKey = MeetupSettings.getAPIKey();
        
        if(String.isBlank(meetupAPIKey)){
            return null;
        }
        
        List<MeetupEvent> results = new List<MeetupEvent>();

        String searchText = getParamValue(params,'searchText','salesforce');
        String textFormat = getParamValue(params,'textFormat','simpleHTML');
        String zipCode = getParamValue(params,'zipCode','94105');
        String radius = getParamValue(params,'radius','50');
        String page = getParamValue(params,'page','20');

        Map<String,String> reqParams = new Map<String,String>{
            'key' => meetupAPIKey,
            'sign' => 'true',
            'photo-host' => 'secure',
            'country' => 'US',
            'text' => searchText,
            'text_format' => textFormat,
            'zip' => zipCode,
            'radius' => radius,
            'page' => page
        };
        
        PageReference reqEndpoint = new PageReference('https://api.meetup.com/2/open_events');
        reqEndpoint.getParameters().putAll(reqParams);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(reqEndpoint.getUrl());
        req.setMethod('GET');
       
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        Map<String,Object> jsonResult = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        
        if(jsonResult.get('results') != null){
            List<Object> events = (List<Object>)jsonResult.get('results');
            for(Object event : events){
                Map<String,Object> mapEvent = (Map<String,Object>)event;
                MeetupEvent mEvent = new MeetupEvent();
                mEvent.eventId = (String)mapEvent.get('id');
                mEvent.name = (String)mapEvent.get('name');
                mEvent.description = (String)mapEvent.get('description');
                mEvent.eventURL = (String)mapEvent.get('event_url');
                mEvent.city = (String)mapEvent.get('name');
                mEvent.waitlistCount = (Integer)mapEvent.get('waitlist_count');
                mEvent.rsvpCount = (Integer)mapEvent.get('yes_rsvp_count');
                mEvent.rsvpLimit = (Integer)mapEvent.get('rsvp_limit');
                if(mapEvent.get('time') != null){
                    mEvent.formattedDate = formatUnixTimeStamp((Long)mapEvent.get('time'));
                }
                
                Map<String,Object> venueMap = (Map<String,Object>)mapEvent.get('venue');
                if(venueMap != null){
                    mEvent.city = (String)venueMap.get('city');
                    mEvent.address = (String)venueMap.get('address_1');
                    mEvent.latitude = (Double)venueMap.get('lat');
                    mEvent.longitude = (Double)venueMap.get('lon');
                }
                results.add(mEvent);
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
    
    private static String formatUnixTimeStamp(Long unixTime){
        if(unixTime == null){
            return '';
        }
        unixTime = unixTime/1000;
        DateTime dateInstance = DateTime.newInstanceGmt(1970, 1, 1, 0, 0, 0);
        return dateInstance.addSeconds(unixTime.intValue()).format();
    }

}