import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/register/register_cubit.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ChangeBottomNavState extends ShopStates{}

class ShopLoadingState extends ShopStates{}

class ShopSuccessState extends ShopStates{}

class ShopErrorState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ChangeFavoritesState extends ShopStates{}

class ChangeFavoritesSuccessState extends ShopStates
{
  final ChangeFavoritesModel model;

  ChangeFavoritesSuccessState(this.model);
}

class ChangeFavoritesErrorState extends ShopStates{}

class GetShopSuccessErrorState extends ShopStates{}

class GetShopErrorErrorState extends ShopStates{}

class GetShopFavoritesLoadingState extends ShopStates{}

class ShopUserDataSuccessState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopUserDataSuccessState(this.loginModel);

}

class ShopUserDataErrorState extends ShopStates{}

class ShopUserDataLoadingState extends ShopStates{}

class ShopRegisterLoadingState extends ShopStates{}

class ShopRegisterSuccessState extends ShopStates{
  final ShopLoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterErrorState extends ShopStates{}

class ShopUpdateLoadingState extends ShopStates{}

class ShopUpdateSuccessState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopUpdateSuccessState(this.loginModel);

}

class ShopUpdateErrorState extends ShopStates{}