public with sharing class MeetupListCtrl{

    @AuraEnabled
    public static List<MeetupEvent> getEvents(String searchText, String radius, String zipCode, String maxResults){
        Map<String,String> params = new Map<String,String>();
        params.put('searchText',searchText);
        params.put('radius',radius);
        params.put('zipCode',zipCode);
        params.put('page',maxResults);
        return MeetupService.getOpenEvents(params);
    }
    
    @AuraEnabled
    public static void updateAPIKey(String apiKey){
        MeetupSettings.setAPIKey(apiKey);
    }

    @AuraEnabled
    public static Boolean canModifyAllData(){
        Profile p = [select Id, PermissionsModifyAllData from Profile where Id = :UserInfo.getProfileId()];
        return p.PermissionsModifyAllData;
    }

    
    @AuraEnabled
    public static String getRecentlyUsedTopics(){
        String results = '';
        Set<Id> topicIds = new Set<Id>();
        List<AggregateResult> groupedResults = [select TopicId
                                                ,Count(Id) 
                                                from TopicAssignment 
                                                where CreatedById = :UserInfo.getUserId() 
                                                and CreatedDate = THIS_MONTH
                                                group by TopicId
                                                order by Count(Id) desc
                                                LIMIT 1000];
                                                
        for (AggregateResult ar : groupedResults){
            topicIds.add((String)ar.get('TopicId'));
            if(topicIds.size() >= 5){
                break;
            }
        }
        
        if(topicIds.size()>0){
            List<String> topicNames = new List<String>();
            for(Topic t : [select Id,Name from Topic where id in :topicIds]){
                topicNames.add(t.Name);
            }
            results = String.join(topicNames,' OR ');
        }
        return results;
    }

}