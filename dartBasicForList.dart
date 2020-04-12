main(){
  
  List value = ['a',1,'가',false, {"key":"value"}, [1,2,3]];
  
  List<String> target = ['가', '나', '다'];
  
  // index
  print(target[0]);
  // length
  print( target.length );
  
  
  // find
  int checkIndex = target.indexOf("가");
  print(checkIndex);
  
  checkIndex = target.lastIndexOf('가');
  print(checkIndex); // 뒤에서부터 찾아도 index 순번이 변하지는 않는다, List의 첫번째 요소는 언제나 0
  
  checkIndex = target.indexOf("a");
  print(checkIndex);
  
  checkIndex = target.lastIndexOf("a");
  print(checkIndex);
  
  
  // for & add
  
  for(int i = 0; i < target.length; i++){
    print(target[i]);
  }
  
  List newTarget1 = [];
  for(int i = 0; i < target.length; i++){
    newTarget1.add("NEW 1 ${target[i]}");
  }
  print(newTarget1);
  
  List newTarget2 = [];
  target.forEach((e){
    newTarget2.add("NEW 2 $e");
  });
  print(newTarget2);
  
  
  List newTarget3 = target.map((e) => "NEW 3 "+e).toList();
  print(newTarget3);
  
  // sort 
  List<int> numList = [1,2,3,4,5];
  target.sort((String start, String end) => end.hashCode.compareTo(start.hashCode));
  print(target);
  // for & find
 
  
  
  
  
  
  
  
}
