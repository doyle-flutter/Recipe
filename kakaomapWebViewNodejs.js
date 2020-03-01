var express = require('express');
var app = express();

app.get('/kaka', (req,res) => res.send(`<!DOCTYPE html>
    <html>
    <head><meta charset="utf-8"/><title>Kakao 지도 시작하기</title></head>
    <body>
        <div id="map" style="width:100%;height:400px;"></div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${MY_KEY}"></script>
        <script>
            var container = document.getElementById('map');
            var options = {center: new kakao.maps.LatLng(33.450701, 126.570667),level: 3};
            var map = new kakao.maps.Map(container, options);
        </script>
        <script> function helloJams() { console.log("Hello"); jams.postMessage("Hello"); } </script>
        <div style=" position: relative; height: 200px; text-align: center; background-color:#ccc; ">
            <div style=" margin: 0; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); ">
                <p>HTML Page</p><button onclick="helloJams()">BUTTON</button>
            </div>
        </div>
    </body>
    </html>`));
    
    app.listen(3000, () => { console.log('3000' ) } );
