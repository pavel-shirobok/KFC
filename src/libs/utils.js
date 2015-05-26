function getParameterByName(locationSearch, name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(locationSearch);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}