import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<RegisterStates> {
  ShopRegisterCubit() : super(RegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  })
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      { 'name':name,
        'phone':phone,
        'email': email,
        'password': password,
      },

    ).then((value)
    {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.message);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });

  }

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=true;
  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityStates());

  }
}
