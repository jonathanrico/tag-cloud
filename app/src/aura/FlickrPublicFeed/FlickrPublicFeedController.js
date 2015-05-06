({
    doInit : function(component, event, helper) {
        if (typeof jQuery !== "undefined" && typeof $j === "undefined"){
            $j = jQuery.noConflict(true);
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
    }

})