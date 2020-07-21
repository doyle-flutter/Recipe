void main(){

...

  // WEB : Jael
  var fs = LocalFileSystem();
  await app.configure(jael(fs.directory('views')));
  app.get('/web',(req,res) async{
    List datas = ["/","/data","/datas"];
    return await res.render('index', 
      {'title': '제임쓰 Flutter', 'datas':datas }
    );
  });
  
...

}
