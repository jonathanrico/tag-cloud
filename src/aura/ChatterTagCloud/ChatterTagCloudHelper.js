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
                for(i = 0; i < tags.length; i++){
                    var tagItem = tags[i];
                    var itemWeight = (!tagItem.weight || tagItem.weight <= 0)?1:tagItem.weight;
                    tc.add(tagItem.name, itemWeight, 'javascript:TagCloud.navigateToSObject("'+tagItem.itemId+'")');
                }
                tc.loadEffector('CountSize').base(22).range(8);
                tc.setup(tagcontainer);
            } else {
                alert('Unable to fetch tags');
            }
        });

        $A.enqueueAction(a);

    },
})
