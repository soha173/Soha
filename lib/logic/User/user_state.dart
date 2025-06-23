part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserModel user;
  UserLoaded(this.user);
}

final class UserUpdating extends UserState {}

final class UserUpdated extends UserState {
  final UserModel user;
  UserUpdated(this.user);
}

final class UserError extends UserState {
  final String message;
  UserError(this.message);
}
