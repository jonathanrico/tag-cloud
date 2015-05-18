public with sharing class TagCloudCtrl{

    @AuraEnabled
    public static List<TagCloudItem> getTags(String tagType){
        if(tagType == 'most-talked-topics'){
            return getMostTalkedAboutTopics();
        }else{
            return new List<TagCloudItem>();
        }
    }

    private static List<TagCloudItem> getMostTalkedAboutTopics(){
        List<TagCloudItem> results = new List<TagCloudItem>();
        Integer min = 0;
        Integer max = 0;
        
        for(Topic t : [select Id,Name,TalkingAbout from Topic limit 100]){
            results.add(new TagCloudItem(t.Id, t.Name, t.TalkingAbout));
        }
        return results;
    }

}
