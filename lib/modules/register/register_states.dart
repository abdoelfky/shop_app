import 'package:shop_app/models/shop_login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates
{
  final ShopLoginModel loginModel;

  RegisterSuccessState(this.loginModel);


}

class RegisterErrorState extends RegisterStates{
  final error;
  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityStates extends RegisterStates{}


