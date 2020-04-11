//dartPad 기준

void main() {

  // 문자열 
  
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
  
//  print(value[11] == null); // 불가
//   print(value[11]); // 불가
  
  print(value.length);
  
  
  for(int i = 0; i < value.length; i++){
    print("$i 순번에 값은 : ${value[i]}"); // 빈공간, 특수기도 값으로 찾을 수 있다
  }
  
  
  String customValue = value.trim();
  print(customValue); // 문자열의 가장 앞뒤 공백을 지운다
  
  customValue = value.split(' ')[0]; print(customValue);  
  customValue = value.split(' ')[1]; print(customValue);  
  customValue = value.split(' ')[2]; print(customValue);  
  customValue = value.split(' ')[3]; print(customValue);  
  
  List customValueSplit = value.split(' ');
  print(customValueSplit); // 공란을 기준으로 값을 나누어 배열로 만들어줍니다
  
  // 문제 : 빈공간을 지우고 문자로 연속된 값을 만드시오 [2점]
  // 정답 : (빈)문자열분석(공간)
  String cleanValue = value.trim();
  List<String> splitValue = cleanValue.split(" ");
  print(splitValue);
  
  String resultValue = "";
  for(int i=0; i<splitValue.length; i++){
    resultValue += splitValue[i].toString();
  }
  print("resultValue : $resultValue");
  
  
//   value[0] = "index를 이용하여 새로운 값을 주입할 수 없습니다";
//   print(value);
  
  List newValue = [1,2,3];
  for(int i = 0; i < newValue.length; i++){
    value = value+newValue[i].toString();
  }
  print(value);
  
  for(int i = 0; i < newValue.length; i++){
    value += newValue[i].toString(); 
    // 줄여서 사용할 수 있습니다 
    // 기존 문자열에 값을 더 할 수 있습니다
  }
  print(value);
  

  //찾기
  for(int i=0; i<value.length; i++){
    if(value[i] == "원하는 값인가요?"){
      print("네 있습니다");
    }
    else{
      print("없습니다");
    }
  }
  
  int findIndex = value.indexOf(" "); // 가장 처음부터 찾은 값의 Index
  print(findIndex);
  
  findIndex = value.lastIndexOf(" "); // 가장 마지막부터 찾은 값의 Index
  print(findIndex);
  
  // 특정 문자 바꾸기
  String changeValue = value.replaceAll(" ","공간");
  print(changeValue);
  
  
  // 문제 : 빈 공간 및 괄호(앞) (/뒤), 기호/ 를 제거한 문자열을 만드시오 [3점]
  // 정답 : 내용
  
  String example = " (앞) 내용 (/뒤)  ";
  
  List<String> resultValue3 = example.trim().replaceAll("(앞)", "").replaceAll("(\/뒤)", "").split(" ");
  String exampleResult = "";
  for(int i=0; i<resultValue3.length; i++){
    exampleResult += resultValue3[i];
  }
  
  print("exampleResult : $exampleResult");
  
  List checkString = ['(', ")",'/'];
  for(int i=0;i<checkString.length;i++){
    if(exampleResult.contains(checkString[i])){
      exampleResult = "오류";
    }
  }
  print("CheckIng exampleResult : $exampleResult");
  
  
}
