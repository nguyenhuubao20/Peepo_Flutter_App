class AuthenModel {
  final String? id;
  final String? username;
  final String? email;
  final String? fullName;
  final String? address;
  final String? roleName;
  final String? token;
  final String? refreshToken;
  final String? status;

  AuthenModel(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.address,
      this.roleName,
      this.token,
      this.refreshToken,
      this.status});

  factory AuthenModel.fromJson(Map<String, dynamic> json) {
    return AuthenModel(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        fullName: json['fullName'],
        address: json['address'],
        roleName: json['roleName'],
        token: json['token'],
        refreshToken: json['refreshToken'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['roleName'] = this.roleName;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    data['status'] = this.status;
    return data;
  }
}
