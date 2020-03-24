// 위도, 경도를 사용한 지도의 직선거리(피타고라스 방정식 사용)
// meter || kilometer 소수점 반올림

class MapStraightDistanceByPythagoras{
  double startLat = 34.8944;
  double startLong = 128.0258;

  double endLat = 34.8932;
  double endLong = 128.0256;

  MapStraightDistanceByPythagoras({
    @required this.startLat,
    @required this.startLong,
    @required this.endLat,
    @required this.endLong
  }):assert([startLong, startLat, endLong, endLat] != null){
    this._errCheck(this._init);
  }

  double _result;
  double get result => this._result;
  set result(double newResult) => this._result = newResult;

  bool err = false;

  int kilometer() => (this._result).round();

  int meter() => (this._result*1000).round();

   void _init(){
    try{
      print(this.startLat.abs());
      double dLat = ((this.startLat.abs() - this.endLat.abs()))*92;
      double dLong = ((this.startLong.abs() - this.endLong.abs()))*114;
      double root = pow(dLat, 2)+pow(dLong, 2);
      this._result = sqrt(root);
    }
    catch(e){
      this.err = true;
    }
  }

  void _errCheck(Function callback){
    if(this.startLat == this.startLong) throw "CHECK Start POINT";
    if(this.endLat == this.endLong) throw "CHECK End POINT";
    if(this.startLat == this.endLong) throw "ERR POINT";
    if(this.startLong == this.endLat) throw "ERR POINT";
    if(this.err) throw "ALL POINT ERR";
    else return callback();
  }
}
