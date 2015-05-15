({
    doInit : function(component, event, helper) {
        var userId = component.get('v.userId');
        helper.getFeedPhotos(component, userId);
    },

    nextPhoto : function(component, event, helper){
        helper.moveToNextPhoto(component);
    },

    previousPhoto : function(component, event, helper){
        helper.moveToPreviousPhoto(component);
    }

})
