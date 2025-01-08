import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? fullName;
  final String? address;
  final String? roleName;
  final String? status;

  User(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.address,
      this.roleName,
      this.status});

  @override
  List<Object?> get props =>
      [id, username, email, fullName, address, roleName, status];
}
