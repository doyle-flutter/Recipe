
// 해당 라우터 그룹

app.group('/mongo', (router){
  router
    ..get('/', (req,res) async{
      //read All
      return db.collection('posts').find().toList();
    })
    ..post('/targetData1', (req,res) async{
      //read Target1
      await req.parseBody();
      Map<String,dynamic> data = req.bodyAsMap;
      return db.collection('posts').find(data).toList();
    })
    ..post('/targetData2', (req,res) async{
      //read Target2
      await req.parseBody();
      Map<String,dynamic> data = req.bodyAsMap;
      return db.collection('posts').find(where.eq("title",data['title'])).toList();
    })
    ..get('/create1/:data',(req,res) async{
      // create1
      String data = req.params['data'];
      await db.collection('posts').insert({"title":"title2"});
      return await db.collection('posts').find().toList();
    })
    ..get('/create2update/:data',(req,res) async{
      // create2 : 존재하는 collection data 중 필드값 새로운 생성 // update
      // update
      String data = req.params['data'];
      var target = await db.collection('posts').findOne({"title":"title2"});
      print(target);
      target["des"] = "des2";
      await db.collection('posts').save(target);
      return await db.collection('posts').find().toList();
    })
    ..get('/delete/:data', (req,res) async{
      String data = req.params['data'];
      await db.collection('posts').remove(where.eq('title', "title2"));
      return await db.collection('posts').find().toList();
    });
});
