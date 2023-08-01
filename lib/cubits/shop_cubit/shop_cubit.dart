import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/modules/product_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';

import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/Get_favorites_model.dart';
import '../../models/categories_model.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  int currentIndex = 0;

  List<Widget> screens = const [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopNavBarChange());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorite = {};
  void getHomeData() {
    emit(GetShopHomeDataLoading());

    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((product) {
        favorite.addAll({
          product.id: product.inFavorites,
        });
      });
      emit(GetShopHomeDataSuccess());
    }).catchError((error) {
      emit(GetShopHomeDataFailed(error.toString()));
    });
  }

//////////////////////get Categories////////////////////////

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(GetShopHomeDataLoading());

    DioHelper.getData(
      url: 'categories',
      // token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategoriesDataSuccess());
    }).catchError((error) {
      emit(GetCategoriesDataFailed(error.toString()));
    });
  }

  //////////////////////////////////////add remove favorites//////////////////////////////////
  ///

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorites(int id) {
    favorite[id] = !favorite[id]!;
    emit(ChangeFavoriteSuccess());

    DioHelper.postData(url: 'favorites', data: {'product_id': id}, auth: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status) {
        favorite[id] = !favorite[id]!;
      } else {
        getFavorites();
      }
      emit(ChangeFavoriteSuccess());
    }).catchError((error) {
      favorite[id] = !favorite[id]!;
      emit(ChangeFavoriteFailed(error.toString()));
    });
  }

  //////////////////////////////////////get favorites//////////////////

  GetFavoritesModel? getFavoritesModel;

  void getFavorites() {
    emit(GetFavoriteLoading());

    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(GetFavoriteSuccess());
    }).catchError((error) {
      emit(GetFavoriteFailed(error.toString()));
    });
  }
  //////////////////////////////get user data///////////////////
  ///

  UserData? userData;
  void getUserData() {
    emit(GetUserDataLoading());

    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      userData = UserData.fromJson(value.data);
      emit(GetUserDataSuccess());
    }).catchError((error) {
      emit(GetUserDataFailed(error.toString()));
    });
  }

  ///////////////update user ///

  void updateUser({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateUserLoading());
    DioHelper.putData(
      url: 'update-profile',
      auth: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userData = UserData.fromJson(value.data);
      emit(UpdateUserSuccess(userData!));
    }).catchError((error) {
      emit(UpdateUserFailed(error.toString()));
    });
  }
}
