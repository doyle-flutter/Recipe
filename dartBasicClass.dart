class MyClass{
  String vString;
  int vInt;
  double vDouble;
  bool vBool = false;
  String value = "ClassVarValue";
  String _value2 = "ClassVarValue 2";
  
  
  MyClass(String newVString, {this.vDouble, this.vInt = 111})
    :assert(newVString != null), assert(vDouble != null ){
    this.vString = newVString;
    this._init();
  }
  
  
  String get value2 => this._value2;
  set value2(String newValue) => this._value2 = newValue;
  
  void _init(){
    this.vInt = 1;
  }
  
  String vIntvDouble() => (this.vInt+this.vDouble).toString();
}


class YourClass{
  MyClass myClass;
  
  YourClass(){
    this._init();
  }
  
  _init(){
    myClass = new MyClass("NEW String", vDouble: 2.0);
    String mString = myClass.vIntvDouble();
    print(mString);
    
    myClass.value2 = "NEW Value2";
    print(myClass.value2); 
  }
}




void main(){
  
//   YourClass yClass = new YourClass();  
// Login 에서 실행한 적 없으나 Logic 에서 _init함수로 실행 됨에따라
// Login Class 문자열이 출
  
//   Login login = new Login();
//   Logic login2 = new Login();
  
//   login.userId();
//   login2.userId();
  
//   login.userPw();
//   login2.userPw();
  
//   login.userToken();
  
//   login2.token = "LOGIC 2 : TOKEN";
//   login2.userToken();
  
  
//   // 구현 '만' 하는 것으로 _init함수가 실행되지 않음
//   // 따라서 implement 는 interface의 성격을 띄며
//   // 구현체의 내부를 제한하는 양식으로 사용
  
 // LoginLogic loginLogic = new LoginLogic();
  
//   ThemClass t = new ThemClass();
//   print(t.vString);
  
 KOPerSon koPerson1 = new KOPerSon();
 PerSon koperSon2 = new KOPerSon();
 
 koPerson1.name = "James";
 koPerson1.speak();
  
 koperSon2.name = "James 2";
 koperSon2.speak();
  
 USPerSon usPerson = new USPerSon();
 usPerson.speak();
  
  
  
}



class ParentClass{
  String vString;
  String pr(){

  }

  String pr1(){

  }
  String pr2(){

  }
}

class ChildClass extends ParentClass{

  @override
  // TODO: implement vString
  String get vString => super.vString;

  @override
  String pr2() {
    // TODO: implement pr2
    return super.pr2();
  }
}


// abstract 추상적인
// 만들고자하는 로직을 추상화하는 단계
// 코드의 전반적인 흐름을 먼저 만들고 맞추어 내부를 꾸밈
// 추상층 Class를 먼저 정의
// 상속(확장) Class 또는 구현 Class 를 생성
// 내부 코드 작성
// 사용


abstract class Logic{
  String vString;
  String token = "Logic Token";
  
  String userId(){
    print("Logic ID");
  }
  String userPw(){
    print("Logic PW");
  }
  String userToken(){
    print("TOKEN : ${this.token}");
  }
}
  
// 상속 보다 확장의 개념이 더욱 어울림
// Logic 의 기능 및 개념을 확장


class Login extends Logic{

  @override
  String userId() {
    super.userId();
    print("Login Class : userID()");
    return "this.UserID";

  }
  @override
  String userPw(){
    super.userPw();
    print("Login Class : userPW()");
    return "this.UserPW";
  }
  
  @override
  String userToken(){
    super.userToken();
    print("Login Class : userToken(${this.token})");
    return "this.UserToken";
  }
  
}


// implements 구현하다
// Logic이 만들어진 내용에 맞추어 구현

class LoginLogic implements Logic{
  @override
  String token;

  @override
  String vString;

  @override
  String userId() {
    // TODO: implement userId
    return null;
  }

  @override
  String userPw() {
    // TODO: implement userPw
    return null;
  }

  @override
  String userToken() {
    // TODO: implement userToken
    return null;
  }

}



// MixIN

class WeClass{
  String weString = "We Class Valaue";
}

class ThemClass with WeClass{
  String get vString => this.weString;
}

abstract class PerSon{
  String name;
  String age;
  
  String speak(){
    print("MY NAME IS $name");
    return "MY NAME IS $name";
  }
}

abstract class National{
  String idCard;
}


class KOPerSon extends PerSon implements National{
  @override
  String idCard = "KO IDCARD NUMBER";
  
  @override
  String speak(){
    super.speak();
    print(this.idCard);
    return "Class : KOPerSon Class";
  }
  
}

class USPerSon extends PerSon with WeClass{
   
  @override
  String speak(){
    super.name = this.weString;
    super.speak();
    return "Class : USPerSon";
  }
}



