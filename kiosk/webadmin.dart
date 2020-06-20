<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>키오스크 관리자</title>
    <script src="/socket.io/socket.io.js"></script>
</head>
<body>
    <script>
        var socket = io();
        socket.emit("platformCheck", "WEB ADMIN");
    </script>
</body>
</html>
