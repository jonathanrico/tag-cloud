({
    loadTagItems : function(component, type, tagcontainer){

        var a = component.get("c.getTags");

        a.setParams({
            'tagType': type
        });

        a.setCallback(this, function(action) {
            if (action.getState() === "SUCCESS") {

                var tags = action.getReturnValue();

                var tc = TagCloud.create();
                for(i = 0; i < tags.length; i++){
                    var tagItem = tags[i];
                    tc.add(tagItem.name, tagItem.weight, '/'+tagItem.itemId, Date.parse('2005/06/23 00:00:00'));
                }

                tc.loadEffector('CountSize').base(10).range(5);
                tc.loadEffector('DateTimeColor');

                tc.setup(tagcontainer);
            } else {
                alert('Unable to fetch tags');
            }
        });

        $A.enqueueAction(a);

    },
})
