var express = require('express');
var app = express();

app.get("/web", (req, res) =>{
    res.send(`<html>
    <head>
        <script>
            function helloJams() {
                console.log("Hello");
                jams.postMessage("Hello"); 
            }
        </script>
    </head>
    <body>
        <div style=" position: relative; height: 200px; text-align: center; background-color:#ccc; ">
            <div style=" margin: 0; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); ">
                <p>HTML Page</p>
                <button onclick="helloJams()">BUTTON</button>
            </div>
        </div>
    </body>
    </html>`);
});

app.listen(3000, () => { console.log('3000' ) } );
