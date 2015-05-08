({
    doInit : function(component, event, helper) {
        var userId = component.get('v.userId');
        helper.getFeedPhotos(component, userId);
        helper.initHandlers(component);
        var context = $A.getContext().getApp();
        var autoPlay = component.get('v.autoplay');
        // Make sure we only auto-play in the one.app context
        if(context == 'one:one' && autoPlay == true){
            var autoPlay = function () {
                  setTimeout(function () {
                      console.log('auto play');
                      if(component){
                          helper.moveToNextPhoto(component);
                          autoPlay();
                      }
                  }, 5000);
            };
            autoPlay();
        }
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
        helper.moveToNextPhoto(component);
    },

    previousPhoto : function(component, event, helper){
        helper.moveToPreviousPhoto(component);
    }

})
