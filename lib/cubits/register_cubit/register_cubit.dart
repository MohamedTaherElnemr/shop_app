import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  UserData? RegisterData;
  String? token;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoading());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      RegisterData = UserData.fromJson(value.data);
      token = RegisterData!.token;
      CacheHelper.setData(
        key: 'token',
        value: RegisterData!.token,
      );

      emit(RegisterSuccess(RegisterData!));
    }).catchError((error) {
      emit(RegisterFailed(error.toString()));
    });
  }

//   bool isPass = true;

//   IconData suffixIcon = Icons.visibility_outlined;

//   Widget changeSuffixIcon() => IconButton(
//       onPressed: () {
//         isPass = !isPass;
//         suffixIcon =
//             isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//       },
//       icon: Icon(suffixIcon));
//
}
