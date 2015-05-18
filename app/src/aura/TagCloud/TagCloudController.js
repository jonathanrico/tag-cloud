({
    doInit : function(component, event, helper) {
        var tagsType = component.get('v.tagsType');
        helper.loadTagItems(component, tagsType, 'mytagcloud');
    }

})
