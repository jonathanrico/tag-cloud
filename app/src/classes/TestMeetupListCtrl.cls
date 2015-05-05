@isTest
private class TestMeetupListCtrl{

    static testMethod void testOpenEvents(){
        createTestCustomSetting();

        Test.setMock(HttpCalloutMock.class, new TestMeetupMock());
        Test.startTest();
            List<MeetupEvent> result = MeetupListCtrl.getEvents('search term','50','94127','20');
            System.assert(result != null);
            System.assert(result.size() == 2);
        Test.stopTest();
    }

    static testMethod void testAPIKeyCreation(){
        Test.setMock(HttpCalloutMock.class, new TestMeetupMock());
        Test.startTest();
            MeetupListCtrl.updateAPIKey('NEW KEY VALUE');
            System.assert(MeetupSettings.getAPIKey() == 'NEW KEY VALUE');
        Test.stopTest();
    }

    static testMethod void testAPIKeyUpdate(){
        createTestCustomSetting();
        Test.setMock(HttpCalloutMock.class, new TestMeetupMock());
        Test.startTest();
            MeetupListCtrl.updateAPIKey('UPDATED KEY VALUE');
            System.assert(MeetupSettings.getAPIKey() == 'UPDATED KEY VALUE');
        Test.stopTest();
    }

    static testMethod void testTopicsQuery(){
        createTestCustomSetting();
        Test.startTest();
            try{
                Boolean canModifyAll = MeetupListCtrl.canModifyAllData();
                String results = MeetupListCtrl.getRecentlyUsedTopics();
                System.assert(results != null);
            }catch(Exception e){
                System.assert(false);
            }
        Test.stopTest();
    }

    static void createTestCustomSetting(){
        Meetup_Settings__c cs = new Meetup_Settings__c();
        cs.API_Key__c = 'MYSUPERSECRETAPIKEY';
        insert cs;
    }

}