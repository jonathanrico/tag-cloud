({
	doSearch : function(component, event, helper) {
        console.log('doing search')
        var meetupSearchEvent = $A.get("e.LightningMeetup:MeetupSearchEvent");
        var searchTerms = component.find('meetupSearch').get('v.value');
        var zipCode = component.find('searchZipCode').get('v.value');
        var radius = component.find('searchRadius').get('v.value');
        var maxResults = component.get('v.maxResults');
        console.log('*** '+maxResults);
        meetupSearchEvent.setParams({
            "searchTerms": searchTerms,
            "zipCode": zipCode,
            "radius": radius,
            "maxResults": maxResults
        }).fire();
	}
})