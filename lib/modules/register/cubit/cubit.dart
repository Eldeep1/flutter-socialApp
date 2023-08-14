import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model/user_model.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  //
  // LoginModel? loginModel;
  void userRegister({
    required email,
    required password,
    required name,
    required phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
          password: password);
      // emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required email,
    required name,
    required phone,
    required uId,
    String? password,
  }) {
    UserModel model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image:
          'https://img.freepik.com/premium-photo/fox-with-blue-coat-gold-trim_81048-10103.jpg?w=360',
      coverImage:
          'https://img.freepik.com/free-photo/still-life-with-musical-instrument_23-2150466291.jpg?t=st=1691572556~exp=1691576156~hmac=6040510020d9626471e2d5c13cc59b6038104ae2d89bdf262fa96031f8837492&w=360',
      bio: 'write your bio...',
      isEmailVerified: false,
      password: password,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: uId);
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
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
