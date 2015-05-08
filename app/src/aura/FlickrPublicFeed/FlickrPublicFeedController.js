({
    doInit : function(component, event, helper) {
        var userId = component.get('v.userId');
        helper.getFeedPhotos(component, userId);
        var context = $A.getContext().getApp();
        var autoPlay = component.get('v.autoplay');
        // Make sure we only auto-play in the one.app context
        if(context == 'one:one' && autoPlay == true){
            var autoPlay = function () {
                  setTimeout(function () {
                      if(component){
                          helper.moveToNextPhoto(component);
                          autoPlay();
                      }
                  }, 5000);
            };
            autoPlay();
        }
    },
    
    nextPhoto : function(component, event, helper){
        helper.moveToNextPhoto(component);
    },

    previousPhoto : function(component, event, helper){
        helper.moveToPreviousPhoto(component);
    }

})
