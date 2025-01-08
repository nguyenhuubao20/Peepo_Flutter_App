class LoginModel {
  String? emailOrUsername;
  String? password;

  LoginModel({this.emailOrUsername, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      emailOrUsername: json['emailOrUsername'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailOrUsername': emailOrUsername,
      'password': password,
    };
  }
}
