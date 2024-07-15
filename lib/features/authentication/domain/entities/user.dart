import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String username;
  final String password;

  const User({this.id, required this.username, required this.password});
  @override
  List<Object?> get props => [username];
}
