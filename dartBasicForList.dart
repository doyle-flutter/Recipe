main(){
  
  List value = ['a',1,'가',false, {"key":"value"}, [1,2,3]];
  
  List<String> target = ['가', '나', '다'];
  
  print(value);
  print(target);
  
  // index
  print( target[0] );
  // length
  print( target.length );
  
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
  

  
  
  // find
  // 뒤에서부터 찾아도 index 순번이 변하지는 않는다, 
  // List의 첫번째 요소는 언제나 0
  
  
  int checkIndex = target.indexOf("가");
  print(checkIndex);
  
  checkIndex = target.lastIndexOf('가');
  print(checkIndex); 

  checkIndex = target.indexOf("a");
  print(checkIndex);
  
  checkIndex = target.lastIndexOf("a");
  print(checkIndex);
  
  
  // main Context가 return 되어 종료
  
  
  String findValue1 = '가';
  for(int i =0; i<target.length; i++){
    if(target[i] == findValue1) print("찾음");
    print(target[i]);
  }
  
  String findValue2 = '가';
  for(int i =0; i<target.length; i++){
    // if(target[i] == findValue2) return print("찾음"); 
    print(target[i]);
  }
  

  
  // sort 
  
  List<int> numList = [1,2,5,4,3];
  
  numList.sort((int start, int end) => end.compareTo(start));
  print(numList);
  numList.sort((int start, int end) => start.compareTo(end));
  print(numList);
  
  
  // 예제
  // 주어진 배열을 오름차순으로 변경하고
  // 50보다 큰 수를 찾아서 print() 하기
  
  List<int> examplEx = [1,3,4,6,60];
  
  examplEx.sort((int s, int e) => s.compareTo(e));
  examplEx.forEach((e) => (e > 50) ? print(e) : null);

  
}
