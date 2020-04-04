// 음악 파일(URL) 재생 & Stream 을 통한 실시간 
// https://pub.dev/packages/audio 
// 예시 소리파일은 패키지에서 제공한 파일을 재생하므로, 
// 정상적으로 재생되지 않을 수 있습니다
class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {

  Audio audioPlayer = new Audio(single: true);
  AudioPlayerState state = AudioPlayerState.STOPPED;
  StreamSubscription<AudioPlayerState> _playerStateSubscription;
  bool check = false;

  @override
  void initState() {
    _playerStateSubscription = audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state)
    {
      switch (state){
        case AudioPlayerState.STOPPED:{
          setState(() {
            check = !check;
          });
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: (check) ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: (){
            if(check){
              audioPlayer.pause();
            }
            else{
              audioPlayer.play("https://firebasestorage.googleapis.com/v0/b/opensource-11ed5.appspot.com/o/flutter_audio_plugin%2FSampleAudio_0.4mb.mp3?alt=media&token=a6334d66-dc48-4562-b126-ed7004b18e5c");
            }
            setState(() {
              check = !check;
            });
          },
        ),
      ),
    );
  }
}



