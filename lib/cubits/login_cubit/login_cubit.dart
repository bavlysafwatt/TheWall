// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser(
      {required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  void tryToLogin({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await loginUser(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(
            errorMessage: 'Wrong credential provided for that user.'));
      } else {
        emit(LoginFailure(errorMessage: 'Can\'t login now, try again later'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Error, please try again later!'));
    }
  }
}
