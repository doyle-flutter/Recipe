void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MapView()
            )
          ),
        ),
      ),
    );
  }
}

class MapView extends StatelessWidget {

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<LocationData> getLatLong() async{

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return _locationData = null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return _locationData = null;
      }
    }

    return _locationData = await location.getLocation();
  }

  String MY_URL ='';
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLatLong(),
      builder: (BuildContext context, AsyncSnapshot<LocationData> snap){
        if(!snap.hasData || snap.data.longitude == null) return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        String _url = "${MY_URL}/kaka/${snap.data.latitude.toString()}/${snap.data.longitude.toString()}";
        return WebviewScaffold(
          url: _url,
          appBar: AppBar(title: Text("카카오맵 위치지정"),),
          withJavascript: true,
          withZoom: true,
        );
      },
    );
  }
}

