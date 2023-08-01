import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  UserData? loginData;
  String? token;

  void userLogin({required String email, required String password}) {
    emit(LoginLoading());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginData = UserData.fromJson(value.data);
      token = loginData!.token;
      CacheHelper.setData(
        key: 'token',
        value: loginData!.token,
      );

      emit(LoginSuccess(loginData!));
    }).catchError((error) {
      emit(LoginFailed(error.toString()));
    });
  }
}
