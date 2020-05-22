var app = require('express')();

app.get('/auth', (req, res) => {
    var key = req.query['code'];
    return res.send(
        `
        <!DOCTYPE html>
        <html>
        <head><meta charset="utf-8"/><title>Kakao 로그인 완료</title></head>
        <body>
            <div style="width:100%; text-align:center; margin-top:50px;">
                <button onClick=helloJames() style="font-size:3rem; ">로그인 완료</button>
            </div>
            <script> function helloJames() { console.log("Hello"); james.postMessage(true); } </script>
        </body>
        </html>
        `
    );
});

app.listen(3000);
