@isTest
private class TestMeetupSettings{

    static testMethod void testWithoutCustomSettings(){
        Test.startTest();
            String apiKey = MeetupSettings.getAPIKey();
            System.assert(apiKey == null);
        Test.stopTest();
    }

    static testMethod void testWithCustomSettings(){
        createTestCustomSetting();
        Test.startTest();
            String apiKey = MeetupSettings.getAPIKey();
            System.assert(apiKey != null);
        Test.stopTest();
    }

    static void createTestCustomSetting(){
        Meetup_Settings__c cs = new Meetup_Settings__c();
        cs.API_Key__c = 'MYSUPERSECRETAPIKEY';
        insert cs;
    }

}