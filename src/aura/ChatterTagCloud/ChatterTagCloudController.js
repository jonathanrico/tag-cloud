({
    doInit : function(component, event, helper) {
        var tagContainer = component.getGlobalId()+'_tagcloud';
        helper.loadTagItems(component, 'most-talked-topics', parseInt(component.get('v.maxTags')), tagContainer);
    }
})
