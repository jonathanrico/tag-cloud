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
        for(Topic t : [select Id,Name,TalkingAbout from Topic order by TalkingAbout desc limit :maxItems]){
            results.add(new TagCloudItem(t.Id, t.Name, t.TalkingAbout));
        }
        return results;
    }

    private static List<TagCloudItem> getObjectTopics(String objectName, Integer maxItems){
        List<TagCloudItem> results = new List<TagCloudItem>();
        Map<Id,Integer> topicsMap = new Map<Id,Integer>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        Schema.SObjectType sObjType = globalDescribe.get(objectName);
        if(sObjType == null){
            return results;
        }
        String objectPrefix = sObjType.getDescribe().getkeyprefix();

        List<AggregateResult> groupedResults = [select TopicId
                                                ,Count(Id) cnt
                                                from TopicAssignment
                                                where EntityKeyPrefix = :objectPrefix
                                                and CreatedDate = THIS_MONTH
                                                group by TopicId
                                                order by Count(Id) desc
                                                LIMIT :maxItems];

        for (AggregateResult ar : groupedResults){
            topicsMap.put((String)ar.get('TopicId'), (Integer)ar.get('cnt'));
        }

        for(Topic t : [select Id,Name from Topic where id in :topicsMap.keySet() order by Name desc]){
            results.add(new TagCloudItem(t.Id, t.Name, topicsMap.get(t.Id)));
        }

        return results;
    }


}
