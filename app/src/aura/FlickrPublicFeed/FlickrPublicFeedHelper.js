({

    getFeedPhotos : function(component, userId){

        var a = component.get("c.getFlickrFeedPhotos");

        a.setParams({
            'userId': userId
        });

        a.setCallback(this, function(action) {
            if (action.getState() === "SUCCESS") {
                res = action.getReturnValue();
                component.set('v.photos',action.getReturnValue());
                component.set('v.currentPhotoURL', res[0].photoURL);
                component.set('v.currentPhotoIndex', 0);
                component.set('v.currentPhotoLink', res[0].link);
            } else {
                alert('Unable to fetch Photos, please provide a Flickr User Id');
            }
        });
        $A.enqueueAction(a);

    },

    moveToNextPhoto : function(component){
        var photos = component.get('v.photos');
        var currentIndex = component.get('v.currentPhotoIndex');
        if(currentIndex >= photos.length-1){
            currentIndex = 0;
        }else{
            currentIndex++;
        }
        component.set('v.currentPhotoURL', photos[currentIndex].photoURL);
        component.set('v.currentPhotoIndex', currentIndex);
        component.set('v.currentPhotoLink', photos[currentIndex].link);
    },

    moveToPreviousPhoto : function(component){
        var photos = component.get('v.photos');
        var currentIndex = component.get('v.currentPhotoIndex');
        if(currentIndex <= 0){
            currentIndex = photos.length-1;
        }else{
            currentIndex--;
        }
        component.set('v.currentPhotoURL', photos[currentIndex].photoURL);
        component.set('v.currentPhotoIndex', currentIndex);
        component.set('v.currentPhotoLink', photos[currentIndex].link);
    },

    startAutoPlay : function(component){
        var autoPlay = component.get('v.autoplay');
        if(autoPlay == true || autoPlay == 'true'){
            var moveFunction = this.moveToNextPhoto;
            var autoPlay = function () {
            var timeOutId = setTimeout(function () {
                    moveFunction(component);
                    autoPlay();
              	}, 5000);
            	component.set('v.timerId', timeOutId);
            };
            autoPlay();
        }
    },

    stopAutoPlay : function(component){
        var timeOutId = component.get('v.timerId');
        if(timeOutId){
            clearTimeout(timeOutId);
        }
    }

})
