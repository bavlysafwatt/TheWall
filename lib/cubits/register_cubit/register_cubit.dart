// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(
      {required String username,
      required String email,
      required String password}) async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    FirebaseFirestore.instance.collection('users').doc(user.user!.email).set({
      'email': user.user!.email,
      'username': username,
    });
  }

  void tryToRegister({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password == confirmPassword) {
      emit(RegisterLoading());
      try {
        await registerUser(
            username: username, email: email, password: password);
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(RegisterFailure(
              errorMessage: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(RegisterFailure(
              errorMessage: 'The account already exists for that email.'));
        } else if (e.code == 'invalid-email') {
          emit(RegisterFailure(errorMessage: 'Email is not valid.'));
        } else {
          emit(RegisterFailure(
              errorMessage: 'Can\'t login now, try again later'));
        }
      } catch (e) {
        emit(RegisterFailure(errorMessage: 'Error, please try again later!'));
      }
    } else {
      emit(RegisterFailure(errorMessage: 'Passwords doesn\'t match'));
    }
  }
}
