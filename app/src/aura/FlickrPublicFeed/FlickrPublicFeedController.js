({
    doInit : function(component, event, helper) {
        var userId = component.get('v.userId');
        helper.getFeedPhotos(component, userId);
        helper.initHandlers(component);
    },

    showSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : true });
        evt.fire();
    },

    hideSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : false });
        evt.fire();
    },

    nextPhoto : function(component, event, helper){
        var photos = component.get('v.photos');
        var currentIndex = component.get('v.currentPhotoIndex');
        if(currentIndex >= photos.length-1){
            currentIndex = 0;
        }else{
            currentIndex++;
        }
        component.set('v.currentPhotoURL', photos[currentIndex].photoURL);
        component.set('v.currentPhotoIndex', currentIndex);
    },

    previousPhoto : function(component, event, helper){
        var photos = component.get('v.photos');
        var currentIndex = component.get('v.currentPhotoIndex');
        if(currentIndex <= 0){
            currentIndex = photos.length-1;
        }else{
            currentIndex--;
        }
        component.set('v.currentPhotoURL', photos[currentIndex].photoURL);
        component.set('v.currentPhotoIndex', currentIndex);
    }

})
