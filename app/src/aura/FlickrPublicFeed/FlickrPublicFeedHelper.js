({

    initHandlers : function(component){
        var ready = component.get("v.ready");
        if (ready === false) {
            return;
        }
    },

    getFeedPhotos : function(component, userId){

        var a = component.get("c.getFlickrFeedPhotos");

        a.setParams({
            'userId': userId
        });

        a.setCallback(this, function(action) {
            if (action.getState() === "SUCCESS") {
                res = action.getReturnValue();
                console.log(res);
                component.set('v.photos',action.getReturnValue());
                component.set('v.currentPhotoURL', res[0].photoURL);
                component.set('v.currentPhotoIndex', 0);
            } else {
                alert(action.getState());
            }
        });
        $A.enqueueAction(a);

    }

})
