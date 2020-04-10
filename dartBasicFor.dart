void main(){
  // For & Find
  
// String

//   String value = "abcdefg";
//   String target = "";
  
//   // 1 For문
//   for(int _i = 0; _i < value.length; _i++){
//     print(value);
//     print(_i);
//   }
  
//   // String Indexing
//   for(int _i = 0; _i < value.length; _i++){
//     print(value[_i]);
//   }
  
//   // bool
//     for(int _i = 0; _i < value.length; _i++){
//       print(value[_i] == target);
//     }
  
//   //if
//   target = "c";
//   for(int _i = 0; _i < value.length; _i++){
//     print(value[_i]);
//     if(value[_i] == target){
//       print("Find It!");
//     }
//   }
  
//   //if & return
//   target = "d";
  
//   for(int _i = 0; _i < value.length; _i++){
//     print(value[_i]);
//     if(value[_i] == target){
//       return print("Find It!");
//     }
//   }
  
  
 // List
  
//   List<int> list = [1,2,3,4,5,6,7];
  
//   List<int> forList = list.map((e) => e).toList();
//   print(forList);
  
//   List<int> newLists;
  
//   // List<int> newNewLists = list.forEach((e) => print(e));
//   // list.forEach((e) => newLists.add(e));
//   // print(newLists);
//   list.forEach((e) => print(e));
  
//   void email({int i}) => print(i.toString());
//   list.forEach((e) => email(i:e)); 
//   //.forEach는 변수에 담을 수도, 내부에서 외부 컨텍스트를 사용하기 불편하지만
//   // 내부 컨텍스트에서는 자유롭기 때문에 void 기능을 반복 작업할 때 사용하기 좋음
  
//   //요소 찾기
//   var v;
//   v = list.indexOf(1);
//   print(v);
//   v = list.indexOf(8);
//   print(v); // 없으면 -1 // 있으면 있는 위치의 index 값
  
//   v = list.map((e) => list.indexOf(e)).toList();
//   print(v);
  
 
//   int target = 6;
  
//   v = list.map((e) => e == target).toList();
//   print(v);
  
//   v = list.map((int e){
//     if(e == target){
//       return e;
//     }
//     else{
//       return null;
//     }
//   }).toList();
//   print(v);
  

  
  
  
  
  
}
