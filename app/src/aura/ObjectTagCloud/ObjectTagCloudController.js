({
    doInit : function(component, event, helper) {
        var tagContainer = component.getGlobalId()+'_tagcloud';
        helper.loadTagItems(component, component.get('v.objectName'), parseInt(component.get('v.maxTags')), tagContainer);
    }
})
