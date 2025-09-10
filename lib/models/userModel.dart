class UserModel{
  String? uid;
  String? username;
  String? email;
  String? password;
  String? pic;
  String?gender;
  String?age;
  String?phoneno;
  String?dob;

  UserModel({this.uid,this.email,this.password,this.pic,this.username,this.age,this.dob,this.gender,this.phoneno});

  UserModel.fromMap(Map<String ,dynamic>map)
  {
    uid=map["uid"];
    username=map["username"];
    email=map["email"];
    password=map["password"];
    pic=map["pic"];
    age=map["age"];
    gender=map["gender"];
    dob=map["dob"];
    phoneno=map["phoneno"];
  }

  Map<String,dynamic> toMap()
  {
    return
    {
      "uid":uid,
    "username":username,
    "email":email,
    "password":password,
    "pic":pic,
    "age":age,
    "gender":gender,
    "dob":dob,
    "phoneno":phoneno
    };
  }

}
