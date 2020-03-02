var express = require('express');
var app = express();

app.use(express.json());

var MY_KEY = 'JavaScript 키';

app.get('/kaka/:lat/:long', (req,res) => {
    var lat = req.params.lat;
    var long = req.params.long;
    res.send(`<!DOCTYPE html>
    <html>
    <head><meta charset="utf-8"/><title>Kakao 지도 시작하기</title></head>
    <body>
        <div id="map" style="width:100%;height:400px;"></div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${MY_KEY}"></script>
        <script>
            function displayMarker(locPosition, message) {
                var marker = new kakao.maps.Marker({ map: map, position: locPosition }); 
                var iwContent = message, iwRemoveable = true;
                var infowindow = new kakao.maps.InfoWindow({ content : iwContent, removable : iwRemoveable});
                infowindow.open(map, marker);
                map.setCenter(locPosition);      
            }   
            var container = document.getElementById('map');
            var options = {center: new kakao.maps.LatLng(${lat}, ${long}),level: 3};
            var map = new kakao.maps.Map(container, options);
            var locPosition = new kakao.maps.LatLng(${lat}, ${long}),
            message = '<div style="padding:5px;">You!</div>';
            displayMarker(locPosition, message);   
        </script>
        <script> function helloJams() { console.log("Hello"); jams.postMessage("Hello"); } </script>
        <div style=" position: relative; height: 200px; text-align: center; background-color:#ccc; ">
            <div style=" margin: 0; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); ">
                <p>HTML Page</p><button onclick="helloJams()">BUTTON</button>
            </div>
        </div>
    </body>
    </html>`);
});

app.listen(3000, () => { console.log('3000')});
