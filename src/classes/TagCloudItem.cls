public with sharing class TagCloudItem{

    @AuraEnabled public String itemId{get;set;}
    @AuraEnabled public String name{get;set;}
    @AuraEnabled public Integer weight{get;set;}

    public TagCloudItem(String itemId, String name, Integer weight){
        this.itemId = itemId;
        this.name = name;
        this.weight = weight;
    }

}
