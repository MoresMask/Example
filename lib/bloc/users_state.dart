part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

//User loading state
class UserLoadingState extends UsersState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UsersState {
  UserLoadedState(this.users);
  final List<UserModel> users;
  List<Object> get props => [users];
}

class UserErrorState extends UsersState {
  UserErrorState(this.error);
  final String error;

  List<Object> get props => [error];
}
