(function() {
    let client_id = "CZIZBABDK31BRGHMYGR0R44O0WGA5IVVOP1EFQ04QEFV3SMX";
    let client_secret = "OTM52YCMGQDOI1JRAOA31Y5LAR0KA3LTX0M5XSQSMSFAIEOU";
    let version = "20170801"
    let near = "San Francisco, CA";

    function changeImageURL(imageURL) {
        $('#image').attr("src", imageURL);
    }

    function setDefaultImage() {
        changeImageURL("coffee-bean.png");
    }

    function fetchVenue(id) {
        let venueURL = "https://api.foursquare.com/v2/venues/" + id;
        $.getJSON(venueURL, {
                client_id: client_id,
                client_secret: client_secret,
                v: version
            })
            .done(function(json) {
                console.log("venue");
                console.log(json);
                if (json.response && json.response.venue && json.response.venue.bestPhoto) {
                    let bestPhoto = json.response.venue.bestPhoto;
                    let imageURL = bestPhoto.prefix + "300x300" + bestPhoto.suffix;
                    changeImageURL(imageURL);
                } else {
                    setDefaultImage();
                }
            });
    }

    function runVenueSearch(location) {
        // remove city and state from the location string
        let query = location.replace(/\,\s\w+\, \w\w$/i, "");
        let searchURL = "https://api.foursquare.com/v2/venues/search";
        $.getJSON(searchURL, {
                client_id: client_id,
                client_secret: client_secret,
                v: version,
                near: near,
                query: query
            })
            .done(function(json) {
                console.log("venue search");
                console.log(json);
                if (json.response && json.response.venues && json.response.venues.length > 0) {
                    fetchVenue(json.response.venues[0].id);
                } else {
                    setDefaultImage();
                }
            });
    }

    function fetchFutureEvent() {
        // Unable to run due to CORS configurationf or Cross-Site Scripting
        let futureEventURL = "/api/events/future";
        $.getJSON(futureEventURL)
            .done(function(json) {
                console.log("future");
                console.log(json);
                if ($.isArray(json) && json.length > 0) {
                    let location = json[json.length - 1].location;
                    runVenueSearch(location);
                } else {
                    setDefaultImage();
                }
            });
    }

    function loadImage() {
        fetchFutureEvent();
    }

    $(loadImage);
}());