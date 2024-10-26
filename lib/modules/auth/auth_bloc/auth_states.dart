abstract class AuthStates {}

class AuthInitialState extends AuthStates {}
class AuthLoadingState extends AuthStates {}
class AuthErrorState extends AuthStates {
  String message;
  
  AuthErrorState(this.message);
}
class AuthAuthenticatedState extends AuthStates {}
class AuthUnauthenticatedState extends AuthStates {}

class LoadingUserDataState extends AuthStates {}
class SuccessUserDataState extends AuthStates {}
class ErrorUserDataState extends AuthStates {
  final String message;
  ErrorUserDataState(this.message);
}
