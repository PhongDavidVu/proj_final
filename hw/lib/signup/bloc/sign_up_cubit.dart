import 'package:flutter/services.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  String _name = "";
  String _email = "";
  String _password = "";

  set name(String name) {
    _name = name;
  }

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  void signupWithGitHub() {

    emit(SignUpFailed(provider: 'github', reason: 'dev is lazy'));
  }

  Future<void> signupWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    GoogleSignInAccount? googleUser;

    try {
      googleUser = await googleSignIn.signIn();
    } on PlatformException catch (e) {
      print('PlatformException: $e');
      emit(SignUpFailed(provider: 'google', reason: 'Failed'));
      return;
    } catch (e) {
      print('Exception: $e');
      emit(SignUpFailed(provider: 'google', reason: 'Failed'));
      return;
    }

    if (googleUser == null) {
      emit(SignUpFailed(provider: 'google', reason: 'User Cancel'));
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);
      final User? user = userCredential.user;

      if (user == null) {
        emit(SignUpFailed(provider: 'google', reason: 'Unable to Signup to Firebase'));
        return;
      }
      emit(SignUpSuccess(
          provider: 'google',
          name: user.displayName ?? user.email ?? '',
          photoURL: user.photoURL ?? '',
          email: user.email));
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: $e');
      emit(SignUpFailed(provider: 'google', reason: 'Unable to Signup to Firebase'));
    } catch (e) {
      print('Exception: $e');
      emit(SignUpFailed(provider: 'google', reason: 'Unable to Signup to Firebase'));
    }
  }


  void signupWithLinkedIn() {
    emit(SignUpFailed(provider: 'LinkedIn', reason: 'dev is lazy'));  }

  void signUp() {
    if (_name.isEmpty) {
      emit(SignUp(
          status: 'Failed', reason: Batch16String.current.notEmpty('Name')));
    } else if (_email.isEmpty) {
      emit(SignUp(
          status: 'Failed', reason: Batch16String.current.notEmpty('Email')));
    } else if (_password.isEmpty) {
      emit(SignUp(
          status: 'Failed',
          reason: Batch16String.current.notEmpty('Password')));
    } else if (!_isEmailValid(_email)) {
      emit(SignUp(
          status: 'Failed', reason: Batch16String.current.invalid("email")));
    } else if (!_isPasswordValid(_password)) {
      emit(SignUp(
          status: 'Failed', reason: Batch16String.current.tooWeak('Password')));
    }
    if (!(_password.isEmpty ||
        _email.isEmpty ||
        _email.isEmpty ||
        !_isPasswordValid(_password) ||
        !_isEmailValid(_email))) {
      emit(SignUp(status: 'Success', reason: ''));
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
