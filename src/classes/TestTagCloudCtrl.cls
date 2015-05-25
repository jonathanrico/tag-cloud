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
            List<Topic> topics = createTopics(10);
            List<TagCloudItem> mtaResults = TagCloudCtrl.getTags('most-talked-topics',10);
            System.assert(mtaResults.size() == 10);
            List<TagCloudItem> objectResults = TagCloudCtrl.getTags('Account',10);
            System.assert(objectResults.size() == 0);
        Test.stopTest();
    }

    private static List<Topic> createTopics(Integer numOfTopics){
        List<Topic> topics = new List<Topic>();
        for(Integer i = 0;i< numOfTopics;i++){
          Topic t = new Topic();
          t.Name = 'Sample Topic '+i;
          topics.add(t);
        }
        insert topics;
        return topics;
    }

}
