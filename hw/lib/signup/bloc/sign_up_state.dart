part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpFailed extends SignUpState {
  String provider;
  String reason;
  SignUpFailed({required this.provider, required this.reason});
}

class SignUp extends SignUpState {
  String status;
  String reason;
  SignUp({required this.status, required this.reason});
}

class SignUpSuccess extends SignUpState {
  final String provider;
  final String? name;
  final String? email;
  final String? photoURL;
  SignUpSuccess({required this.provider, required this.name, required this.email, required this.photoURL});
}
