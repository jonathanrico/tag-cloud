({
    doInit : function(component, event, helper) {
        if (typeof jQuery !== "undefined" && typeof $j === "undefined"){
            $j = jQuery.noConflict(true);
        }
        var tagContainer = component.getGlobalId()+'_tagcloud';
        helper.loadTagItems(component, 'most-talked-topics', parseInt(component.get('v.maxTags')), tagContainer);
        helper.initHandlers(component, tagContainer);
    }
})
