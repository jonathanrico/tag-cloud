@isTest
private class TestTagCloudCtrl{

    static testMethod void testWithNoResults(){
        Test.startTest();
            List<TagCloudItem> mtaResults = TagCloudCtrl.getTags('most-talked-topics',10);
            System.assert(mtaResults.size() == 0);
            List<TagCloudItem> objectResults = TagCloudCtrl.getTags('Account',10);
            System.assert(objectResults.size() == 0);
        Test.stopTest();
    }

    static testMethod void testWithResults(){
        Test.startTest();
            List<TagCloudItem> mtaResults = TagCloudCtrl.getTags('most-talked-topics',10);
            System.assert(mtaResults.size() == 0);
            List<TagCloudItem> objectResults = TagCloudCtrl.getTags('Account',10);
            System.assert(objectResults.size() == 0);
        Test.stopTest();
    }

}
