import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // LoginModel? loginModel;
  void userLogin({
    required email,
    required password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool hidePassword = true;

  void changePasswordVisibility() {
    if (hidePassword) {
      suffix = Icons.visibility_outlined;
      hidePassword = false;
    } else {
      hidePassword = true;
      suffix = Icons.visibility_off_outlined;
    }
    emit(ChangeIconState());
  }
}
