// 문법이 중요한 이유
// https://cafe.naver.com/flutterjames/38

void main() {
  
  void ff( int c, { int a, String b } ){
    print("a : ${a}");
    print("b : ${b}");
  }
  
  ff( 444, a: 123, b: "321" );
  ff( 555, b : "321", a : 123 );
  
  MyClass m = MyClass(666, b: "321", a: 123);
  m.mFF(777, a: 123, b: "321");
  
  MyClass.mFF2(888, b: "321", a: 123);
  
}

class MyClass{
  MyClass( 
    int c, { int a, String b } );
  void mFF( int c, { int a, String b } ){}
  
  static mFF2( int c, { int a, String b } ){}
  
}
