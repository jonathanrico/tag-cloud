public with sharing class MeetupEvent{

    @AuraEnabled public String eventId{get;set;}
    @AuraEnabled public String name{get;set;}
    @AuraEnabled public String description{get;set;}
    @AuraEnabled public String eventURL{get;set;}
    @AuraEnabled public String city{get;set;}
    @AuraEnabled public String address{get;set;}
    @AuraEnabled public String formattedDate{get;set;}
    
    @AuraEnabled public Integer waitlistCount{get;set;}
    @AuraEnabled public Integer rsvpCount{get;set;}
    @AuraEnabled public Integer rsvpLimit{get;set;}
    @AuraEnabled public Double latitude{get;set;}
    @AuraEnabled public Double longitude{get;set;}

}