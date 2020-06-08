// and : flutter_media_notification 1.2.6 ( https://pub.dev/packages/flutter_media_notification )
// ios : native_audio 0.0.23 ( https://pub.dev/packages/native_audio )
// audio : audio 0.0.5 ( https://pub.dev/packages/audio ) - tutorial 재생목록 중 60번 영상 참고
// TEST H/W : LG Q7, APPLE SE2

class MyApp4 extends StatefulWidget {
  @override
  _MyApp4State createState() => _MyApp4State();
}

class _MyApp4State extends State<MyApp4> {
  var _audio = NativeAudio();

  Audio audioPlayer = new Audio(single: true);
  AudioPlayerState state = AudioPlayerState.STOPPED;
  StreamSubscription<AudioPlayerState> _playerStateSubscription;
  bool check = false;
  
  @override
  void initState() {
    if(Platform.isAndroid){
      playCt();
    }
    else{
      _audio.play(
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
        title: "How The Fashion Industry Is Responding To Climate Change",
        album: "Science Friday",
        artist: "WNYC Studio",
        imageUrl: "https://www.sciencefriday.com/wp-content/uploads/2019/09/clothes-close-min.jpg"
      );
    }

    super.initState();
  }

  void playCt(){
    _playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state)
    {
      switch (state){
        case AudioPlayerState.STOPPED:{
          break;
        }
        case AudioPlayerState.LOADING:
          break;
        case AudioPlayerState.READY:
          break;
        case AudioPlayerState.PLAYING:
          break;
        case AudioPlayerState.PAUSED:
          break;
      }
    });
    MediaNotification.setListener('play', () async{
      print("PLAY");
      await andPlayerFunc();
      return;
    });
    MediaNotification.setListener('pause', () async{
      print("pause");
      await audioPlayer.pause();
      return;
    });
    MediaNotification.setListener('next', () {
      print("next");
    });
    MediaNotification.setListener('prev', () {
      print("prev");
    });
    MediaNotification.setListener('select', () {
      print("select");
    });
  }

  Future<void> andPlayerFunc() async 
    => await audioPlayer.play(
    "https://firebasestorage.googleapis.com/v0/b/opensource-11ed5.appspot.com/o/flutter_audio_plugin%2FSampleAudio_0.4mb.mp3?alt=media&token=a6334d66-dc48-4562-b126-ed7004b18e5c"
  );

  Future<dynamic> playNoti({bool playCheck = true}) async{
    if(!Platform.isAndroid) return;
    await andPlayerFunc();
    return await MediaNotification.showNotification(
      title: "TITLE",
      author: "DES",
      isPlaying: playCheck
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("PLAY"),
          onPressed: () async{
            await playNoti();
          },
        ),
      ),
    );
  }
}
