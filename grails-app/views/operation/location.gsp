<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}"/>


</head>

<body>
<div class="col-sm-12">
    <h1>${operationInstance.id}</h1>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <div id="map"></div>
        <script>
            function initMap() {
                var opLocation = {lat: ${operationInstance.latitude.replace(",", ".")}, lng: ${operationInstance.longitude.replace(",", ".")}};
                var map = new google.maps.Map(document.getElementById("map"), {
                    zoom: 4,
                    center: opLocation
                });
                var marker = new google.maps.Marker({
                    position: opLocation,
                    map: map
                });
            }
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=API_KEY&callback=initMap"></script>
    </div>
</div>

</body>
</html>