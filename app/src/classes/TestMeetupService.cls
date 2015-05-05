@isTest
private class TestMeetupService{

    static testMethod void testWithoutAPIKey(){
        Test.startTest();
            List<MeetupEvent> result = MeetupService.getOpenEvents(getTestParams());
            System.assert(result == null);
        Test.stopTest();
    }

    static testMethod void testValidResponseAPIKey(){
        createTestCustomSetting();

        Test.setMock(HttpCalloutMock.class, new TestMeetupMock());
        Test.startTest();
            List<MeetupEvent> result = MeetupService.getOpenEvents(getTestParams());
            System.assert(result != null);
            System.assert(result.size() == 2);
        Test.stopTest();
    }

    static Map<String,String> getTestParams(){
        Map<String,String> testParams = new Map<String,String>{
            'searchText'=>'lightning',
            'zipCode'=>'94105'
        };
        return testParams;
    }

    static void createTestCustomSetting(){
        Meetup_Settings__c cs = new Meetup_Settings__c();
        cs.API_Key__c = 'MYSUPERSECRETAPIKEY';
        insert cs;
    }

}