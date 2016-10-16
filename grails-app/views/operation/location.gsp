<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'operation.label', default: 'Operation')}"/>

</head>

<body>
<div class="col-sm-12">
    <h1>Localisation d'une opération <small>${operationInstance?.category.name} - ${operationInstance?.tiers.name} - <g:formatNumber
            number="${operationInstance.amount}" format="###,###.##"/>€</small></h1>
    <hr/>
</div>

<div class="col-sm-12">
    <div class="around-border">
        <div id="map" style="width:100%; height:70%;"></div>
        <script>
            function initMap() {
                var opLocation = {lat: ${operationInstance.latitude.replace(",", ".")}, lng: ${operationInstance.longitude.replace(",", ".")}};
                var map = new google.maps.Map(document.getElementById("map"), {
                    zoom: 16,
                    center: opLocation
                });
                var marker = new google.maps.Marker({
                    position: opLocation,
                    map: map
                });
            }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap"></script>
    </div>
</div>

</body>
</html>