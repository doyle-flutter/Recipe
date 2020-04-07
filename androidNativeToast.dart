
const NEW_PAGE_TOAST = const MethodChannel("samples.flutter.dev/newpagetoast");
_showToast() async => await NEW_PAGE_TOAST.invokeMethod("SHOW");


class NowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Semantics(
              label: "*Flutter : 이동하기 전 페이지에서 안드로이드 채널을 통해 MainActivity의 Toast를 실행할 수 있는가?",
              child: RaisedButton(
                onPressed: _showToast,
                child: Text("NOW PAGE"),
              ),
            ),

            Semantics(
              label: "*Flutter : 이동한 페이지에서 안드로이드 채널을 통해 MainActivity의 Toast를 실행할 수 있는가?",
              child: RaisedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => NewPageToast()
                  )
                ),
                child: Text("NEW PAGE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
