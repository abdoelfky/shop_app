import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<LoginStates> {
  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },

    ).then((value)
    {
    loginModel=ShopLoginModel.fromJson(value.data);
    print(loginModel.data.token);
    print(loginModel.status);
    print(loginModel.message);
    emit(LoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });

  }

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=true;
  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());

  }
}
