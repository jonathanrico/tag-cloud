public with sharing class MeetupSettings{

    public static void setAPIKey(String apiKey){
        Meetup_Settings__c cs = Meetup_Settings__c.getOrgDefaults();
        if(cs == null){
            cs = new Meetup_Settings__c(SetupOwnerId=null);
        }
        cs.API_Key__c = apiKey;
        upsert cs;
    }
    
    public static String getAPIKey(){
        return (String)getValue('API_Key__c',null);
    }

    private static Object getValue(String key, Object defaultValue){
        Meetup_Settings__c cs = Meetup_Settings__c.getInstance();
        if(cs != null && cs.get(key) != null){
            return cs.get(key);
        }else{
            return defaultValue;
        }
    }
    
}