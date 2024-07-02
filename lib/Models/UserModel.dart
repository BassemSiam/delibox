class UserModel {
  String? userName;
  String? brandName;
  String? email;
  String? password;
  String? uId;
  String? phone;

  UserModel({this.userName, this.email, this.phone, this.uId,this.password,this.brandName});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userName = json['userName'];
    uId = json['uId'];
    phone = json['phone'];
    brandName = json['brandName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'brandName': brandName,
      'uId': uId,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }
}
