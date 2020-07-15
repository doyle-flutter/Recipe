import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';

main() async {
    
    var app = Angel();
    var http = AngelHttp(app);

    app
      ..get('/', (req, res) => res.write('Hello, world!(Dart Server : Angle) \n - James Flutter -'))
      ..get('/data', (req,res) => "제임스 Flutter")
      ..get('/datas', (req,res) => [ 1, 2, 3, 4, { "key" : "value" } ])
      ..get('/path/:id', (req,res) => { 'pathId' : req.params['id'] })
      // ..get('/int/int:id', (req,res) => { 'int' : req.params['id'] })
      // ..get('/double/double:id', (req,res) => { 'string' : req.params['id'] })
      ..get('/headers', (req,res) => { 
          'hasParsedBody' : req.hasParsedBody,
          'User-Agent' : req.headers['user-agent'],
          'host' : req.headers['host'],
          'code' : req.headers['statusCode'],
          'contentType.mimeType' : req.contentType,
          'headers' : req.headers.toString(),
          'date' : req.headers.date,
          'userAgentHeader' : req.headers['userAgentHeader'],
          'content-type' : req.headers['content-type'],
          'location' : req.headers['location']
        })
      ..group('/news/:id', (router) async{
          router
            ..get('/', (req, res) => {'newsGroupBasic' : req.params['id']})
            ..get('/subId', (req, res) => {'newsGroupSubId' : req.params['id']})
            ..get('/subId2', (req, res) => {'newsGroupSubId2' : req.params['id']});
        });

    app.group('/datas', (router) async{
      router
        ..post('/map', (req,res) async{
          await req.parseBody();
          return { 'postMapData' : req.bodyAsMap['data'] };
        })
        ..post('/list', (req, res) async{
          await req.parseBody();
          return {
            'listData' : req.bodyAsList,
            'listDataLength' : req.bodyAsList.length
          };
        });
    });

    await http.startServer('127.0.0.1', 3000);
}
