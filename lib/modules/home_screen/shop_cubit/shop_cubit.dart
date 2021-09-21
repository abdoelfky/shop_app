import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_states.dart';
import 'package:shop_app/modules/productes/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomsScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom({int index}) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  Map<int, bool> favorites = {};
  HomeModel homeModel;

  void getHomeDate() {
    emit(ShopLoadingState());
    DioHelper.getData(url: HOME, query: null, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data.toString());
      print(homeModel.status);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(ShopSuccessState());
      print(favorites.toString());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesDate() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print(onError);
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ChangeFavoritesState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      getFavorites();
      emit(ChangeFavoritesSuccessState(changeFavoritesModel));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId];
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(GetShopFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetShopSuccessErrorState());
    }).catchError((onError) {
      print(onError);
      emit(GetShopErrorErrorState());
    });
  }

  ShopLoginModel userData;

  void getUserData() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopUserDataSuccessState(userData));
    }).catchError((onError) {
      print(onError);
      emit(ShopUserDataErrorState());
    });
  }

  void updateUserData(
      {@required String name, @required String phone, @required String email}) {
    emit(ShopUpdateLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateSuccessState(userData));
    }).catchError((onError) {
      print(onError);
      emit(ShopUpdateErrorState());
    });
  }
}
