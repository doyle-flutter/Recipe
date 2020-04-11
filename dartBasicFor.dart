void main() {

  // 문자열 
  
  // 분석
  
  String value = " (빈) 문자열 분석 (공간) ";
 
  print(value[0]);
  print(value[1]);
  print(value[2]);
  print(value[3]);
  try{
    print(value[11] == null);
  }
  catch(e){
    print("value 변수에 없는 index");
  }
  
//   print(value[11] == null);
  
//   print(value[11]);
  
  print(value.length);
  
  
  for(int i = 0; i < value.length; i++){
    print("$i 순번에 값은 : ${value[i]}"); // 빈공간, 특수기호도 값으로 찾을 수 있다
  }
  
  
  String customValue = value.trim();
  print(customValue); // 문자열의 가장 앞뒤 공백을 지운다
  
  customValue = value.split(' ')[0]; print(customValue);  
  customValue = value.split(' ')[1]; print(customValue);  
  customValue = value.split(' ')[2]; print(customValue);  
  customValue = value.split(' ')[3]; print(customValue);  
  
  List customValueSplit = value.split(' ');
  print(customValueSplit); // 공란을 기준으로 값을 나누어 배열로 만들어줍니다
  
  
}
