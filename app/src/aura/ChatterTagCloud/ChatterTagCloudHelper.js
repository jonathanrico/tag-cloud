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

                var tc = TagCloud.create();
                for(i = 0; i < tags.length; i++){
                    var tagItem = tags[i];
                    tc.add(tagItem.name, tagItem.weight, 'javascript:TagCloud.navigateToSObject("'+tagItem.itemId+'")');
                }

                tc.loadEffector('CountSize').base(10).range(20);

                tc.setup(tagcontainer);
            } else {
                alert('Unable to fetch tags');
            }
        });

        $A.enqueueAction(a);

    },
})
