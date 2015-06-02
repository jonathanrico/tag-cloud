({

    loadTagItems : function(component, type, maxTags, tagcontainer){

        var a = component.get("c.getTags");

        a.setParams({
            'tagType': type,
            'maxTags': maxTags
        });

        a.setCallback(this, function(action) {
            if (action.getState() === "SUCCESS") {
                var tags = action.getReturnValue();
                component.set('v.totalTags',tags.length);
                var tc = TagCloud.create();
                var sfIdregex = /[a-zA-Z0-9]{15}|[a-zA-Z0-9]{18}/;
                for(i = 0; i < tags.length; i++){
                    var tagItem = tags[i];
                    var itemWeight = (!tagItem.weight || tagItem.weight <= 0)?1:tagItem.weight;
                    var itemId = tagItem.itemId.trim();
                    //Validate salesforce id format
                    if(!sfIdregex.test(itemId)){
                        continue;
                    }
                    tc.add(tagItem.name, itemWeight, itemId);
                }
                tc.loadEffector('CountSize').base(22).range(8);
                tc.setup(tagcontainer);
            } else {
                alert('Unable to fetch tags');
            }
        });

        $A.enqueueAction(a);

    },

    initHandlers : function(component, containerId){
        var ready = component.get("v.ready");
        if (ready === false) {
            return;
        }
        var tagContainerId = '#'+containerId.replace(/(:|;)/g,"\\$1");
        $j(tagContainerId).on('click','.tagcloud-anchor', function(e){
            var recordId = $j(this).data('item-id');
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
                "recordId": recordId,
                "slideDevName": "feed"
            });
            urlEvent.fire();
        });
    }

})
