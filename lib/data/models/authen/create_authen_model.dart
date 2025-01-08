class CreateAuthenModel {
  String? userName;
  String? password;
  String? email;
  String? roleName;
  String? phoneNumber;

  CreateAuthenModel(
      {this.userName,
      this.password,
      this.email,
      this.roleName,
      this.phoneNumber});

  CreateAuthenModel.fromJson(Map<String, dynamic> json) {
    userName = json['username'];
    password = json['password'];
    email = json['email'];
    roleName = json['roleName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.userName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['roleName'] = this.roleName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
