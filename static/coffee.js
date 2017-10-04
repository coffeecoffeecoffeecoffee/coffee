(function() {
    let client_id = "CZIZBABDK31BRGHMYGR0R44O0WGA5IVVOP1EFQ04QEFV3SMX";
    let client_secret = "OTM52YCMGQDOI1JRAOA31Y5LAR0KA3LTX0M5XSQSMSFAIEOU";
    let version = "20170801"
    let near = "San Francisco, CA";

    let debug = false;

    function log() {
        if (debug) {
            console.log.apply(this, arguments);
        }
    }

    function changeImageURL(imageURL) {
        log(["changing image URL", imageURL]);
        $('#image').attr("src", imageURL);
    }

    function showDefaultImage() {
        log("setting default image");
        changeImageURL("coffee-bean.png");
    }

    function changeLink(venue) {
        if (venue && venue.id) {
            let venueURL = "https://foursquare.com/v/" + venue.id;
            log(["changing link", venueURL]);
            $("#link").attr("href", venueURL);
        }
    }

    function fetchVenue(venue) {
        log(["fetching venue", venue]);
        let venueURL = "https://api.foursquare.com/v2/venues/" + venue.id;
        $.getJSON(venueURL, {
                client_id: client_id,
                client_secret: client_secret,
                v: version
            })
            .done(function(json) {
                log(["venue", json]);
                if (json.response && json.response.venue && json.response.venue.bestPhoto) {
                    let bestPhoto = json.response.venue.bestPhoto;
                    let imageURL = bestPhoto.prefix + "300x300" + bestPhoto.suffix;
                    changeImageURL(imageURL);
                } else {
                    showDefaultImage();
                }
            });
    }

    function runVenueSearch(location) {
        // remove city and state from the location string
        let query = location.replace(/\,\s[\w ]+\, \w\w$/i, "");
        let searchURL = "https://api.foursquare.com/v2/venues/search";
        $.getJSON(searchURL, {
                client_id: client_id,
                client_secret: client_secret,
                v: version,
                near: near,
                query: query
            })
            .done(function(json) {
                log(["venue search: " + query, json]);
                if (json.response && json.response.venues) {
                    if (json.response.venues.length > 0) {
                        let venue = json.response.venues[0];
                        fetchVenue(venue);
                        changeLink(venue);
                    } else {
                        log("No search results");
                        showDefaultImage();
                    }
                } else {
                    showDefaultImage();
                }
            });
    }

    function fetchFutureEvent() {
        // Unable to run due to CORS configurationf or Cross-Site Scripting
        let futureEventURL = "/api/events/future";
        $.getJSON(futureEventURL)
            .done(function(json) {
                log(["future", json]);
                if ($.isArray(json) && json.length > 0) {
                    let location = json[json.length - 1].location;
                    runVenueSearch(location);
                } else {
                    showDefaultImage();
                }
            });
    }

    function loadImage() {
        fetchFutureEvent();
    }

    $(loadImage);
}());