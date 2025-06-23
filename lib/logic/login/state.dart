class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String token;

  LoginSuccessState({required this.token});
}

class LoginErrorState extends LoginStates {
  final String em;

  LoginErrorState(this.em);
}