// ... ing

void main() {

  // value context
  
  var a = "동적으로(아무거나)) 담을 수 있음"; 
  dynamic b = '아무거나';
  String c = "반드시 문자열만";
  int d = 1;
  double e = 2.0;
  bool f = true;
  void g = null;
  Function h = (){};
  MyClass i = new MyClass();
  
  // identify context
  List lvar = [];
  List<dynamic> ldynamic = [1,"2",false];
  List<String> lstring = ["리스트", "안에", "반드시", "문자만"];
  List<int> lint = [1,2,3];
  List<double> ldouble = [1.0, 2.0, 3.0];
  List<bool> lbool = [false, true, false];
  List<void> lvoid = [null, null, null];
  List<List> llist = [[],[],[]];
  List<Set> lset = [new Set(), new Set.from([]), new Set()];
  List<Map> lmap = [{}, {}];
  List<Function> lfunction = [(){}, (){}, (){}];
  List<MyClass> lmyClass = [new MyClass(), new MyClass()];
  
  List<List<String>> llstring = [ ["a"], ["b"], ["c"] ];
  List<List<int>> llint = [[1], [2], [3]];
  List<List<double>> lldouble = [[1.0],[2.0],[3]];
  List<List<bool>> llbool = [[false], [true], [false]];
  List<List<void>> llvoid = [[null],[null],[null]];
  List<List<Map>> llmap = [[{}],[{}],[{}]];
  List<List<MyClass>> llMyclass = [[new MyClass()],[new MyClass()],[new MyClass()]];
  List<List<Function>> llfunction = [[(){}],[(){}],[(){}]];
  
  
  
  Set sa = new Set();
  Set sb = new Set.from([1,'2','2',false, false, new MyClass(), new MyClass()]);
  Set<String> sc = new Set.from(['a', 'a', 'c']);
  Set<int> sd = new Set.from([1, 1, 3]);
  Set<double> se = new Set.from([1.0, 1.0, 3.0]);
  Set<bool>  sf = new Set.from([false, false, true]);
  Set<void> sg = new Set.from([null, null, null]);
  
  Map ma = new Map();
  
  
  Function fa = (){};
  Function fb = () => a;
  
  
  MyClass mya = new MyClass();
  
  
    
}


class MyClass{
  
}
