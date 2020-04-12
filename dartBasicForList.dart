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
  print(checkIndex);
  
  checkIndex = target.indexOf("a");
  print(checkIndex);
  
  checkIndex = target.lastIndexOf("a");
  print(checkIndex);
  
  
  
}
