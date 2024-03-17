
import 'package:mob_test_henry/models/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded({
    required this.users,
});
}

