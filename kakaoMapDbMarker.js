// nodejs
// JS API KEY
const express = require('express');
const app = express();
const MY_KEY = "JS API KEY";

// server render
app.get('/kaka', (req,res) => {
    return res.send(
      `<!DOCTYPE html>
          <html>
              <head>
                  <meta charset="utf-8">
                  <title>마커 생성하기</title>

              </head>
              <body>
                  <div id="map" style="width:100%;height:500px;"></div>

                  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${MY_KEY}"></script>
                  <script>
                  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                      mapOption = { 
                          center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                          level: 3 // 지도의 확대 레벨
                      };

                  var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                  // 마커가 표시될 위치입니다 
                  var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

                  // 마커를 생성합니다
                  var marker = new kakao.maps.Marker({
                      position: markerPosition
                  });

                  // 마커가 지도 위에 표시되도록 설정합니다
                  marker.setMap(map);

                  </script>
              </body>
          </html>`
    )
});



// html render
app.get('/kakas/mk', (req,res) => {
    return res.sendFile('/Users/../../mk.html');
});
// ex) db data
app.post('/kaka/', (req, res) => {
    // let {lv, lat, long } = req.params;
    let positions = [
        {
            title: '카카오', 
            latlng: [33.450705, 126.570677]
        },
        {
            title: '생태연못', 
            latlng: [33.450936, 126.569477]
        },
        {
            title: '텃밭', 
            latlng: [33.450879, 126.569940]
        },
        {
            title: '근린공원',
            latlng: [33.451393, 126.570738]
        }
    ];
    return res.json(JSON.stringify(positions));
});
    
    
app.listen(3000, () => { console.log('3000' ) } );
