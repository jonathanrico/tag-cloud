public with sharing class TagCloudCtrl{

    @AuraEnabled
    public static List<TagCloudItem> getTags(String tagType, Integer maxTags){
        Integer maxItems = Integer.valueOf(maxTags);
        if(tagType == 'most-talked-topics'){
            return getMostTalkedAboutTopics(maxItems);
        }else{
            return getObjectTopics(tagType, maxItems);
        }
    }

    private static List<TagCloudItem> getMostTalkedAboutTopics(Integer maxItems){
        List<TagCloudItem> results = new List<TagCloudItem>();
        if(hasCRUDFLSForTopics()){
            Set<Id> mostTalkedTopicIds = new Set<Id>();
            for(Topic t : [select Id from Topic order by TalkingAbout desc limit :maxItems]){
                mostTalkedTopicIds.add(t.Id);
            }
            if(mostTalkedTopicIds.size()>0){
              for(Topic t : [select Id,Name,TalkingAbout from Topic where id in :mostTalkedTopicIds order by Name asc]){
                  results.add(new TagCloudItem(t.Id, t.Name, t.TalkingAbout));
              }
            }
        }
        return results;
    }

    private static List<TagCloudItem> getObjectTopics(String objectName, Integer maxItems){
        List<TagCloudItem> results = new List<TagCloudItem>();
        if(hasCRUDFLSForTopicAssignments()){
            Map<Id,Integer> topicsMap = new Map<Id,Integer>();
            Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
            Schema.SObjectType sObjType = globalDescribe.get(objectName);
            if(sObjType == null){
                return results;
            }
            String objectPrefix = sObjType.getDescribe().getkeyprefix();
            //TODO: Figure out how to expand the limit of this query
            //Currently limited by System.QueryException: Implementation restriction: TopicAssignment
            //only allows security evaluation for non-admin users when either (1) LIMIT is specified
            //and at most 1000 or (2) WHERE is specified and filter on Id or Entity
            List<AggregateResult> groupedResults = [select TopicId
                                                    ,Count(Id) cnt
                                                    from TopicAssignment
                                                    where EntityKeyPrefix = :objectPrefix
                                                    and CreatedDate = THIS_MONTH
                                                    group by TopicId
                                                    order by Count(Id) desc
                                                    LIMIT 1000];
            for (AggregateResult ar : groupedResults){
                if(topicsMap.size() > maxItems){
                  break;
                }
                topicsMap.put((String)ar.get('TopicId'), (Integer)ar.get('cnt'));
            }
            for(Topic t : [select Id,Name from Topic where id in :topicsMap.keySet() order by Name asc]){
                results.add(new TagCloudItem(t.Id, t.Name, topicsMap.get(t.Id)));
            }
        }
        return results;
    }

    private static Boolean hasCRUDFLSForTopics(){
        if(!Topic.sObjectType.getDescribe().isAccessible()){
            return false;
        }
        Set<String> topicReadFields = new Set<String>{
            'Id'
            ,'Name'
            ,'TalkingAbout'
        };
        Map<String,Schema.SObjectField> m = Schema.SObjectType.Topic.fields.getMap();
        for (String fieldToCheck : topicReadFields) {
            // Check if the user has create read on each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
                return false;
            }
        }
        return true;
    }

    private static Boolean hasCRUDFLSForTopicAssignments(){
        if(!TopicAssignment.sObjectType.getDescribe().isAccessible()){
            return false;
        }
        Set<String> topicAssignmentReadFields = new Set<String>{
            'Id'
        };
        Map<String,Schema.SObjectField> m = Schema.SObjectType.TopicAssignment.fields.getMap();
        for (String fieldToCheck : topicAssignmentReadFields) {
            // Check if the user has create read on each field
            if (!m.get(fieldToCheck).getDescribe().isAccessible()) {
                return false;
            }
        }
        return true;
    }

}
