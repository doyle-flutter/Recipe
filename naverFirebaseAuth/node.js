app.get('/firebase', async (req, res) => {
  await axios(
    {
      method: 'POST',
      'url':"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=WEBKEY", 
      headers:{'Content-Type' : 'application/json'},
      params: {"email":"abc2@gmail.com","password":"b123456","returnSecureToken":'true'}
    }
  );
  res.json(true);
});

app.get('/firebase2', async (req, res) => {
  await axios(
    {
      method: 'POST',
      'url':"https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=WEBKEY", 
      headers:{'Content-Type' : 'application/json'},
      params: {"email":"abc3@gmail.com","password":"c123456","returnSecureToken":'true'}
    }
  );
  res.json(true);
});



// 발급 한 WEB_KEY
// 별도 생성 규칙을 통해 중복되지 않는 키를 생성하고 서비스를 이용하는 이용자별로 고유하게 지정해야합니다
const ADMIN_KEY = "a123456";

app.post('/likeFirebase', (req,res) => {
  let hdContentType = req.headers['content-type'];
  let email = req.body['email'];
  let password = req.body['password'];
  let key = req.query['key'];

  // 검증 Validation - 더 많은 내용이 검증되어야 합니다
  if(key == undefined || key !== ADMIN_KEY) return res.json("KEY ERR!");
  if(hdContentType == undefined ||hdContentType !== 'appliciotn/json') return res.json('header ERR!');
  if(email == undefined || password == undefined) return res.json(false);

  // 암호화 방식을 선정하여 비밀번호를 변경하여 사용합니다
  let makeToken = password+'1'; 

  conn.sqlInfo.query('INSERT INTO user (id,token) VALUES (?,?)',[email, makeToken], (err, results) => {
    if(err) return res.json('save ERR');
    return res.json(results);
  });
});

app.get('/likeFirebase/readUser', (req,res) => {
  let key = req.query['key'];

  if(key == undefined || key !== ADMIN_KEY) return res.json("KEY ERR!");
  
  // DB 생성 전 테스트
  let arr = [{'id':'user1'}, {'id':'user2'}];
  let tag = '';
  for( let id of arr){
    tag += `<p>${id['id']}</p>`
  }
  res.send(tag);

  // DB 생성 후
  // conn.sqlInfo.query('SELECT * FROM user key = ?', [key], (err, results) => {
  //   if(err) return res.json('DB ERR!');
  //   let tag = '';
  //   for( let id in results){
  //     tag += `<p>${id['id']}</p>`
  //   }
  //   res.send(tag);
  // });
});
