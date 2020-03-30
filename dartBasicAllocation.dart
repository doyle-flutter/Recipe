void main() {

  // value context
  var vVar = "동적으로(아무거나)) 담을 수 있음"; 
  dynamic vdynamic = '아무거나';
  String vString = "반드시 문자열만";
  int vInt = 1;
  double vDouble = 2.0;
  bool vBool = true;
  void vVoiid = null;
  List vlist = new List();
  Set vSet = new Set();
  Function vFunction = (){};
  MyClass vMyClass = new MyClass();
  
  
  // identify context
  List lVar = [];
  List<dynamic> ldynamic = [1,"2",false];
  List<String> lString = ["리스트", "안에", "반드시", "문자만"];
  List<int> lInt = [1,2,3];
  List<double> lDouble = [1.0, 2.0, 3.0];
  List<bool> lBool = [false, true, false];
  List<void> lVoid = [null, null, null];
  List<List> lList = [[],[],[]];
  List<Set> lSet = [new Set(), new Set.from([]), new Set()];
  List<Map> lMap = [{}, {}];
  List<Function> lFunction = [(){}, (){}, (){}];
  List<MyClass> lMyClass = [new MyClass(), new MyClass()];
  
  List<List<String>> llString = [ ["a"], ["b"], ["c"] ];
  List<List<int>> llInt = [[1], [2], [3]];
  List<List<double>> llDouble = [[1.0],[2.0],[3]];
  List<List<bool>> llBool = [[false], [true], [false]];
  List<List<void>> llVoid = [[null],[null],[null]];
  List<List<List>> llList = [[[]],[[]],[[]], new List.from([new List()])];
  List<List<Set>> llSet = [[new Set()],[new Set()],[new Set.from([])]];
  List<List<Map>> llMap = [[{}],[{}],[{}]];
  List<List<Function>> llFunction = [[(){}],[(){}],[(){}]];
  List<List<MyClass>> llMyclass = [[new MyClass()],[new MyClass()]];
  
  Set sa = new Set();
  Set sb = new Set.from([1,'2','2',false, false, new MyClass(), new MyClass()]);
  Set<String> sc = new Set.from(['a', 'a', 'c']);
  Set<int> sd = new Set.from([1, 1, 3]);
  Set<double> se = new Set.from([1.0, 1.0, 3.0]);
  Set<bool>  sf = new Set.from([false, false, true]);
  Set<void> sg = new Set.from([null, null, null]);
  Set<List> sList = new Set.from([[1,2,3], new List()]);
  Set<Set> sSet = new Set.from([new Set(), new Set.from([])]);
  Set<Map> sMap = new Set.from([new Map(), {}]);
  Set<Function> sFunction = new Set.from([(){}, (){}]);
  Set<MyClass> sMyClass = new Set.from([new MyClass(), new MyClass()]);
  
  Set<List<String>> slString = new Set.from([lString]);
  Set<List<int>> slInt = new Set.from([lInt]);
  Set<List<double>> slDouble = new Set.from([lDouble]);
  Set<List<bool>> slBool = new Set.from([lBool]);
  Set<List<void>> slVoid = new Set.from([lVoid]);
  Set<List<List>> slList = new Set.from([lList]);
  Set<List<Set>> slSet = new Set.from([lSet]);
  Set<List<Map>> slMap = new Set.from([lMap]);
  Set<List<Function>> slFunction = new Set.from([lFunction]);
  Set<List<MyClass>> slMyClass = new Set.from([lMyClass]);
   
  Map mVar = new Map();
  Map mVarFrom = new Map.from({'a':'b'});
  Map<String, dynamic> mdynamic = {"key1":1, "key2":"2"};
  Map<String, String> mString = {"key1":"문자열", "key2":"값"};
  Map<String, int> mInt = {"key1":1, "key2":2};
  Map<String, double> mDouble = {"key1": 1.0, "key2": 2.3};
  Map<String, bool> mBool = {"key1": true, "key2": false};
  Map<String, void> mVoid = {"key1":null};
  Map<String, List> mList = {'key1': [], 'key2':new List()};
  Map<String, Set> mSet = {'key1': new Set(), 'key2':new Set.from([])};
  Map<String, Map> mMap = {'key1': {}, 'key2': new Map()};
  Map<String, Function> mFunction = {'key1': (){}};
  Map<String, MyClass> mMyClass = {'key1':new MyClass()};
  
  // 가능
  Map<int, String> mIntKey = {1: "값"};
  
  Map<String, List<String>> mlString = new Map.from({'key1': lString});
  Map<String, List<int>> mlInt = {'key1': lInt};
  // ...
  
  
  Function fVar = (){};
  
  Function(String) fpString2 = (String v){ return v; };
  Function(String v) fpString = (String v){ return v; };
  Function(int i) fpInt = (int i) => i;
  Function(double i) fpDouble = (double i) => i;
  
  Function(List l) fpList = (List l) => l[0];
  print(fpList(lString));
  
  Function(Map m) fpMap = (Map m) => m['id'];
  print(fpMap({'id': "IDID"}));
  
  Function(Set s) fpSet = (Set s) => s.toList()[0];
  print(fpSet(new Set.from([1,2,2])));
  
  Function(Function f) fpFunction = (Function f) => f();
  print(fpFunction(() => "String Value Function in Function"));
  
  
  Function({String v}) fparamsNaming1 = ({String v}) => v;
  print(fparamsNaming1(v:"StringValue"));
  
  Function({String v, int i}) fparamsNaming2 = ({String v, int i}) => i;
  print(fparamsNaming2(v:"StringValue", i:123123));
  
  
  Function fClosure1 = (){};
  Function fClosure2 = (){return vString;};
  Function fClosure3 = (){ return (){ return vString; }; };
  print(fClosure1());
  print(fClosure2());
  print(fClosure3()());
  
  String fString = (){return vString;}();
  String fString2() => vString;
  String fString3(){return vString;}
  
  print(fString);
  print(fString2);
  print(fString3);
  
  print(fString2());
  print(fString3());
  
  
  MyClass mya = new MyClass();
  
  
    
}


class MyClass{
  
}
