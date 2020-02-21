// Flutter X 생활코딩 #7 ADMIN PAGE(Nodejs&Express)

var express = require('express');
var app = express();


app.use(express.json());
app.use(express.urlencoded( {extended : false } ));

var mysql = require('mysql');
var connection = mysql.createConnection({ 
  user : '',
  password : '',
  database : '',
});

connection.connect();

app.get('/', (req,res) => {
  res.json("Hello World !");
})

app.get('/db',(req,res) => {
  connection.query("SELECT * FROM myapp", (err, result, field) => {
    if(err) throw err;
    return res.json(result);
  });
});

app.get('/admin', (req,res) => {
  connection.query('SELECT * FROM myapp', (err, result) => {
    var contentsInpuArea = () => {
      if(result.length < 5) return  `<div>
          <h2>ADMIN_Page</h2>
          <form method='post', action='/admin/add', accept-charset='utf-8'>
            <div>
              <div class='inputItem' ><p>Date : </p></div><input type='text', name='date', placeholder="Ex) 2020-02-01" />
            </div>
            <div>
              <div class='inputItem' ><p>source : </p></div><input type='text', name='source' placeholder="Ex) NAVER" />
            </div>
            <div>
              <div class='inputItem' ><p>country : </p></div><input type='text', name='country' placeholder="Ex) KO" />
            </div>
            <div>
              <div class='inputItem' ><p>infectedCount : </p></div><input type='text', name='infectedCount' placeholder="Ex) 1" />
            </div>
            <div><input type='submit' style='width:100px;' /></div>
          </form>
        </div>`;
      return `<p>더이상 추가할 수 없습니다</p>`;
    };

    var contentsTableArea = () => {
      if(result.length < 1) return `<td>NOT DATA !</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>`;
      var tablecontents = result.map((e) => `<tr>
          <td>${e['id']}</td>
          <td>${e['date']}</td>
          <td>${e['source']}</td>
          <td>${e['country']}</td>
          <td>${e['infectedCount']}</td>
          <td><a href='' >UP</a></td>
          <td><a href='' >DOWN</a></td>
          <td><a href='' >UPDATE</a></td>
          <td> 
            <form action='/admin/delete', method='post', accept-charset='utf-8'>
              <input type="hidden" name="id" value="${e['id']}" />
              <input type="submit" value="delete" />
            </form>
          <td/>
        </tr>`);
      return tablecontents.reduce((startV, endV) => startV+endV);
    }

    res.send(
      `
      <html>
        <head>
          <style>
            .inputItem{
              display : inline-block;
              margin-right : 10px;
            }
            table{
              text-align: center;
              width:50%;
            }
            table.t1 tr:nth-child(even) {
              background-color: #eee;
            }
            table.t1 tr:nth-child(odd) {
              background-color: #fff;
            }
            table.t1 th {
              color: white;
              background-color: black;
            }
          </style>
        </head>
        <body>
          ${contentsInpuArea()}
          <div>
            <table class='t1'>
              <tr>
                <th>ID</th>
                <th>DATE</th>
                <th>SOURCE</th>
                <th>COUNTRY</th>
                <th>INFECTEDCOUNT</th>
                <th>UP</th>
                <th>DOWN</th>
                <th>UPDATE</th>
                <th>DELETE</th>
              </tr>
              ${contentsTableArea()}
            </table>
          </div>
        </body>
        </html>
      `
    );
  })
});

app.post('/admin/add',(req,res) => {
  var result = req.body;
  console.log("connect");
  if(nullcheck(result)) return res.json(false);
  else{
    connection.query(
      'INSERT INTO myapp (date, source, country, infectedCount) VALUES(?, ?, ?, ?)', 
      [result.date, result.source, result.country, result.infectedCount], 
        (err, result) => {
          if(err) throw err;
          return res.json(true);
        });
    return false;
  };
});

app.post('/admin/delete', (req,res) => {
  var id = req.body.id;
  connection.query('DELETE FROM myapp WHERE id=?', [id], (err, result) => {
    if(err) throw err;
    return res.redirect('/admin');
  });
});

// 2020 02 22 +- Counter 
app.post('/admin/infacted/up',(req,res) => {
  var id = req.body.id;
  connection.query('SELECT * FROM myapp WHERE id=?', [id], (err, result) => {
    var id = result[0]['id'];
    var upCount = result[0]['infectedCount']+1;
    connection.query('UPDATE myapp SET infectedCount=? WHERE id=?',[upCount, id], (err, result) => {
      console.log('UP...');
      return res.json(true);
    });
  });
});
app.post('/admin/infacted/down',(req,res) => {
  var id = req.body.id;
  connection.query('SELECT * FROM myapp WHERE id=?', [id], (err, result) => {
    var id = result[0]['id'];
    var upCount = result[0]['infectedCount']-1;
    if(upCount < 0) return res.json(false);
    connection.query('UPDATE myapp SET infectedCount=? WHERE id=?',[upCount, id], (err, result) => {
      console.log('Down!!!!!!');
      return res.json(true);
    });
  });
});

function nullcheck(result){
  for(var key in result) if (result[key] == '' || result[key] == null) return true;
  return dataFormatCheck(result);
}

function dataFormatCheck({date,country}){
  var txtSplitList = date.split('-');
  if(txtSplitList.length < 3) return true
  return countryCheck(country);
}

function countryCheck(country){
  if(country.length > 2) return true;
  return false;
}


app.listen(4000, () => console.log('localhost:4000/admin'));
